// To parse this JSON data, do
//
//     final dashboardResponseModel = dashboardResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardResponseModel dashboardResponseModelFromJson(String str) => DashboardResponseModel.fromJson(json.decode(str));

String dashboardResponseModelToJson(DashboardResponseModel data) => json.encode(data.toJson());

class DashboardResponseModel {
  bool? success;
  Data? data;

  DashboardResponseModel({
    this.success,
    this.data,
  });

  DashboardResponseModel copyWith({
    bool? success,
    Data? data,
  }) =>
      DashboardResponseModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) => DashboardResponseModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  List<Offer>? offers;
  List<ServiceTypeElement>? serviceTypes;
  List<MediaGallery>? mediaGallery;

  Data({
    this.offers,
    this.serviceTypes,
    this.mediaGallery,
  });

  Data copyWith({
    List<Offer>? offers,
    List<ServiceTypeElement>? serviceTypes,
    List<MediaGallery>? mediaGallery,
  }) =>
      Data(
        offers: offers ?? this.offers,
        serviceTypes: serviceTypes ?? this.serviceTypes,
        mediaGallery: mediaGallery ?? this.mediaGallery,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
    serviceTypes: json["service_types"] == null ? [] : List<ServiceTypeElement>.from(json["service_types"]!.map((x) => ServiceTypeElement.fromJson(x))),
    mediaGallery: json["media_gallery"] == null ? [] : List<MediaGallery>.from(json["media_gallery"]!.map((x) => MediaGallery.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "offers": offers == null ? [] : List<dynamic>.from(offers!.map((x) => x.toJson())),
    "service_types": serviceTypes == null ? [] : List<dynamic>.from(serviceTypes!.map((x) => x.toJson())),
    "media_gallery": mediaGallery == null ? [] : List<dynamic>.from(mediaGallery!.map((x) => x.toJson())),
  };
}

class MediaGallery {
  int? id;
  String? title;
  String? type;
  String? fileUrl;
  String? thumbnail;

  MediaGallery({
    this.id,
    this.title,
    this.type,
    this.fileUrl,
    this.thumbnail,
  });

  MediaGallery copyWith({
    int? id,
    String? title,
    String? type,
    String? fileUrl,
    String? thumbnail,
  }) =>
      MediaGallery(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        fileUrl: fileUrl ?? this.fileUrl,
        thumbnail: thumbnail ?? this.thumbnail,
      );

  factory MediaGallery.fromJson(Map<String, dynamic> json) => MediaGallery(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    fileUrl: json["file_url"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "file_url": fileUrl,
    "thumbnail": thumbnail,
  };
}

class Offer {
  int? id;
  String? code;
  String? name;
  String? description;
  String? discountType;
  int? discountValue;
  OfferServiceType? serviceType;
  List<Service>? services;
  int? totalOriginalAmount;
  int? totalAfterDiscount;
  int? savings;
  String? image;
  String? thumbnail;
  DateTime? validFrom;
  DateTime? validTo;

  Offer({
    this.id,
    this.code,
    this.name,
    this.description,
    this.discountType,
    this.discountValue,
    this.serviceType,
    this.services,
    this.totalOriginalAmount,
    this.totalAfterDiscount,
    this.savings,
    this.image,
    this.thumbnail,
    this.validFrom,
    this.validTo,
  });

  Offer copyWith({
    int? id,
    String? code,
    String? name,
    String? description,
    String? discountType,
    int? discountValue,
    OfferServiceType? serviceType,
    List<Service>? services,
    int? totalOriginalAmount,
    int? totalAfterDiscount,
    int? savings,
    String? image,
    String? thumbnail,
    DateTime? validFrom,
    DateTime? validTo,
  }) =>
      Offer(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        description: description ?? this.description,
        discountType: discountType ?? this.discountType,
        discountValue: discountValue ?? this.discountValue,
        serviceType: serviceType ?? this.serviceType,
        services: services ?? this.services,
        totalOriginalAmount: totalOriginalAmount ?? this.totalOriginalAmount,
        totalAfterDiscount: totalAfterDiscount ?? this.totalAfterDiscount,
        savings: savings ?? this.savings,
        image: image ?? this.image,
        thumbnail: thumbnail ?? this.thumbnail,
        validFrom: validFrom ?? this.validFrom,
        validTo: validTo ?? this.validTo,
      );

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    description: json["description"],
    discountType: json["discount_type"],
    discountValue: json["discount_value"],
    serviceType: json["service_type"] == null ? null : OfferServiceType.fromJson(json["service_type"]),
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    totalOriginalAmount: json["total_original_amount"],
    totalAfterDiscount: json["total_after_discount"],
    savings: json["savings"],
    image: json["image"],
    thumbnail: json["thumbnail"],
    validFrom: json["valid_from"] == null ? null : DateTime.parse(json["valid_from"]),
    validTo: json["valid_to"] == null ? null : DateTime.parse(json["valid_to"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "description": description,
    "discount_type": discountType,
    "discount_value": discountValue,
    "service_type": serviceType?.toJson(),
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    "total_original_amount": totalOriginalAmount,
    "total_after_discount": totalAfterDiscount,
    "savings": savings,
    "image": image,
    "thumbnail": thumbnail,
    "valid_from": validFrom?.toIso8601String(),
    "valid_to": validTo?.toIso8601String(),
  };
}

class OfferServiceType {
  int? id;
  String? name;
  dynamic cartId;

  OfferServiceType({
    this.id,
    this.name,
    this.cartId,
  });

  OfferServiceType copyWith({
    int? id,
    String? name,
    dynamic cartId,
  }) =>
      OfferServiceType(
        id: id ?? this.id,
        name: name ?? this.name,
        cartId: cartId ?? this.cartId,
      );

  factory OfferServiceType.fromJson(Map<String, dynamic> json) => OfferServiceType(
    id: json["id"],
    name: json["name"],
    cartId: json["cart_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cart_id": cartId,
  };
}

class Service {
  int? id;
  String? name;
  int? price;
  int? quantity;
  int? subtotal;

  Service({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.subtotal,
  });

  Service copyWith({
    int? id,
    String? name,
    int? price,
    int? quantity,
    int? subtotal,
  }) =>
      Service(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        subtotal: subtotal ?? this.subtotal,
      );

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    quantity: json["quantity"],
    subtotal: json["subtotal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "quantity": quantity,
    "subtotal": subtotal,
  };
}

class ServiceTypeElement {
  int? id;
  String? name;
  String? image;
  String? thumbnail;

  ServiceTypeElement({
    this.id,
    this.name,
    this.image,
    this.thumbnail,
  });

  ServiceTypeElement copyWith({
    int? id,
    String? name,
    String? image,
    String? thumbnail,
  }) =>
      ServiceTypeElement(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        thumbnail: thumbnail ?? this.thumbnail,
      );

  factory ServiceTypeElement.fromJson(Map<String, dynamic> json) => ServiceTypeElement(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "thumbnail": thumbnail,
  };
}
