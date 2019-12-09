
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';

MyCartModal myCartFromJson(String str) => MyCartModal.fromJson(json.decode(str));

String myCartToJson(MyCartModal data) => json.encode(data.toJson());

class MyCartModal extends ChangeNotifier{
  Result result;
  int statusCode;
  String message;
  bool isError;
  double totalCost = 0.0 ;
  bool _loading = false ;
  bool loaded = false ;

  MyCartModal({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory MyCartModal.fromJson(Map<String, dynamic> json) => MyCartModal(
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



  void getMyCart(){

    print("Get My Cart getMyCart Called");
    if(!_loading) {
      _loading=true;
      NetworkUtils.getRequest(endPoint: Constant.GetCart).then((r) {
        _loading=false;
        print("Get My Cart response = $r");
        setData(json.decode(r));
      }).catchError((e) {
        _loading=false;
        print("Error caught in Get My Cart $e");
      });
    }
  }




  void setData(json) {
    result= Result.fromJson(json["Result"]);
    statusCode= json["StatusCode"];
    message= json["Message"];
    isError = json["IsError"];
    loaded=true;

    for(int i =0 ; i<result.cartItems.length ; i++){
      totalCost = totalCost+  result.cartItems[i].amount*result.cartItems[i].quantity ;
    }

    print(totalCost) ;


    notifyListeners();
  }




}

class Result {
  String userId;
  List<CartItem> cartItems;
  DateTime createdOn;
  dynamic updatedOn;

  Result({
    this.userId,
    this.cartItems,
    this.createdOn,
    this.updatedOn,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userId: json["UserId"],
    cartItems: List<CartItem>.from(json["CartItems"].map((x) => CartItem.fromJson(x))),
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "CartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}

class CartItem {
  String id;
  String userId;
  String productId;
  String productVariantId;
  int quantity;
  String offerId;
  double amount;
  DateTime createdOn;
  dynamic updatedOn;

  CartItem({
    this.id,
    this.userId,
    this.productId,
    this.productVariantId,
    this.quantity,
    this.offerId,
    this.amount,
    this.createdOn,
    this.updatedOn,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["Id"],
    userId: json["UserId"],
    productId: json["ProductId"],
    productVariantId: json["ProductVariantId"],
    quantity: json["Quantity"],
    offerId: json["OfferId"],
    amount: json["Amount"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "UserId": userId,
    "ProductId": productId,
    "ProductVariantId": productVariantId,
    "Quantity": quantity,
    "OfferId": offerId,
    "Amount": amount,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}
