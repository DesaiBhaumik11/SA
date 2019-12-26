// To parse this JSON data, do
//
//     final myCartModal = myCartModalFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
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



  addTocart(bst.Result resultModal){



    final body= json.encode({

      "ProductId": ""+resultModal.id,
      "ProductVariantId": ""+resultModal.productVariantId,
      "Quantity": "${resultModal.quantity==0?1:resultModal.quantity}" ,
      "OfferId": "",
      "Amount": "${resultModal.price}"});


    print("addToCart Body" + body) ;

    NetworkUtils.postRequest(body: body ,endpoint: Constant.AddItem).then((res){
      print("addTocart response = $res");
      Utility.toastMessage("Added to cart sucessfully");
      getMyCart();
    }).catchError((e){print("Error addTocart  $e");}) ;

  }


  claerCart(){

    NetworkUtils.deleteRequest(endPoint: Constant.ClearCart).then((res){
      print("claerCart response = $res");
     // getMyCart();

      result.cartItemViewModels=List();

       cartItemSize = 0 ;
       totalCost = 0.0;

      notifyListeners() ;


    }).catchError((e){print("Error claerCart  $e");}) ;



  }


  void getMyCart(){
    if(!_loading) {
      _loading=true;
      NetworkUtils.getRequest(endPoint: Constant.GetCart).then((r) {
        _loading=false;
        print("Get My Cart response = $r");
        setData(json.decode(r)) ;
      }).catchError((e) {
        loaded=true;
        _loading=false;
        print("Error caught in Get My Cart $e") ;

        cartItemSize=0 ;
        totalCost =0 ;
        result.cartItemViewModels = List();

        notifyListeners() ;

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
    NetworkUtils.postRequest(endpoint: Constant.UpdateQuantity+ itemId+"&quantity=$quantity" ,headers: headersmap).then((res){

      print("updateQuantity REsponse>>> $res") ;

    }) ;

  }

  void setData(json) {

    version= json["Version"];
    statusCode= json["StatusCode"];
    message= json["Message"];
    isError= json["IsError"];
    loaded=true;
    try{
      result= Result.fromJson(json["Result"]);


      totalCost = 0.0 ;
      for(int i =0 ; i<result.cartItemViewModels.length ; i++){
        totalCost = totalCost+  result.cartItemViewModels[i].price*result.cartItemViewModels[i].quantity ;
      }
      cartItemSize = result.cartItemViewModels.length ;
      print("Cart Size ${cartItemSize} , Total Cost ${totalCost}") ;

    }catch(Exception){

      cartItemSize=0 ;
      totalCost =0 ;
    }
    notifyListeners() ;
  }

}

class Result {
  String cartId;
  List<CartItemViewModel> cartItemViewModels=List();
  double totalAmount;
  double deliveryCharges;
  double discount;

  Result({
    this.cartId,
    this.cartItemViewModels,
    this.totalAmount,
    this.deliveryCharges,
    this.discount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    cartId: json["CartId"],
    cartItemViewModels: List<CartItemViewModel>.from(json["CartItemViewModels"].map((x) => CartItemViewModel.fromJson(x))),
    totalAmount: json["TotalAmount"],
    deliveryCharges: json["DeliveryCharges"],
    discount: json["Discount"],
  );

  Map<String, dynamic> toJson() => {
    "CartId": cartId,
    "CartItemViewModels": List<dynamic>.from(cartItemViewModels.map((x) => x.toJson())),
    "TotalAmount": totalAmount,
    "DeliveryCharges": deliveryCharges,
    "Discount": discount,
  };
}

class CartItemViewModel {
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
  double cartItemTotal;

  CartItemViewModel({
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
    this.cartItemTotal,
  });

  factory CartItemViewModel.fromJson(Map<String, dynamic> json) => CartItemViewModel(
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
    cartItemTotal: json["CartItemTotal"],
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
    "CartItemTotal": cartItemTotal,
  };
}
