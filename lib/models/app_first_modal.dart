// To parse this JSON data, do
//
//     final appFirstModal = appFirstModalFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';

AppFirstModal appFirstModalFromJson(String str) => AppFirstModal.fromJson(json.decode(str));

String appFirstModalToJson(AppFirstModal data) => json.encode(data.toJson());

class AppFirstModal extends ChangeNotifier {
  String version;
  int statusCode;
  String message;
  bool isError;
  Result result;
  bool loaded=false;
  bool _loading=false;
  String ImageUrl ="";

  AppFirstModal({
    this.version,
    this.statusCode,
    this.message,
    this.isError,
    this.result,
  });

  factory AppFirstModal.fromJson(Map<String, dynamic> json) => AppFirstModal(
    version: json["Version"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    isError: json["IsError"],
    result: Result.fromJson(json["Result"]),
  );

  Map<String, dynamic> toJson() => {
    "Version": version,
    "StatusCode": statusCode,
    "Message": message,
    "IsError": isError,
    "Result": result.toJson(),
  };



  getDefaults([call]){
      NetworkUtils.getRequest(endPoint: Constant.GetDefaults ).then((r) {
        print("getDefaults response = $r");

        final decoded = jsonDecode(r) as Map;
        final data = decoded['Result'] as Map;

        ImageUrl = data["ImageUrl"] ;
        print("getDefaults" +ImageUrl ) ;

        if(call!=null){
          call();
        }

      }).catchError((e) {

        if(call!=null){
          call();
        }
        print("getDefaults error $e");
      });

  }



  appFirstRun(String jwtToken,[call]){
    Map<String,String> headers = Map() ;
    Map<String,String> body = Map() ;
    headers["device_token"]=jwtToken ;
    //headers["Content-Type"]="application/json" ;

    if(!_loading) {
      _loading=true;
      NetworkUtils.appFirstRunPost(endpoint: Constant.AppFirstStart ,body:  body , headers: headers).then((r) {
        _loading=false;
        print("appFirstRun response = $r");



        setData( json.decode(r) , call);
//        if(call!=null){
//          call();
//        }

      }).catchError((e) {
        _loading=false;
        print("appFirstRun error $e");
if(call!=null){
  call();
}
        loaded=true;
        notifyListeners();



        //setData(json.decode(e));



      });
    }
  }



  void setDataLoginRToken(json, SharedPreferences prefs){


    result = Result.fromJson(json["Result"]);

    print("setDataLoginRToken   ${result.token}") ;
    prefs.setString("AUTH_TOKEN",result.token) ;
    NetworkUtils.updateToken(prefs);
  }


  void setData(json,[call]) {
    version = json["Version"];
    statusCode = json["StatusCode"];
    message = json["Message"];
    isError = json["IsError"];

    if (statusCode == 200) {
    result = Result.fromJson(json["Result"]);
    SharedPreferences.getInstance().then((r) {
      r.setString("AUTH_TOKEN", result.token);
      NetworkUtils.updateToken(r);
      getDefaults(call);
    });
    loaded = true;
    notifyListeners();
  }else{
      if(message=="Another user is active on this device."){


        SharedPreferences.getInstance().then((r) {
          NetworkUtils.updateToken(r);
          getDefaults(call);
        });

      }else{
        Utility.toastMessage(message);
      }
    }}


}

class Result {
  String token;

  Result({
    this.token,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    token: json["Token"],
  );

  Map<String, dynamic> toJson() => {
    "Token": "Bearer " + token,
  };
}
