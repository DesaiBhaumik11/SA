
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';

import 'ApiResponseModel.dart';

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

  Future<dynamic> callGetMyCartAPI() {
    ApiCall().getCart().then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        CartManagerResponseModel getCartManagerResponseModel =
        CartManagerResponseModel.fromJson(apiResponseModel.Result);
        managerItemViewModel = getCartManagerResponseModel.managerItemViewModel;
        streamController.add(managerItemViewModel);
      }
    });
  }
}

class ManagerItemViewModel {
  String productId;
  String unit;
  String id;
  int quantity;

  int minimumOrderQuantity;
  int incrementalStep;

  ManagerItemViewModel({
    this.productId,
    this.unit,
    this.id,
    this.quantity,

    this.minimumOrderQuantity,
    this.incrementalStep,

  });

  factory ManagerItemViewModel.fromJson(Map<String, dynamic> json) => ManagerItemViewModel(

    productId: json["ItemId"],
    unit: json["Unit"],
    id: json["Id"],
    quantity: json["Quantity"],

    minimumOrderQuantity: json['MinimumOrderQuantity'],
    incrementalStep: json['IncrementalStep'],
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "Unit": unit,
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