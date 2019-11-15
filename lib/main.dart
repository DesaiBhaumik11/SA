import 'package:flutter/material.dart';
import 'package:vegetos_flutter/UI/CategoriesScreen.dart';
import 'package:vegetos_flutter/UI/DashboardScreen.dart';
import 'package:vegetos_flutter/UI/MyCartScreen.dart';
import 'package:vegetos_flutter/UI/PaymentOptionScreen.dart';
import 'package:vegetos_flutter/UI/ProductDetailScreen.dart';
import 'package:vegetos_flutter/UI/SplashScreeen.dart';
import 'package:vegetos_flutter/UI/WelcomeScreen.dart';
import 'package:vegetos_flutter/UI/set_delivery_location.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

import 'UI/SplashScreeen.dart';
import 'UI/choose_address.dart';
import 'UI/location_service_unavailable.dart';
import 'UI/promo_screen.dart';
import 'UI/search_screen.dart';
import 'UI/set_delivery_details.dart';
import 'UI/set_location_manually.dart';

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

        },
        home: DashboardScreen());
  }
}
