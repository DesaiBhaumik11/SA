import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:location/location.dart';
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
    ProgressDialog pr = new ProgressDialog(
        context, type: ProgressDialogType.Normal, isDismissible: false);
    if (msg != null && msg.isNotEmpty) {
      pr.style(message: msg, messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600));
    }
    return pr;
  }



  static void forceUpate(BuildContext context) {
    if (Platform.isAndroid) {
      InAppUpdate.checkForUpdate().then((state) {
        if (state.immediateUpdateAllowed && state.updateAvailable) {
          InAppUpdate.performImmediateUpdate();
        } else {
          Navigator.pushAndRemoveUntil(
              context, EnterExitRoute(enterPage: ForceUpdate(true)), (
              c) => false);
        }
      });
    } else {
      Navigator.pushAndRemoveUntil(
          context, EnterExitRoute(enterPage: ForceUpdate(true)), (c) => false);
    }
  }

  static String displayOrderStatus(String status, String shippingStatus) {
    if (status == EnumOrderStatus.getString(OrderStatus.Confirmed) && shippingStatus != EnumShippingStatus.getString(ShippingStatus.Pending)) {
      return shippingStatus;
    }
    return status;
  }

  static Future<bool> checkEnabledLocationService() async {
    Location location = new Location();
    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    return true;
  }

}
