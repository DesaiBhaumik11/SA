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
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';

// ignore: must_be_immutable
class VerifyOTP extends StatefulWidget {
  String phone;

  VerifyOTP(String mobile) {
    this.phone = mobile;
  }

  @override
  _VerifyOTPState createState() => _VerifyOTPState(phone);
}

class _VerifyOTPState extends State<VerifyOTP> {
  String phone, code;

  AppFirstModal appFirstModal;

  TextEditingController otpController = TextEditingController();
  String thisText = "";
  int pinLength = 6;

  bool hasError = false;
  String errorMessage;

  _VerifyOTPState(String phone) {
    this.phone = phone;
  }

  @override
  Widget build(BuildContext context) {
    appFirstModal = Provider.of<AppFirstModal>(context);
    double appBarHeight  = AppBar().preferredSize.height;
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
                padding: EdgeInsets.only(right: 20),
                child: Image.asset(
                  "assets/OkAssets/Cencelicone.png", height: 22, width: 22,)
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBarHeight,
          width:  MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/OkAssets/VerifyOtp.png"))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.33,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Verify OTP',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Enter the six digit OTP sent on',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'your mobile number to continue',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 10),
              otpPin(),
              SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          onPressed: () {
                            code = otpController.text;
                            validate();

                            // Navigator.of(context).push(SlideLeftRoute(page: UpdateProfile()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Verify',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Text(
                  'Haven\'t received the OTP yet?',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(SlideRightRoute(page: LoginScreen()));
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Text(
                      'Resend OTP.',
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget otpPin() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        child: PinCodeTextField(
          autofocus: false,
          isCupertino: false,
          pinBoxOuterPadding:
          EdgeInsets.all(MediaQuery
              .of(context)
              .size
              .width * 0.011),
          controller: otpController,
          hideCharacter: true,
          highlight: true,
          highlightColor: Const.iconOrange,
          defaultBorderColor: Const.allBOxStroke,
          hasTextBorderColor: Const.widgetGreen,
          maxLength: pinLength,
          hasError: hasError,
          maskCharacter: "#",

          onDone: (text) {
            code = text;
            print("DONE $text");
          },
//                pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
          wrapAlignment: WrapAlignment.center,
          pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
          pinTextStyle: TextStyle(fontSize: 30.0),
          pinBoxWidth: 45,
          pinBoxHeight: 45,
          pinTextAnimatedSwitcherTransition:
          ProvidedPinBoxTextAnimation.scalingTransition,
          pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
        ),
      ),
    );
  }

  void validate() {
    ProgressDialog dialog = Utility.progressDialog(context, "");
    dialog.show();
    NetworkUtils.postRequest(
        endpoint: Constant.Validate,
        body: json.encode(
            {"Code": "" + code, "IsdCode": "+91", "Mobile": "" + phone}))
        .then((res) {
      dialog.dismiss();
      print("validate response $res");

      var root = json.decode(res);

      if (root["StatusCode"] == 200) {
        SharedPreferences.getInstance().then((prefs) {
          // prefs.setString("AUTH_TOKEN",result["Token"]) ;
          // prefs.setBool("login", true);
          prefs.setString("phone", "$phone");
          appFirstModal.setDataLoginRToken(root, prefs);
        });
        Navigator.pushAndRemoveUntil(context,
            EnterExitRoute(enterPage: DashboardScreen()), (c) => false);
      } else {
        Utility.toastMessage("${root["Message"]}");
      }
    }).catchError((e) {
      print("validate catchError $e");
    });
  }
}