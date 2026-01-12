import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servicemen_customer_app/models/create_address_request_model.dart';
import 'package:servicemen_customer_app/services/repositories/location_repository.dart';
import 'package:servicemen_customer_app/services/repositories/location_repository_impl.dart';

import '../models/get_address_list_model.dart';
import '../models/service_area_model.dart';
import '../services/api/api_client.dart';
import '../services/local_data/shared_pref.dart';
import '../services/local_data/shared_pref_keys.dart';

class LocationProvider extends ChangeNotifier {
  LatLng _currentPosition = const LatLng(21.1702, 72.8311); // Surat
  String _placeName = "Maria Palace";
  String _address =
      "Shahpore Road Near, Mughal Sarai,\nShahpore, Surat, Gujarat 395003";
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController societyNameController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  String addressType = "";
  ServiceArea? area;
  String? city;
  String? state;
  int _selectedAddress = 0;
  bool isLoading = false;
  String? errorMessage;
  ServiceAreaModel? _serviceAreaModel;
  GetAddressListModel? _getAddressListModel;
  final SharedPrefService pref = SharedPrefService();
  final ApiClient api = ApiClient.instance;
  final LocationRepository locationRepo = LocationRepositoryImpl();
  final formKey = GlobalKey<FormState>();

  ServiceAreaModel? get serviceAreaModel => _serviceAreaModel;

  GetAddressListModel? get addressListModel => _getAddressListModel;

  LatLng get currentPosition => _currentPosition;

  String get placeName => _placeName;

  String get address => _address;

  int get selectedAddress => _selectedAddress;

  void updateLocation(LatLng position) {
    _currentPosition = position;
    notifyListeners();
  }

  void clearFormValue() {
    houseNumberController.clear();
    societyNameController.clear();
    landmarkController.clear();
    pinCodeController.clear();
    area = null;
    city = null;
    state = null;
    addressType = "";
    notifyListeners();
  }

  Future<void> updateFormValue(Address address) async {
    final cancel = BotToast.showLoading();
    clearFormValue();

  await getServiceArea(showLoader: false).then((onValue){
      cancel(); // ALWAYS close loading
      houseNumberController.text = address.houseFlatNo ?? "";
      societyNameController.text = address.buildingSocietyName ?? "";
      landmarkController.text = address.landmark ?? "";
      pinCodeController.text = address.pincode ?? "";
      ServiceArea? a = _serviceAreaModel?.data?.serviceAreas?.firstWhere(
            (e) => e.area == address.area,
      );
      area = a;
      city = a?.city;
      state = a?.state;
      addressType = address.addressType ?? "";
      notifyListeners();
    });


  }

  void selectArea(ServiceArea newValue) {
    area = newValue;
    notifyListeners();
  }

  void selectState(String newValue) {
    state = newValue;
    notifyListeners();
  }

  void selectCity(String newValue) {
    city = newValue;
    notifyListeners();
  }

  void selectAddressType(String newValue) {
    addressType = newValue;
    notifyListeners();
  }

  void updateAddress({required String place, required String address}) {
    _placeName = place;
    _address = address;
    notifyListeners();
  }

  void selectMainAddress(int id) {
    _selectedAddress = id;
    notifyListeners();
  }

  Future<void> getServiceArea({bool? showLoader} ) async {
    if(showLoader!=false){
      isLoading = true;
    }

    errorMessage = null;
    notifyListeners();

    try {
      final response = await locationRepo.serviceArea();

      if (response.success) {
        _serviceAreaModel = ServiceAreaModel.fromJson(response.data);
      }
    } catch (e) {
      print("error--$e");
    } finally {
      if(showLoader!=false){
        isLoading = false;
      }
      notifyListeners();
    }
  }

  Future<bool> createAddress() async {
    print("!api.header.containsKey("")--->${!api.header.containsKey("Authorization")}");

    try {
      CreateAddressModel model = CreateAddressModel(
        addressType: addressType,
        houseFlatNo: houseNumberController.text.trim(),
        buildingSocietyName: societyNameController.text.trim(),
        landmark: landmarkController.text.trim(),
        area: area!.area.toString(),
        city: city.toString(),
        state: state.toString(),
        pinCode: pinCodeController.text.trim(),
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
      );
      final response = await locationRepo.createAddress(model);
      print("response.succes---${response.success}");
      return response.success;
    } catch (e) {
      print("error--$e");
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> getAddressList() async {
    errorMessage = null;
    _getAddressListModel = null;
    try {
      final response = await locationRepo.getAddressList();
      if (response.success) {
        _getAddressListModel = GetAddressListModel.fromJson(response.data);
        if ((_getAddressListModel?.data?.total ?? 0) > 0) {
          Address address = _getAddressListModel!.data!.addresses!.firstWhere(
            (e) => e.isDefault == true,
          );
          selectMainAddress(address.id!);
        }
        return true;
      } else {
        errorMessage = response.message;
        return false;
      }
    } catch (e) {
      errorMessage = "Something went wrong";
      print("error--$e");
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> updateAddressApi(int id) async {
    try {
      CreateAddressModel model = CreateAddressModel(
        addressType: addressType,
        houseFlatNo: houseNumberController.text.trim(),
        buildingSocietyName: societyNameController.text.trim(),
        landmark: landmarkController.text.trim(),
        area: area!.area.toString(),
        city: city.toString(),
        state: state.toString(),
        pinCode: pinCodeController.text.trim(),
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
        customerAddressId: id,
      );
      final response = await locationRepo.updateAddress(model);
      print("response.succes---${response.success}");
      return response.success;
    } catch (e) {
      print("error--$e");
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> setDefaultAddress() async {
    errorMessage = null;
    try {
      final response = await locationRepo.setDefaultAddress({
        "customer_address_id": _selectedAddress,
      });

      if (response.success) {

        return true;
      } else {
        errorMessage = response.message;
        return false;
      }
    } catch (e) {
      errorMessage = "Something went wrong";
      print("error--$e");
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> deleteAddress(int id) async {
    errorMessage = null;

    try {
      final response = await locationRepo.deleteAddress({
        "customer_address_id": id,
      });

      if (response.success) {
        return true;
      } else {
        errorMessage = response.message;
        return false;
      }
    } catch (e) {
      errorMessage = "Something went wrong";
      print("error--$e");
      return false;
    } finally {


    }
  }
}
