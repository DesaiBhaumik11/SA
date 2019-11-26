// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/models/product_common.dart';

SearchModel searchModelFromJson(String str) => SearchModel.fromMap(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toMap());

class SearchModel with ChangeNotifier{
  List<Result> result;
  int statusCode;
  String message;
  bool isError;

  bool search=false;
  SearchModel({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory SearchModel.fromMap(Map<String, dynamic> json) => SearchModel(
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

  searchProducts(s){
      NetworkUtils.getRequest(endPoint: "SearchProduct?searchString=$s").then((r){
        print("Best selling product response = $r");
        setData(json.decode(r));
      }).catchError((e) {
        print("Error caught in search $e");
      });
  }

  void setData(json) {
    result= List<Result>.from(json["Result"].map((x) => Result.fromMap(x)));
    statusCode= json["StatusCode"];
    message= json["Message"];
    isError= json["IsError"];
    notifyListeners();
  }

  void searching(bool param0) {
    search=param0;
    notifyListeners();
  }
}

