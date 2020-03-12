import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/AuthTokenController.dart';
import 'package:vegetos_flutter/Utils/DeviceTokenController.dart';
import 'package:vegetos_flutter/Utils/config.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';

typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

abstract class NetworkUtils {
  //static String _baseUrl="http://artismicro.archisys.biz:5101/";
  static String _baseUrl = Config.baseURL + '/';
  static String awtToken = "";
  static bool useLocalToken = false;



  static String deviceToken ="" ;
  static String authorization = "";

  static updateToken(SharedPreferences prefs){

    print("updateToken >>JWT_TOKEN ${prefs.getString("JWT_TOKEN")}") ;
    print("updateToken >>AUTH_TOKEN ${prefs.getString("AUTH_TOKEN")}") ;

    if(prefs.getString("JWT_TOKEN")==null){
      DeviceTokenController();
    }else{
      deviceToken = prefs.getString("JWT_TOKEN") ;
    }

    if(prefs.getString("AUTH_TOKEN")==null){
      AuthTokenController();
    }else{
      authorization = prefs.getString("AUTH_TOKEN") ;
    }

  }

  static Future<String> postRequest(
      {body,
      String endpoint,
      Map<String, String> headers}) async {


    String url = '$_baseUrl$endpoint';

    print("postRequest url ${url} >> Body >>> ${body.toString()}");


    Map<String, String> headerMap = Map();

    DeviceTokenController();
    AuthTokenController();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString("JWT_TOKEN");
    String authorization = prefs.getString("AUTH_TOKEN");


    headerMap["device_token"] = deviceToken;
    headerMap["Content-Type"] = "application/json";
    headerMap["Authorization"] = "Bearer "+authorization;


    print("postRequest Headers ${headerMap.toString()}") ;

    Response response = await post(url, headers: headerMap, body: body);
    if(response.statusCode==200){
    }else{

      if(response.statusCode==405){
        refreshToken(body: body , endpoint: endpoint , requestType: "postRequest");
      }else{

      }

     // print("Response for$endpoint = ${response.body}");

        Fluttertoast.showToast(msg: "Error ${response.statusCode} ${response.reasonPhrase}",backgroundColor: Colors.redAccent,textColor: Colors.white);
    }
    return response.body;

  }

  static Future<String> getRequest({String endPoint}) async {
    Map<String, String> headerMap = Map();

    DeviceTokenController();
    AuthTokenController();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString("JWT_TOKEN");
    String authorization = prefs.getString("AUTH_TOKEN");
    headerMap["device_token"] = deviceToken;
    headerMap["Content-Type"] = "application/json";
    headerMap["Authorization"] = "Bearer "+authorization;


    String url = "$_baseUrl$endPoint";
    print("Url = $url");
    print("Heades = device_token>>>$deviceToken");
    print("Heades = Authorization>>>$authorization");

    Response response = await get(url, headers: headerMap);

    return response.body;

  }

  static bool trustSelfSigned = true;

  static HttpClient _getHttpClient() {
    HttpClient httpClient = new HttpClient()
      ..connectionTimeout = const Duration(seconds: 10)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  static Future<String> fileUploadMultipart(
      {Map<String, String> body,
      String pathKey,
      String endPoint,
      String fileName,
      String filePath,
      OnUploadProgressCallback onUploadProgress}) async {
    final url = '$_baseUrl$endPoint';
    print("url multipart = $url");
    print("body multipart = $body");
    print("filePath multipart = $filePath");
    print("fileName multipart = $fileName");

    final httpClient = _getHttpClient();

    final request = await httpClient.postUrl(Uri.parse(url));

    int byteCount = 0;

    var requestMultipart = MultipartRequest("", Uri.parse("uri"));
    if (filePath != null && filePath.isNotEmpty) {
      var multipart = await MultipartFile.fromPath(pathKey, filePath);
      requestMultipart.files.add(multipart);
    }
    requestMultipart.fields.addAll(body);

    var msStream = requestMultipart.finalize();

    var totalByteLength = requestMultipart.contentLength;

    request.contentLength = totalByteLength;

    request.headers.set(HttpHeaders.contentTypeHeader,
        requestMultipart.headers[HttpHeaders.contentTypeHeader]);

    Stream<List<int>> streamUpload = msStream.transform(
      new StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
            // CALL STATUS CALLBACK;
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
        },
      ),
    );

    await request.addStream(streamUpload);

    final httpResponse = await request.close();
//
    var statusCode = httpResponse.statusCode;

    return await readResponseAsString(httpResponse);
  }

  static Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = new Completer<String>();
    var contents = new StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }

  _generateToken() async {
    String manufacturer, model, osVersion;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      manufacturer = androidInfo.manufacturer;
      model = androidInfo.model;
      osVersion = androidInfo.version.release;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      model = iosInfo.model;
      osVersion = iosInfo.utsname.version;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map<String, dynamic> map = Map();
    map["id"] = Uuid().v4();
    map["appversion"] = packageInfo.version;
    map["appversioncode"] = packageInfo.buildNumber;
    map["manufacturer"] = Platform.isIOS ? "Apple" : manufacturer;
    map["model"] = model;
    map["os"] = Platform.isAndroid ? "Android" : "Ios";
    map["osversion"] = osVersion;
    map["platform"] = "Mobile";
    map["notificationid"] = "23";
    print("Map = $map");

    final key = '2C39927D43F04E1CBAB1615841D94000';
    final claimSet = new JwtClaim(
      issuer: 'com.archisys.vegetos',
      audience: <String>['com.archisys.artis'],
      otherClaims: map,
    );

    String token = issueJwtHS256(claimSet, key);
//    setState(() {
//      _counter=token;
//      this.map="$map";
//    });
    print("JWT token  =  $token");
  }

  static Future<String> putRequest(
      {body,
        String endpoint,
        Map<String, String> headers}) async{
    print("Put Request" + body.toString());
    String url = '$_baseUrl$endpoint';
//    Map<String, String> headerMap = headers ?? new Map();
    Map<String, String> headerMap = Map();

    headerMap["device_token"] = deviceToken;
    headerMap["Content-Type"] = "application/json";
    //headerMap["Authorization"] = authorization;
    headerMap["Authorization"] = "Bearer "+authorization;

    Response response = await put(url, headers: headerMap, body: body??Map());
    if(response.statusCode==200){
    }else{
      Fluttertoast.showToast(msg: "Error ${response.statusCode} ${response.reasonPhrase}",backgroundColor: Colors.redAccent,textColor: Colors.white);
    }
   // print("Response for$endpoint = ${response.body}");
    return response.body;
  }


  static Future<String> deleteRequest({String endPoint}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url="$_baseUrl$endPoint";
    Map<String, String> headerMap = Map();
    headerMap["device_token"] = prefs.getString("JWT_TOKEN");
    headerMap["Content-Type"] = "application/json";
    //headerMap["Authorization"] = authorization;
    headerMap["Authorization"] = "Bearer "+prefs.getString("AUTH_TOKEN");


    Response response = await delete(url, headers: headerMap);
    if(response.statusCode==200){
    }else{
      Fluttertoast.showToast(msg: "Error ${response.statusCode} ${response.reasonPhrase}",backgroundColor: Colors.redAccent,textColor: Colors.white);
    }
   // print("$endPoint response = ${response.body}");
   // print("Response for$endPoint = ${response.body}");
    return response.body;
  }

  static Future<String> appFirstRunPost(
      {body,
        String endpoint,
        Map<String, String> headers}) async {
    String url = '$_baseUrl$endpoint';
    Response response = await post(url, headers: headers, body: body??Map());
    if(response.statusCode==200){
    }else{
      Fluttertoast.showToast(msg: "Error ${response.statusCode} ${response.reasonPhrase}",backgroundColor: Colors.redAccent,textColor: Colors.white);
    }
    return response.body;

  }

  static Future<String> refreshToken(
      {body,
        String endpoint,
        String requestType}) async {
    Map<String,String> headers = Map();
    String url = '$_baseUrl'+ Constant.RefreshToken + deviceToken;
    Response response = await post(url, headers: headers, body: body??Map());
    if(response.statusCode==200){
      print("refreshToken Response ${response}");
      if(requestType=="postRequest"){
        postRequest(body:  body , endpoint: endpoint);
      }


    }else{
      Fluttertoast.showToast(msg: "Error ${response.statusCode} ${response.reasonPhrase}",backgroundColor: Colors.redAccent,textColor: Colors.white);
    }
    return response.body;

  }

}
