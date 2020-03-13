
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'UnitsModel.dart';

class CartManagerResponseModel {

  static StreamController streamController = StreamController.broadcast();
  List<ManagerItemViewModel> managerItemViewModel;
//  static List<ManagerItemViewModel> managerItemViewModel1;

  CartManagerResponseModel({
    this.managerItemViewModel,
  });

  factory CartManagerResponseModel.fromJson(Map<String, dynamic> json) {
    return CartManagerResponseModel(
      managerItemViewModel: json["CartItemViewModels"] != null ? ManagerItemViewModel.parseList(json["CartItemViewModels"]) : new List(),
    );
  }

  Map<String, dynamic> toJson() => {
    "CartItemViewModels": List<dynamic>.from(managerItemViewModel.map((x) => x.toJson())),
  };

  static List<CartManagerResponseModel> parseList(listData) {
    var list = listData as List;
    List<CartManagerResponseModel> jobList =
    list.map((data) => CartManagerResponseModel.fromJson(data)).toList();
    return jobList;
  }

  void deleteCartItem(String itemId) {
    ApiCall().deleteItem(itemId).then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
      } else if (apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : 'Something went wrong.!');
      } else {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : 'Something went wrong.!');
      }
    });
  }

  Future<dynamic> updateCartQuantity(String itemId, String quantity) {
    ApiCall()
        .updateQuantity(itemId, quantity)
        .then((apiResponseModel) {

      if (apiResponseModel.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Item Updated');
      } else if (apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : 'Something went wrong.!');
      } else {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : 'Something went wrong.!');
      }
    });
  }

  Future<dynamic> callGetMyCartAPI() {
    ApiCall().getCart().then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        CartManagerResponseModel getCartManagerResponseModel =
        CartManagerResponseModel.fromJson(apiResponseModel.Result);
        managerItemViewModel = getCartManagerResponseModel.managerItemViewModel;
        Map<String,ManagerItemViewModel> cartHashMap = new Map();
        for(int i = 0; i < managerItemViewModel.length; i++) {
          ManagerItemViewModel cartItemViewModel=managerItemViewModel[i];
          cartHashMap[cartItemViewModel.productId] = cartItemViewModel;
        }
        streamController.add(cartHashMap);
        print(cartHashMap);
        print(cartHashMap.containsKey(managerItemViewModel[0].productId));
        print(cartHashMap.keys);
      }
    });
  }
}

class ManagerItemViewModel {

  String productId;
  String id;
  int  quantity;

  int minimumOrderQuantity;
  int incrementalStep;
  List<UnitsModel> units;

  ManagerItemViewModel({
    this.productId,
    this.units,
    this.id,
    this.quantity,

    this.minimumOrderQuantity,
    this.incrementalStep,

  });

  factory ManagerItemViewModel.fromJson(Map<String, dynamic> json) => ManagerItemViewModel(

    productId: json["Id"],
    units: json['Units'] != null ? UnitsModel.parseList(json['Units']) : null,
    id: json["ItemId"],
    quantity: json["Quantity"],

    minimumOrderQuantity: json['MinimumOrderQuantity'],
    incrementalStep: json['IncrementalStep'],
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "Unit": units,
    "Id": id,
    "Quantity": quantity,
  };

  static List<ManagerItemViewModel> parseList(listData) {
    var list = listData as List;
    List<ManagerItemViewModel> jobList =
    list.map((data) => ManagerItemViewModel.fromJson(data)).toList();
    return jobList;
  }

  static List encodedToJson(List<ManagerItemViewModel>list){
    List jsonList = List();
    list.map((item)=>
        jsonList.add(item.toJson())
    ).toList();
    return jsonList;
  }
}