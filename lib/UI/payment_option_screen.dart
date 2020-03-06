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
import 'package:vegetos_flutter/Utils/Enumaration.dart';
import 'package:vegetos_flutter/Utils/config.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';
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
  int _radioValue1 = -1;
  var text = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);

  static DefaultAddressModel addressModel;

  GetCartResponseModel cartResponseModel;
  PaymentModeC paymentModeC;
  List<PaymentModeC> paymentmodes;

//  List<PaymentModeC> paymentmodes = [
//    PaymentModeC(
//      index: 1,
//      name: "Online",
//      code: 2,
//    ),
//    PaymentModeC(
//      index: 2,
//      name: "COD",
//      code: 5,
//    ),
//  ];
  String radioItem = 'Online';

  // Group Value for Radio Button.
  int id = 1;

  @override
  void setState(fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    callGetMyCartAPI();
    callGetPaymentMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addressModel = Provider.of<DefaultAddressModel>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset(
              'assets/OkAssets/LeftSideArrow.png',
              height: 25,
            ),
          ),
        ),
        title: Text(
          'Payment Options',
          style: TextStyle(
              fontFamily: 'GoogleSans',
              fontWeight: FontWeight.w500,
              color: Const.textBlack),
        ),
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            cartResponseModel != null
                ? priceTotalBox()
                : InkWell(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        height: 250,
                        child: Card(
                          child: Center(
                              child: Center(
                            child: CircularProgressIndicator(),
                          )),
                        )),
                  ),
            paymentmodes != null
                ? paymentMode()
                : InkWell(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        height: 150,
                        child: Card(
                          child: Center(
                              child: Center(
                            child: CircularProgressIndicator(),
                          )),
                        )),
                    //promoContainer(),
                    //walletContainer(),
                  )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            callProceedToCheckoutAPI(cartResponseModel.SubTotal.toString());
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

  Widget callGetMyCartAPI() {
    ApiCall().setContext(context).getCart().then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        GetCartResponseModel getCartResponseModel =
            GetCartResponseModel.fromJson(apiResponseModel.Result);
        setState(() {
          cartResponseModel = getCartResponseModel;
          /*if(model.discount != null) {
            totalSaving = model.discount.toString();
          } else {
            totalSaving = "0";
          }

          if(model.SubTotal != null) {
            checkoutTotal = model.SubTotal.toString();
          } else {
            checkoutTotal = "0";
          }

          if(model.cartItemViewModels != null) {
            cartTotalItems = model.cartItemViewModels.length.toString();
          } else {
            cartTotalItems = "0";
          }

          setState(() {
            isDataAvailable = true;
          });*/
        });
      } else {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : 'Something went wrong.!');
      }
    });
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
                        '₹ ${cartResponseModel.totalAmount}',
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
                        '-₹ ${cartResponseModel.discount}',
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
                        cartResponseModel.deliveryCharges.toString(),
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
                        '-₹ ${cartResponseModel.discount}',
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
              /*Container(
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
              ),*/
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
                        '₹ ${cartResponseModel.SubTotal.toString()}',
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

  Widget paymentMode() {
    return Container(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Column(
              children: createRadioListUsers(),
//      <Widget>[
//        Container(
//          alignment: Alignment.topLeft,
//          child: Text(
//            'Payment Mode:',
//            style: TextStyle(
//                fontSize: 15.0,
//                fontFamily: 'GoogleSans',
//                fontWeight: FontWeight.w500,
//                color: Const.primaryColorGreen),
//          ),
//        ),
//        Row(children : <Widget>[
//          new Radio(
//          value: 0,
//          activeColor: Const.orange,
//          groupValue: _radioValue1,
//          onChanged: (int e) {
//            setState(() {
//              _radioValue1 = e;
//            });
//          },
//        ), new Text('Gateway',style: text,),
//          ]),
//        Row(children : <Widget>[
//          new Radio(
//          value: 1,
//          activeColor: Const.orange,
//          groupValue: _radioValue1,
//          onChanged: (int e) {
//            setState(() {
//              _radioValue1 = e;
//            });
//          },
//        ), new Text('Cash', style: text,),
//            ]),
//      ],
            ),
          ),
        ));
  }

  setSelectedUser(PaymentModeC user) {
    setState(() {
      paymentModeC = user;
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    widgets.add(
      Container(
        alignment: Alignment.topLeft,
        child: Text(
          'Payment Mode:',
          style: TextStyle(
              fontSize: 15.0,
              fontFamily: 'GoogleSans',
              fontWeight: FontWeight.w500,
              color: Const.primaryColorGreen),
        ),
      ),
    );
    for (PaymentModeC user in paymentmodes) {
      widgets.add(
        RadioListTile(
          value: user,
          groupValue: paymentModeC,
          title:
              Text(user.name == EnumPaymentMode.Online ? "PayNow" : user.name),
          subtitle: Text(user.name == EnumPaymentMode.Online
              ? "Pay using payment Gateway"
              : user.name == EnumPaymentMode.COD ? "Cash On Delivery" : ""),
          onChanged: (currentUser) {
            print("Current User ${currentUser}");
            setSelectedUser(currentUser);
          },
          selected: paymentModeC == user,
          activeColor: Colors.green,
        ),
      );
    }
    return widgets;
  }

  Widget promoContainer() {
    var promo = Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/VegetosAssets/promocode.png',
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
                'assets/VegetosAssets/promocode.png',
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
                'assets/VegetosAssets/Wallet.png',
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

  void callGetPaymentMode() {
    ApiCall().getPaymentModes().then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        List<dynamic> modes = apiResponseModel.Result;
        List<PaymentModeC> paymodes = new List();
        if (modes != null && modes.length > 0) {
          for (int i = 0; i < modes.length; i++) {
            paymodes.add(new PaymentModeC(name: modes[i].toString(), index: i));
//            paymentmodes.add(new PaymentModeC(name : EnumPaymentMode.getPaymentModeStr(modes[i]),index: i, code: modes[i]));
          }
        }
        setState(() {
          paymentmodes = paymodes;
        });
      }
//      paymentmodes.add(new PaymentModeC(name : "Online",index: 0, code: 2));
//      paymentmodes.add(new PaymentModeC(name : "COD",index: 1, code: 5));
    });
  }

  void callProceedToCheckoutAPI(String totalAmount) {
    if (paymentModeC == null) {
      Fluttertoast.showToast(msg: 'Please select PaymentMode');
      return;
    }
    ProgressDialog progressDialog = Utility.progressDialog(context, "");
    progressDialog.show();
    if (paymentModeC.name == EnumPaymentMode.Online) {
      ApiCall()
          .setContext(context)
          .proceedTopaymentUsingGateway()
          .then((apiResponseModel) {
        //implementRazorPay("");
        if (progressDialog != null && progressDialog.isShowing()) {
          progressDialog.dismiss();
        }
        if (apiResponseModel.statusCode == 200) {
          ProceedToPaymentModel proceedToPaymentModel =
              ProceedToPaymentModel.fromJson(apiResponseModel.Result);
          implementRazorPay(proceedToPaymentModel.GatewayOrderId, totalAmount,
              proceedToPaymentModel.TransactionId);
        } else if (apiResponseModel.statusCode == 401) {
          Fluttertoast.showToast(
              msg: apiResponseModel.message != null
                  ? apiResponseModel.message
                  : 'Something went wrong.!');
          Navigator.of(context).pop();
        } else {
          Fluttertoast.showToast(
              msg: apiResponseModel.message != null
                  ? apiResponseModel.message
                  : 'Something went wrong.!');
          Navigator.of(context).pop();
        }
      });
    } else if (paymentModeC.name == EnumPaymentMode.COD) {
      ApiCall()
          .setContext(context)
          .proceedTopaymentUsingCOD()
          .then((apiResponseModel) {
        //implementRazorPay("");
        if (progressDialog != null && progressDialog.isShowing()) {
          progressDialog.dismiss();
        }
        if (apiResponseModel.statusCode == 200) {
          ProceedToPaymentModel proceedToPaymentModel =
              ProceedToPaymentModel.fromJson(apiResponseModel.Result);
//          implementRazorPay(proceedToPaymentModel.GatewayOrderId, totalAmount,
//              proceedToPaymentModel.TransactionId);
//          callPaymentConfirmAPI(proceedToPaymentModel.GatewayOrderId, totalAmount, proceedToPaymentModel.TransactionId);
          ApiCall().clearCart().then((apiResponseModel) {
            if (apiResponseModel.statusCode == 200 ||
                apiResponseModel.statusCode == 204) {
              Navigator.pushAndRemoveUntil(
                  context,
                  EnterExitRoute(
                      enterPage: OrderPlacedScreen(
                          proceedToPaymentModel.TransactionId, true)),
                  (c) => false);
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
        } else if (apiResponseModel.statusCode == 401) {
          Fluttertoast.showToast(
              msg: apiResponseModel.message != null
                  ? apiResponseModel.message
                  : 'Something went wrong.!');
          Navigator.of(context).pop();
        } else {
          Fluttertoast.showToast(
              msg: apiResponseModel.message != null
                  ? apiResponseModel.message
                  : 'Something went wrong.!');
          Navigator.of(context).pop();
        }
      });
    }
  }

  void implementRazorPay(String orderId, String amount, String tranId) {
    SharedPreferences.getInstance().then((prefs) {
      Map<String, dynamic> tokenMap =
          Const.parseJwt(prefs.getString('AUTH_TOKEN'));
      String mobile = "", email = "";

      if (tokenMap['mobile'] != null &&
          tokenMap['mobile'].toString().toLowerCase() != "") {
        String isd = "";
        if (tokenMap['countrycode'] != null &&
            tokenMap['countrycode'].toString().toLowerCase() != "true") {
          isd = tokenMap['countrycode'].toString();
        }
        mobile = isd + tokenMap['mobile'].toString();
      }
      if (tokenMap['email'] != null &&
          tokenMap['email'].toString().toLowerCase() != "true") {
        email = tokenMap['email'].toString();
      }

      totalAmount = amount;
      transactionId = tranId;
      Razorpay razorpay = Razorpay();
      var options = {
        'key': Config.RazorPayKey,
//        'amount': amount,
        'name': 'Vegetos',
        'description': 'Vegetos Checkout',
        'order_id': orderId,
        'prefill': {'contact': mobile, 'email': email}
      };

      razorpay.open(options);

      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(response);
    callPaymentConfirmAPI(response.paymentId, totalAmount, transactionId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response.message);
    Fluttertoast.showToast(
        msg: response.message != null ? response.message : "Payment failed!");
    Navigator.of(context).pop();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(response);
    Navigator.of(context).pop();
  }

  void callPaymentConfirmAPI(
      String paymentId, String totalAmount, String transactionId) {
    ProgressDialog progressDialog = Utility.progressDialog(context, "");
    progressDialog.show();
    ApiCall()
        .setContext(context)
        .confirmPayment(paymentId, transactionId)
        .then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        //callClearCartAPI(progressDialog);
        if (progressDialog != null && progressDialog.isShowing()) {
          progressDialog.dismiss();
        }
        ApiCall().clearCart().then((apiResponseModel) {
          if (apiResponseModel.statusCode == 200 ||
              apiResponseModel.statusCode == 204) {
            Navigator.pushAndRemoveUntil(
                context,
                EnterExitRoute(
                    enterPage: OrderPlacedScreen(transactionId, true)),
                (c) => false);
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
      } else if (apiResponseModel.statusCode == 401) {
        if (progressDialog != null && progressDialog.isShowing()) {
          progressDialog.dismiss();
        }
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : 'Something went wrong');
        Navigator.of(context).pop();
      } else {
        if (progressDialog != null && progressDialog.isShowing()) {
          progressDialog.dismiss();
        }
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : 'Something went wrong');
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

class PaymentModeC {
  String name;
  int index;

  PaymentModeC({this.name, this.index});
}
