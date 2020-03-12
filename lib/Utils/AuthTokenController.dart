import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/AppFirstStartResponseModel.dart';

import 'ApiCall.dart';

class AuthTokenController {
  Future<String> validateAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("AUTH_TOKEN");
    if (authToken != null && authToken.isNotEmpty) {
      Map<String, dynamic> tokenMap = Const.parseJwt(authToken);
      if (tokenMap != null) {
        return authToken;
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  void callAppFirstStartAPI() {
    ApiCall().appFirstStart().then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        AppFirstStartResponseModel appFirstStartResponseModel =
            AppFirstStartResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("AUTH_TOKEN", appFirstStartResponseModel.token);
        });
      } else {
        callRefreshTokenAPI();
      }
    });
  }

  void callRefreshTokenAPI() {
    ApiCall().refreshToken().then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        AppFirstStartResponseModel appFirstStartResponseModel =
            AppFirstStartResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("AUTH_TOKEN", appFirstStartResponseModel.token);
        });
      } else {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : 'Something went wrong');
      }
    });
  }
}
