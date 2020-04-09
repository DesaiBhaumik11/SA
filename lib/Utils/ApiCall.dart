

//this file created by prashant for remaining api calls on 08-01-2020
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/login.dart';
import 'package:vegetos_flutter/UI/splash_screeen.dart';
import 'package:vegetos_flutter/Utils/config.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:http/http.dart';
import 'package:vegetos_flutter/models/AppFirstStartResponseModel.dart';
import 'package:vegetos_flutter/models/CheckoutRequestModel.dart';

import 'package:vegetos_flutter/models/GetCartResponseModel.dart' as cart;
import 'package:vegetos_flutter/models/address_modal.dart';

import 'DeviceTokenController.dart';

class ApiCall {

  static final String GetProductWithDefaultVariantByIds = "/ProductWithDefaultVariant";
  static final String GetManufacturerByIds = "/GetManufacturerById";
  static final String SetLocation = "/SetLocation";
  static final String AppFirstStart = "/AppFirstStart";
  static final String RefreshToken = "/RefreshToken";
  static final String GetDefaults = "/GetDefaults";
  static final String Register  = "/Register";
  static final String Login  = "/Login";
  static final String Logout  = "/Logout";
  static final String Validate  = "/Validate";

  static final String GetMyAddresses  = "/GetMyAddresses";
  static final String DeleteAddress  = "/DeleteAddress";
  static final String AddAddress  = "/AddAddress";
  static final String UpdateAddress  = "/UpdateAddress";
  static final String BestSellingProducts = "/GetBestSellingProducts";
  static final String VegetosExclusive = "/GetVegetosExclusive";
  static final String RecommendedForYou = "/GetRecommendedProducts";
  static final String GetAllShippingSchedule = "/GetAllShippingSchedule";
  static final String GetShippingScheduleFor = "/GetShippingScheduleFor";
  static final String GetPaymentModes = "/GetPaymentModes";
  static final String SetDefaultAddress  = "/SetDefaultAddress";
  static final String GetAddressById = "/GetAddressById";
  static final String GetShippingMode = "/GetShippingMode";
  static final String GetAllShippingScheduleWithMode = "/GetAllShippingScheduleWithMode";
  static final String GetShippingSlotWithMode = "/GetShippingSlotWithMode";
  static final String GetAllRetailsForPincode = "/GetAllRetailsForPincode";



  static final String ProceedToPayment = "/ProceedTopayment";
  static final String ProceedTopaymentUsingGateway = "/ProceedTopaymentUsingGateway";
  static final String ProceedTopaymentUsingCOD = "/ProceedTopaymentUsingCOD";

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
  static final String OrderCancellationRequestById = "/OrderCancellationRequestById";

  static final String SearchProduct = "/SearchProduct";

  static final String GetProductDetailById = "/GetProductById";

  static final String GetMyDefaultAddress = "/GetMyDefaultAddress";

  BuildContext context;


  ApiCall setContext(BuildContext context){
    this.context=context;
    return this;
  }

  Future<ApiResponseModel> _get(String URL) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = await DeviceTokenController().ValidateDeviceToken();
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(Config.baseURL + URL , headers: header);
      return getResponse(response,true);
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> _post(String URL,var apiRequestBody) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = await DeviceTokenController().ValidateDeviceToken();
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken ,'Content-Type' : 'application/json'};

      final response = await post(Config.baseURL + URL, headers: header , body: apiRequestBody);
      return getResponse(response,true);
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> _put(String URL,var apiRequestBody) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = await DeviceTokenController().ValidateDeviceToken();
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken ,'Content-Type' : 'application/json'};
      if(apiRequestBody!=null) {
        final response = await put(Config.baseURL + URL, headers: header, body: apiRequestBody);
        return getResponse(response, true);
      }else{
        final response = await put(Config.baseURL + URL, headers: header);
        return getResponse(response, true);
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }

  Future<ApiResponseModel> _delete(String URL) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = await DeviceTokenController().ValidateDeviceToken();
      Map<String, String> headerMap = Map();
      headerMap["device_token"] = deviceToken;
      headerMap["Content-Type"] = "application/json";
      headerMap["Authorization"] = "Bearer "+token;

      final response = await delete(Config.baseURL + URL,
          headers: headerMap);
      return getResponse(response,true);
    } catch (e) {
      return _internalCrash(e.toString());
    }
  }



  ApiResponseModel getResponse(var response,bool isRedirect){
    print(response.request.url);
    print(response.request.headers);
    print(response.body);
    if(response.statusCode == 200) {
      var responseJson = _returnResponseJson(response);
      return ApiResponseModel.fromJson(responseJson);
    }else {
      return errorResponse(response,isRedirect);
    }
  }

  ApiResponseModel errorResponse(var response,bool isRedirect){
    ApiResponseModel apiResponseModel = ApiResponseModel();
    if(response.headers.containsKey("token-expired")){
      String value=response.headers['token-expired'].toString();
      apiResponseModel.tokenExpired=value=="true"?true:false;
    }
    if(response.statusCode==401){
      if(apiResponseModel.tokenExpired==true && isRedirect) {
        return redirect(response);
      }else{
        if(context!=null){
          String uuid = Uuid().v4();
          SharedPreferences.getInstance().then((prefs) {
            prefs.setBool("login", false);
            prefs.setString("UUID", uuid);
            prefs.setString("JWT_TOKEN","");
            prefs.setString("AUTH_TOKEN", "");
            prefs.setString("phone", "Guest User");
            DeviceTokenController().ValidateDeviceToken().then((token) {
              ApiCall().appFirstStart().then((apiResponseModel) {
                if(apiResponseModel.statusCode == 200) {
                  AppFirstStartResponseModel appFirstStartResponseModel = AppFirstStartResponseModel.fromJson(apiResponseModel.Result);
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setString("AUTH_TOKEN", appFirstStartResponseModel.token);
                    Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: DashboardScreen()),(c)=>false);
                  });
                } else {
                  Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: SplashScreen()),(c)=>false);
                }
              });
            });
          });

        }
      }
    }else if (apiResponseModel.statusCode == 426){
      if(context!=null) {
        Utility.forceUpate(context);
      }
    }
    apiResponseModel.statusCode = response.statusCode;
    apiResponseModel.message = response.reasonPhrase;
    return apiResponseModel;
  }

  ApiResponseModel redirect(var response){
    String method=response.request.method;
    String url=response.request.url.toString();
    String body="";
    if(method=="POST"){
      body=response.body.toString();
    }
    refreshToken().then((apiResponseModel){
      if(apiResponseModel.statusCode == 200) {
        AppFirstStartResponseModel appFirstStartResponseModel = AppFirstStartResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("AUTH_TOKEN", appFirstStartResponseModel.token);
          String deviceToken = prefs.getString('JWT_TOKEN');
          Map<String, String> headerMap = Map();
          headerMap["device_token"] = deviceToken;
          headerMap["Content-Type"] = "application/json";
          headerMap["Authorization"] = "Bearer "+appFirstStartResponseModel.token;
          print(response.request.url);
          print(response.request.headers);
          if(method=="POST"){
            post(url,headers: headerMap,body: body).then((res){
              return getResponse(res, false);
            });
          }else if(method=="GET"){
            get(url,headers: headerMap).then((res){
              return getResponse(res, false);
            });
          }else{
            return errorResponse(response,false);
          }
        });
      } else {
        return errorResponse(response,false);
      }
    });
  }

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
    print("crash:"+msg);
    ApiResponseModel apiResponseModel = ApiResponseModel();
    apiResponseModel.statusCode = -1;
    apiResponseModel.message = msg != null ? msg : '';
    print(msg);
    return apiResponseModel;

  }

  Future<ApiResponseModel> GetProductWithDefaultVarientAPI(String categoryId) async {
    return _get(ApiCall.GetProductWithDefaultVariantByIds + "?categoryId=" + categoryId);
  }

  Future<ApiResponseModel> GetManufacturerByIdAPI(String manufacturerId) async {
    return _get(ApiCall.GetManufacturerByIds + "?id=" + manufacturerId);
  }

  Future<ApiResponseModel> setLocation(String pincode) async {
    return _get(ApiCall.SetLocation + "?pinCode=" + pincode);
  }

  Future<ApiResponseModel> bestSellingItems(String pageNumber, String pageSize) async {
    return _get(ApiCall.BestSellingProducts + "?pageNumber=" + pageNumber + "&pageSize=" + pageSize);
  }

  Future<ApiResponseModel> vegetosExclusive(String pageNumber, String pageSize) async {
    return _get(ApiCall.VegetosExclusive + "?pageNumber=" + pageNumber + "&pageSize=" + pageSize);
  }

  Future<ApiResponseModel> recommendedForYou(String pageNumber, String pageSize) async {
    return _get(ApiCall.RecommendedForYou + "?pageNumber=" +
        pageNumber + "&pageSize=" + pageSize);
  }

  Future<ApiResponseModel> getAllShippingSchedule() async {
    return _get(ApiCall.GetAllShippingSchedule);
  }

  Future<ApiResponseModel> getShippingScheduleFor() async {
    return _get(ApiCall.GetShippingScheduleFor);
  }

  Future<ApiResponseModel> getShippingModes() async {
    return _get(ApiCall.GetShippingMode);
  }

  Future<ApiResponseModel> getAllShippingScheduleWithMode(String shippingMode) async {
    return _get(ApiCall.GetAllShippingScheduleWithMode + "?shippingMode=" + shippingMode);
  }

  Future<ApiResponseModel> getAllRetailsForPinCode(String pinCode) async {
    return _get(ApiCall.GetAllRetailsForPincode + "?pinCode=" + pinCode);
  }

//  Future<ApiResponseModel> getShippingSlotWithMode() async {
//    return _get(ApiCall.GetShippingSlotWithMode);
//  }

  Future<ApiResponseModel> getPaymentModes() async {
    return _get(ApiCall.GetPaymentModes);
  }

  Future<ApiResponseModel> proceedTopaymentUsingGateway() async {
    return _get(ApiCall.ProceedTopaymentUsingGateway);
  }

  Future<ApiResponseModel> proceedTopaymentUsingCOD() async {
    return _get(ApiCall.ProceedTopaymentUsingCOD);
  }

  Future<ApiResponseModel> proceedToPayment(String totalAmount) async {
    return _get(ApiCall.ProceedToPayment);
  }

  Future<ApiResponseModel> confirmPayment(String paymanetId, String transactionId) async {
    return _get(ApiCall.ConfirmPayment +
        "?transactionId=" + transactionId + "&razorPaymentId=" + paymanetId);
  }


  Future<ApiResponseModel> getDefaults() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("AUTH_TOKEN");
      String deviceToken = await DeviceTokenController().ValidateDeviceToken();
      Map<String, String> header = {'Authorization': "Bearer " + token, 'device_token' : deviceToken};

      final response = await get(Config.baseURL + ApiCall.GetDefaults, headers: header);
      print(response.request.url.toString());
      print(response.body);
      if(response.statusCode == 200) {
        var responseJson = _returnResponseJson(response);
        return ApiResponseModel.fromJson(responseJson);
      } else {
        ApiResponseModel apiResponseModel = ApiResponseModel();
        if(response.headers.containsKey("token-expired")){
          String value=response.headers['token-expired'].toString();
          apiResponseModel.tokenExpired=value=="true"?true:false;
        }
        apiResponseModel.statusCode = response.statusCode;
        apiResponseModel.message = response.reasonPhrase;
        return apiResponseModel;
      }
    } catch (e) {
      return _internalCrash(e.toString());
    }
//    return _get(ApiCall.GetDefaults);
  }

  Future<ApiResponseModel> checkout(CheckoutRequestModel model) async {
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
      "SubTotal": model.SubTotal.toString(),
      "TaxAmount": model.TaxAmount.toString(),
      "TotalAmount": model.TotalAmount.toString(),
      "OfferAmount": model.OfferAmount.toString(),
//        "CheckoutItems": cart.CartItemViewModel.encondeToJson(model.CheckoutItems),
    });
    return _post(ApiCall.Checkout, apiRequestBody);
  }


  Future<ApiResponseModel> getOrders() async {
    return _get(ApiCall.GetOrders);
  }

  Future<ApiResponseModel> clearCart() async {
    return _delete(ApiCall.ClearCart);
  }

  Future<ApiResponseModel> updateQuantity(String itemId, String qty) async {
    return _post(ApiCall.UpdateQuantity + "?itemId=" + itemId + "&quantity=" + qty, null);
  }

  Future<ApiResponseModel> deleteItem(String itemId) async {
   return _delete(ApiCall.DeleteItem + "?itemId=" + itemId);
  }

  Future<ApiResponseModel> getProductDetailById(String productId) async {
    return _get(ApiCall.GetProductDetailById + "?id=" + productId);
  }

  Future<ApiResponseModel> getCartCount() async {
    return _get(ApiCall.CartCount);
  }

  Future<ApiResponseModel> getOrderById(String transactionId) async {
    return _get(ApiCall.GetOrderById + "?transactionId=" + transactionId);
  }

  Future<ApiResponseModel> searchProduct(String searchString) async {
    return _get(ApiCall.SearchProduct + "?searchString=" + searchString);
  }

  Future<ApiResponseModel> validate(String code, String phone) async {
    var apiRequestBody = json.encode({
      "Code":""+code,
      "IsdCode": "+91",
      "Mobile": ""+phone
    });
    return _post(ApiCall.Validate, apiRequestBody);
  }

  Future<ApiResponseModel> login(String phone) async {
    var apiRequestBody = json.encode({
      "IsdCode": "+91",
      "Mobile": ""+phone
    });
   return _post(ApiCall.Login, apiRequestBody);
  }

  Future<ApiResponseModel> logout() async {
    return _get(ApiCall.Logout);
  }

  // Address
  Future<ApiResponseModel> getMyAddress() async {
    return _get(ApiCall.GetMyAddresses);
  }

  Future<ApiResponseModel> updateAddress(Result result,{callback}) async {
    var apiRequestBody = json.encode({
      "Id":            result.id,
      "NamePrefix":    result.namePrefix,
      "Name":          result.name,
      "ContactId":     result.contactId,
      "AddressLine1":  result.addressLine1,
      "AddressLine2":  result.addressLine2,
      "City":          result.city,
      "Country":       result.country,
      "State":         result.state,
      "Pin":           result.pin,
      "Title":         result.title,
      "Latitude":      result.latitude,
      "Longitude":     result.longitude,
      "IsDefault":     result.isDefault
    });
    return _put(ApiCall.UpdateAddress,apiRequestBody);
  }

  Future<ApiResponseModel> getAddressById(String addressId) async {
    return _get(ApiCall.GetAddressById+"?addressId="+addressId);
  }

  Future<ApiResponseModel> getMyDefaultAddress() async {
    return _get(ApiCall.GetMyDefaultAddress);
  }

  Future<ApiResponseModel> setDefaultAddress(String addressId) async {
    return _get(ApiCall.SetDefaultAddress+ "?addressId="+addressId);
  }

  Future<ApiResponseModel> addAddress(Result result) async {
    var apiRequestBody = json.encode({
      "NamePrefix" : result.namePrefix,
      "Name":          result.name,
      "AddressLine1":  result.addressLine1,
      "AddressLine2":  result.addressLine2,
      "City":          result.city,
      "Country":       result.country,
      "State":         result.state,
      "Pin":           result.pin,
      "Title":           result.title,
      "Latitude":      result.latitude,
      "Longitude":     result.longitude,
      "IsDefault":     result.isDefault
    });
    return _post(ApiCall.AddAddress,apiRequestBody);
  }

  Future<ApiResponseModel> deleteAddress(String id) async {
    return _delete(ApiCall.DeleteAddress + "?addressId="+id);
  }

  //cart
  Future<ApiResponseModel> getCart() async {
    return _get(ApiCall.GetCart);
  }
  Future<ApiResponseModel> count() async {
    return _get(ApiCall.CartCount);
  }

  Future<ApiResponseModel> addToCart(String productId,  String qty, String offerId, String amount,String offerAmount) async {
    var apiRequestBody = json.encode({
      "ProductId": productId,
      "Quantity": qty,
      "OfferId": offerId,
      "Amount": amount,
      "OfferAmount":offerAmount,
    });
    return _post(ApiCall.AddToCart,apiRequestBody);
  }

  Future<ApiResponseModel> orderCancellationRequestById(String transactionId) async {
    return _put(ApiCall.OrderCancellationRequestById + "?transactionId=" + transactionId,null);
  }

  Future<ApiResponseModel> refreshToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String deviceToken = await DeviceTokenController().ValidateDeviceToken();
      Map<String, String> header = {'device_token' : deviceToken};
      String token =  prefs.getString("AUTH_TOKEN");

      final response = await post(Config.baseURL + ApiCall.RefreshToken + "?expiredTokenString=" + token, headers: header);
      print(response.request.url);
      print(response.request.headers);
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
      String deviceToken = await DeviceTokenController().ValidateDeviceToken();
      Map<String, String> header = {'device_token' : deviceToken};

      final response = await post(Config.baseURL + ApiCall.AppFirstStart, headers: header);
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

}

