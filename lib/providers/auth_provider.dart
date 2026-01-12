import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/models/service_area_model.dart';
import 'package:servicemen_customer_app/models/verify_otp_model.dart';
import 'package:servicemen_customer_app/providers/location_provider.dart';

import '../models/create_profile_model.dart';
import '../models/get_profile_model.dart';
import '../services/api/api_client.dart';
import '../services/local_data/shared_pref.dart';
import '../services/local_data/shared_pref_keys.dart';
import '../services/repositories/auth_repository.dart';
import '../services/repositories/auth_repository_impl.dart';
import '../utils/app_functions.dart';
import '../utils/navigation_service.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController loginPhoneNumberController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String gender = "";
  final AuthRepository authRepo = AuthRepositoryImpl();
  final SharedPrefService pref = SharedPrefService();
  final ApiClient api = ApiClient.instance;
  VerifyOtpModel? verifyOtpModel;
  File? profileImage;
  bool isLoading = false;
  String? errorMessage;
  bool isFirstLaunch = false;
  bool isLoggedIn = false;
  bool isNewUser = false;
  bool isUpdateProfile = false;
  final formKey = GlobalKey<FormState>();
  static const int _totalSeconds = 120;
  int _secondsLeft = _totalSeconds;
  Timer? _timer;
  GetProfileResponseModel? _getProfileResponseModel;

  File? get image => profileImage;

  int get secondsLeft => _secondsLeft;

  bool get canResend => _secondsLeft == 0;

  GetProfileResponseModel? get getProfileResponseModel =>
      _getProfileResponseModel;

  AuthProvider() {
    AuthSession.onUnauthorized = logoutUser;
  }

  Future<void> logoutUser() async {
    // clear token / prefs here
    // SharedPreferences.clear();
    final val = await logout();
    if (val == true) {
      NavigationService.logoutToLogin();
    }

  }

  void startTimer() {
    _timer?.cancel();
    _secondsLeft = _totalSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
        notifyListeners();
      } else {
        _secondsLeft--;
        notifyListeners();
      }
    });
  }

  void resetTimer() {
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Called on app start
  Future<bool> isAppFirstLaunch() async {
    final val = await pref.getBoolValue(SharedPrefKey.firstLaunch);
    return val ?? true;
  }

  /// Call this after onboarding completed
  Future<void> setFirstLaunchFalse() async {
    await pref.setBoolValue(SharedPrefKey.firstLaunch, false);
  }

  Future<void> checkStatus() async {
    String? token = await pref.getStringValue(SharedPrefKey.token);
    bool? isNewUserVal = await pref.getBoolValue(SharedPrefKey.isNewUser);
    loginPhoneNumberController.text =
        await pref.getStringValue(SharedPrefKey.phone) ?? "";
    bool hasToken = token != null && token.isNotEmpty ? true : false;
    if (hasToken == true) {
      api.updateHeader(token: token);
    }
    isFirstLaunch = await isAppFirstLaunch();
    isLoggedIn = hasToken;
    isNewUser = isNewUserVal ?? false;
  }

  Future<bool> logout() async {
    final success = await logoutApi();
    if (success == true) {
      loginPhoneNumberController.clear();
      await pref.clear();
      api.updateHeader(token: null);
    }
    return success;
  }

  void clearProfileValue() {
    nameController.clear();
    emailController.clear();
    profileImage = null;
    gender = "";
    notifyListeners();
  }

  void selectGender(String gen) {
    gender = gen;
    notifyListeners();
  }

  void updateProfile(bool val) {
    isUpdateProfile = val;
    notifyListeners();
  }

  Future<void> changeImage(File file) async {
    profileImage = file;
    notifyListeners();
    await uploadProfile();
  }

  /// Validate and call API
  Future<bool> requestOtp() async {
    final phone = loginPhoneNumberController.text.trim().replaceAll("-", "");

    if (phone.isEmpty) {
      errorMessage = "Phone number is required";
      notifyListeners();
      return false;
    }

    final validation = validatePhone(phone);
    if (validation != null) {
      errorMessage = validation;
      notifyListeners();
      return false;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await authRepo.requestOtp(phoneNumber: phone);

      if (response.success) {
        startTimer();
        return true;
      } else {
        errorMessage = response.error?.message;
        return false;
      }
    } catch (e) {
      errorMessage = "Something went wrong";
      print("E----$e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> verifyOtp() async {
    isLoading = true;
    errorMessage = null;
    verifyOtpModel = null;
    notifyListeners();

    try {
      final response = await authRepo.verifyOtp(
        phoneNumber: loginPhoneNumberController.text.trim().replaceAll("-", ""),
        otp: "123456",
      );

      if (response.success) {
        verifyOtpModel = VerifyOtpModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        final token = verifyOtpModel?.data?.accessToken;
        final refreshToken = verifyOtpModel?.data?.refreshToken;
        final isNewUser = verifyOtpModel?.data?.isNewUser;
        final phone = verifyOtpModel?.data?.customer?.phone;
        final userId = verifyOtpModel?.data?.customer?.id;

        await pref.setStringValue(SharedPrefKey.token, token.toString());
        await pref.setBoolValue(SharedPrefKey.isNewUser, isNewUser!);
        await pref.setStringValue(SharedPrefKey.phone, phone!);
        await pref.setStringValue(
          SharedPrefKey.refreshToken,
          refreshToken.toString(),
        );
        await pref.setStringValue(SharedPrefKey.userId, userId.toString());

        api.updateHeader(token: token);

        return true;
      } else {
        errorMessage = response.error?.message;
        return false;
      }
    } catch (_) {
      errorMessage = "Something went wrong";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createProfile(BuildContext context) async {
    isLoading = true;
    errorMessage = null;
    verifyOtpModel = null;
    notifyListeners();

    try {
      ProfileCreateRequest model = ProfileCreateRequest(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        gender: gender.toString().toLowerCase(),
      );
      final response = await authRepo.createProfile(profileRequest: model);

      if (response.success) {
        await pref.setBoolValue(SharedPrefKey.isNewUser,false);
        return true;
      } else {
        errorMessage = response.message;
        return false;
      }
    } catch (_) {
      errorMessage = "Something went wrong";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateProfileApi(BuildContext context) async {
    isLoading = true;
    errorMessage = null;
    verifyOtpModel = null;
    notifyListeners();

    try {
      ProfileCreateRequest model = ProfileCreateRequest(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        gender: gender.toString().toLowerCase(),
      );
      final response = await authRepo.updateProfile(profileRequest: model);

      if (response.success) {
        return true;
      } else {
        errorMessage = response.error?.message;
        return false;
      }
    } catch (_) {
      errorMessage = "Something went wrong";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> uploadProfile() async {
    if (image == null) return;
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final response = await authRepo.uploadProfilePhoto(profileFile: image!);
      if (response.success) {
        BotToast.showText(text: "Profile image uploaded successfully");
      } else {
        errorMessage = response.message;
        BotToast.showText(text: errorMessage.toString());
      }
    } catch (_) {
      errorMessage = "Something went wrong";
      BotToast.showText(text: errorMessage.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool?> deleteProfilePhoto() async {
    if (getProfileResponseModel?.data?.customer?.profilePhoto == null) {
      return null;
    }
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await authRepo.deleteProfilePhoto();
      if (response.success) {
        BotToast.showText(text: "Profile image deleted successfully");
        return true;
      } else {
        errorMessage = response.message;
        BotToast.showText(text: errorMessage.toString());
        return false;
      }
    } catch (_) {
      errorMessage = "Something went wrong";
      BotToast.showText(text: errorMessage.toString());
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setProfileValues() {
    nameController.text = _getProfileResponseModel?.data?.customer?.name ?? "";
    loginPhoneNumberController.text =
        _getProfileResponseModel?.data?.customer?.phone ?? "";
    emailController.text =
        _getProfileResponseModel?.data?.customer?.email ?? "";
    print(
      "_getProfileResponseModel?.data?.customer?.gender ---${_getProfileResponseModel?.data?.customer?.gender}",
    );
    gender = capitalize(_getProfileResponseModel?.data?.customer?.gender ?? "");
  }

  Future<void> getProfile(BuildContext context) async {
    updateProfile(false);
    isLoading = true;
    errorMessage = null;
    _getProfileResponseModel = null;
    notifyListeners();
    try {
      final response = await authRepo.getProfile();
      if (response.success) {
        _getProfileResponseModel = GetProfileResponseModel.fromJson(
          response.data,
        );
        setProfileValues();
      } else {
        errorMessage = response.message;
      }
    } catch (_) {
      errorMessage = "Something went wrong";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> logoutApi() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final refreshToken = await SharedPrefService().getStringValue(
        SharedPrefKey.refreshToken,
      );
      final response = await authRepo.logout(refreshToken!);
      if (response.success) {
        return true;
      } else {
        errorMessage = response.error?.message;
        return false;
      }
    } catch (_) {
      errorMessage = "Something went wrong";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
typedef LogoutCallback = Future<void> Function();

class AuthSession {
  static LogoutCallback? onUnauthorized;
}