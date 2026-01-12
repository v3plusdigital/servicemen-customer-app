import 'package:servicemen_customer_app/services/api/api_response.dart';
import 'package:servicemen_customer_app/services/repositories/services_repository.dart';

import '../api/api_client.dart';
import '../api/api_endpoints.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  final ApiClient api = ApiClient.instance;
  @override
  Future<ApiResponse> dashboard() async {
    final response = await api.get(
      ApiEndPoints.baseUrl + ApiEndPoints.dashboard,
    );

    return response;
  }

  @override
  Future<ApiResponse> serviceByType(int id) async {
    final response = await api.post(
      "${ApiEndPoints.baseUrl}${ApiEndPoints.services}",
      {"service_type_id": id},
    );
    return response;
  }

  @override
  Future<ApiResponse> addToCart(Map<String, dynamic> body) async {
    final response = await api.post(
      "${ApiEndPoints.baseUrl}${ApiEndPoints.addToCart}",
      body,
    );
    return response;
  }

  @override
  Future<ApiResponse> getCart() async {
    final response = await api.get(
      "${ApiEndPoints.baseUrl}${ApiEndPoints.getCart}",
    );
    return response;
  }

  @override
  Future<ApiResponse<dynamic>> getTimeSlot() async {
    final response = await api.get(
      "${ApiEndPoints.baseUrl}${ApiEndPoints.timeSlot}",
    );
    return response;
  }

  @override
  Future<ApiResponse> getOrderSummary(int cartId) async {
    final response = await api.post(
      "${ApiEndPoints.baseUrl}${ApiEndPoints.getOrderSummary}",
      {"cart_id": cartId},
    );
    return response;
  }

  @override
  Future<ApiResponse> deleteCart(int cartId) async {
    final response = await api.post(
      "${ApiEndPoints.baseUrl}${ApiEndPoints.deletecart}",
      {"cart_id": cartId},
    );
    return response;
  }
}
