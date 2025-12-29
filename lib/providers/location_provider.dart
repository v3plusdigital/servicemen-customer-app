
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LocationProvider extends ChangeNotifier {
  LatLng _currentPosition = const LatLng(21.1702, 72.8311); // Surat
  String _placeName = "Maria Palace";
  String _address =
      "Shahpore Road Near, Mughal Sarai,\nShahpore, Surat, Gujarat 395003";
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController societyNameController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  String addressType="";
  String area="Shahpore";
  String city="Shahpore";
  String state="Shahpore";
  String gender="";
  int _selectedAddress=0;

  LatLng get currentPosition => _currentPosition;
  String get placeName => _placeName;
  String get address => _address;
  int get selectedAddress => _selectedAddress;

  void updateLocation(LatLng position) {
    _currentPosition = position;
    notifyListeners();
  }

  void selectArea(String newValue) {
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
  void selectGender(String gen){
    gender=gen;
    notifyListeners();
  }

  void updateAddress({
    required String place,
    required String address,
  }) {
    _placeName = place;
    _address = address;
    notifyListeners();
  }

  void selectMainAddress(int i){
    _selectedAddress=i;
    notifyListeners();
  }
}
