import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/models/product_common.dart';
ProductDetailModal productDetailFromJson(String str) => ProductDetailModal.fromJson(json.decode(str));

String productDetailToJson(ProductDetailModal data) => json.encode(data.toJson());

class ProductDetailModal extends ChangeNotifier{
  Result result;
  int statusCode;
  String message;
  bool isError;

  bool loaded=false;
  bool _loading=false;

  ProductDetailModal({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory ProductDetailModal.fromJson(Map<String, dynamic> json) => ProductDetailModal(
    result: Result.fromMap(json["Result"]),
    statusCode: json["StatusCode"],
    message: json["Message"],
    isError: json["IsError"],
  );

  Map<String, dynamic> toJson() => {
    "Result": result.toMap(),
    "StatusCode": statusCode,
    "Message": message,
    "IsError": isError,
  };


  getProductDetail(String id,callback){
    if(!_loading) {
      _loading=true;
      NetworkUtils.getRequest(endPoint:  Constant.GetProductById+id).then((r) {
        _loading=false;
        print("getProductDetail = $r");
        setData(json.decode(r)) ;
        callback();
      }).catchError((e) {
        _loading=false;
        print("Error caught in getProductDetail $e");
      });
    }
  }

  void setData(decode) {

    result = Result.fromMap(decode["Result"]);
    statusCode =  decode["StatusCode"];
    message= decode["Message"];
    isError = decode["IsError"];


    loaded=true;
    notifyListeners();
  }

}

