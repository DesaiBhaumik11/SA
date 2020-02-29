import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/login.dart';
import 'package:vegetos_flutter/UI/update_profile.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/pin_view.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';

// ignore: must_be_immutable
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

  TextEditingController otpController = TextEditingController();
  String thisText = "";
  int pinLength = 6;

  bool hasError = false;
  String errorMessage;

  _VerifyOTPState(String phone) {
    this.phone=phone ;
  }



  @override
  Widget build(BuildContext context) {
    appFirstModal = Provider.of<AppFirstModal>(context) ;


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
      body: Column(
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


          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
            alignment: Alignment.center,
            child:PinCodeTextField(
              autofocus: false,
              isCupertino: false,
              pinBoxOuterPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              controller: otpController,
              hideCharacter: true,
              highlight: true,
              highlightColor: Const.iconOrange,
              defaultBorderColor: Const.allBOxStroke,
              hasTextBorderColor: Const.widgetGreen,
              maxLength: pinLength,
              hasError: hasError,
              maskCharacter: "#",

              onDone: (text){
                code = text;
                print("DONE $text");
              },
//                pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
              wrapAlignment: WrapAlignment.start,
              pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
              pinTextStyle: TextStyle(fontSize: 30.0),
              pinBoxWidth: 45,
              pinBoxHeight: 45,
              pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
              pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
            ),
          ),
          Visibility(
            child: Text(
              "Wrong PIN!",
              style: TextStyle(color: Colors.red),
            ),
            visible: hasError,
          ),


//
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 15),
//            child: PinView (
//                count: 6, // count of the fields, excluding dashes
//                autoFocusFirstField: false,
//                submit: (e){
//                  code= e ;
//                  print("PinView Submit ${e}") ;
//                } // gets triggered when all the fields are filled
//            ),
//          ),


          SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        code = otpController.text;
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

      if(root["StatusCode"]==200){
        SharedPreferences.getInstance().then((prefs){
         // prefs.setString("AUTH_TOKEN",result["Token"]) ;
         // prefs.setBool("login", true);
          prefs.setString("phone", "$phone");
          appFirstModal.setDataLoginRToken(root ,prefs);

        });
        Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: DashboardScreen()),(c)=>false);
      }else{
        Utility.toastMessage("${root["Message"]}") ;
      }

    }).catchError((e){
      print("validate catchError $e") ;
    });
  }

//  void validate() {
//    ProgressDialog dialog = Utility.progressDialog(context,"");
//    dialog.show() ;
//    ApiCall().validate(code, phone).then((apiResponseModel){
//      if(apiResponseModel.statusCode == 200) {
//        appFirstStartResponseModel =  AppFirstStartResponseModel.fromJson(apiResponseModel.Result);
//        SharedPreferences.getInstance().then((prefs){
//          prefs.setString("phone", "$phone");
//          prefs.setBool("login",true) ;
////          prefs.setString("AUTH_TOKEN",appFirstModal.token) ;
//        });
//        Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: DashboardScreen()),(c)=>false);
//      } else if(apiResponseModel.statusCode == 401) {
//        Utility.toastMessage("${apiResponseModel.message}") ;
//      } else {
//        Utility.toastMessage("${apiResponseModel.message}") ;
//      }
//    });
//  }
}
