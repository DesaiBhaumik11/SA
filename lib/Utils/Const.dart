

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Const
{
  static String initialRoute = "/";
  static String welcome = "/WelcomeScreen";
  static String dashboard = "/DashboardScreen";
  static String categories = "/CategoriesScreen";
  static String productDetail = "/ProductDetailScreen";
  static String myCart = "/MyCartScreen";
  static String paymentOption = "/PaymentOptionScreen";

  static String welcome1_title = "Fresh, Organic & Handpicked";
  static String welcome1_desc = "We prefer local and organically grown fruits and vegetables, assuring that all of them are fresh and healthy enough for your family.";

  static String welcome2_title = "Most Affordable Price";
  static String welcome2_desc = "Redefine 'pocket-friendly' and get your daily/weekly/monthly groceries at the lowest price only on 'Vegetos'.";

  static String welcome3_title = "Scheduled Delivery";
  static String welcome3_desc = "Get your orders delivered at your doorstep at your time of convenience by simply booking the preferred timeslot with 'Vegetos' app.";

  static String category_title = "Fruits & Vegetables";
  static String category_desc = "Pick what you need from a variety of fresh and hand-picked fruits and vegetables.";

  static String product_detail_desc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  static String demo_address = "Shayona Tilak 3, New SG road, Gota\nAhmedabad Gujarat 380248";

  static String disclaimer = "Disclaimer: Please check the product at the time of delivery.";


  //static const primaryColor = Color(0xFF009a00);
  static const gray_10 = Color(0xFFe6e6e6);
  static const dashboard_gray = Color(0xFF464646);
  static const location_grey = Color(0xFF393939);
  static const grey_800 = Color(0xFF808080);
  static const nav_menu_devider = Color(0xFFDAF1F7);

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

  //static Color primaryColor = const Color(0xFF009a00);
}