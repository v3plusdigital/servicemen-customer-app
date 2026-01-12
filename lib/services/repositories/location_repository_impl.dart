import 'package:servicemen_customer_app/services/api/api_response.dart';
import 'package:servicemen_customer_app/services/repositories/location_repository.dart';

import '../../models/create_address_request_model.dart';
import '../api/api_client.dart';
import '../api/api_endpoints.dart';

class LocationRepositoryImpl extends LocationRepository {
  final ApiClient api = ApiClient.instance;

  @override
  Future<ApiResponse> serviceArea() async {
    final response = await api.get(
      ApiEndPoints.baseUrl + ApiEndPoints.serviceArea,
    );
    return response;
  }

  @override
  Future<ApiResponse> createAddress(CreateAddressModel model) async {
    final response = await api.post(
      ApiEndPoints.baseUrl + ApiEndPoints.createAddress,
      model.toJson(),
    );
    return response;
  }
  @override
  Future<ApiResponse> updateAddress(CreateAddressModel model) async {
    final response = await api.post(
      ApiEndPoints.baseUrl + ApiEndPoints.updateAddress,
      model.toJson(),
    );
    return response;
  }

  @override
  Future<ApiResponse> getAddressList() async {
    final response = await api.get(
      ApiEndPoints.baseUrl + ApiEndPoints.addressList,
    );
    return response;
  }

  @override
  Future<ApiResponse> setDefaultAddress(Map<String,dynamic> body) async {
    final response = await api.post(
      ApiEndPoints.baseUrl + ApiEndPoints.setDefaultAddress,
      body,
    );
    return response;
  }
  @override
  Future<ApiResponse> deleteAddress(Map<String,dynamic> body) async {
    final response = await api.post(
      ApiEndPoints.baseUrl + ApiEndPoints.deleteAddress,
      body,
    );
    return response;
  }


}
