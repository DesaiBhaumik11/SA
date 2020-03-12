import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/AuthTokenController.dart';
import 'package:vegetos_flutter/Utils/DeviceTokenController.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/AppFirstStartResponseModel.dart';
import 'package:vegetos_flutter/models/GetDefaultsResponseModel.dart';
import 'set_delivery_location.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  bool runOnce = true;
  String version = "";
  bool runOnlyOnce = false;

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
    getVeriosnCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (!runOnlyOnce) {
      runOnlyOnce = true;
      checkUUID(context);
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: new Image.asset(
                'assets/OkAssets/01.Splashscreen.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Version : ' + version,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkUUID(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString("UUID");
    if (uuid == null || uuid.isEmpty) {
      uuid = Uuid().v4();
      prefs.setString("UUID", uuid);
      DeviceTokenController().ValidateDeviceToken().then((token) {
        callAppFirstStartAPI(context);
      });
    } else {
      DeviceTokenController().ValidateDeviceToken().then((token) async {
        String authToken = await AuthTokenController().validateAuthToken();
        if (authToken != null && authToken.isNotEmpty) {
          callGetDefaultsAPI(context);
        } else {
          callAppFirstStartAPI(context);
        }
      });
    }
  }

  Future<String> getVeriosnCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  navigate(context) {
    SharedPreferences.getInstance().then((prefs) {
      String businessId = prefs.getString("BusinessLocationId");
      String address = prefs.getString("FullAddress");
      if (businessId != null &&
          businessId.isNotEmpty &&
          address != null &&
          address.isNotEmpty) {
        Navigator.pushAndRemoveUntil(context,
            EnterExitRoute(enterPage: DashboardScreen()), (c) => false);
      } else {
        SharedPreferences.getInstance().then((prefs){
          prefs.setString("phone", "Guest User");
        }) ;
        Navigator.pushAndRemoveUntil(context,
            EnterExitRoute(enterPage: SetDeliveryLocation()), (c) => false);
      }
    });
  }

  /*void loginCheck(BuildContext context) async {
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setString("AUTH_TOKEN", appFirstModal.result==null?null:appFirstModal.result.token) ;

      SharedPreferences.getInstance().then((prefs){

        if(prefs.getBool("LOGIN")==null){
          Navigator.pushNamed(context, Const.welcome) ;
        }else{
          Navigator.pushNamed(context, Const.dashboard);
        }
      });
  }*/

  void callAppFirstStartAPI(BuildContext context) {
    ApiCall().appFirstStart().then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        AppFirstStartResponseModel appFirstStartResponseModel =
            AppFirstStartResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("AUTH_TOKEN", appFirstStartResponseModel.token);
          callGetDefaultsAPI(context);
        });
      } else if (apiResponseModel.statusCode == 426) {
        Utility.forceUpate(context);
      } else {
        callGetDefaultsAPI(context);
      }
    });
  }

  void callRefreshTokenAPI(BuildContext context) {
    ApiCall().refreshToken().then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        AppFirstStartResponseModel appFirstStartResponseModel =
            AppFirstStartResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("AUTH_TOKEN", appFirstStartResponseModel.token);
        });
        callGetDefaultsAPI(context);
      } else if (apiResponseModel.statusCode == 401) {
        //Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong');
        SharedPreferences.getInstance().then((prefs) {
          String uuid = Uuid().v4();
          prefs.setString("JWT_TOKEN", "");
          prefs.setString("UUID", uuid);
          DeviceTokenController().ValidateDeviceToken().then((token) {
            callAppFirstStartAPI(context);
          });
        });
      } else if (apiResponseModel.statusCode == 426) {
        Utility.forceUpate(context);
      } else {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : 'Something went wrong');
      }
    });
  }

  void callGetDefaultsAPI(BuildContext context) {
    ApiCall().getDefaults().then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        GetDefaultsResponseModel getDefaultsResponseModel =
            GetDefaultsResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("ImageURL", getDefaultsResponseModel.ImageUrl);
          Future.delayed(Duration(seconds: 1)).then((_) {
            navigate(context);
          });
        });
      } else if (apiResponseModel.statusCode == 401) {
        callRefreshTokenAPI(context);
      } else if (apiResponseModel.statusCode == 426) {
        Utility.forceUpate(context);
      } else {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : 'Something went wrong');
      }
    });
  }
}
