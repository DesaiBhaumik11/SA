import 'package:flutter/material.dart';
import 'package:vegetos_flutter/UI/CategoriesScreen.dart';
import 'package:vegetos_flutter/UI/DashboardScreen.dart';
import 'package:vegetos_flutter/UI/MyCartScreen.dart';
import 'package:vegetos_flutter/UI/PaymentOptionScreen.dart';
import 'package:vegetos_flutter/UI/ProductDetailScreen.dart';
import 'package:vegetos_flutter/UI/SplashScreeen.dart';
import 'package:vegetos_flutter/UI/WelcomeScreen.dart';
import 'package:vegetos_flutter/UI/customer_Support2.dart';
import 'package:vegetos_flutter/UI/set_delivery_location.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

import 'UI/SplashScreeen.dart';
import 'UI/choose_address.dart';
import 'UI/customer_Support_1.dart';
import 'UI/expired_items.dart';
import 'UI/location_service_unavailable.dart';
import 'UI/login.dart';
import 'UI/promo_screen.dart';
import 'UI/search_screen.dart';
import 'UI/set_delivery_details.dart';
import 'UI/set_location_manually.dart';
import 'UI/tell_us_about.dart';
import 'UI/update_profile.dart';
import 'UI/verify_OTP.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vegetos',
        theme: ThemeData(
          primarySwatch: Const.primaryColor,
          fontFamily: 'GoogleSans',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Const.initialRoute,
        routes: <String, WidgetBuilder>{
          Const.welcome: (BuildContext context) => WelcomeScreenState(),
          Const.dashboard: (BuildContext context) => DashboardScreen(),
          Const.categories: (BuildContext context) => CategoriesScreen(),
          Const.productDetail: (BuildContext context) => ProductDetailScreen(),
          Const.myCart: (BuildContext context) => MyCartScreen(),
          Const.paymentOption: (BuildContext context) => PaymentOptionScreen(),
          Const.setDeliveryLocation: (BuildContext context) => SetDeliveryLocation(),
          Const.setLocationManually: (BuildContext context) => SetLocationManually(),
          Const.locationServiceUnavailable: (BuildContext context) => LocationServiceUnavailable((){}),
          Const.searchScreen: (BuildContext context) => SearchScreen(),
          Const.setDeliveryDetails: (BuildContext context) => SetDeliveryDetails(),
          Const.chooseAddress: (BuildContext context) => ChooseAddress(),
          Const.promoCode: (BuildContext context) => PromoCode(),
          Const.customerSupport1: (BuildContext context) => CustomerSupport1(),
          Const.customerSupport2: (BuildContext context) => CustomerSupport2(),
          Const.expiredItems: (BuildContext context) => ExpiredItems(),
          Const.tellUsAbout: (BuildContext context) => TellUsAbout(),
          Const.loginScreen: (BuildContext context) => LoginScreen(),
          Const.verifyOTP: (BuildContext context) => VerifyOTP(),
          Const.updateProfile: (BuildContext context) => UpdateProfile(),
        },
//        home: DashboardScreen());
        home: WelcomeScreenState());
  }
}
