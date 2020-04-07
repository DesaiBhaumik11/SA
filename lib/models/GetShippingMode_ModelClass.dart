// To parse this JSON data, do
//
//     final getShippingMode = getShippingModeFromJson(jsonString);

import 'dart:convert';

GetShippingMode getShippingModeFromJson(String str) => GetShippingMode.fromJson(json.decode(str));

String getShippingModeToJson(GetShippingMode data) => json.encode(data.toJson());

class GetShippingMode {

  bool homeDeliveryEnabled;
  bool pickupFromStoreEnabled;
  double minOrderValueForHomeDelivery;
  double homeDeliveryChargesBelowMinOrderValue;

  GetShippingMode({

    this.homeDeliveryEnabled,
    this.pickupFromStoreEnabled,
    this.minOrderValueForHomeDelivery,
    this.homeDeliveryChargesBelowMinOrderValue,
  });

  factory GetShippingMode.fromJson(Map<String, dynamic> json) => GetShippingMode(
    homeDeliveryEnabled: json["HomeDeliveryEnabled"],
    pickupFromStoreEnabled: json["PickupFromStoreEnabled"],
    minOrderValueForHomeDelivery: json["MinOrderValueForHomeDelivery"],
    homeDeliveryChargesBelowMinOrderValue: json["HomeDeliveryChargesBelowMinOrderValue"],
  );

  Map<String, dynamic> toJson() => {
    "HomeDeliveryEnabled": homeDeliveryEnabled,
    "PickupFromStoreEnabled": pickupFromStoreEnabled,
    "MinOrderValueForHomeDelivery": minOrderValueForHomeDelivery,
    "HomeDeliveryChargesBelowMinOrderValue": homeDeliveryChargesBelowMinOrderValue,
  };
}
