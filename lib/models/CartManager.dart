import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';
import 'UnitsModel.dart';

class CartManagerResponseModel {

  /// ------------------------------Initialize Stream Controller --------------------------------------------///

  static StreamController streamController = StreamController.broadcast();

  /// -------------------------------------------------------------------------------------------------------///
  List<ManagerItemViewModel> managerItemViewModel;

  CartManagerResponseModel({
    this.managerItemViewModel,
  });

  factory CartManagerResponseModel.fromJson(Map<String, dynamic> json) {
    return CartManagerResponseModel(
      managerItemViewModel: json["CartItemViewModels"] != null
          ? ManagerItemViewModel.parseList(json["CartItemViewModels"])
          : new List(),
    );
  }

  Map<String, dynamic> toJson() => {
        "CartItemViewModels":
            List<dynamic>.from(managerItemViewModel.map((x) => x.toJson())),
      };

  static List<CartManagerResponseModel> parseList(listData) {
    var list = listData as List;
    List<CartManagerResponseModel> jobList =
        list.map((data) => CartManagerResponseModel.fromJson(data)).toList();
    return jobList;
  }

  /// -----------------------Delete CartItem API call--------------------------------------------------------///

  Future<ApiResponseModel> deleteCartItem(String itemId) async {
    ApiResponseModel apiResponseModel = await ApiCall().deleteItem(itemId);
    listenCart(apiResponseModel, "Item Deleted");
    return apiResponseModel;
  }

  /// ------------------------Add to Cart API call-----------------------------------------------------------///

  Future<ApiResponseModel> addToCart(
      productId, qty, offerId, amount, offerAmount) async {
    ApiResponseModel apiResponseModel =
        await ApiCall().addToCart(productId, qty, offerId, amount, offerAmount);
    listenCart(apiResponseModel, 'Item added in cart');
    return apiResponseModel;
  }

  /// -----------------------Update CartItem API call--------------------------------------------------------///

  Future<ApiResponseModel> updateCartQuantity(
      String itemId, String quantity) async {
    ApiResponseModel apiResponseModel =
        await ApiCall().updateQuantity(itemId, quantity);
    listenCart(apiResponseModel, "Item Updated");
    return apiResponseModel;
  }

  ///------------------------Listen Stream from All API Response---------------------------------------------///

  void listenCart(ApiResponseModel apiResponseModel, String message) {
    if (apiResponseModel.statusCode == 200 ||
        apiResponseModel.statusCode == 204) {
      CartManagerResponseModel getCartManagerResponseModel =
          CartManagerResponseModel.fromJson(apiResponseModel.Result);
      managerItemViewModel = getCartManagerResponseModel.managerItemViewModel;
      if (message.isNotEmpty) {
        Fluttertoast.showToast(msg: message);
      }
      Map<String, ManagerItemViewModel> cartHashMap = new Map();
      for (int i = 0; i < managerItemViewModel.length; i++) {
        ManagerItemViewModel cartItemViewModel = managerItemViewModel[i];
        cartHashMap[cartItemViewModel.productId] = cartItemViewModel;
      }
      streamController.add(cartHashMap);
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
  }

  /// ------------------------Get CartItem API call----------------------------------------------------------///

  Future<ApiResponseModel> callGetMyCartAPI() async {
    ApiResponseModel apiResponseModel = await ApiCall().getCart();
    listenCart(apiResponseModel, "");
    return apiResponseModel;
  }

  /// -------------------------------------------------------------------------------------------------------///
}

class ManagerItemViewModel {
  ProductWithDefaultVarientModel productModel =
      ProductWithDefaultVarientModel();

  String productId;
  String itemId;
  int quantity;

  int minimumOrderQuantity;
  int incrementalStep;
  List<UnitsModel> units;

  ManagerItemViewModel({
    this.productId,
    this.units,
    this.itemId,
    this.quantity,
    this.minimumOrderQuantity,
    this.incrementalStep,
  });

  factory ManagerItemViewModel.fromJson(Map<String, dynamic> json) =>
      ManagerItemViewModel(
        productId: json["Id"],
        units:
            json['Units'] != null ? UnitsModel.parseList(json['Units']) : null,
        itemId: json["ItemId"],
        quantity: json["Quantity"],
        minimumOrderQuantity: json['MinimumOrderQuantity'],
        incrementalStep: json['IncrementalStep'],
      );

  Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "Unit": units,
        "Id": itemId,
        "Quantity": quantity,
      };

  static List<ManagerItemViewModel> parseList(listData) {
    var list = listData as List;
    List<ManagerItemViewModel> jobList =
        list.map((data) => ManagerItemViewModel.fromJson(data)).toList();
    return jobList;
  }

  static List encodedToJson(List<ManagerItemViewModel> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }
}
