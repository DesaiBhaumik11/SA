
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceTokenController
{
  DeviceTokenController()
  {
    SharedPreferences.getInstance().then((prefs) {
      String getToken = prefs.getString("JWT_TOKEN");
      String uuid = Uuid().v4();
      if(getToken != null && getToken.isNotEmpty) {
        bool isValid = validateJWTToken(getToken);
        if(!isValid) {
          getJwtToken(uuid);
        }
      } else {
        getJwtToken(uuid);
      }
    });
  }

  Future<String> getJwtToken(String uuid) async {

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
    map["id"]=              uuid;
    map["appversion"]=      packageInfo.version;
    map["appversioncode"]=  packageInfo.buildNumber;
    map["manufacturer"]=    Platform.isIOS?"Apple":manufacturer;
    map["model"]=           model;
    map["os"]=              Platform.isAndroid?"Android":"Ios";
    map["osversion"]=       osVersion;
    map["platform"]=        "Mobile";
    map["notificationid"]=  "";

    print("Map = $map") ;

    final key = '2C39927D43F04E1CBAB1615841D94000';
    final claimSet = new JwtClaim(
        issuer: 'com.archisys.vegetos',
        audience: <String>['com.archisys.artis'],
        otherClaims: map,
        maxAge: const Duration(minutes: 5)
    );
    String token = issueJwtHS256(claimSet, key);

    SharedPreferences.getInstance().then((prefs){
      prefs.setString("JWT_TOKEN",token) ;
    });
    print("JWT token  =  $token");
    return token;
  }


  bool validateJWTToken(String token) {
    try {
      String key = "2C39927D43F04E1CBAB1615841D94000";
      final JwtClaim decClaimSet = verifyJwtHS256Signature(token, key);
      decClaimSet.validate();
      return true;
    } catch(e) {
      return false;
    }
  }
}