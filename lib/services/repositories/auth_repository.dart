import 'dart:io';

import '../../models/create_profile_model.dart';
import '../api/api_client.dart';
import '../api/api_response.dart';

abstract class AuthRepository {
  Future<ApiResponse> requestOtp({required String phoneNumber});

  Future<ApiResponse> verifyOtp({
    required String phoneNumber,
    required String otp,
  });

  Future<ApiResponse> createProfile({
    required ProfileCreateRequest profileRequest,
  });
  Future<ApiResponse> updateProfile({
    required ProfileCreateRequest profileRequest,
  });

  Future<ApiResponse> uploadProfilePhoto({required File profileFile});

  Future<ApiResponse> deleteProfilePhoto();
  Future<ApiResponse> getProfile();

  Future<ApiResponse> logout(String token);

  Future<bool> isLoggedIn();
}
