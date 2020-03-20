import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/login.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var regName = TextEditingController();
  var regEmail = TextEditingController();
  var regPhoneNumber = TextEditingController();
  var regPassword = TextEditingController();
  var regConformPassword = TextEditingController();

  bool _notShowPassword = true;
  bool _autoValidate = false;


  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(top:0.0,right: 20),
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image.asset("assets/OkAssets/Cencelicone.png",height: 22,width: 22),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBarHeight,
          width:  MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/OkAssets/backgraound.PNG")
              )
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              okProfile(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  formForSignUp(),
                  GestureDetector(
                    onTap: () {

                      name= regName.text;
                      email = regEmail.text;
                      mobile = regPhoneNumber.text;

                      if(mobile==""||mobile.length < 10){
                        Utility.toastMessage("Enter phone number");
                      } else {
                        register();
                      }
                      // Navigator.of(context).push(SlideLeftRoute(page: VerifyOTP()));
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            )
                          ],
                          color: Colors.green[700]
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Have An Account?",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              EnterExitRoute(enterPage: LoginScreen(), exitPage: RegisterScreen()));
                        },
                        child: Text(
                          " Sign In",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.green
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formForSignUp() {
    return Container(
//      height: 330,
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Card(
        elevation: 5,
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Name",style: TextStyle(fontWeight: FontWeight.w500),),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: regName,
//                    onChanged: (e) {
//                      name = e;
//                    },
                  ),
                ),
                SizedBox(height: 10),
                Text("Phone Number",style: TextStyle(fontWeight: FontWeight.w500),),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.newline,
                    controller: regPhoneNumber,
//                    onChanged: (e) {
//                      mobile = e;
//                    },
                  ),
                ),
                SizedBox(height: 10),
                Text("Email",style: TextStyle(fontWeight: FontWeight.w500),),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.go,
                    controller: regEmail,
//                    onChanged: (e) {
//                      email = e;
//                    },
                  ),
                ),
                SizedBox(height: 10),
//                Text("Password"),
//                Container(
//                  height: 35,
//                  child: TextFormField(
//                    decoration: InputDecoration(
//                      border: OutlineInputBorder(
//                        //  borderRadius: BorderRadius.all(Radius.circular(20)),
//                      ),
//                      focusColor: Colors.deepPurple,
//                    ),
//                    keyboardType: TextInputType.multiline,
//                    textInputAction: TextInputAction.send,
//                    obscureText: true,
//                    controller: regPassword,
//                    validator: passwordValidation,
//                  ),
//                ),
//                SizedBox(height: 10),
//                Text("Conform Password"),
//                Container(
//                  height: 35,
//                  child: TextFormField(
//                    decoration: InputDecoration(
//                        border: OutlineInputBorder(
//                          //    borderRadius: BorderRadius.all(Radius.circular(20)),
//                        ),
//                        focusColor: Colors.deepPurple,
//                        suffixIcon: IconButton(
//                          icon: Icon(_notShowPassword
//                              ? Icons.visibility_off
//                              : Icons.visibility),
//                          onPressed: () {
//                            setState(() {
//                              _notShowPassword = !_notShowPassword;
//                            });
//                          },
//                        )),
//                    keyboardType: TextInputType.multiline,
//                    textInputAction: TextInputAction.done,
//                    obscureText: _notShowPassword,
//                    controller: regConformPassword,
//                    validator: conformPasswordValidation,
//                  ),
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget okProfile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
      //  SizedBox(height: 50,),
        Text("Sign up",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25,
              color: Colors.green[800]
          ),
        ),
//        Container(
//          margin: EdgeInsets.only(top: 20),
//          height: 100,
//          width: 100,
//          //  color: Colors.blue,
////          child: Stack(
////            children: <Widget>[
////              Container(
////                height: 100,
////                width: 100,
////                decoration: BoxDecoration(
////                    shape: BoxShape.circle,
////                    color: Colors.blueGrey[900],
////                    image: DecorationImage(
////                        image: NetworkImage(
////                            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQf9UDq4tsvB8SQ7Kz6FugTDxwh22MLbVJlACifly-96NfPRrGR"
////                        )
////                    )
////                ),
////              ),
////              Align(
////                alignment: Alignment.bottomRight,
////                child: Container(
////                  height: 30,
////                  width: 30,
////                  child: InkWell(
////                    onTap: () {
////
////                    },
////                    child: Card(
////                      elevation: 2,
////                      color: Colors.green,
////                      shape: RoundedRectangleBorder(
////                        borderRadius: BorderRadius.circular(30.0),
////                      ),
////                      child: Icon(
////                        Icons.add,
////                        color: Colors.white,
////                        size: 20,
////                      ),
////                    ),
////                  ),
////                ),
////              )
////            ],
////          ),
//        )
      ],
    );
  }

  void register() {

    print(email);
    print(mobile);
    print(name);

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
