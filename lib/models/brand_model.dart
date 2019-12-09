// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';

BrandModel brandModelFromJson(String str) =>
    BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel with ChangeNotifier {
  List<Result> result;
  int statusCode;
  String message;
  bool isError;
  bool loaded = false;
  bool _loading = true;

  BrandModel({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        result:
            List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
        statusCode: json["StatusCode"],
        message: json["Message"],
        isError: json["IsError"],
      );

  void setData(json) {
    statusCode = json["StatusCode"];
    message = json["Message"];
    isError = json["IsError"];

    if(!isError){
      result = List<Result>.from(json["Result"].map((x) => Result.fromJson(x)));
    }else{
      result=List();
    }
    _loading=false;
    loaded = true;
    notifyListeners();
  }

  void loadBrands(){
    if(!_loading){
      _loading=true;
      NetworkUtils.getRequest(endPoint: Constant.GetBrands).then((r){
        setData(json.decode(r));
      }).catchError((e){loaded=false;
      _loading=false;});
    }
  }

  Map<String, dynamic> toJson() => {
        "Result": List<dynamic>.from(result.map((x) => x.toJson())),
        "StatusCode": statusCode,
        "Message": message,
        "IsError": isError,
      };
}

class Result {
  String id;
  String name;
  dynamic mediaId;
  String manufacturerId;
  Manufacturers manufacturers;
  String updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  Result({
    this.id,
    this.name,
    this.mediaId,
    this.manufacturerId,
    this.manufacturers,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["Id"],
        name: json["Name"],
        mediaId: json["MediaId"],
        manufacturerId: json["ManufacturerId"],
        manufacturers: Manufacturers.fromJson(json["Manufacturers"]),
        updatedBy: json["UpdatedBy"] == null ? null : json["UpdatedBy"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        updatedOn: json["UpdatedOn"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "MediaId": mediaId,
        "ManufacturerId": manufacturerId,
        "Manufacturers": manufacturers.toJson(),
        "UpdatedBy": updatedBy == null ? null : updatedBy,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "UpdatedOn": updatedOn,
      };
}

class Manufacturers {
  String id;
  String name;
  dynamic products;
  dynamic brands;
  String updatedBy;
  String createdBy;
  DateTime createdOn;
  DateTime updatedOn;

  Manufacturers({
    this.id,
    this.name,
    this.products,
    this.brands,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory Manufacturers.fromJson(Map<String, dynamic> json) => Manufacturers(
        id: json["Id"],
        name: json["Name"],
        products: json["Products"],
        brands: json["Brands"],
        updatedBy: json["UpdatedBy"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        updatedOn: json["UpdatedOn"] == null
            ? null
            : DateTime.parse(json["UpdatedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Products": products,
        "Brands": brands,
        "UpdatedBy": updatedBy,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "UpdatedOn": updatedOn == null ? null : updatedOn.toIso8601String(),
      };
}
