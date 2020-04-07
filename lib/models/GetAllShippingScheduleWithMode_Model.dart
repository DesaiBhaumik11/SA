// To parse this JSON data, do
//
//     final getAllShippingScheduleWithMode = getAllShippingScheduleWithModeFromJson(jsonString);

import 'dart:convert';

GetAllShippingScheduleWithMode getAllShippingScheduleWithModeFromJson(String str) => GetAllShippingScheduleWithMode.fromJson(json.decode(str));

String getAllShippingScheduleWithModeToJson(GetAllShippingScheduleWithMode data) => json.encode(data.toJson());

class GetAllShippingScheduleWithMode {
  DateTime key;
  List<Item> items;

  GetAllShippingScheduleWithMode({
    this.key,
    this.items,
  });

  factory GetAllShippingScheduleWithMode.fromJson(Map<String, dynamic> json) => GetAllShippingScheduleWithMode(
    key: DateTime.parse(json["Key"]),
    items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Key": key.toIso8601String(),
    "Items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String id;
  DateTime date;
  String timeFrom;
  String timeTo;
  bool isHoliday;
  ShippingMode shippingMode;
  String businessLocationId;

  Item({
    this.id,
    this.date,
    this.timeFrom,
    this.timeTo,
    this.isHoliday,
    this.shippingMode,
    this.businessLocationId,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["Id"],
    date: DateTime.parse(json["Date"]),
    timeFrom: json["TimeFrom"],
    timeTo: json["TimeTo"],
    isHoliday: json["IsHoliday"],
    shippingMode: shippingModeValues.map[json["ShippingMode"]],
    businessLocationId: json["BusinessLocationId"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Date": date.toIso8601String(),
    "TimeFrom": timeFrom,
    "TimeTo": timeTo,
    "IsHoliday": isHoliday,
    "ShippingMode": shippingModeValues.reverse[shippingMode],
    "BusinessLocationId": businessLocationId,
  };
}

enum ShippingMode { HOME_DELIVERY, PICKUP_FROM_STORE }

final shippingModeValues = EnumValues({
  "HomeDelivery": ShippingMode.HOME_DELIVERY,
  "PickupFromStore": ShippingMode.PICKUP_FROM_STORE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
