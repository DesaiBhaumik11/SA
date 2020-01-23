import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/models/CartCountModel.dart';
import 'package:vegetos_flutter/models/DashboardProductResponseModel.dart';
import 'package:vegetos_flutter/UI/all_product_screen.dart';
import 'package:vegetos_flutter/UI/categories_screen.dart';
import 'package:vegetos_flutter/UI/login.dart';
import 'package:vegetos_flutter/UI/my_addresses.dart';
import 'package:vegetos_flutter/UI/my_cart_screen.dart';
import 'package:vegetos_flutter/UI/my_orders.dart';
import 'package:vegetos_flutter/UI/product_detail_screen.dart';
import 'package:vegetos_flutter/UI/search_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/AutoSizeText.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';
import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';
import 'package:vegetos_flutter/models/address_modal.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';
import 'package:vegetos_flutter/models/best_selling_product.dart';
import 'package:vegetos_flutter/models/default_address.dart';
import 'package:vegetos_flutter/models/default_address.dart';
import 'package:vegetos_flutter/models/default_address.dart';
import 'package:vegetos_flutter/models/my_cart.dart';
import 'package:vegetos_flutter/models/product_common.dart' as bst;
import 'package:vegetos_flutter/models/categories_model.dart';
import 'package:vegetos_flutter/models/product_detail.dart';
import 'package:vegetos_flutter/models/recommended_products.dart';
import 'package:vegetos_flutter/models/shipping_slot_modal.dart';
import 'package:vegetos_flutter/models/vegetos_exclusive.dart';
//import 'package:wc_flutter_share/wc_flutter_share.dart';

class DashboardScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardScreenState();
  }

}

class DashboardScreenState extends State<DashboardScreen>
{
  //MyCartModal myCartModal ;
  static int cartSize=0;
   static AppFirstModal appFirstModal ;
  static AddressModal addressModal ;
  //static DefaultAddressModel defaultAddressModal ;

  //BestSellingProductModel bestSelling ;
  //VegetosExclusiveModel vegitosExclusive ;
  //RecommendedProductsModel recommendedProducts ;
  bool allCals = true ;
  String phoneNumber ;

  bool isAnnonymous = true;

  String deliveryAddress = '';
  String cartTotal = '0';
  String ImageURL = '';

  Future bestSellingFuture;
  Future exclusiveFuture;
  Future recommendedFuture;

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((prefs) {
      Map<String, dynamic> tokenMap = Const.parseJwt(prefs.getString('AUTH_TOKEN'));
      if(tokenMap['anonymous'].toString().toLowerCase() == "true") {
        setState(() {
          isAnnonymous = true;
        });
      } else {
        setState(() {
          isAnnonymous = false;
        });
      }

      String businessLocationId = prefs.getString('BusinessLocationId');
      String address = prefs.getString('FullAddress');
      if(businessLocationId != null && businessLocationId.isNotEmpty) {
        deliveryAddress = address;
      }

      ImageURL = prefs.getString("ImageURL");
    });
    callCartCountAPI();
    bestSellingFuture = ApiCall().bestSellingItems("1", "10");
    exclusiveFuture = ApiCall().vegetosExclusive("1", "10");
    recommendedFuture = ApiCall().recommendedForYou("1", "10");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SharedPreferences.getInstance().then((prefs){
      phoneNumber = prefs.getString("phone");
    }) ;

    appFirstModal = Provider.of<AppFirstModal>(context);
    //defaultAddressModal = Provider.of<DefaultAddressModel>(context);
    final cat=Provider.of<CategoriesModel>(context);

    /*if(!defaultAddressModal.loaded){
      defaultAddressModal.loadAddress(context) ;
    }else{

    }*/


     //bestSelling=Provider.of<BestSellingProductModel>(context);
     //vegitosExclusive=Provider.of<VegetosExclusiveModel>(context);
     //recommendedProducts=Provider.of<RecommendedProductsModel>(context);

     addressModal=Provider.of<AddressModal>(context);
     //myCartModal=Provider.of<MyCartModal>(context);
     /*shippingSlotModal=Provider.of<ShippingSlotModal>(context);


    if(!shippingSlotModal.loaded){
      shippingSlotModal.getShippingSlot() ;
    }*/


    /*if(!myCartModal.loaded){
      myCartModal.getMyCart() ;
    }else{

      if(allCals){
        allCals = false ;
        myCartModal.getMyCart() ;
      }else{
        cartSize=myCartModal.result==null?0:myCartModal.result.cartItemViewModels.length ;
      }

    }*/

//    if(!addressModal.loaded){
//      addressModal.getMyAddresses() ;
//    }
    if(!cat.isLoaded){
      cat.loadCategories();
    }
    /*if(!bestSelling.loaded){
      bestSelling.loadProducts();
    }
    if(!vegitosExclusive.loaded){
      vegitosExclusive.loadProducts();
    }
    if(!recommendedProducts.loaded){
      recommendedProducts.loadProducts();
    }*/

    
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
          //physics: BouncingScrollPhysics(),
          child: Container(
            color: Const.gray10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                searchBar(context),
                //adViewWidget(),
                /*bestSelling.loaded?horizontalList(context , "Best Selling Items",bestSelling.result):Center(child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CircularProgressIndicator(),
                ),),*/
                bestSellingContainer(),
                //vegitosExclusive.loaded?horizontalList(context,"Vegeto's Exclusive",vegitosExclusive.result):Container(),
                //recommendedProducts.loaded?horizontalList(context,"Recommended for you",recommendedProducts.result):Container(),
                vegetosExclusiveContainer(),
                recommendedContainer(),

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
      pinned: true,
      backgroundColor: Const.appBar,
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            //myCartModal.loaded =false ;
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
                      child: Text(cartTotal,
                          style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans', color: Colors.white)),
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
          InkWell(child: Container(
            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Set Delivery Location',style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans'),textAlign: TextAlign.left,)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: AutoSizeText(
                        deliveryAddress.isNotEmpty ? deliveryAddress : 'Location not set!',
                        style: TextStyle(fontSize: 18.0, fontFamily: 'GoogleSans'),
                        minFontSize: 16.0,
                        maxFontSize: 18.0,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    deliveryAddress.isNotEmpty ? Icon(Icons.edit, color: Colors.white, size: 20.0,) : Icon(Icons.error, color: Colors.red, size: 20.0,)
                  ],
                )
              ],
            ),
          ),onTap: (){
            Navigator.push(context, EnterExitRoute(enterPage: MyAddresses()),);
          },),


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
                        Navigator.push(context, EnterExitRoute(enterPage: SearchScreen()));
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

  Widget childView(BuildContext context, ProductWithDefaultVarientModel result) {

    String name = "";
    String unit = "";
    for(int i = 0; i < result.ProductDetails.length; i++) {
      if(result.ProductDetails[i].Language == "En-US") {
        name = result.ProductDetails[i].Name;
        break;
      }
    }

    for(int i = 0; i < result.Units.length; i++) {
      if(result.Units[i].Language == "En-US") {
        unit = result.Units[i].Name;
        break;
      }
    }

    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            final ProductDetailModal productModal=Provider.of<ProductDetailModal>(context);
            showDialog(context: context,builder: (c)=>Center(child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator())));
              productModal.getProductDetail(result.ProductId,(){
              Navigator.pop(context);
              Navigator.push(context, EnterExitRoute(enterPage: ProductDetailScreen(result.ProductId)));
            }) ;

          },
          child: Container(
            width: 180.0,
            height: 280.0,
            child: Card(
              child: Column(
                children: <Widget>[
                  Stack(
                    //alignment: Alignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 110.0,
                          height: 110.0,
                          //alignment: Alignment.center,
                          child: Card(
                            elevation: 0.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            /*child: result.productMediaId==null||result.productMediaId.isEmpty?Image.asset("02-product.png",height: 100,width: 100,):
                            Image.network(ImageURL + result.productMediaId + '&h=150&w=150', height: 110.0, width: 110.0,),*/
                            child: Image.asset("02-product.png",height: 100,width: 100,),
                          ),
                          margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        ),
                      ),
                      result.ProductPrice.DiscountPercent != null && result.ProductPrice.DiscountPercent != 0 ? Container(
                        margin: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.orange
                        ),
                        child: Text(result.ProductPrice.DiscountPercent != null ? result.ProductPrice.DiscountPercent.toString() + ' %': '0 %',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
                            color: Colors.white),),
                      ) : Container(),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(name ,
                              overflow: TextOverflow.ellipsis, maxLines: 2 ,style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
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
                      child: Text(result.MinimumOrderQuantity.toString() + " " + unit,style: TextStyle(fontSize: 11.0, fontFamily: 'GoogleSans',
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
                          child: Text('₹ ${result.ProductPrice.OfferPrice != null ? result.ProductPrice.OfferPrice.toString() : 0}',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(result.ProductPrice.Price != null ? '₹' + result.ProductPrice.Price.toString() : 0,style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey, decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ),
                    ],
                  ),
                 InkWell(child:  Container(
                   margin: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                   padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5.0),
                       //color: Const.gray10
                       color: Const.primaryColor
                   ),
                   child: Align(
                     alignment: Alignment.center,
                     child: Text('+ ADD',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                       color: Colors.white, fontWeight: FontWeight.w500,)),
                   ),

                 ),
                 onTap: (){
                   //Fluttertoast.showToast(msg: 'Delivery location not found, coming soon.');
                   //myCartModal.addTocart(result);
                   callAddToCartAPI(result.ProductId, result.ProductVariantId, "1", "", result.ProductPrice.OfferPrice.toString());
                 },)
                ],
              ),
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

                  if(isAnnonymous) {
                    Navigator.push(context, EnterExitRoute(enterPage: LoginScreen()));
                  } else {
                    //Navigator.pushNamed(context, Const.profile);
                  }
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
              /*Container(
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
              ),*/
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

                      InkWell(child: Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Home',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      ),onTap: (){
                        Navigator.pop(context) ;

                        /*recommendedProducts.loadProducts() ;
                        bestSelling.loadProducts() ;
                        bestSelling.loadProducts() ;*/


                      },)


                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  //Navigator.pushNamed(context, Const.myOrders);
                  Navigator.push(context, EnterExitRoute(enterPage: MyOrders()));
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
              /*InkWell(
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
              ),*/
              InkWell(
                onTap: (){
                  Navigator.push(context, EnterExitRoute(enterPage: MyCartScreen()));
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
                  Navigator.push(context, EnterExitRoute(enterPage: MyAddresses()));
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
              /*InkWell(
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
              ),*/
              /*InkWell(
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
              ),*/
              /*InkWell(
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
              ),*/
              Container(
                height: 5.0,
                color: Const.navMenuDevider,
              ),
              /*Container(
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
              ),*/
              /*Container(
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
              ),*/
              /*InkWell(child: Container(
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

//                WcFlutterShare.share(
//                    sharePopupTitle: 'Share',
//                    subject: 'This is subject',
//                    text: 'This is text',
//                    mimeType: 'text/plain');
                //Share.share('check out my website https://example.com', subject: 'Look what I made!');
              },),*/
              InkWell(
                onTap: (){
                  //Navigator.pushNamed(context, Const.aboutVegetos);
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
                  //Navigator.pushNamed(context, Const.aboutAppRelease);
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


              !isAnnonymous ? InkWell(
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
              ) : Container()
            ],
          ),
        )
      ,
    );
  }



  Widget callBestSellingItemsAPI() {
    return FutureBuilder(
      future: bestSellingFuture,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if(apiResponseModel.statusCode == 200) {
            DashboardProductResponseModel responseModel = DashboardProductResponseModel.fromJson(apiResponseModel.Result);
            return productList(responseModel.Results);
          } else if(apiResponseModel.statusCode == 401) {
            return somethingWentWrong(1);
          } else {
            return somethingWentWrong(1);
          }
        } else if(snapshot.connectionState == ConnectionState.waiting) {
          return Container(child: Center(child: CircularProgressIndicator(),),height: 275.0,);
        } else {
          return somethingWentWrong(1);
        }
      },
    );
  }

  Widget bestSellingContainer() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Card(
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                        child: Text('Best Selling Items',
                            style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w700,
                            color: Colors.black)),
                      ),

                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(child: Text('view all',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Colors.green)),onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductScreen('Best Selling Items'))) ;

                            },),
                          ),
                        ),
                      ),


                    ],
                  ),
                  callBestSellingItemsAPI(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



  Widget productList(List<ProductWithDefaultVarientModel> products) {
    return Container(
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
    );
  }



  Widget callVegetosExclusiveProductAPI() {
    return FutureBuilder(
      future: exclusiveFuture,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if(apiResponseModel.statusCode == 200) {
            DashboardProductResponseModel responseModel = DashboardProductResponseModel.fromJson(apiResponseModel.Result);
            return productList(responseModel.Results);
          } else if(apiResponseModel.statusCode == 401) {
            return somethingWentWrong(2);
          } else {
            return somethingWentWrong(2);
          }
        } else if(snapshot.connectionState == ConnectionState.waiting) {
          return Container(child: Center(child: CircularProgressIndicator(),),height: 275.0,);
        } else {
          return somethingWentWrong(2);
        }
      },
    );
  }

  Widget vegetosExclusiveContainer() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Card(
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                        child: Text("Vegeto's Exclusive",
                            style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                      ),

                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(child: Text('view all',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Colors.green)),onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductScreen("Vegeto's Exclusive"))) ;

                            },),
                          ),
                        ),
                      ),


                    ],
                  ),
                  callVegetosExclusiveProductAPI(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



  Widget callRecommendedForYouAPI() {
    return FutureBuilder(
      future: recommendedFuture,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if(apiResponseModel.statusCode == 200) {
            DashboardProductResponseModel responseModel = DashboardProductResponseModel.fromJson(apiResponseModel.Result);
            return productList(responseModel.Results);
          } else if(apiResponseModel.statusCode == 401) {
            return somethingWentWrong(3);
          } else {
            return somethingWentWrong(3);
          }
        } else if(snapshot.connectionState == ConnectionState.waiting) {
          return Container(child: Center(child: CircularProgressIndicator(),),height: 275.0,);
        } else {
          return somethingWentWrong(3);
        }
      },
    );
  }

  Widget recommendedContainer() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Card(
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                        child: Text("Recommended for you",
                            style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                      ),

                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(child: Text('view all',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Colors.green)),onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductScreen("Recommended for you"))) ;

                            },),
                          ),
                        ),
                      ),


                    ],
                  ),
                  callRecommendedForYouAPI(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



  Widget somethingWentWrong(int index) {
    return InkWell(
      onTap: () {
        //1 == Best Selling
        //2 == Vegetos Exclusive
        //3 == Recommended
        if(index == 1) {
          callBestSellingItemsAPI();
        } else if(index == 2) {
          callVegetosExclusiveProductAPI();
        } else if(index == 3) {
          callRecommendedForYouAPI();
        } else {

        }
      },
      child: Container(
        height: 275.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error, color: Colors.red, size: 25.0,),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
              child: Text("Items not loaded",
                  style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  /*void callGetCartAPI() {
    ApiCall().getCart().then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        GetCartResponseModel getCartResponseModel = GetCartResponseModel.fromJson(apiResponseModel.Result);
        setState(() {
          if(getCartResponseModel.cartItemViewModels != null) {
            cartTotal = getCartResponseModel.cartItemViewModels.length.toString();
          }
        });
      } else if(apiResponseModel.statusCode == 401) {

      } else {

      }
    });
  }*/

  void callCartCountAPI() {
    ApiCall().getCartCount().then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        CartCountModel cartCountModel = CartCountModel.fromJson(apiResponseModel.Result);
        setState(() {
          if(cartCountModel.count != null) {
            cartTotal = cartCountModel.count.toString();
          }
        });
      } else if (apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      }
    });
  }

  void callAddToCartAPI(String productId, String varientId, String qty, String offerId, String amount) {
    ApiCall().addToCart(productId, varientId, qty, offerId, amount).then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
        callCartCountAPI();
      } else if (apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      }
    });
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
                                   logoutApi(context) ;
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

  void logoutApi([BuildContext context]) {
    //Navigator.pushNamed(context, Const.loginScreen);


    NetworkUtils.getRequest(endPoint: Constant.Logout).then((res){
      print("logoutApi " +res) ;

      String uuid =  Uuid().v4();
      getJwtToken(uuid).then((token){

        SharedPreferences.getInstance().then((prefs){
          prefs.setBool("login", false) ;
        }) ;

        DashboardScreenState.addressModal.loaded=false ;
        //DashboardScreenState.defaultAddressModal.loaded=false ;
        DashboardScreenState.appFirstModal.appFirstRun(token , [Navigator.pushReplacement(context,
            EnterExitRoute(enterPage: LoginScreen()))]) ;

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
