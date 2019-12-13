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

class MyCartModal extends ChangeNotifier{
  String version;
  int statusCode;
  String message;
  bool isError;
  Result result;
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
    result: Result.fromJson(json["Result"]),
  );

  Map<String, dynamic> toJson() => {
    "Version": version,
    "StatusCode": statusCode,
    "Message": message,
    "IsError": isError,
    "Result": result.toJson(),
  };



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
      });
    }
  }


  addTocart(bst.Result resultModal){

    final body= json.encode({
      "Id":""+resultModal.id,
      "CartId": "",
      "ProductId": ""+resultModal.id,
      "ProductVariantId": ""+resultModal.productVariantId,
      "Quantity": "${resultModal.quantity}",
      "OfferId": "",
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


  void updateQuantity(String itemId , int quantity){

//    print("${itemId}   >>> ${quantity}") ;
    Map<String , String>  headersmap = Map() ;
    print("updateQuantity itemId>>> $itemId quantity>>> $quantity") ;
    NetworkUtils.postRequest(endpoint: Constant.UpdateQuantity+ itemId + "&quantity=${quantity}" ,headers: headersmap).then((res){

      print("updateQuantity REsponse>>> $res") ;

    }) ;

  }

  void setData(json) {
    result= Result.fromJson(json["Result"]);
    statusCode= json["StatusCode"];
    message= json["Message"];
    isError = json["IsError"];
    loaded=true;
    totalCost = 0.0 ;
    for(int i =0 ; i<result.productViewModel.length ; i++){
      totalCost = totalCost+  result.totalAmount*result.productViewModel[i].quantity ;
    }
    cartItemSize = result.productViewModel.length ;
    print("Cart Size ${cartItemSize} , Total Cost ${totalCost}") ;
    notifyListeners();
  }




}

class Result {
  String id;
  String cartId;
  List<ProductViewModel> productViewModel;
  double totalAmount;
  double deliveryChages;
  double discount;

  Result({
    this.id,
    this.cartId,
    this.productViewModel,
    this.totalAmount,
    this.deliveryChages,
    this.discount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    cartId: json["CartId"],
    productViewModel: List<ProductViewModel>.from(json["ProductViewModel"].map((x) => ProductViewModel.fromJson(x))),
    totalAmount: json["TotalAmount"],
    deliveryChages: json["DeliveryChages"],
    discount: json["Discount"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CartId": cartId,
    "ProductViewModel": List<dynamic>.from(productViewModel.map((x) => x.toJson())),
    "TotalAmount": totalAmount,
    "DeliveryChages": deliveryChages,
    "Discount": discount,
  };
}

class ProductViewModel {
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
  int quantity;

  ProductViewModel({
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
    this.quantity,
  });

  factory ProductViewModel.fromJson(Map<String, dynamic> json) => ProductViewModel(
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
    quantity: json["Quantity"],
  );

  Map<String, dynamic> toJson() => {
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
    "Quantity": quantity,
  };
}
