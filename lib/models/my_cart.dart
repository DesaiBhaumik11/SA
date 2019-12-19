// To parse this JSON data, do
//
//     final myCartModal = myCartModalFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/models/product_common.dart' as bst;

MyCartModal myCartModalFromJson(String str) => MyCartModal.fromJson(json.decode(str));

String myCartModalToJson(MyCartModal data) => json.encode(data.toJson());

class MyCartModal extends ChangeNotifier {
  String version;
  int statusCode;
  String message;
  bool isError;
  List<Result> result;

  bool _loading = false ;
  bool loaded = false ;
  int cartItemSize = 0 ;
  double totalCost = 0.0;

  MyCartModal({
    this.version,
    this.statusCode,
    this.message,
    this.isError,
    this.result,
  });

  factory MyCartModal.fromJson(Map<String, dynamic> json) => MyCartModal(
    version: json["Version"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    isError: json["IsError"],
    result: List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Version": version,
    "StatusCode": statusCode,
    "Message": message,
    "IsError": isError,
    "Result": List<dynamic>.from(result.map((x) => x.toJson())),
  };






  addTocart(bst.Result resultModal){



//    {
//      "ProductId": "a4a4ceb7-fa45-47e8-8106-6b85e15e1e4d",
//    "ProductVariantId": "3eee7688-2684-49f1-812f-852731af0e65",
//    "Quantity": 10,
//    "OfferId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//    "Amount": 200
//    }
//

    final body= json.encode({

      "ProductId": ""+resultModal.id,
      "ProductVariantId": ""+resultModal.productVariantId,
      "Quantity": "${resultModal.quantity}",
      "OfferId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "Amount": "${resultModal.price}"});


    print("addToCart Body" + body) ;

    NetworkUtils.postRequest(body: body ,endpoint: Constant.AddItem).then((res){
      print("addTocart response = $res");
      getMyCart();
    }).catchError((e){print("Error addTocart  $e");}) ;

  }


  claerCart(){

    NetworkUtils.deleteRequest(endPoint: Constant.ClearCart).then((res){
      print("claerCart response = $res");
      getMyCart();
    }).catchError((e){print("Error claerCart  $e");}) ;



  }


  void getMyCart(){
    if(!_loading) {
      _loading=true;
      NetworkUtils.getRequest(endPoint: Constant.GetCart).then((r) {
        _loading=false;
        print("Get My Cart response = $r");
        setData(json.decode(r));
      }).catchError((e) {
        _loading=false;
        print("Error caught in Get My Cart $e");

        // loaded =true ;
        // notifyListeners();
        //setData(json.decode(e));

      });
    }
  }



  void updateQuantity(String itemId , int quantity){

    //    print("${itemId}   >>> ${quantity}") ;
    Map<String , String>  headersmap = Map() ;
    print("updateQuantity itemId>>> $itemId quantity>>> $quantity") ;
    NetworkUtils.postRequest(endpoint: Constant.UpdateQuantity+ itemId + "&quantity=${quantity}" ,headers: headersmap).then((res){

      print("updateQuantity REsponse>>> $res") ;

    }) ;

  }

  void setData(json) {

    version= json["Version"];
    statusCode= json["StatusCode"];
    message= json["Message"];
    isError= json["IsError"];
    result= List<Result>.from(json["Result"].map((x) => Result.fromJson(x)));


//    result= Result.fromJson(json["Result"]);
//    statusCode= json["StatusCode"];
//    message= json["Message"];
//    isError = json["IsError"];
    loaded=true;
    totalCost = 0.0 ;
    for(int i =0 ; i<result.length ; i++){
      totalCost = totalCost+  result[i].price*result[i].quantity ;
    }
    cartItemSize = result.length ;
    print("Cart Size ${cartItemSize} , Total Cost ${totalCost}") ;
    notifyListeners();
  }





}

class Result {
  String itemId;
  String name;
  String description;
  double price;
  String unit;
  dynamic categoryId;
  String productVariantId;
  String productVariantGroupId;
  String productMediaId;
  double offer;
  String id;
  String brandId;
  double discountPercent;
  String seoTag;
  String businessId;
  int quantity;

  Result({
    this.itemId,
    this.name,
    this.description,
    this.price,
    this.unit,
    this.categoryId,
    this.productVariantId,
    this.productVariantGroupId,
    this.productMediaId,
    this.offer,
    this.id,
    this.brandId,
    this.discountPercent,
    this.seoTag,
    this.businessId,
    this.quantity,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    itemId: json["ItemId"],
    name: json["Name"],
    description: json["Description"],
    price: json["Price"],
    unit: json["Unit"],
    categoryId: json["CategoryId"],
    productVariantId: json["ProductVariantId"],
    productVariantGroupId: json["ProductVariantGroupId"],
    productMediaId: json["ProductMediaId"],
    offer: json["Offer"],
    id: json["Id"],
    brandId: json["BrandId"],
    discountPercent: json["DiscountPercent"],
    seoTag: json["SEOTag"],
    businessId: json["BusinessId"],
    quantity: json["Quantity"],
  );

  Map<String, dynamic> toJson() => {
    "ItemId": itemId,
    "Name": name,
    "Description": description,
    "Price": price,
    "Unit": unit,
    "CategoryId": categoryId,
    "ProductVariantId": productVariantId,
    "ProductVariantGroupId": productVariantGroupId,
    "ProductMediaId": productMediaId,
    "Offer": offer,
    "Id": id,
    "BrandId": brandId,
    "DiscountPercent": discountPercent,
    "SEOTag": seoTag,
    "BusinessId": businessId,
    "Quantity": quantity,
  };
}
