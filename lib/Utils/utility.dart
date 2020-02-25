import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/force_update.dart';
import 'package:vegetos_flutter/Utils/Enumaration.dart';

class Utility {

  static toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }


  static ProgressDialog progressDialog(BuildContext context, String msg) {
    ProgressDialog pr= new ProgressDialog(
        context, type: ProgressDialogType.Normal, isDismissible: false);
    if(msg!=null && msg.isNotEmpty) {
      pr.style(message: msg,messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600));
    }
    return pr;
  }

  static String getInitialStatus(int currentStatus){
        String status="";
        switch(currentStatus){
          case 0: status="Draft"; break;
          case 1: status="Pending"; break;
          case 2: status="Failed"; break;
          case 3: status="Ordered"; break;
          case 4: status="Confirmed"; break;
          case 5: status="Rejected"; break;
          case 6: status="Cancelled"; break;
          case 7: status="InTransit"; break;
          case 8: status="Received"; break;
        }
        return status;
  }
  static String getFirstStatuslabel(int currentStatus){
    if(currentStatus>=3){
      return "Ordered";
    }else{
      return getInitialStatus(currentStatus);
    }
  }
  static String getSecondStatuslabel(int currentStatus){
    if(currentStatus>=6 || currentStatus<=4){
      return "Confirmed";
    }else{
      return getInitialStatus(currentStatus);
    }
  }

  static void forceUpate(BuildContext context){
    if(Platform.isAndroid) {
      InAppUpdate.checkForUpdate().then((state) {
        if (state.immediateUpdateAllowed && state.updateAvailable) {
          InAppUpdate.performImmediateUpdate();
        } else {
          Navigator.pushAndRemoveUntil(
              context, EnterExitRoute(enterPage: ForceUpdate(true)), (
              c) => false);
        }
      });
    }else{
      Navigator.pushAndRemoveUntil(
          context, EnterExitRoute(enterPage: ForceUpdate(true)), (
          c) => false);
    }
  }
}
