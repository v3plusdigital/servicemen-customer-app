// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

GetCartModel getCartModelFromJson(String str) =>
    GetCartModel.fromJson(json.decode(str));

String getCartModelToJson(GetCartModel data) => json.encode(data.toJson());

class GetCartModel {
  bool? success;
  Data? data;

  GetCartModel({this.success, this.data});

  GetCartModel copyWith({bool? success, Data? data}) =>
      GetCartModel(success: success ?? this.success, data: data ?? this.data);

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class Data {
  List<Cart>? carts;
  int? total;

  Data({this.carts, this.total});

  Data copyWith({List<Cart>? carts, int? total}) =>
      Data(carts: carts ?? this.carts, total: total ?? this.total);

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    carts: json["carts"] == null
        ? []
        : List<Cart>.from(json["carts"]!.map((x) => Cart.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "carts": carts == null
        ? []
        : List<dynamic>.from(carts!.map((x) => x.toJson())),
    "total": total,
  };
}

class Cart {
  int? id;
  int? serviceTypeId;
  String? serviceTypeName;
  String? serviceTypeImage;
  String? serviceTypeImageThumb;
  dynamic addressId;
  dynamic address;
  dynamic preferredDate;
  dynamic preferredTime;
  dynamic problemDescription;
  dynamic offerId;
  bool? isOfferCart;
  List<Item>? items;
  int? subtotal;
  int? discountAmount;
  int? totalAmount;
  bool? isReadyForCheckout;
  DateTime? createdAt;

  Cart({
    this.id,
    this.serviceTypeId,
    this.serviceTypeName,
    this.serviceTypeImage,
    this.serviceTypeImageThumb,
    this.addressId,
    this.address,
    this.preferredDate,
    this.preferredTime,
    this.problemDescription,
    this.offerId,
    this.isOfferCart,
    this.items,
    this.subtotal,
    this.discountAmount,
    this.totalAmount,
    this.isReadyForCheckout,
    this.createdAt,
  });

  Cart copyWith({
    int? id,
    int? serviceTypeId,
    String? serviceTypeName,
    String? serviceTypeImage,
    String? serviceTypeImageThumb,
    dynamic addressId,
    dynamic address,
    dynamic preferredDate,
    dynamic preferredTime,
    dynamic problemDescription,
    dynamic offerId,
    bool? isOfferCart,
    List<Item>? items,
    int? subtotal,
    int? discountAmount,
    int? totalAmount,
    bool? isReadyForCheckout,
    DateTime? createdAt,
  }) => Cart(
    id: id ?? this.id,
    serviceTypeId: serviceTypeId ?? this.serviceTypeId,
    serviceTypeName: serviceTypeName ?? this.serviceTypeName,
    serviceTypeImage: serviceTypeImage ?? this.serviceTypeImage,
    serviceTypeImageThumb: serviceTypeImageThumb ?? this.serviceTypeImageThumb,
    addressId: addressId ?? this.addressId,
    address: address ?? this.address,
    preferredDate: preferredDate ?? this.preferredDate,
    preferredTime: preferredTime ?? this.preferredTime,
    problemDescription: problemDescription ?? this.problemDescription,
    offerId: offerId ?? this.offerId,
    isOfferCart: isOfferCart ?? this.isOfferCart,
    items: items ?? this.items,
    subtotal: subtotal ?? this.subtotal,
    discountAmount: discountAmount ?? this.discountAmount,
    totalAmount: totalAmount ?? this.totalAmount,
    isReadyForCheckout: isReadyForCheckout ?? this.isReadyForCheckout,
    createdAt: createdAt ?? this.createdAt,
  );

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    serviceTypeId: json["service_type_id"],
    serviceTypeName: json["service_type_name"],
    serviceTypeImage: json["service_type_image"],
    serviceTypeImageThumb: json["service_type_image_thumb"],
    addressId: json["address_id"],
    address: json["address"],
    preferredDate: json["preferred_date"],
    preferredTime: json["preferred_time"],
    problemDescription: json["problem_description"],
    offerId: json["offer_id"],
    isOfferCart: json["is_offer_cart"],
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    subtotal: json["subtotal"],
    discountAmount: json["discount_amount"],
    totalAmount: json["total_amount"],
    isReadyForCheckout: json["is_ready_for_checkout"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_type_id": serviceTypeId,
    "service_type_name": serviceTypeName,
    "service_type_image": serviceTypeImage,
    "service_type_image_thumb": serviceTypeImageThumb,
    "address_id": addressId,
    "address": address,
    "preferred_date": preferredDate,
    "preferred_time": preferredTime,
    "problem_description": problemDescription,
    "offer_id": offerId,
    "is_offer_cart": isOfferCart,
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "subtotal": subtotal,
    "discount_amount": discountAmount,
    "total_amount": totalAmount,
    "is_ready_for_checkout": isReadyForCheckout,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Item {
  int? id;
  int? serviceId;
  String? serviceName;
  int? servicePrice;
  String? serviceImage;
  String? serviceImageThumb;
  int? quantity;
  int? subtotal;

  Item({
    this.id,
    this.serviceId,
    this.serviceName,
    this.servicePrice,
    this.serviceImage,
    this.serviceImageThumb,
    this.quantity,
    this.subtotal,
  });

  Item copyWith({
    int? id,
    int? serviceId,
    String? serviceName,
    int? servicePrice,
    String? serviceImage,
    String? serviceImageThumb,
    int? quantity,
    int? subtotal,
  }) => Item(
    id: id ?? this.id,
    serviceId: serviceId ?? this.serviceId,
    serviceName: serviceName ?? this.serviceName,
    servicePrice: servicePrice ?? this.servicePrice,
    serviceImage: serviceImage ?? this.serviceImage,
    serviceImageThumb: serviceImageThumb ?? this.serviceImageThumb,
    quantity: quantity ?? this.quantity,
    subtotal: subtotal ?? this.subtotal,
  );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    serviceId: json["service_id"],
    serviceName: json["service_name"],
    servicePrice: json["service_price"],
    serviceImage: json["service_image"],
    serviceImageThumb: json["service_image_thumb"],
    quantity: json["quantity"],
    subtotal: json["subtotal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_id": serviceId,
    "service_name": serviceName,
    "service_price": servicePrice,
    "service_image": serviceImage,
    "service_image_thumb": serviceImageThumb,
    "quantity": quantity,
    "subtotal": subtotal,
  };
}
