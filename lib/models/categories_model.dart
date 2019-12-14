// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel extends ChangeNotifier {
  List<Result> result;
  int statusCode;
  String message;
  bool isError;
  bool _loading =false ;
  bool isLoaded = false;

  CategoriesModel({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
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



  setSubVisibility(index){
    result[index].showSubs=!(result[index].showSubs);
    notifyListeners();
  }
  loadCategories() {
    if(!_loading) {
      _loading=true;
      NetworkUtils.getRequest(endPoint: Constant.GetAllCategories).then((r) {
        _loading=false;
        print("categories response = $r");
        setData(json.decode(r));
      }).catchError((e) {
        _loading=false;
        print("Error caught");
      });
    }
  }

  void setData(json) {

    result= List<Result>.from(json["Result"].map((x) => Result.fromJson(x)));
    statusCode= json["StatusCode"];
    message= json["Message"];
    isError= json["IsError"];
    isLoaded = true;
    notifyListeners();
  }


}

class Result {
  String id;
  String name;
  String parentId;
  String mediaId;
  dynamic products;
  List<Result> subCategories;
  dynamic parent;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  var showSubs=false;

  Result({
    this.id,
    this.name,
    this.parentId,
    this.mediaId,
    this.products,
    this.subCategories,
    this.parent,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    name: json["Name"],
    parentId: json["ParentId"] == null ? null : json["ParentId"],
    mediaId: json["MediaId"],
    products: json["Products"],
    subCategories: json["SubCategories"] == null ? null : List<Result>.from(json["SubCategories"].map((x) => Result.fromJson(x))),
    parent: json["Parent"],
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "ParentId": parentId == null ? null : parentId,
    "MediaId": mediaId,
    "Products": products,
    "SubCategories": subCategories == null ? null : List<dynamic>.from(subCategories.map((x) => x.toJson())),
    "Parent": parent,
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}

