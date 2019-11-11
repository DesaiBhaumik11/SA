import 'package:flutter/material.dart';
import 'package:vegetos_flutter/UI/CategoriesScreen.dart';
import 'package:vegetos_flutter/UI/DashboardScreen.dart';
import 'package:vegetos_flutter/UI/MyCartScreen.dart';
import 'package:vegetos_flutter/UI/PaymentOptionScreen.dart';
import 'package:vegetos_flutter/UI/ProductDetailScreen.dart';
import 'package:vegetos_flutter/UI/SplashScreeen.dart';
import 'package:vegetos_flutter/UI/WelcomeScreen.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vegetos',
        theme: ThemeData(
          primarySwatch: Const.primaryColor
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Const.initialRoute,
        routes: <String, WidgetBuilder> {
        Const.welcome: (BuildContext context) => WelcomeScreenState(),
        Const.dashboard: (BuildContext context) => DashboardScreen(),
        Const.categories: (BuildContext context) => CategoriesScreen(),
        Const.productDetail: (BuildContext context) => ProductDetailScreen(),
        Const.myCart: (BuildContext context) => MyCartScreen(),
        Const.paymentOption: (BuildContext context) => PaymentOptionScreen(),
      },
      home: SplashScreen()
    );
  }
}
