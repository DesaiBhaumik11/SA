
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';

import 'ApiCall.dart';

class CartFunction
{
  static String callAddToCartAPI(String productId, String varientId, String qty, String offerId, String amount) {
    ApiCall().addToCart(productId, varientId, qty, offerId, amount).then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
        return callGetCartAPI();
      } else if (apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
        return '';
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
        return '';
      }
    });
  }

  static String callGetCartAPI() {
    ApiCall().getCart().then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        GetCartResponseModel getCartResponseModel = GetCartResponseModel.fromJson(apiResponseModel.Result);
        return getCartResponseModel.cartItemViewModels.length.toString();
      } else if(apiResponseModel.statusCode == 401) {
        return '';
      } else {
        return '';
      }
    });
  }
}