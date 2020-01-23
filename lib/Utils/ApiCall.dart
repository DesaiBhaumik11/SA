

//this file created by prashant for remaining api calls on 08-01-2020
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:http/http.dart';
import 'package:vegetos_flutter/models/CheckoutRequestModel.dart';

class ApiCall
{

  static final String baseURL = "http://artismicro.archisys.biz:5101";
  //static final String baseURL = "http://195.168.0.37:5001";
  //static final String baseURL = "http://195.168.0.85:5001";

  static final String GetProductWithDefaultVariantByIds = "/ProductWithDefaultVariant";
  static final String SetLocation = "/SetLocation";
  static final String AppFirstStart = "/AppFirstStart";
  static final String RefreshToken = "/RefreshToken?expiredTokenString=";
  static final String GetDefaults = "/GetDefaults";

  static final String BestSellingProducts = "/GetBestSellingProducts";
  static final String VegetosExclusive = "/GetVegetosExclusive";
  static final String RecommendedForYou = "/GetRecommendedProducts";
  static final String GetAllShippingSchedule = "/GetAllShippingSchedule";

  static final String ProceedToPayment = "/ProceedTopayment";
  static final String ConfirmPayment = "/PaymentConfirm";
  static final String AddToCart = "/AddItem";
  static final String GetCart = "/GetCart";

  static final String UpdateQuantity = "/UpdateQuantity";
  static final String DeleteItem = "/DeleteItem";
  static final String ClearCart = "/ClearCart";
  static final String CartCount = "/Count";

  static final String Checkout = "/CheckOut";
  static final String GetOrders = "/GetOrders";
  static final String GetOrderById = "/GetOrderById";

  static final String GetProductDetailById = "/GetProductById";

  static final String GetMyDefaultAddress = "/GetMyDefaultAddress";

  dynamic _returnResponseJson(var response) {
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      //print(responseJson);
      return responseJson;
    } else {
      print(response.reasonPhrase);
    }
  }

  ApiResponseModel _internalCrash(String msg) {
    ApiResponseModel apiResponseModel = ApiResponseModel();
    apiResponseModel.statusCode = -1;
    apiResponseModel.message = msg != null ? msg : '';
    print(msg);
    return apiResponseModel;
  }

  Future<ApiResponseModel> GetProductWithDefaultVarientAPI(String categoryId) async {

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(ApiCall.baseURL + ApiCall.GetProductWithDefaultVariantByIds + "?categoryId=" + categoryId, headers: header);
      print("Headers : => " + header.toString());
      print("URL : => " + response.request.url.toString());
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> setLocation(String pincode) async {

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(ApiCall.baseURL + ApiCall.SetLocation + "?pinCode=" + pincode, headers: header);
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> appFirstStart() async {

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'device_token' : deviceToken};

      final response = await post(ApiCall.baseURL + ApiCall.AppFirstStart, headers: header);
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> refreshToken() async {

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'device_token' : deviceToken};

      final response = await get(ApiCall.baseURL + ApiCall.RefreshToken, headers: header);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> bestSellingItems(String pageNumber, String pageSize) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};
      print(pageNumber + pageSize);
      final response = await get(ApiCall.baseURL + ApiCall.BestSellingProducts + "?pageNumber=" + pageNumber + "&pageSize=" + pageSize,
          headers: header);
      print(response.request.url);
      print(response.request.headers);
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> vegetosExclusive(String pageNumber, String pageSize) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};
      print(pageNumber + pageSize);
      final response = await get(ApiCall.baseURL + ApiCall.VegetosExclusive + "?pageNumber=" + pageNumber + "&pageSize=" + pageSize,
          headers: header);
      print(response.request.url);
      print(response.request.headers);
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> recommendedForYou(String pageNumber, String pageSize) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};
      print(pageNumber + pageSize);
      final response = await get(ApiCall.baseURL + ApiCall.RecommendedForYou + "?pageNumber=" +
          pageNumber + "&pageSize=" + pageSize, headers: header);
      print(response.request.url);
      print(response.request.headers);
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> getAllShippingSchedule() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(ApiCall.baseURL + ApiCall.GetAllShippingSchedule, headers: header);
      print(response.request.url.toString());
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }


  Future<ApiResponseModel> proceedToPayment(String totalAmount) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      /*Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken,
        };
      header["Content-Type"] = "application/json";*/

      Map<String, String> headerMap = Map();
      headerMap["device_token"] = deviceToken;
      headerMap["Content-Type"] = "application/json";
      headerMap["Authorization"] = "Bearer "+token;

      Response response = await get(ApiCall.baseURL + ApiCall.ProceedToPayment, headers: headerMap);
      print(response.request.url.toString());
      print(headerMap);
      //print(requestApiBody);
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> confirmPayment(String paymanetId, String transactionId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};
      //Map<String, String> requestApiBody = {"razorPaymentId":paymanetId, "totalAmount":totalAmount, "GatewayOrderId":""};

      final response = await get(ApiCall.baseURL + ApiCall.ConfirmPayment +
          "?transactionId=" + transactionId + "&razorPaymentId=" + paymanetId, headers: header);
      print(response.request.url.toString());
      print(header);
      //print(requestApiBody);
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> addToCart(String productId, String varientId, String qty, String offerId, String amount) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      //Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};
      Map<String, String> headerMap = Map();
      headerMap["device_token"] = deviceToken;
      headerMap["Content-Type"] = "application/json";
      headerMap["Authorization"] = "Bearer "+token;
      /*Map<String, String> requestApiBody = {
        "ProductId":productId,
        "ProductVariantId":varientId,
        "Quantity":qty,
        "OfferId":offerId,
        "Amount":amount,
      };*/

      final response = await post(ApiCall.baseURL + ApiCall.AddToCart, headers: headerMap, body: json.encode({
        "ProductId": productId,
        "ProductVariantId": varientId,
        "Quantity": qty,
        "OfferId": offerId,
        "Amount": amount,
      }),);
      print(response.request.url.toString());
      print(headerMap);
      //print(requestApiBody);
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> getCart() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(ApiCall.baseURL + ApiCall.GetCart, headers: header);
      print(response.request.url.toString());
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> getMyDefaultAddress() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(ApiCall.baseURL + ApiCall.GetMyDefaultAddress, headers: header);
      print(response.request.url.toString());
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> getDefaults() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(ApiCall.baseURL + ApiCall.GetDefaults, headers: header);
      print(response.request.url.toString());
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> checkout(CheckoutRequestModel model) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> headerMap = Map();
      headerMap["device_token"] = deviceToken;
      headerMap["Content-Type"] = "application/json";
      headerMap["Authorization"] = "Bearer "+token;

      var apiRequestBody = json.encode({
        "DeliveryAddressId": model.DeliveryAddressId,
        "Name": model.Name,
        "AddressLine1": model.AddressLine1,
        "AddressLine2": model.AddressLine2,
        "City": model.City,
        "State": model.State,
        "Country": model.Country,
        "Pin": model.Pin,
        "MobileNo": model.MobileNo,
        "LocationId": model.LocationId,
        "ShippingScheduleId": model.ShippingScheduleId,
        "BusinessId": model.BusinessId,
        "ShippingDetails": model.ShippingDetails,
        "SubTotal": model.SubTotal,
        "TaxAmount": model.TaxAmount,
        "TotalAmount": model.TotalAmount,
        "OfferAmount": model.OfferAmount,
        "CheckoutItems": model.CheckoutItems,
      });


      final response = await post(ApiCall.baseURL + ApiCall.Checkout, headers: headerMap, body: apiRequestBody,);
      print(response.request.url.toString());
      print(headerMap);
      print(apiRequestBody);
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }


  Future<ApiResponseModel> getOrders() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(ApiCall.baseURL + ApiCall.GetOrders, headers: header);
      print(response.request.url.toString());
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> clearCart() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      //Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};
      Map<String, String> headerMap = Map();
      headerMap["device_token"] = deviceToken;
      headerMap["Content-Type"] = "application/json";
      headerMap["Authorization"] = "Bearer "+token;

      final response = await delete(ApiCall.baseURL + ApiCall.ClearCart, headers: headerMap);
      print(response.request.url.toString());
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> updateQuantity(String itemId, String qty) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> headerMap = Map();
      headerMap["device_token"] = deviceToken;
      headerMap["Content-Type"] = "application/json";
      headerMap["Authorization"] = "Bearer "+token;

      final response = await post(ApiCall.baseURL + ApiCall.UpdateQuantity + "?itemId=" + itemId + "&quantity=" + qty,
          headers: headerMap);
      print(response.request.url.toString());
      print(headerMap);
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> deleteItem(String itemId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> headerMap = Map();
      headerMap["device_token"] = deviceToken;
      headerMap["Content-Type"] = "application/json";
      headerMap["Authorization"] = "Bearer "+token;

      final response = await delete(ApiCall.baseURL + ApiCall.DeleteItem + "?itemId=" + itemId,
          headers: headerMap);
      print(response.request.url.toString());
      print(headerMap);
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> getProductDetailById(String productId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(ApiCall.baseURL + ApiCall.GetProductDetailById + "?id=" + productId, headers: header);
      print(response.request.url.toString());
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> getCartCount() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(ApiCall.baseURL + ApiCall.CartCount, headers: header);
      print(response.request.url.toString());
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> getOrderById(String transactionId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = prefs.getString('JWT_TOKEN');
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(ApiCall.baseURL + ApiCall.GetOrderById + "?transactionId=" + transactionId, headers: header);
      print(response.request.url.toString());
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

}