// To parse this JSON data, do
//
//     final appFirstModal = appFirstModalFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';

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
  String device_token ="" ;
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


  updateDeviceToken(String token){
    device_token = token ;
  }


  getDefaults(){
      NetworkUtils.getRequest(endPoint: Constant.GetDefaults ).then((r) {
        print("getDefaults response = $r");

        final decoded = jsonDecode(r) as Map;
        final data = decoded['Result'] as Map;

        ImageUrl = data["ImageUrl"] ;
        print("getDefaults" +ImageUrl ) ;


      }).catchError((e) {

        print("getDefaults error $e");
      });

  }



  appFirstRun(String jwtToken){
    Map<String,String> headers = Map() ;
    Map<String,String> body = Map() ;
    headers["device_token"]=jwtToken ;
    //headers["Content-Type"]="application/json" ;

    if(!_loading) {
      _loading=true;
      NetworkUtils.appFirstRunPost(endpoint: Constant.AppFirstStart ,body:  body , headers: headers).then((r) {
        _loading=false;
        print("appFirstRun response = $r");
        setData(json.decode(r));
      }).catchError((e) {
        _loading=false;
        print("appFirstRun error $e");

        loaded=true;
        notifyListeners();



        //setData(json.decode(e));



      });
    }
  }

  void setData(json) {


      version = json["Version"];
      statusCode = json["StatusCode"];
      message = json["Message"];
      isError = json["IsError"];
      result = Result.fromJson(json["Result"]);

    loaded=true;
    notifyListeners();
  }


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
