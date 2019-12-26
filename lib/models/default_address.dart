// To parse this JSON data, do
//
//     final defaultAddressModel = defaultAddressModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/models/address_modal.dart';

DefaultAddressModel defaultAddressModelFromJson(String str) => DefaultAddressModel.fromJson(json.decode(str));

String defaultAddressModelToJson(DefaultAddressModel data) => json.encode(data.toJson());

class DefaultAddressModel with ChangeNotifier {
  Result result;
  int statusCode;
  String message;
  bool isError;

  bool loaded=false;

  DefaultAddressModel({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory DefaultAddressModel.fromJson(Map<String, dynamic> json) => DefaultAddressModel(
    result: Result.fromJson(json["Result"]),
    statusCode: json["StatusCode"],
    message: json["Message"],
    isError: json["IsError"],
  );

  Map<String, dynamic> toJson() => {
    "Result": result.toJson(),
    "StatusCode": statusCode,
    "Message": message,
    "IsError": isError,
  };

  void loadAddress(context) {
    NetworkUtils.getRequest(endPoint: "GetMyDefaultAddress").then((r){
      var root=json.decode(r);
      if(root["StatusCode"]==200){
        setData(root);
      }
    });
  }

  void setData(json) {
    result= Result.fromJson(json["Result"]);
    statusCode= json["StatusCode"];
    message= json["Message"];
    isError= json["IsError"];
    loaded=true;
    notifyListeners();
  }
}
//
//class Result {
//  String id;
//  String name;
//  String contactId;
//  String addressLine1;
//  String addressLine2;
//  String city;
//  String country;
//  String state;
//  String pin;
//  int latitude;
//  int longitude;
//  bool isDefault;
//  dynamic updatedBy;
//  String createdBy;
//  DateTime createdOn;
//  dynamic updatedOn;
//
//  Result({
//    this.id,
//    this.name,
//    this.contactId,
//    this.addressLine1,
//    this.addressLine2,
//    this.city,
//    this.country,
//    this.state,
//    this.pin,
//    this.latitude,
//    this.longitude,
//    this.isDefault,
//    this.updatedBy,
//    this.createdBy,
//    this.createdOn,
//    this.updatedOn,
//  });
//
//  factory Result.fromJson(Map<String, dynamic> json) => Result(
//    id: json["Id"],
//    name: json["Name"],
//    contactId: json["ContactId"],
//    addressLine1: json["AddressLine1"],
//    addressLine2: json["AddressLine2"],
//    city: json["City"],
//    country: json["Country"],
//    state: json["State"],
//    pin: json["Pin"],
//    latitude: json["Latitude"],
//    longitude: json["Longitude"],
//    isDefault: json["IsDefault"],
//    updatedBy: json["UpdatedBy"],
//    createdBy: json["CreatedBy"],
//    createdOn: DateTime.parse(json["CreatedOn"]),
//    updatedOn: json["UpdatedOn"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "Id": id,
//    "Name": name,
//    "ContactId": contactId,
//    "AddressLine1": addressLine1,
//    "AddressLine2": addressLine2,
//    "City": city,
//    "Country": country,
//    "State": state,
//    "Pin": pin,
//    "Latitude": latitude,
//    "Longitude": longitude,
//    "IsDefault": isDefault,
//    "UpdatedBy": updatedBy,
//    "CreatedBy": createdBy,
//    "CreatedOn": createdOn.toIso8601String(),
//    "UpdatedOn": updatedOn,
//  };
//}
