class ProfileCreateRequest {
  final String name;
  final String email;
  final String gender;
  final String label;
  final String addressLine1;
  final String addressLine2;
  final String landmark;
  final String city;
  final String state;
  final String pinCode;
  final String latitude;
  final String longitude;

  ProfileCreateRequest({
    required this.name,
    required this.email,
    required this.gender,
    required this.label,
    required this.addressLine1,
    required this.addressLine2,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.latitude,
    required this.longitude,

  });

  Map<String, String> toFields() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'label': label,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'landmark': landmark,
      'city': city,
      'state': state,
      'pincode': pinCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
