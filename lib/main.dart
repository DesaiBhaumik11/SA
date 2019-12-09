import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetos_flutter/UI/my_cart_screen.dart';
import 'package:vegetos_flutter/UI/payment_option_screen.dart';
import 'package:vegetos_flutter/UI/product_detail_screen.dart';
import 'package:vegetos_flutter/UI/splash_screeen.dart';
import 'package:vegetos_flutter/UI/welcome_screen.dart';
import 'package:vegetos_flutter/UI/customer_support_2.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/profile.dart';
import 'package:vegetos_flutter/UI/set_delivery_location.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/address_modal.dart';
import 'package:vegetos_flutter/models/best_selling_product.dart';
import 'package:vegetos_flutter/models/categories_model.dart';
import 'package:vegetos_flutter/models/my_cart.dart';
import 'package:vegetos_flutter/models/product_detail.dart';
import 'package:vegetos_flutter/models/recommended_products.dart';
import 'package:vegetos_flutter/models/search_products.dart';
import 'package:vegetos_flutter/models/vegetos_exclusive.dart';

import 'UI/order_placed_screen.dart';
import 'UI/about_app_release.dart';
import 'UI/about_vegetos.dart';
import 'UI/add_balance.dart';
import 'UI/add_new_address.dart';
import 'UI/cart_view.dart';
import 'UI/categories_screen.dart';
import 'UI/choose_address.dart';
import 'UI/customer_support_1.dart';
import 'UI/expired_items.dart';
import 'UI/item_subscribed.dart';
import 'UI/items_offerzone.dart';
import 'UI/locate_on_map.dart';
import 'UI/location_service_unavailable.dart';
import 'UI/login.dart';
import 'UI/my_addresses.dart';
import 'UI/my_orders.dart';
import 'UI/my_subscriptions.dart';
import 'UI/offerzone.dart';
import 'UI/promo_screen.dart';
import 'UI/search_screen.dart';
import 'UI/select_contact.dart';
import 'UI/set_delivery_details.dart';
import 'UI/set_location_manually.dart';
import 'UI/shared_cart.dart';
import 'UI/tell_us_about.dart';
import 'UI/update_profile.dart';
import 'UI/verify_otp.dart';
import 'UI/wallet.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final categories=CategoriesModel();

  final productModal=ProductDetailModal();
  final addressModal=AddressModal();

  final bestSellingProducts=BestSellingProductModel();

  final vegetosExclusive=VegetosExclusiveModel();

  final recommendedProducts=RecommendedProductsModel();

  final searchModel=SearchModel();

  final mycartModal=MyCartModal();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [

      ChangeNotifierProvider<MyCartModal>.value(value: mycartModal),
      ChangeNotifierProvider<AddressModal>.value(value: addressModal),
      ChangeNotifierProvider<ProductDetailModal>.value(value: productModal),
      ChangeNotifierProvider<CategoriesModel>.value(value: categories),
      ChangeNotifierProvider<BestSellingProductModel>.value(value: bestSellingProducts),
      ChangeNotifierProvider<VegetosExclusiveModel>.value(value: vegetosExclusive),
      ChangeNotifierProvider<RecommendedProductsModel>.value(value: recommendedProducts),
      ChangeNotifierProvider<SearchModel>.value(value: searchModel)

    ],child: MaterialApp(
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
          Const.paymentOption: (BuildContext context) => PaymentOptionScreen(),Const.setDeliveryLocation: (BuildContext context) =>
              SetDeliveryLocation(),
          Const.setLocationManually: (BuildContext context) =>SetLocationManually(),
          Const.locationServiceUnavailable: (BuildContext context) =>
              LocationServiceUnavailable(() {}),
          Const.searchScreen: (BuildContext context) => SearchScreen(),
          Const.setDeliveryDetails: (BuildContext context) =>
              SetDeliveryDetails(),
          Const.orderPlacedScreen: (BuildContext context) =>
              OrderPlacedScreen(),
          Const.chooseAddress: (BuildContext context) => ChooseAddress(),
          Const.promoCode: (BuildContext context) => PromoCode(),
          Const.customerSupport1: (BuildContext context) => CustomerSupport1(),
          Const.customerSupport2: (BuildContext context) => CustomerSupport2(),
          Const.expiredItems: (BuildContext context) => ExpiredItems(),
          Const.tellUsAbout: (BuildContext context) => TellUsAbout(),
          Const.loginScreen: (BuildContext context) => LoginScreen(),
          Const.verifyOTP: (BuildContext context) => VerifyOTP(),
          Const.updateProfile: (BuildContext context) => UpdateProfile(),
          Const.myOrders: (BuildContext context) => MyOrders(),
          Const.myAddresses: (BuildContext context) => MyAddresses(),
          Const.addNewAddress: (BuildContext context) => AddNewAddress(),
          Const.locateMap: (BuildContext context) => LocateMap(),
          Const.offerzone: (BuildContext context) => Offerzone(),
          Const.itemsOfferzone: (BuildContext context) => ItemsOfferzone(),
          Const.wallet: (BuildContext context) => Wallet(),
          Const.addBalance: (BuildContext context) => AddBalance(),
          Const.aboutVegetos: (BuildContext context) => AboutVegetos(),
          Const.aboutAppRelease: (BuildContext context) => AboutAppRelease(),
          Const.profile: (BuildContext context) => Profile(),
          Const.mySubscriptions: (BuildContext context) => MySubscriptions(),
          Const.itemsSubscribed: (BuildContext context) => ItemsSubscribed(),
          Const.selectContact: (BuildContext context) => SelectContact(),
          Const.sharedCart: (BuildContext context) => SharedCart(),
          Const.cartView: (BuildContext context) => CartView(),
        },
        home: DashboardScreen()));
  }
}
