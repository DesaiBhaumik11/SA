


import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:vegetos_flutter/Utils/const.dart';

class SplashScreen extends StatelessWidget {
  bool runOnce=true;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   if(runOnce){
     runOnce=false;
     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
     Future.delayed(const Duration(milliseconds: 3000), () {

       getJwtToken() ;

       Navigator.pushNamed(context, Const.welcome);
     });
   }

    return Scaffold(
      body: Container(
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
            )
          ],
        ),
      ),
    );
  }


  String _counter="Token";

  String map="Map";

  Future getJwtToken() async {

    String manufacturer,model,osVersion;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      manufacturer=androidInfo.manufacturer;
      model=androidInfo.model;
      osVersion=androidInfo.version.release;
    }else{
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      model=iosInfo.model;
      osVersion=iosInfo.utsname.version;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map<String,dynamic> map=Map();
    map["id"]=              Uuid().v4();
    map["appversion"]=      packageInfo.version;
    map["appversioncode"]=  packageInfo.buildNumber;
    map["manufacturer"]=    Platform.isIOS?"Apple":manufacturer;
    map["model"]=           model;
    map["os"]=              Platform.isAndroid?"Android":"Ios";
    map["osversion"]=       osVersion;
    map["platform"]=        "Mobile";
    map["notificationid"]=  "23";
    print("Map = $map");

    final key = '2C39927D43F04E1CBAB1615841D94000';
    final claimSet = new JwtClaim(
      issuer: 'com.archisys.vegetos',
      audience: <String>['com.archisys.artis'],
      otherClaims: map,
    );
    String token = issueJwtHS256(claimSet, key);



    SharedPreferences.getInstance().then((prefs){
      prefs.setString("JWT_TOKEN", "" + token) ;

    });


    print("JWT token  =  $token");


  }

}