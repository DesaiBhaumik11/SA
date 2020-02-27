import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/verify_otp.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String mobile ="" ;
  String email ="",name ="",reffer_code="" ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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


            Image.asset('login.png', height: 140, ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Register with OTP', style: TextStyle(
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


//            SizedBox(height: 30),

//            Padding(
//              padding: const EdgeInsets.only(left: 15),
//              child: Text(
//                  'Enter your Reffer Code', style: TextStyle(
//                  fontWeight: FontWeight.w500,
//                  color: Colors.black54,
//                  fontSize: 15
//              )
//              ),
//            ),
//
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 15),
//              child: TextFormField(
//                maxLength: 100,
//                onChanged: (e){
//                  reffer_code = e ;
//                },
//                keyboardType: TextInputType.text,
//                decoration: InputDecoration(
//                    counterText: '',
//                    contentPadding: EdgeInsets.symmetric(vertical: 10)
//                ),
//                style: TextStyle(
//                  fontSize: 18,
//                  fontWeight: FontWeight.w500,
//                ),
//              ),
//            ),



            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                  'Enter your Name', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                  fontSize: 15
              )
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 100,
                onChanged: (e){
                  name = e ;
                },
                keyboardType: TextInputType.text,
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


            SizedBox(height: 30),

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


            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                  'Enter your email', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                  fontSize: 15
              )
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 100,
                onChanged: (e){
                  email = e ;
                },
                keyboardType: TextInputType.emailAddress,
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



            SizedBox(height: 30),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          if(mobile==""||mobile.length < 10){
                            Utility.toastMessage("Enter phone number")  ;
                          }else{

                            register();
                          }
                          // Navigator.of(context).push(SlideLeftRoute(page: VerifyOTP()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Register', style: TextStyle(
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

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(child: Text('Login ', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                ),),onTap: (){

                  Navigator.pop(context) ;
                  //Navigator.pushNamed(context, Const.loginScreen);
                },) ,

                SizedBox(width:20),
              ],
            ),

          ],
        ),
      ),
    );
  }

  void register() {

    ProgressDialog dialog = Utility.progressDialog(context,"");
    dialog.show() ;
    NetworkUtils.postRequest(endpoint: Constant.Register  ,body: json.encode(
        {
      "Email":""+email,
      "Name":""+name,
      "ReferralCode":""+reffer_code,
      "IsdCode": "+91",
      "Mobile": ""+mobile}

      )).then((res){

        dialog.dismiss() ;

        var root =json.decode(res);

        if(root["StatusCode"]==200){

          Navigator.of(context).push(SlideLeftRoute(page: VerifyOTP(mobile)));
        }else{
          Utility.toastMessage("${root["Message"]}") ;
        }

        print("Register Response Here $res") ;

    });
  }


//
//  void validate(String code) {
//    ProgressDialog dialog = Utility.progressDialog(context,"");
//    dialog.show() ;
//    NetworkUtils.postRequest(endpoint: Constant.Validate  ,body: json.encode({
//      "Code":""+code,
//      "IsdCode": "+91",
//      "Mobile": ""+mobile})).then((res){
//      dialog.dismiss() ;
//      print("validate response $res") ;
//
//    }).catchError((e){
//      print("validate catchError $e") ;
//    });
//  }

}
