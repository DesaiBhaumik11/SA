import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/register_screen.dart';
import 'package:vegetos_flutter/UI/verify_otp.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String mobile="" ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },

              child: Padding(
                padding: EdgeInsets.all(20),
                child: Icon(Icons.close,color: Colors.red,
                ),
              ),
            ),
          ],
      ),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[

            SizedBox(height: 50),


            Image.asset('login.png', height: 170, ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Login with OTP', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19
                ),),
              ],
            ),

            SizedBox(height: 7),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('We will send you a One Time Password', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('on your registered mobile number', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
              ],
            ),

            SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                  'Enter your mobile number', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                  fontSize: 15
              )
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 10,
                onChanged: (e){
                  mobile = e ;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.symmetric(vertical: 10)
                ),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),


            SizedBox(height: 50),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          if(mobile==""||mobile.length < 10){

                            Utility.toastMessage("Enter Correct Number")  ;

                          }else{    loginApi();

                          }

                          // Navigator.of(context).push(SlideLeftRoute(page: VerifyOTP()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Login', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),

            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(child: Text('Register ', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                ),),onTap: (){
                  Navigator.push(context, EnterExitRoute(enterPage: RegisterScreen()));
                },) ,

                SizedBox(width:20),
              ],
            ),


          ],
        ),
      ),
    ),
    onWillPop: (){
      Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: DashboardScreen()),(c)=>false);

    },) ;
  }


  void loginApi() {


    ProgressDialog progressDialog  = Utility.progressDialog(context, "") ;
    progressDialog.show() ;
    NetworkUtils.postRequest(endpoint: Constant.Login  ,body: json.encode({
      "IsdCode": "+91",
      "Mobile": ""+mobile})).then((res){
        print("loginApi Response login $res") ;
        progressDialog.dismiss();

        final decoded = jsonDecode(res) as Map;
        print("login Response  ${res}");
        String message =decoded["Message"] ;
        if(message=="User registered. Otp sent."){
          Navigator.of(context).push(SlideLeftRoute(page: VerifyOTP(mobile)));
        }else{
          Utility.toastMessage(message) ;
        }

    }).catchError((e){
      print("Login catchError $e") ;
      progressDialog.dismiss();
    });
  }

}
