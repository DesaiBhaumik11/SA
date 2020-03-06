import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:package_info/package_info.dart';
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
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';
import 'package:vegetos_flutter/models/ProceedToPaymentModel.dart';
import 'package:vegetos_flutter/models/default_address.dart';
import 'package:vegetos_flutter/models/my_cart.dart';

import 'my_cart_screen.dart';

class ForceUpdate extends StatefulWidget {

  bool isAndroidPlatform = true;

  ForceUpdate(this.isAndroidPlatform);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForceUpdateState();
  }
}

class ForceUpdateState extends State<ForceUpdate> {
  var text = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);

  String message="";

  @override
  void setState(fn) {
    // TODO: implement setState
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    PackageInfo.fromPlatform().then((info){
      setState(() {
        message="Your Current App Version "+ info.version + " is no longer supported to the app, please update your app.";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Force Update', style: TextStyle(color: Const.textBlack),),
        actions: <Widget>[
          InkWell(
            onTap: () {
              //myCartModal.loaded =false ;
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              child:
              Stack(
                children: <Widget>[
                  Align(
                    child: Icon(Icons.close, color: Const.iconOrange,),
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Const.gray10,
        child: Column(
          children: <Widget>[
            priceTotalBox(),
        ]
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            OpenAppstore.launch(
                androidAppId: "com.okgreens", iOSAppId: "1496095904");
          },
          child: Container(
            color: Const.primaryColor,
            height: 50.0,
            child: Center(
              child: Text(
                'Update Now',
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
    return Center(child:Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      alignment: Alignment.center,
      child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'New Update Available',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.locationGrey),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        message,
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
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    ));
  }

}
