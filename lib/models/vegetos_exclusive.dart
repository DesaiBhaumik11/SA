// To parse this JSON data, do
//
//     final vegetosExclusiveModel = vegetosExclusiveModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/models/product_common.dart';

VegetosExclusiveModel vegetosExclusiveModelFromJson(String str) => VegetosExclusiveModel.fromMap(json.decode(str));

String vegetosExclusiveModelToJson(VegetosExclusiveModel data) => json.encode(data.toMap());

class VegetosExclusiveModel with ChangeNotifier {
  List<Result> result;
  int statusCode;
  String message;
  bool isError;

  bool _loading=false;
  bool loaded=false;

  VegetosExclusiveModel({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory VegetosExclusiveModel.fromMap(Map<String, dynamic> json) => VegetosExclusiveModel(
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
      NetworkUtils.getRequest(endPoint: Constant.GetVegetosExclusive).then((r) {
        _loading=false;
        print("product response = $r");
        setData(json.decode(r));
      }).catchError((e) {
        _loading=false;
        print("Error caught in $e");
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
