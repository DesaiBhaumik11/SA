
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:vegetos_flutter/models/CartCountModel.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';

import 'ApiCall.dart';

class MyCartUtils
{
  static String cartCount = "0";

  static StreamController streamController = StreamController.broadcast();

  void callAddToCartAPI(String productId,  String qty, String offerId, String amount) {
    ApiCall().addToCart(productId,  qty, offerId, amount).then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
        callCartCountAPI();
      } else if (apiResponseModel.statusCode == 401) {
        //Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      } else {
        //Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      }
    });
  }

  String callCartCountAPI() {
    ApiCall().getCartCount().then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        CartCountModel cartCountModel = CartCountModel.fromJson(apiResponseModel.Result);
        if(cartCountModel.count != null) {
          cartCount = cartCountModel.count.toString();
        }
        streamController.add(cartCount);
      } else if(apiResponseModel.statusCode == 401) {
        //Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      } else {
        //Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      }
      return cartCount;
    });
  }
}