
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/categories_screen.dart';
import 'package:vegetos_flutter/UI/my_cart_screen.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/models/address_modal.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';
import 'package:vegetos_flutter/models/best_selling_product.dart';
import 'package:vegetos_flutter/models/my_cart.dart';
import 'package:vegetos_flutter/models/product_common.dart' as bst;
import 'package:vegetos_flutter/models/categories_model.dart';
import 'package:vegetos_flutter/models/product_detail.dart';
import 'package:vegetos_flutter/models/recommended_products.dart';
import 'package:vegetos_flutter/models/shipping_slot_modal.dart';
import 'package:vegetos_flutter/models/vegetos_exclusive.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class DashboardScreen extends StatelessWidget
{
  MyCartModal myCartModal ;
  static int cartSize=0;
   static AppFirstModal appFirstModal ;
  ShippingSlotModal shippingSlotModal ;
  bool allCals = true ;
  String phoneNumber ;


  @override
  Widget build(BuildContext context) {

    SharedPreferences.getInstance().then((prefs){
      phoneNumber = prefs.getString("phone");
    }) ;

    appFirstModal = Provider.of<AppFirstModal>(context);
    final cat=Provider.of<CategoriesModel>(context);


    final bestSelling=Provider.of<BestSellingProductModel>(context);
    final vegitosExclusive=Provider.of<VegetosExclusiveModel>(context);
    final recommendedProducts=Provider.of<RecommendedProductsModel>(context);

    final addressModal=Provider.of<AddressModal>(context);
     myCartModal=Provider.of<MyCartModal>(context);
    shippingSlotModal=Provider.of<ShippingSlotModal>(context);


    if(!shippingSlotModal.loaded){
      shippingSlotModal.getShippingSlot() ;
    }


    if(!myCartModal.loaded){
      myCartModal.getMyCart() ;
    }else{

      if(allCals){
        allCals = false ;
        myCartModal.getMyCart() ;
      }else{
        cartSize=myCartModal.result.cartItemViewModels.length ;
      }


    }

//    if(!addressModal.loaded){
//      addressModal.getMyAddresses() ;
//    }
    if(!cat.isLoaded){
      cat.loadCategories();
    }
    if(!bestSelling.loaded){
      bestSelling.loadProducts();
    }
    if(!vegitosExclusive.loaded){
      vegitosExclusive.loadProducts();
    }
    if(!recommendedProducts.loaded){
      recommendedProducts.loadProducts();
    }
    return Scaffold(
      drawer: Drawer(
        child: drawer(context),
      ),
      body: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget> [
            appBar(context),
          ];
        },
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            color: Const.gray10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                searchBar(context),
                adViewWidget(),
                bestSelling.loaded?horizontalList("Best Selling Items",bestSelling.result):Center(child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CircularProgressIndicator(),
                ),),
                vegitosExclusive.loaded?horizontalList("Vegeto's Exclusive",vegitosExclusive.result):Container(),
                recommendedProducts.loaded?horizontalList("Recommended for you",recommendedProducts.result):Container(),


              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget appBar(BuildContext context)
  {
    return SliverAppBar(
      automaticallyImplyLeading: true,
      floating: true,
      pinned: false,
      backgroundColor: Const.appBar,
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            myCartModal.loaded =false ;
            Navigator.push(context, SlideRightRoute(page: MyCartScreen()));
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: Stack(
              children: <Widget>[
                Align(
                  child: Icon(Icons.shopping_cart),
                  alignment: Alignment.center,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 0.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 8.0,
                      child: Text("${myCartModal.cartItemSize}" ,style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans', color: Colors.white)),
                      //child: Text("${cartSize}" ,style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans', color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
      title: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Set Delivery Location',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans'),textAlign: TextAlign.left,)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('No Location Found',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans'),),
                    Icon(Icons.error, color: Colors.red, size: 20.0,)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget searchBar(BuildContext context)
  {
    return Container(
      height: 50.0,
      color: Const.appBar,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.pushNamed(context, Const.categories);
                    Navigator.push(context, SlideRightRoute(page: CategoriesScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Text('Categories',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          color: Const.dashboardGray, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Const.searchScreen);
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            child: Icon(Icons.search, color: Const.dashboardGray,),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            child: Text('Search Product',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500, color: Const.dashboardGray)),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget adViewWidget()
  {
    List<Image> imageList = <Image> [
      Image.asset('assets/ad01.png', fit: BoxFit.fill,),
      Image.asset('assets/ad02.png', fit: BoxFit.fill,)
    ];


    return Container(
      height: 180.0,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 2,
        controller: null,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: imageList[index],
          );
        },
      ),
    );
  }

  Widget childView(BuildContext context, bst.Result result)
  {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            final ProductDetailModal productModal=Provider.of<ProductDetailModal>(context);
            showDialog(context: context,builder: (c)=>Center(child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator())));
              productModal.getProductDetail(result.id,(){
              Navigator.pop(context);
              Navigator.pushNamed(context, Const.productDetail);
            }) ;

          },
          child: Container(
            width: 180.0,
            height: 270.0,
            child: Card(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: result.productMediaId==null||result.productMediaId.isEmpty?Image.asset("02-product.png",height: 100,width: 100,):Image.network("${appFirstModal
                          .ImageUrl}${result.productMediaId}", height: 100.0, width: 100.0,),
                        ),
                        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.orange
                        ),
                        child: Text('12% OFF',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
                            color: Colors.white),),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(result.seoTag,overflow: TextOverflow.ellipsis, maxLines: 2 ,style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                        ),
                      ],
                    ),
                  ),Expanded(child: Container(),flex: 1,),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('${result.quantity} ${result.unit} ',style: TextStyle(fontSize: 11.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('₹ ${result.price}',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('₹120 ',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey, decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ),
                    ],
                  ),
                 InkWell(child:  Container(
                   margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                   padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5.0),
                       color: Const.primaryColor
                   ),
                   child: Align(
                     alignment: Alignment.center,
                     child: Text('+ ADD',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                       color: Colors.white, fontWeight: FontWeight.w500,)),
                   ),

                 ),
                 onTap: (){
                   myCartModal.addTocart(result);
                 },)
                ],
              ),
            ),
          ),
        )
      ],
    );

  }

  Widget horizontalList(String s, List<bst.Result> products)
  {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
          child: Card(
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                      child: Text(s,style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('view all',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w500,
                              color: Colors.green)),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 275.0,
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: products.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return childView(context,products[index]);
                      }
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget drawer(BuildContext context)
  {

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child:
        SafeArea(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.profile);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/mobile.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('$phoneNumber' ,style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.0,
                color: Const.navMenuDevider,
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/address.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Location ',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black), overflow: TextOverflow.ellipsis,  maxLines: 1,),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                            child: Image.asset('assets/edit-pencil.png', height: 20.0, width: 20.0,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 5.0,
                color: Const.navMenuDevider,
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/home.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Home',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.myOrders);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/myorders.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('My Orders',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.mySubscriptions);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/my_subscription.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('My Subscriptions',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.myCart);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/mycart.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('My Cart',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.myAddresses,);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/my_addressess.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('My Addresses',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.sharedCart);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/shared_cart.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('Shared Cart',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.orange,
                                radius: 10.0,
                                child: Text('88',style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans', color: Colors.white)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.wallet);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/wallet_menu.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('Wallet',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.offerzone);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/offerzone.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('Offerzone',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.0,
                color: Const.navMenuDevider,
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/customer_support_menu.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Customer Support',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/rate-us.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Rate Us',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(child: Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/share.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Share',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),onTap: (){
                //Navigator.pop(context) ;

                WcFlutterShare.share(
                    sharePopupTitle: 'Share',
                    subject: 'This is subject',
                    text: 'This is text',
                    mimeType: 'text/plain');
                //Share.share('check out my website https://example.com', subject: 'Look what I made!');
              },),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.aboutVegetos);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/about-vegetos.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('About Vegetos',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.aboutAppRelease);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/about-app.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('About App Release',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (s) {
                        return FunkyOverlay();
                      });
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/logout.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('Logout',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ,
    );
  }



}


class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();







  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Material(
          color: Colors.white,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Padding(
                padding: EdgeInsets.symmetric( vertical: 35),
                child:  Wrap(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Image.asset('cancel-subscription.png', height: 150,),

                        SizedBox(
                          height: 10,
                        ),

                        Text(Const.logout1,textAlign: TextAlign.center, style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),),


                        SizedBox(
                          height: 10,
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: (){
                                   logoutApi() ;
                                 // Navigator.pushNamed(context, Const.loginScreen);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50))
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  child: Text('Logout', style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),),
                                )
                            ),

                            SizedBox(width: 10,),
                            RaisedButton(
                                color: Const.greyLight,
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50))
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                  child: Text('Cancel', style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),),
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }

  void logoutApi() {
    //Navigator.pushNamed(context, Const.loginScreen);

    NetworkUtils.getRequest(endPoint: Constant.Logout).then((res){
      print("logoutApi " +res) ;

      String uuid =  Uuid().v4();
      getJwtToken(uuid).then((token){

        SharedPreferences.getInstance().then((prefs){

          prefs.setBool("login", false) ;

        }) ;

        DashboardScreen.appFirstModal.appFirstRun(token , [Navigator.pushReplacementNamed(context, Const.loginScreen)]) ;

      }) ;

    }) ;

  }
  Future<String> getJwtToken( [uuid]) async {

    // uuid = uuid + randomAlphaNumeric(10) ;


    String manufacturer,model,osVersion;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      manufacturer=androidInfo.manufacturer;
      model=androidInfo.model;
      osVersion=androidInfo.version.release;
    }else{
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      model=iosInfo.model;
      osVersion=iosInfo.utsname.version;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map<String,dynamic> map=Map();
    map["id"]=              uuid;
    map["appversion"]=      packageInfo.version;

    map["appversioncode"]=  packageInfo.buildNumber;
    map["manufacturer"]=    Platform.isIOS?"Apple":manufacturer;
    map["model"]=           model;
    map["os"]=              Platform.isAndroid?"Android":"Ios";
    map["osversion"]=       osVersion;
//    map["platform"]=        Platform.isAndroid?"Android":"Ios";
    //   map["nbf"]=        "1577355877";
    map["platform"]=        "Mobile";
    map["notificationid"]=  "";
    print("Map = $map") ;

    final key = '2C39927D43F04E1CBAB1615841D94000';
    final claimSet = new JwtClaim(
      issuer: 'com.archisys.vegetos',
      audience: <String>['com.archisys.artis'],

      otherClaims: map,
    );
    String token = issueJwtHS256(claimSet, key);

    SharedPreferences.getInstance().then((prefs){
      prefs.setString("JWT_TOKEN",token) ;
    });
    print("JWT token DASHBOARD  =  $token");

    return token;

  }
}



/*
class _sliverAppbarDelegate extends SliverPersistentHeaderDelegate
{
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _sliverAppbarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return SizedBox.expand(child: child,);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_sliverAppbarDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return maxHeight != oldDelegate.maxExtent || minHeight != oldDelegate.minExtent || child != oldDelegate.child;
  }

}*/
