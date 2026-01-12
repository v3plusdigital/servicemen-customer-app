import '../../models/create_address_request_model.dart';
import '../api/api_response.dart';

abstract class LocationRepository {
  Future<ApiResponse> serviceArea();
  Future<ApiResponse> createAddress(CreateAddressModel model);
  Future<ApiResponse> updateAddress(CreateAddressModel model);
  Future<ApiResponse> getAddressList();
  Future<ApiResponse> setDefaultAddress(Map<String,dynamic> body);
  Future<ApiResponse> deleteAddress(Map<String,dynamic> body);

}