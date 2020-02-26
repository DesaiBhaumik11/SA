import 'dart:convert';

import 'package:flutter/services.dart';

class DataProvider{

  Future<String> loadPrivacyPolicy() async {
    String jsonString = await rootBundle.loadString('assets/privacyPolicy.json');
    final jsonResponse = json.decode(jsonString);
    //print(jsonResponse["kHtmlPP"]);
    return jsonResponse["kHtmlPP"];
  }

  Future<String> loadTermsAndCondition() async {
    String jsonString = await rootBundle.loadString('assets/termsAndCondition.json');
    final jsonResponse = json.decode(jsonString);
    //print(jsonResponse["kHtmlPP"]);
    return jsonResponse["kHtmlTC"];
  }
  Future<String> loadAboutVegetos() async {
    String jsonString = await rootBundle.loadString('assets/about_vegetos.json');
    final jsonResponse = json.decode(jsonString);
    //print(jsonResponse["kHtmlPP"]);
    return jsonResponse["kHtmlAV"];
  }
}