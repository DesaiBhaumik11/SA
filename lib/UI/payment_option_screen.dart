import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/order_placed_screen.dart';
import 'package:vegetos_flutter/UI/promo_screen.dart';
import 'package:vegetos_flutter/UI/set_delivery_location.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/ProceedToPaymentModel.dart';
import 'package:vegetos_flutter/models/default_address.dart';
import 'package:vegetos_flutter/models/my_cart.dart';

import 'my_cart_screen.dart';

class PaymentOptionScreen extends StatefulWidget {

  String shippingSlotId = "";

  PaymentOptionScreen(this.shippingSlotId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentOptionScreenState();
  }
}

class PaymentOptionScreenState extends State<PaymentOptionScreen> {
  bool isPromoAplied = true;
  bool wallet = true;

  String totalAmount = '';
  String transactionId = '';

  static DefaultAddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    addressModel = Provider.of<DefaultAddressModel>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Const.appBar,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset(
              'back.png',
              height: 25,
            ),
          ),
        ),
        title: Text(
          'Payment Options',
          style:
              TextStyle(fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        color: Const.gray10,
        child: Column(
          children: <Widget>[
            priceTotalBox(),
            //promoContainer(),
            //walletContainer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            ProgressDialog progressDialog = Utility.progressDialog(context, "");
            progressDialog.show();
            MyCartModal myCartModal = MyCartState.myCartModal;
            callProceedToCheckoutAPI(myCartModal.totalCost.round().toString(), progressDialog);
          },
          child: Container(
            color: Const.primaryColor,
            height: 50.0,
            child: Center(
              child: Text(
                'Procced to Payment',
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget priceTotalBox() {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'M.R.P',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        '₹ ${MyCartState.myCartModal.result.totalAmount}',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Product Discount',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        '-₹ ${MyCartState.myCartModal.result.discount}',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Delivery Charge ',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Const.locationGrey),
                          ),
                          Icon(
                            Icons.help_outline,
                            color: Const.primaryColor,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        'FREE',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Promo/Discount',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        '-₹ ${MyCartState.myCartModal.result.discount}',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Wallet',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        '-₹0.0',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Const.gray10,
                height: 1.0,
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Sub Total',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        '₹ ${MyCartState.myCartModal.result.totalAmount}',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Your Savings',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        '₹0.0',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget promoContainer() {
    var promo = Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/promocode.png',
              height: 25.0,
              width: 25.0,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              child: Text(
                'Apply Promo Code',
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w500,
                    color: Const.locationGrey),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Const.locationGrey,
            ),
          ),
        ],
      ),
    );

    var appliedPromo = GestureDetector(
      onTap: () {
        Navigator.of(context).push(SlideLeftRoute(page: PromoCode()));
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/promocode.png',
                height: 25.0,
                width: 25.0,
              ),
            ),

//          Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
//                child: Text('SUMMER19 - 40% off upto ₹100', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans',
//                    fontWeight: FontWeight.w500, color: Const.location_grey),),
//              ),
//              Container(
//                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
//                child: Align(
//                  alignment: Alignment.centerLeft,
//                  child: Text('Promo code applied successfully', style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
//                      fontWeight: FontWeight.w500, color: Const.location_grey),),
//                ),
//              ),
//            ],
//          ),
//
//          Expanded(
//            flex: 1,
//            child: Container(),
//          ),
//          Column(
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
//                child: Text('- ₹62', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans',
//                    fontWeight: FontWeight.w500, color: Const.location_grey),),
//              ),
//              Container(
//                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
//                child: Text('Remove', style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
//                    fontWeight: FontWeight.w500, color: Colors.red),),
//              ),
//            ],
//          )

            SizedBox(
              width: 10,
            ),

            Text(
              'Apply Promo Code',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Const.locationGrey,
                  fontWeight: FontWeight.w500),
            ),

            Expanded(
              flex: 1,
              child: Container(),
            ),

            IconButton(
              onPressed: () {
                Navigator.of(context).push(SlideLeftRoute(page: PromoCode()));
              },
              icon: Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
    );

    return isPromoAplied ? appliedPromo : promo;
  }

  Widget walletContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          wallet = !wallet;
        });
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/wallet.png',
                height: 25.0,
                width: 25.0,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Wallet',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500,
                          color: Const.locationGrey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total Balance: ₹30',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: Checkbox(
                value: wallet,
                activeColor: Const.primaryColor,
                onChanged: (b) {
                  setState(() {
                    wallet = b;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*void checkOutCall() {
    SharedPreferences.getInstance().then((prefs) {

      String businessLocationId = prefs.getString("BusinessLocationId");
      String businessId = prefs.getString("BusinessId");

      MyCartModal myCartModal = MyCartState.myCartModal;
      ProgressDialog progressDialog = Utility.progressDialog(context, "");
      progressDialog.show();
      NetworkUtils.postRequest(
          endpoint: Constant.Checkout,
          body: json.encode({
            "DeliveryAddressId": "${addressModel.result.id}",
            "Name": "${addressModel.result.name}",
            "AddressLine1": "${addressModel.result.addressLine1}",
            "AddressLine2": "${addressModel.result.addressLine2}",
            "City": "${addressModel.result.city}",
            "State": "${addressModel.result.state}",
            "Country": "${addressModel.result.country}",
            "Pin": "${addressModel.result.pin}",
            "MobileNo": "${prefs.getString("phone")}",
            "LocationId": businessLocationId,
            "ShippingScheduleId": widget.shippingSlotId,
            "BusinessId": businessId,
            "ShippingDetails": "this is the shipping detail",
            "SubTotal": "${myCartModal.totalCost}",
            "TaxAmount": "0",
            "TotalAmount": "${myCartModal.totalCost}",
            "OfferAmount": "0",
            "CheckoutItems": MyCartState.myCartModal.result.cartItemViewModels,
          })).then((res) {
        print("checkOutCall Response $res");
        var root = json.decode(res);
        if (root["Message"] == "Request successful.") {
          //proceedTopayment();

          Future.delayed(Duration(seconds: 1)).then((_) {
            //callProceedToCheckoutAPI(myCartModal.totalCost.round().toString(), progressDialog);
          });

          //      Navigator.of(context).push(SlideLeftRoute(page: OrderPlacedScreen()));

        } else {
          Utility.toastMessage(root["Message"]);
          progressDialog.dismiss();
        }
      }).catchError((e) {
        print("checkOutCall catchError $e");
        progressDialog.dismiss();
      });
    });
  }*/

  /*void proceedTopayment() {
    MyCartModal myCartModal = MyCartState.myCartModal;

    NetworkUtils.postRequest(
        endpoint: Constant.ProceedTopayment,
        body: json.encode({
          "PaymentMethod": "0",
          "TotalAmount": "${myCartModal.totalCost}",
          "GatewayOrderId": "",
        })).then((res) {
      print("proceedTopayment Response $res");

      //Navigator.of(context).push(SlideLeftRoute(page: OrderPlacedScreen()));
      var root = json.decode(res) ;

      if(root["Message"] =="Request successful."){

        Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: OrderPlacedScreen()),(c)=>false);
        //Navigator.of(context).push(SlideLeftRoute(page: OrderPlacedScreen()));

      }else{
        Utility.toastMessage(root["Message"]) ;
      }
    }).catchError((e) {
      print("proceedTopayment catchError $e");
    });
  }*/

  void callProceedToCheckoutAPI(String totalAmount, ProgressDialog progressDialog) {
    ApiCall().proceedToPayment(totalAmount).then((apiResponseModel) {
      //implementRazorPay("");
      if(apiResponseModel.statusCode == 200) {
        ProceedToPaymentModel proceedToPaymentModel = ProceedToPaymentModel.fromJson(apiResponseModel.Result);
        progressDialog.dismiss();
        implementRazorPay(proceedToPaymentModel.GatewayOrderId, totalAmount, proceedToPaymentModel.TransactionId);
      } else if(apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
        Navigator.of(context).pop();
      }
    });
  }


  void implementRazorPay(String orderId, String amount, String tranId) {
    totalAmount = amount;
    transactionId = tranId;
    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_GIzJZIWq8j3pzL',
      //'amount': amount,
      'name': 'Vegetos',
      'description': 'Vegetos Checkout',
      'order_id':orderId,
    };

    razorpay.open(options);

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(response);
    callPaymentConfirmAPI(response.paymentId, totalAmount, transactionId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response.message);
    Fluttertoast.showToast(msg: response.message != null ? response.message : "Payment failed!");
    Navigator.of(context).pop();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(response);
    Navigator.of(context).pop();
  }


  void callPaymentConfirmAPI(String paymentId, String totalAmount, String transactionId) {
    ProgressDialog progressDialog = Utility.progressDialog(context, "");
    progressDialog.show();
    ApiCall().confirmPayment(paymentId, transactionId).then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        //callClearCartAPI(progressDialog);
        progressDialog.dismiss();
        Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: OrderPlacedScreen(transactionId)),(c)=>false);
      } else if(apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong');
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong');
        Navigator.of(context).pop();
      }
    });
  }

  /*void callClearCartAPI(ProgressDialog progressDialog) {
    ApiCall().clearCart().then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        progressDialog.dismiss();
        Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: OrderPlacedScreen()),(c)=>false);
      } else if(apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong!');
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong!');
      }
    });
  }*/



}
