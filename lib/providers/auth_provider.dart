import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/models/verify_otp_model.dart';
import 'package:servicemen_customer_app/providers/location_provider.dart';

import '../models/create_profile_model.dart';
import '../services/api/api_client.dart';
import '../services/local_data/shared_pref.dart';
import '../services/local_data/shared_pref_keys.dart';
import '../services/repositories/auth_repository.dart';
import '../services/repositories/auth_repository_impl.dart';
import '../utils/app_functions.dart';

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

  File? get image => profileImage;

  void selectGender(String gen) {
    gender = gen;
    notifyListeners();
  }

  void changeImage(File file) {
    profileImage = file;
    notifyListeners();
  }

  bool isLoading = false;
  String? errorMessage;

  /// Validate and call API
  Future<bool> requestOtp() async {
    final phone = loginPhoneNumberController.text.trim();

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

  Future<bool> verifyOtp() async {
    isLoading = true;
    errorMessage = null;
    verifyOtpModel = null;
    notifyListeners();

    try {
      final response = await authRepo.verifyOtp(
        phoneNumber: loginPhoneNumberController.text.trim(),
        otp: "123456",
      );

      if (response.success) {
        verifyOtpModel = VerifyOtpModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        final token = verifyOtpModel?.data?.accessToken;
        final userId = verifyOtpModel?.data?.customer?.id;

        await pref.setStringValue(SharedPrefKey.token, token.toString());
        await pref.setStringValue(SharedPrefKey.userId, userId.toString());

        api.updateHeader(token: token);

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

  Future<bool> createProfile(BuildContext context) async {
    isLoading = true;
    errorMessage = null;
    verifyOtpModel = null;
    notifyListeners();

    try {
      final locationProvider = context.read<LocationProvider>();

      ProfileCreateRequest model = ProfileCreateRequest(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        gender: gender.toString(),
        label: locationProvider.addressType,
        addressLine1: locationProvider.houseNumberController.text.trim(),
        addressLine2: locationProvider.societyNameController.text.trim(),
        landmark: locationProvider.landmarkController.text.trim(),
        city: locationProvider.city,
        state: locationProvider.state,
        pinCode: locationProvider.pinCodeController.text.trim(),
        latitude: locationProvider.currentPosition.latitude.toString(),
        longitude: locationProvider.currentPosition.longitude.toString(),
      );
      final response = await authRepo.createProfile(
        profileRequest: model,
        multipartBody: profileImage != null
            ? [MultipartBody('photo', File(profileImage!.path))]
            : [],
      );

      if (response.success) {
        verifyOtpModel = VerifyOtpModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        final token = verifyOtpModel?.data?.accessToken;
        final userId = verifyOtpModel?.data?.customer?.id;

        await pref.setStringValue(SharedPrefKey.token, token.toString());
        await pref.setStringValue(SharedPrefKey.userId, userId.toString());

        api.updateHeader(token: token);

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
}
