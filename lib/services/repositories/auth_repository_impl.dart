import 'dart:io';

import 'package:servicemen_customer_app/models/create_profile_model.dart';
import 'package:servicemen_customer_app/services/api/api_endpoints.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../local_data/shared_pref.dart';
import '../local_data/shared_pref_keys.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient api = ApiClient.instance;
  final SharedPrefService pref = SharedPrefService();

  @override
  Future<ApiResponse> requestOtp({required String phoneNumber}) async {
    final response = await api.post(
      ApiEndPoints.baseUrl + ApiEndPoints.requestOtp,
      {"phone": phoneNumber},
    );

    return response;
  }

  @override
  Future<ApiResponse> logout(String refreshToken) async {

    final response = await api.post(
      ApiEndPoints.baseUrl + ApiEndPoints.logout,
      {"refresh_token":refreshToken},
    );
    return response;
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await pref.getStringValue(SharedPrefKey.token);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<ApiResponse> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final response = await api.post(
      ApiEndPoints.baseUrl + ApiEndPoints.verifyOtp,
      {"phone": phoneNumber, "otp": otp},
    );
    return response;
  }

  @override
  Future<ApiResponse> createProfile({
    required ProfileCreateRequest profileRequest,
  }) async {
    final response = await api.post(
      ApiEndPoints.baseUrl + ApiEndPoints.createProfile,
      profileRequest.toFields(),
      // multipartBody,
    );
    return response;
  }

  @override
  Future<ApiResponse> uploadProfilePhoto({required File profileFile}) async {
    final response = await api.multipart(
      ApiEndPoints.baseUrl + ApiEndPoints.uploadPhoto,
      {},
      [MultipartBody('photo', profileFile)],
    );
    return response;
  }

  @override
  Future<ApiResponse> getProfile() async {
    final response = await api.get(
      ApiEndPoints.baseUrl + ApiEndPoints.getProfile,
    );
    return response;
  }

  @override
  Future<ApiResponse> updateProfile({required ProfileCreateRequest profileRequest})
    async {
      final response = await api.post(
        ApiEndPoints.baseUrl + ApiEndPoints.updateProfile,
        profileRequest.toFields(),
        // multipartBody,
      );
      return response;
    }

  @override
  Future<ApiResponse> deleteProfilePhoto() async {
    final response = await api.post(
      ApiEndPoints.baseUrl + ApiEndPoints.deleteProfilePhoto,
        {}
      // multipartBody,
    );
    return response;
  }
}
