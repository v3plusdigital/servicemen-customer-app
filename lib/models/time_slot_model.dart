// To parse this JSON data, do
//
//     final timeSlotModel = timeSlotModelFromJson(jsonString);

import 'dart:convert';

TimeSlotModel timeSlotModelFromJson(String str) =>
    TimeSlotModel.fromJson(json.decode(str));

String timeSlotModelToJson(TimeSlotModel data) => json.encode(data.toJson());

class TimeSlotModel {
  bool? success;
  List<String>? data;

  TimeSlotModel({this.success, this.data});

  TimeSlotModel copyWith({bool? success, List<String>? data}) =>
      TimeSlotModel(success: success ?? this.success, data: data ?? this.data);

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<String>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
