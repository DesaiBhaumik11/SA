
import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/welcome_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/AuthTokenController.dart';
import 'package:vegetos_flutter/Utils/DeviceTokenController.dart';
import 'package:vegetos_flutter/Utils/Enumaration.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/AppFirstStartResponseModel.dart';
import 'package:vegetos_flutter/models/GetDefaultsResponseModel.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';

class SplashScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }

}

class SplashScreenState extends State<SplashScreen> {

  bool runOnce=true;
  String version = "";
  bool runOnlyOnce=false;
  //AppFirstModal appFirstModal ;

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
    getVeriosnCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //appFirstModal = Provider.of<AppFirstModal>(context);

   /*if(runOnce) {
     runOnce=false;
     SharedPreferences.getInstance().then((prefs) {
       String uuid = prefs.getString("uuid") ?? Uuid().v4();

       prefs.setString("uuid", uuid);



       *//*TokenController().getJwtToken(uuid).then((r) {
         print("AUTH_TOKEN Prefns ${prefs.getString("AUTH_TOKEN")}");
          if(prefs.getString("AUTH_TOKEN")==null){
            appFirstModal.appFirstRun(r,(){navigate(context);}) ;
          }else{
            NetworkUtils.updateToken(prefs );
            appFirstModal.getDefaults();
            navigate(context);
          }
       });*//*
     });
   }*/
    if(!runOnlyOnce) {
      runOnlyOnce=true;
      checkUUID(context);
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: FractionalOffset.topCenter,
                child: Image.asset('assets/top_pattern.png'),
              ),
            ),
            
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Image.asset('assets/splash_logo.png'),
                ),
              )
            ),

            Positioned(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Image.asset('assets/bottom_pattern.png'),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 100.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text('Version : ' + version,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Const.grey800
                  ),
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
    if(uuid == null || uuid.isEmpty) {
      uuid = Uuid().v4();
      prefs.setString("UUID", uuid);
      DeviceTokenController().ValidateDeviceToken().then((token) {
        callAppFirstStartAPI(context);
      });
    } else {
      DeviceTokenController().ValidateDeviceToken().then((token) async {
        String authToken = await AuthTokenController().ValidateAuthToken();
        if(authToken != null && authToken.isNotEmpty) {
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

  navigate(context)
  {
    SharedPreferences.getInstance().then((prefs){
      String businessId = prefs.getString("BusinessLocationId");
      String address = prefs.getString("FullAddress");
      if(businessId != null && businessId.isNotEmpty && address != null && address.isNotEmpty) {
        Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: DashboardScreen()),(c)=>false);
      } else {
        Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: WelcomeScreenState()),(c)=>false);
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
      if(apiResponseModel.statusCode == 200) {
        AppFirstStartResponseModel appFirstStartResponseModel = AppFirstStartResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("AUTH_TOKEN", appFirstStartResponseModel.token);
          callGetDefaultsAPI(context);
        });
      } else {
        callGetDefaultsAPI(context);
      }
    });
  }


  void callRefreshTokenAPI(BuildContext context) {
    ApiCall().refreshToken().then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        AppFirstStartResponseModel appFirstStartResponseModel = AppFirstStartResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("AUTH_TOKEN", appFirstStartResponseModel.token);
        });
        callGetDefaultsAPI(context);
      } else if(apiResponseModel.statusCode == 401){
        //Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong');
        SharedPreferences.getInstance().then((prefs) {
          String uuid = Uuid().v4();
          prefs.setString("JWT_TOKEN","");
          prefs.setString("UUID", uuid);
          DeviceTokenController().ValidateDeviceToken().then((token) {
            callAppFirstStartAPI(context);
          });
        });
      }else{
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong');
      }
    });
  }

  void callGetDefaultsAPI(BuildContext context) {
    ApiCall().getDefaults().then((apiResponseModel){
      if(apiResponseModel.statusCode == 200) {
        GetDefaultsResponseModel getDefaultsResponseModel = GetDefaultsResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("ImageURL", getDefaultsResponseModel.ImageUrl);
          Future.delayed(Duration(seconds: 1)).then((_) {
            navigate(context);
          });
        });
      } else if(apiResponseModel.statusCode == 401) {
        callRefreshTokenAPI(context);
      }
    });
  }
}