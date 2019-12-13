// To parse this JSON data, do
//
//     final shippingSlotModal = shippingSlotModalFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';

ShippingSlotModal shippingSlotModalFromJson(String str) => ShippingSlotModal.fromJson(json.decode(str));

String shippingSlotModalToJson(ShippingSlotModal data) => json.encode(data.toJson());

class ShippingSlotModal extends ChangeNotifier{
  List<Result> result;
  int statusCode;
  int checkedValue=0 ;
  String message;
  bool isError;
  bool loaded = false ;
  bool is_loading = false ;

  ShippingSlotModal({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory ShippingSlotModal.fromJson(Map<String, dynamic> json) => ShippingSlotModal(
    result: List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
    statusCode: json["StatusCode"],
    message: json["Message"],
    isError: json["IsError"],
  );

  Map<String, dynamic> toJson() => {
    "Result": List<dynamic>.from(result.map((x) => x.toJson())),
    "StatusCode": statusCode,
    "Message": message,
    "IsError": isError,
  };

  updateCheckedValue(int val){
    checkedValue = val ;
    notifyListeners() ;

  }

  getShippingSlot(){

    if(!is_loading){
      is_loading = true ;
      NetworkUtils.getRequest(endPoint: Constant.GetShippingSlot).then((response){
        is_loading = false  ;
        print("getShippingSlot = $response");
        setData(json.decode(response)) ;
        loaded = true ;
      });
    }
  }

  void setData(json) {
    result= List<Result>.from(json["Result"].map((x) => Result.fromJson(x)));
    statusCode= json["StatusCode"];
    message= json["Message"];
    isError= json["IsError"];

    notifyListeners() ;

  }



}

class Result {
  String id;
  String day;
  String timeFrom;
  String timeTo;
  String title;
  String description;
  String businessId;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  Result({
    this.id,
    this.day,
    this.timeFrom,
    this.timeTo,
    this.title,
    this.description,
    this.businessId,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    day: json["Day"],
    timeFrom: json["TimeFrom"],
    timeTo: json["TimeTo"],
    title: json["Title"],
    description: json["Description"],
    businessId: json["BusinessId"],
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Day": day,
    "TimeFrom": timeFrom,
    "TimeTo": timeTo,
    "Title": title,
    "Description": description,
    "BusinessId": businessId,
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}
