import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
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

                        }else{


                          validate();

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
                  Navigator.pushNamed(context, Const.registerScreen);
                },) ,

                SizedBox(width:20),
              ],
            ),


          ],
        ),
      ),
    );
  }


  void validate() {


    NetworkUtils.postRequest(endpoint: Constant.Login  ,body: json.encode({
      "IsdCode": "+91",
      "Mobile": ""+mobile})).then((res){
        print("Login Response Here $res") ;

    });
  }
}
