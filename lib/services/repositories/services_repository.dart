import '../api/api_response.dart';

abstract class ServicesRepository {
  Future<ApiResponse> dashboard();
  Future<ApiResponse> serviceByType(int id);
  Future<ApiResponse> addToCart(Map<String, dynamic> body);
  Future<ApiResponse> getCart();
  Future<ApiResponse> getTimeSlot();
  Future<ApiResponse> getOrderSummary(int cartId);
  Future<ApiResponse> deleteCart(int cartId);
}
