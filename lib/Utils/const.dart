

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Pages Srings

class Const {

  // Paragraph Strings

  static String welcome1Title = "Fresh, Organic & Handpicked";
  static String welcome1Desc = "We prefer local and organically grown fruits and vegetables, assuring that all of them are fresh and healthy enough for your family.";

  static String welcome2Title = "Most Affordable Price";
  static String welcome2Desc = "Redefine 'pocket-friendly' and get your daily/weekly/monthly groceries at the lowest price only on 'Vegetos'.";

  static String welcome3Title = "Scheduled Delivery";
  static String welcome3Desc = "Get your orders delivered at your doorstep at your time of convenience by simply booking the preferred timeslot with 'Vegetos' app.";

  static String categoryTitle = "Fruits & Vegetables";
  static String categoryDesc = "Pick what you need from a variety of fresh and hand-picked fruits and vegetables.";

  static String productDetailDesc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  static String demoAddress = "Shayona Tilak 3, New SG road, Gota\nAhmedabad Gujarat 380248";

  static String disclaimer = "Disclaimer: Please check the product at the time of delivery.";

  static String deleteAddressConfirm = 'Are you sure you want to delete\nthis saved address?';

  static String localitydialog1 = 'Locality can\'t be changed';
  static String localitydialog2 = 'Your delivery address has to be inside\nPaldi,Ahmedabad as you have shopped\nfrom the same locality';

  static String offerZone1 = 'June Sale | Get 50% off';
  static String offerZone2 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

  static String aboutVegetos1 = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\nContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.';
  static String privacyPolicy = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\nContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.';
  static String termsConditions = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\nContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.';
  static String contactUs ='\nEmail : info@ok.in\n\nContact Number : 079-42393668\n';

  static String aboutAppRelease1 = 'Ok Greens is brand name owned & managed by Ok Fruits & vegetables Packing Industries.\nWe are providing service of door step delivery of Fruits & Vegetables, grocery & staples, etc..';
  static String aboutAppRelease2 = 'Introducing payment options like UPI, Payment, PhonePe etc. starting from 1 june 2019 12:00 AM';
  static String aboutAppRelease3 = 'Get instant refunds through Ok Greens Cash. Use it for your next purchase or transfer it back to the orignal payment source.';

  static String logout1 = 'Are you sure you wants to logged out\nof your Ok Greens account?';

  static String subDisc = 'Disclaimer: Please check the product at the time of delivery.';
  static String unsubscribedDialog = 'Are you sure you want to\nUnsubscribe this item?';

  static String userNotVeg = 'It seems that the some of your select\ncontacts doesn\'t have Ok Greens,\nwill share download link via sms.';

  static String startedCart = 'has shared a cart with you';

  //static const primaryColor = Color(0xFF009a00);
  static const gray10 = Color(0xFFe6e6e6);
  static const dashboardGray = Color(0xFF464646);
  static const locationGrey = Color(0xFF393939);
  static const grey800 = Color(0xFF808080);
  static const navMenuDivider = Color(0xFFDAF1F7);
  static const orange = Color(0xffE36130);
  static const appBar = Color(0xff47870d);
  static const greyLight = Color(0xffCED1D8);
  static const cancel = Color(0xffD00033);

  static const iconOrange = Color(0xffda6013);
  static const textBlack = Color(0xff000000);
  static const widgetGreen = Color(0xff019024);
  static const colorGrey = Color(0xff797979);
  static const menuIconGrey = Color(0xff999999);
  static const allBOxStroke = Color(0xff898989);
  static const cancelButton = Color(0xffc6c6c6);

  static const calenderBlue = Color(0xff9f295e);
  static const calenderPurple = Color(0xff2c87f6);
  static const calenderRed = Color(0xffe80000);



  static Map<int, Color> color =
  {
    50:Color.fromRGBO(136,14,79, .1),
    100:Color.fromRGBO(136,14,79, .2),
    200:Color.fromRGBO(136,14,79, .3),
    300:Color.fromRGBO(136,14,79, .4),
    400:Color.fromRGBO(136,14,79, .5),
    500:Color.fromRGBO(136,14,79, .6),
    600:Color.fromRGBO(136,14,79, .7),
    700:Color.fromRGBO(136,14,79, .8),
    800:Color.fromRGBO(136,14,79, .9),
    900:Color.fromRGBO(136,14,79, 1),
  };
  static MaterialColor primaryColor = MaterialColor(0xFF009a00, color);

  static Color primaryColorGreen = Color(0xFF009a00);

  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      Fluttertoast.showToast(msg: 'Invalid token');
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      Fluttertoast.showToast(msg: 'Invalid payload');
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        Fluttertoast.showToast(msg: 'Illigal base64url string!');
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  //Transaction Status
  /*{
  Draft = 0,
  Pending = 1,
  Failed = 2,
  Ordered = 3,
  Confirmed = 4,
  Rejected = 5,
  Cancelled = 6,
  InTransit = 7,
  Received = 8
  }*/


  //PaymentStatus
  /*[Display(Name = "Paid")]
  Paid,
  [Display(Name = "Due")]
  Due,
  [Display(Name = "Partial")]
  Partial*/

}