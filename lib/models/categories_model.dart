// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';

CategoriesModel categoriesFromJson(String str) =>
    CategoriesModel.fromMap(json.decode(str));

String categoriesToJson(CategoriesModel data) => json.encode(data.toMap());

class CategoriesModel with ChangeNotifier {
  List<Result> result;
  int statusCode;
  String message;
  bool isError;
  bool isLoaded = false;

  bool _loading=false;

  CategoriesModel({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });
setSubVisibility(index){
  result[index].showSubs=!(result[index].showSubs);
  notifyListeners();
}
  factory CategoriesModel.fromMap(Map<String, dynamic> json) => CategoriesModel(
        result: List<Result>.from(json["Result"].map((x) => Result.fromMap(x))),
        statusCode: json["StatusCode"],
        message: json["Message"],
        isError: json["IsError"],
      );

  Map<String, dynamic> toMap() => {
        "Result": List<dynamic>.from(result.map((x) => x.toMap())),
        "StatusCode": statusCode,
        "Message": message,
        "IsError": isError,
      };

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

    result= List<Result>.from(json["Result"].map((x) => Result.fromMap(x)));
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
  String updatedBy;
  String createdBy;
  DateTime createdOn;
  DateTime updatedOn;

  var showSubs=false;

  Result({
    this.id,
    this.name,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["Id"],
        name: json["Name"],
        updatedBy: json["UpdatedBy"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        updatedOn: json["UpdatedOn"] == null
            ? null
            : DateTime.parse(json["UpdatedOn"]),
      );

  Map<String, dynamic> toMap() => {
        "Id": id,
        "Name": name,
        "UpdatedBy": updatedBy,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "UpdatedOn": updatedOn == null ? null : updatedOn.toIso8601String(),
      };
}
