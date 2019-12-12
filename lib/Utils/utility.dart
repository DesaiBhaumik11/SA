import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Utility {

  static toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  static ProgressDialog progressDialog(BuildContext context, String msg) {
    ProgressDialog pr = new ProgressDialog(
        context, type: ProgressDialogType.Normal, isDismissible: false);
    return pr;
  }
}
