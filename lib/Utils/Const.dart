

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Pages Srings

class Const
{
  static String initialRoute = "/";
  static String welcome = "/WelcomeScreen";
  static String dashboard = "/DashboardScreen";
  static String categories = "/CategoriesScreen";
  static String productDetail = "/ProductDetailScreen";
  static String myCart = "/MyCartScreen";
  static String paymentOption = "/PaymentOptionScreen";
  static String setDeliveryLocation = "/SetDeliveryLocation";
  static String setLocationManually = "/SetLocationManually";
  static String locationServiceUnavailable = "/LocationServiceUnavailable";
  static String searchScreen = "/SearchScreen";
  static String setDeliveryDetails = "/SetDeliveryDetails";
  static String orderPlacedScreen = "/OrderPlacedScreen";
  static String chooseAddress = "/ChooseAddress";
  static String promoCode = "/PromoCode";
  static String customerSupport1 = "/CustomerSupport1";
  static String customerSupport2 = "/CustomerSupport2";
  static String expiredItems = "/ExpiredItems";
  static String tellUsAbout = "/TellUsAbout";
  static String loginScreen = "/LoginScreen";
  static String verifyOTP = "/VerifyOTP";
  static String updateProfile = "/UpdateProfile";
  static String myOrders = "/MyOrders";
  static String myAddresses = "/MyAddresses";
  static String addNewAddress = "/AddNewAddress";
  static String locateMap = "/LocateMap";
  static String offerzone = "/Offerzone";
  static String itemsOfferzone = "/ItemsOfferzone";



  // Paragraph Strings

  static String welcome1Title = "Fresh, Organic & Handpicked";
  static String welcome1Desc = "We prefer local and organically grown fruits and vegetables, assuring that all of them are fresh and healthy enough for your family.";

  static String welcome2_title = "Most Affordable Price";
  static String welcome2Desc = "Redefine 'pocket-friendly' and get your daily/weekly/monthly groceries at the lowest price only on 'Vegetos'.";

  static String welcome3Title = "Scheduled Delivery";
  static String welcome3Desc = "Get your orders delivered at your doorstep at your time of convenience by simply booking the preferred timeslot with 'Vegetos' app.";

  static String categoryTitle = "Fruits & Vegetables";
  static String categoryDesc = "Pick what you need from a variety of fresh and hand-picked fruits and vegetables.";

  static String productDetailDesc = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  static String demoAddress = "Shayona Tilak 3, New SG road, Gota\nAhmedabad Gujarat 380248";

  static String disclaimer = "Disclaimer: Please check the product at the time of delivery.";

  static String deleteAddressConfir = 'Are you sure you want to delete\nthis saved address?';

  static String localitydialog1 = 'Locality can\'t be changed';
  static String localitydialog2 = 'Your delivery address has to be inside\nPaldi,Ahmedabad as you have shopped\nfrom the same locality';

  static String offerzone1 = 'June Sale | Get 50% off';
  static String offerzone2 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';


  //static const primaryColor = Color(0xFF009a00);
  static const gray10 = Color(0xFFe6e6e6);
  static const dashboardGray = Color(0xFF464646);
  static const locationGrey = Color(0xFF393939);
  static const grey800 = Color(0xFF808080);
  static const navMenuDevider = Color(0xFFDAF1F7);
  static const orange = Color(0xffE36130);
  static const appBar = Color(0xff47870d);
  static const greyLight = Color(0xffCED1D8);

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