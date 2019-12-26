import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_view/pin_view.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/login.dart';
import 'package:vegetos_flutter/UI/update_profile.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';

class VerifyOTP extends StatefulWidget {
   String phone ;
  VerifyOTP(String mobile) {
    this.phone = mobile ;
  }


  @override
  _VerifyOTPState createState() => _VerifyOTPState(phone);
}

class _VerifyOTPState extends State<VerifyOTP> {
  String phone  , code ;
  AppFirstModal appFirstModal ;

  _VerifyOTPState(String phone) {
    this.phone=phone ;
  }



  @override
  Widget build(BuildContext context) {
    appFirstModal = Provider.of<AppFirstModal>(context) ;


    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[

          SizedBox(height: 70),
          Image.asset('verify.png', height: 170, ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Verify OTP', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 19
              ),),
            ],
          ),

          SizedBox(height: 7),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Enter the six digit OTP sent on', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15
              ),),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('your mobile number to continue', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15
              ),),
            ],
          ),

          SizedBox(height: 10),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: PinView (
                count: 6, // count of the fields, excluding dashes
                autoFocusFirstField: false,
                submit: (e){
                  code= e ;
                  print("PinView Submit ${e}") ;
                } // gets triggered when all the fields are filled
            ),
          ),




          SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        validate() ;

                        // Navigator.of(context).push(SlideLeftRoute(page: UpdateProfile()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Verify', style: TextStyle(
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

          SizedBox
            (height: 10,),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text('Haven\'t received the OTP yet?', style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
              ),),

              InkWell(
                onTap: (){



                  Navigator.of(context).push(SlideRightRoute(page: LoginScreen()));
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Text(
                    'Resend OTP.', style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500
                  ),
                  ),
                ),
              ),

            ],
          )


        ],
      ),
    );
  }


  void validate() {
    ProgressDialog dialog = Utility.progressDialog(context,"");
    dialog.show() ;
    NetworkUtils.postRequest(endpoint: Constant.Validate  ,body: json.encode({
      "Code":""+code,
      "IsdCode": "+91",
      "Mobile": ""+phone})).then((res){
      dialog.dismiss() ;
      print("validate response $res") ;

      var root = json.decode(res) ;

      if(root["Message"]=="Otp validated."){
        SharedPreferences.getInstance().then((prefs){
         // prefs.setString("AUTH_TOKEN",result["Token"]) ;
         // prefs.setBool("login", true);
          appFirstModal.setDataLoginRToken(root ,prefs) ;
          prefs.setString("phone", "${phone}");
        });


        Navigator.pushNamedAndRemoveUntil(context, Const.dashboard,(c)=>false);
      }else{
        Utility.toastMessage("${root["Message"]}") ;
      }

    }).catchError((e){
      print("validate catchError $e") ;
    });
  }
}
