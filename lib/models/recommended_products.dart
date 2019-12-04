// To parse this JSON data, do
//
//     final recommendedProductsModel = recommendedProductsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/models/product_common.dart';

RecommendedProductsModel recommendedProductsModelFromJson(String str) => RecommendedProductsModel.fromMap(json.decode(str));

String recommendedProductsModelToJson(RecommendedProductsModel data) => json.encode(data.toMap());

class RecommendedProductsModel with ChangeNotifier {
  List<Result> result;
  int statusCode;
  String message;
  bool isError;
  bool loaded=false;
  bool _loading=false;
  RecommendedProductsModel({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory RecommendedProductsModel.fromMap(Map<String, dynamic> json) => RecommendedProductsModel(
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
      NetworkUtils.getRequest(endPoint: ""+Constant.GetBestSellingProducts).then((r) {
        _loading=false;
        print("Recommended product response = $r");
        setData(json.decode(r));
      }).catchError((e) {
        _loading=false;
        print("Error caught in Recommended $e");
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

