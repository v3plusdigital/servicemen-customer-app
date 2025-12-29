// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  bool? success;
  Data? data;

  VerifyOtpModel({
    this.success,
    this.data,
  });

  VerifyOtpModel copyWith({
    bool? success,
    Data? data,
  }) =>
      VerifyOtpModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  int? expiresIn;
  bool? isNewUser;
  Customer? customer;

  Data({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
    this.isNewUser,
    this.customer,
  });

  Data copyWith({
    String? accessToken,
    String? refreshToken,
    String? tokenType,
    int? expiresIn,
    bool? isNewUser,
    Customer? customer,
  }) =>
      Data(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
        isNewUser: isNewUser ?? this.isNewUser,
        customer: customer ?? this.customer,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    isNewUser: json["is_new_user"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "is_new_user": isNewUser,
    "customer": customer?.toJson(),
  };
}

class Customer {
  int? id;
  dynamic name;
  dynamic email;
  String? phone;
  dynamic profilePhoto;

  Customer({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePhoto,
  });

  Customer copyWith({
    int? id,
    dynamic name,
    dynamic email,
    String? phone,
    dynamic profilePhoto,
  }) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        profilePhoto: profilePhoto ?? this.profilePhoto,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    profilePhoto: json["profile_photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "profile_photo": profilePhoto,
  };
}
