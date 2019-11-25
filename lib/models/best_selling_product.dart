// To parse this JSON data, do
//
//     final bestSellingProductModel = bestSellingProductModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/models/product_common.dart';

BestSellingProductModel bestSellingProductModelFromJson(String str) => BestSellingProductModel.fromMap(json.decode(str));

String bestSellingProductModelToJson(BestSellingProductModel data) => json.encode(data.toMap());

class BestSellingProductModel with ChangeNotifier {
  List<Result> result;
  int statusCode;
  String message;
  bool isError;
  bool loaded=false;
  bool _loading=false;

  BestSellingProductModel({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory BestSellingProductModel.fromMap(Map<String, dynamic> json) => BestSellingProductModel(
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

  loadProducts(){
    if(!_loading) {
      _loading=true;
      NetworkUtils.getRequest(endPoint: "GetBestSellingProducts").then((r) {
        _loading=false;
        print("Best selling product response = $r");
        setData(json.decode(r));
      }).catchError((e) {
       _loading=false;
       print("Error caught in best selling $e");
     });
    }
  }

  void setData(json) {
    result= List<Result>.from(json["Result"].map((x) => Result.fromMap(x)));
    statusCode= json["StatusCode"];
    message= json["Message"];
    isError= json["IsError"];
    loaded=true;
    notifyListeners();
  }
}


