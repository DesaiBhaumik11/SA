// To parse this JSON data, do
//
//     final getShippingSlotWithMode = getShippingSlotWithModeFromJson(jsonString);

import 'dart:convert';

GetShippingSlotWithMode getShippingSlotWithModeFromJson(String str) => GetShippingSlotWithMode.fromJson(json.decode(str));

String getShippingSlotWithModeToJson(GetShippingSlotWithMode data) => json.encode(data.toJson());

class GetShippingSlotWithMode {
  String id;
  String day;
  String timeFrom;
  String timeTo;
  String title;
  String description;
  String businessId;
  String shippingMode;
  String createdBy;
  DateTime createdOn;

  GetShippingSlotWithMode({
    this.id,
    this.day,
    this.timeFrom,
    this.timeTo,
    this.title,
    this.description,
    this.businessId,
    this.shippingMode,
    this.createdBy,
    this.createdOn,
  });

  factory GetShippingSlotWithMode.fromJson(Map<String, dynamic> json) => GetShippingSlotWithMode(
    id: json["Id"],
    day: json["Day"],
    timeFrom: json["TimeFrom"],
    timeTo: json["TimeTo"],
    title: json["Title"],
    description: json["Description"],
    businessId: json["BusinessId"],
    shippingMode: json["ShippingMode"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Day": day,
    "TimeFrom": timeFrom,
    "TimeTo": timeTo,
    "Title": title,
    "Description": description,
    "BusinessId": businessId,
    "ShippingMode": shippingMode,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
  };
}
