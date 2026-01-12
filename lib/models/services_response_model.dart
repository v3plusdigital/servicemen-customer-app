// To parse this JSON data, do
//
//     final servicesResponseModel = servicesResponseModelFromJson(jsonString);

import 'dart:convert';

ServicesResponseModel servicesResponseModelFromJson(String str) => ServicesResponseModel.fromJson(json.decode(str));

String servicesResponseModelToJson(ServicesResponseModel data) => json.encode(data.toJson());

class ServicesResponseModel {
  bool? success;
  Data? data;

  ServicesResponseModel({
    this.success,
    this.data,
  });

  ServicesResponseModel copyWith({
    bool? success,
    Data? data,
  }) =>
      ServicesResponseModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory ServicesResponseModel.fromJson(Map<String, dynamic> json) => ServicesResponseModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  ServiceType? serviceType;
  List<Service>? services;
  Pagination? pagination;

  Data({
    this.serviceType,
    this.services,
    this.pagination,
  });

  Data copyWith({
    ServiceType? serviceType,
    List<Service>? services,
    Pagination? pagination,
  }) =>
      Data(
        serviceType: serviceType ?? this.serviceType,
        services: services ?? this.services,
        pagination: pagination ?? this.pagination,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    serviceType: json["service_type"] == null ? null : ServiceType.fromJson(json["service_type"]),
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "service_type": serviceType?.toJson(),
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Pagination {
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;

  Pagination({
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
  });

  Pagination copyWith({
    int? currentPage,
    int? perPage,
    int? total,
    int? lastPage,
  }) =>
      Pagination(
        currentPage: currentPage ?? this.currentPage,
        perPage: perPage ?? this.perPage,
        total: total ?? this.total,
        lastPage: lastPage ?? this.lastPage,
      );

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    perPage: json["per_page"],
    total: json["total"],
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "per_page": perPage,
    "total": total,
    "last_page": lastPage,
  };
}

class ServiceType {
  int? id;
  String? name;
  String? image;
  String? thumbnail;

  ServiceType({
    this.id,
    this.name,
    this.image,
    this.thumbnail,
  });

  ServiceType copyWith({
    int? id,
    String? name,
    String? image,
    String? thumbnail,
  }) =>
      ServiceType(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        thumbnail: thumbnail ?? this.thumbnail,
      );

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
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

class Service {
  int? id;
  String? name;
  String? shortDescription;
  String? description;
  String? image;
  String? thumbnail;
  String? price;

  Service({
    this.id,
    this.name,
    this.shortDescription,
    this.description,
    this.image,
    this.thumbnail,
    this.price,
  });

  Service copyWith({
    int? id,
    String? name,
    String? shortDescription,
    String? description,
    String? image,
    String? thumbnail,
    String? price,
  }) =>
      Service(
        id: id ?? this.id,
        name: name ?? this.name,
        shortDescription: shortDescription ?? this.shortDescription,
        description: description ?? this.description,
        image: image ?? this.image,
        thumbnail: thumbnail ?? this.thumbnail,
        price: price ?? this.price,
      );

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    shortDescription: json["short_description"],
    description: json["description"],
    image: json["image"],
    thumbnail: json["thumbnail"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_description": shortDescription,
    "description": description,
    "image": image,
    "thumbnail": thumbnail,
    "price": price,
  };
}
