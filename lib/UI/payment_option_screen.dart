
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/order_placed_screen.dart';
import 'package:vegetos_flutter/UI/promo_screen.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/default_address.dart';
import 'package:vegetos_flutter/models/my_cart.dart';
import 'package:vegetos_flutter/models/shipping_slot_modal.dart';

import 'my_cart_screen.dart';

class PaymentOptionScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentOptionScreenState();
  }

}

class PaymentOptionScreenState extends State<PaymentOptionScreen>
{
  bool isPromoAplied = true;
  bool wallet = true;

    static DefaultAddressModel addressModel;



  @override
  Widget build(BuildContext context) {
    addressModel=Provider.of<DefaultAddressModel>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Const.appBar,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset('back.png', height: 25,),
          ),
        ),
        title: Text('Payment Options', style: TextStyle(fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
      ),
      body: Container(
        color: Const.gray10,
        child: Column(
          children: <Widget>[
            priceTotalBox(),
            promoContainer(),
            walletContainer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            //Navigator.pushNamed(context, Const.paymentOption);

            checkOutCall() ;

           // Navigator.of(context).push(SlideLeftRoute(page: OrderPlacedScreen()));
          },
          child: Container(
            color: Const.primaryColor,
            height: 50.0,
            child: Center(
              child: Text('Procced to Payment', style: TextStyle(fontSize: 18.0, fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w500, color: Colors.white),),
            ),
          ),
        ),
      ),
    );
  }

  Widget priceTotalBox()
  {
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
                      child: Text('M.R.P', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.locationGrey),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('₹ ${MyCartState.myCartModal.result.totalAmount}', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.locationGrey),),
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
                      child: Text('Product Discount', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.locationGrey),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('-₹ ${MyCartState.myCartModal.result.discount}', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.locationGrey),),
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
                          Text('Delivery Charge ', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w500, color: Const.locationGrey),),
                          Icon(Icons.help_outline, color: Const.primaryColor, size: 20.0,),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('FREE', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.primaryColor),),
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
                      child: Text('Promo/Discount', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.locationGrey),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('-₹ ${MyCartState.myCartModal.result.discount}', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.locationGrey),),
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
                      child: Text('Wallet', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.locationGrey),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('-₹0.0', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.locationGrey),),
                    ),
                  ],
                ),
              ),
              Container(color: Const.gray10, height: 1.0, margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text('Sub Total', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Colors.black),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('₹ ${MyCartState.myCartModal.result.totalAmount}', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Colors.black),),
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
                      child: Text('Your Savings', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.locationGrey),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('₹0.0', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.locationGrey),),
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

  Widget promoContainer()
  {
    var promo = Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.asset('assets/promocode.png', height: 25.0, width: 25.0,),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              child: Text('Apply Promo Code', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w500, color: Const.locationGrey),),
            ),
          ),
          Expanded(
            flex: 0,
            child: Icon(Icons.arrow_forward_ios, color: Const.locationGrey,),
          ),
        ],
      ),
    );

    var appliedPromo = GestureDetector(
      onTap: (){
        Navigator.of(context).push(SlideLeftRoute(page: PromoCode()));
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset('assets/promocode.png', height: 25.0, width: 25.0,),
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

            SizedBox(width: 10,),

            Text('Apply Promo Code', style: TextStyle(
                fontSize: 16.0,
                color: Const.locationGrey,
                fontWeight: FontWeight.w500
            ),),

            Expanded(
              flex: 1,
              child: Container(),
            ),


            IconButton(
              onPressed: (){
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

  Widget walletContainer()
  {
    return
      GestureDetector(
        onTap: (){
          setState(() {
            wallet =!wallet;
          });
        },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset('assets/wallet.png', height: 25.0, width: 25.0,),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Text('Wallet', style: TextStyle(fontSize: 18.0, fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.w500, color: Const.locationGrey),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Total Balance: ₹30', style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.locationGrey),),
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


  void checkOutCall() {



    SharedPreferences.getInstance().then((prefs){
      MyCartModal myCartModal = MyCartState.myCartModal ;
      ProgressDialog progressDialog  = Utility.progressDialog(context, "") ;
      progressDialog.show() ;
      NetworkUtils.postRequest(endpoint: Constant.Checkout  ,body: json.encode({

        "DeliveryAddressId": "${addressModel.result.id}",
        "Name": "${addressModel.result.name}",
        "AddressLine1": "${addressModel.result.addressLine1}",
        "AddressLine2": "${addressModel.result.addressLine2}",
        "City": "${addressModel.result.city}",
        "State": "${addressModel.result.state}",
        "Country": "${addressModel.result.country}",
        "Pin": "${addressModel.result.pin}",
        "MobileNo": "${prefs.getString("phone")}",
        "LocationId": "db9770e6-64f6-47d1-a986-9dd6a698ec83",
        "ShippingScheduleId": "f754b121-8082-4843-993a-c4f1a6442704",
        "BusinessId": "1e683706-2c1f-4d34-90a6-6afc796461fe",
        "ShippingDetails": "this is the shipping detail",
        "SubTotal": "${myCartModal.totalCost}",
        "TaxAmount": "2",
        "TotalAmount": "${myCartModal.totalCost}",
        "OfferAmount": "2",
        "CheckoutItems": MyCartState.myCartModal.result.cartItemViewModels ,

      })).then((res){
        print("checkOutCall Response $res") ;
        progressDialog.dismiss();
        var root = json.decode(res) ;

        if(root["Message"] =="Request successful."){

          proceedTopayment() ;


    //      Navigator.of(context).push(SlideLeftRoute(page: OrderPlacedScreen()));

        }else{
          Utility.toastMessage(root["Message"]) ;
        }
      }).catchError((e){
        print("checkOutCall catchError $e") ;
        progressDialog.dismiss();
      });

    }) ;


  }

  void proceedTopayment() {

    MyCartModal myCartModal = MyCartState.myCartModal ;

    NetworkUtils.postRequest(endpoint: Constant.ProceedTopayment  ,body: json.encode({

      "PaymentMethod": "Card",
      "TotalAmount": "${myCartModal.totalCost}",
      "GatewayOrderId": "987654321",


    })).then((res){
      print("proceedTopayment Response $res") ;


      Navigator.of(context).push(SlideLeftRoute(page: OrderPlacedScreen()));
//      var root = json.decode(res) ;
//
//      if(root["Message"] =="Request successful."){
//
//        //proceedTopayment() ;
//
//        Navigator.of(context).push(SlideLeftRoute(page: OrderPlacedScreen()));
//
//      }else{
//        Utility.toastMessage(root["Message"]) ;
//      }

    }).catchError((e){
      print("proceedTopayment catchError $e") ;

    });



  }
}