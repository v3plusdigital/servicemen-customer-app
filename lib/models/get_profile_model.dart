// To parse this JSON data, do
//
//     final getProfileResponseModel = getProfileResponseModelFromJson(jsonString);

import 'dart:convert';

GetProfileResponseModel getProfileResponseModelFromJson(String str) => GetProfileResponseModel.fromJson(json.decode(str));

String getProfileResponseModelToJson(GetProfileResponseModel data) => json.encode(data.toJson());

class GetProfileResponseModel {
  bool? success;
  Data? data;

  GetProfileResponseModel({
    this.success,
    this.data,
  });

  GetProfileResponseModel copyWith({
    bool? success,
    Data? data,
  }) =>
      GetProfileResponseModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory GetProfileResponseModel.fromJson(Map<String, dynamic> json) => GetProfileResponseModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  Customer? customer;
  List<Address>? addresses;

  Data({
    this.customer,
    this.addresses,
  });

  Data copyWith({
    Customer? customer,
    List<Address>? addresses,
  }) =>
      Data(
        customer: customer ?? this.customer,
        addresses: addresses ?? this.addresses,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    addresses: json["addresses"] == null ? [] : List<Address>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "customer": customer?.toJson(),
    "addresses": addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x.toJson())),
  };
}

class Address {
  int? id;
  String? addressType;
  String? houseFlatNo;
  String? buildingSocietyName;
  String? landmark;
  String? area;
  String? city;
  String? state;
  String? pincode;
  String? latitude;
  String? longitude;
  bool? isDefault;

  Address({
    this.id,
    this.addressType,
    this.houseFlatNo,
    this.buildingSocietyName,
    this.landmark,
    this.area,
    this.city,
    this.state,
    this.pincode,
    this.latitude,
    this.longitude,
    this.isDefault,
  });

  Address copyWith({
    int? id,
    String? addressType,
    String? houseFlatNo,
    String? buildingSocietyName,
    String? landmark,
    String? area,
    String? city,
    String? state,
    String? pincode,
    String? latitude,
    String? longitude,
    bool? isDefault,
  }) =>
      Address(
        id: id ?? this.id,
        addressType: addressType ?? this.addressType,
        houseFlatNo: houseFlatNo ?? this.houseFlatNo,
        buildingSocietyName: buildingSocietyName ?? this.buildingSocietyName,
        landmark: landmark ?? this.landmark,
        area: area ?? this.area,
        city: city ?? this.city,
        state: state ?? this.state,
        pincode: pincode ?? this.pincode,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        isDefault: isDefault ?? this.isDefault,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    addressType: json["address_type"],
    houseFlatNo: json["house_flat_no"],
    buildingSocietyName: json["building_society_name"],
    landmark: json["landmark"],
    area: json["area"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address_type": addressType,
    "house_flat_no": houseFlatNo,
    "building_society_name": buildingSocietyName,
    "landmark": landmark,
    "area": area,
    "city": city,
    "state": state,
    "pincode": pincode,
    "latitude": latitude,
    "longitude": longitude,
    "is_default": isDefault,
  };
}

class Customer {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? gender;
  ProfilePhoto? profilePhoto;
  DateTime? lastLoginAt;
  DateTime? createdAt;

  Customer({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.profilePhoto,
    this.lastLoginAt,
    this.createdAt,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    ProfilePhoto? profilePhoto,
    DateTime? lastLoginAt,
    DateTime? createdAt,
  }) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        lastLoginAt: lastLoginAt ?? this.lastLoginAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    gender: json["gender"],
    profilePhoto: json["profile_photo"] == null ? null : ProfilePhoto.fromJson(json["profile_photo"]),
    lastLoginAt: json["last_login_at"] == null ? null : DateTime.parse(json["last_login_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
    "profile_photo": profilePhoto?.toJson(),
    "last_login_at": lastLoginAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
  };
}

class ProfilePhoto {
  String? original;
  String? thumb;

  ProfilePhoto({
    this.original,
    this.thumb,
  });

  ProfilePhoto copyWith({
    String? original,
    String? thumb,
  }) =>
      ProfilePhoto(
        original: original ?? this.original,
        thumb: thumb ?? this.thumb,
      );

  factory ProfilePhoto.fromJson(Map<String, dynamic> json) => ProfilePhoto(
    original: json["original"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "original": original,
    "thumb": thumb,
  };
}
