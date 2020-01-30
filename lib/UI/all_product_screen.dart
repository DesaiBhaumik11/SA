import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/Utils/MyCartUtils.dart';
import 'package:vegetos_flutter/models/DashboardProductResponseModel.dart';
import 'package:vegetos_flutter/UI/product_detail_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';
import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';
import 'package:vegetos_flutter/models/best_selling_product.dart';
import 'package:vegetos_flutter/models/my_cart.dart';
import 'package:vegetos_flutter/models/product_common.dart' as bst;
import 'package:vegetos_flutter/models/product_detail.dart';
import 'package:vegetos_flutter/models/recommended_products.dart';
import 'package:vegetos_flutter/models/vegetos_exclusive.dart';

import 'my_cart_screen.dart';


class AllProductScreen extends StatefulWidget {
  String name = "" ;

  AllProductScreen(String name){
    this.name = name ;
  }

  @override
  _AllProductScreenState createState() => _AllProductScreenState(name);
}

class _AllProductScreenState extends State<AllProductScreen> {
  MyCartModal myCartModal ;
  static AppFirstModal appFirstModal ;

  String name ;

  Future getProduct;
  String cartTotal = '0';
  String ImageURL = '';

  int pageNUmber = 1;
  int pageSize = 10;

  _AllProductScreenState(String name){
    this.name = name ;
  }

  @override
  void initState() {
    // TODO: implement initState
    if(name == 'Best Selling Items') {
      getProduct = ApiCall().bestSellingItems(pageNUmber.toString(), pageSize.toString());
    } else if(name == "Vegeto's Exclusive") {
      getProduct = ApiCall().vegetosExclusive(pageNUmber.toString(), pageSize.toString());
    } else {
      getProduct = ApiCall().recommendedForYou(pageNUmber.toString(), pageSize.toString());
    }

    SharedPreferences.getInstance().then((prefs) {
      ImageURL = prefs.getString("ImageURL");
    });
    MyCartUtils().callCartCountAPI();

    MyCartUtils.streamController.stream.listen((cartCount) {
      setState(() {
        cartTotal = cartCount;
      });
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    //appFirstModal=Provider.of<AppFirstModal>(context);
     //myCartModal=Provider.of<MyCartModal>(context);
    //final bestSelling=Provider.of<BestSellingProductModel>(context);
    //final vegitosExclusive=Provider.of<VegetosExclusiveModel>(context);
    //final recommendedProducts=Provider.of<RecommendedProductsModel>(context);

    return Scaffold(
      backgroundColor: Const.gray10,
      appBar: AppBar(
        title: Text('${name}'),
        actions: <Widget>[
          InkWell(
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
                        child: Text(MyCartUtils.cartCount,
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
    )
      ,body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            productList(),

          ],
        ),
      ),);
  }

  @override
  void dispose() {
    super.dispose();
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

//    return Column(
//      children: <Widget>[
//        InkWell(
//          onTap: () {
//            final ProductDetailModal productModal=Provider.of<ProductDetailModal>(context);
//            showDialog(context: context,builder: (c)=>Center(child: SizedBox(
//                height: 25,
//                width: 25,
//                child: CircularProgressIndicator())));
//            productModal.getProductDetail(result.ProductId,(){
//              Navigator.pop(context);
//              Navigator.push(context, EnterExitRoute(enterPage: ProductDetailScreen(result.ProductId)));
//            }) ;
//
//          },
//          child: Container(
//            //width: 180.0,
//            //height: 300.0,
//            child: Card(
//              child: Column(
//                children: <Widget>[
//                  Stack(
//                    alignment: Alignment.center,
//                    children: <Widget>[
//                      Container(
//                        width: 100.0,
//                        height: 100.0,
//                        alignment: Alignment.center,
//                        child: Card(
//                          elevation: 0.0,
//                          clipBehavior: Clip.antiAliasWithSaveLayer,
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(5.0)
//                          ),
//                          child: result.PrimaryMediaId==null||result.PrimaryMediaId.isEmpty?Image.asset("02-product.png",height: 100,width: 100,)
//                              :Image.network(ImageURL + result.PrimaryMediaId + '&h=150&w=150' , height: 110.0, width: 110.0,),
////                          child: Image.asset("02-product.png",height: 100,width: 100,),
//                        ),
//                        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
//                      ),
//                      result.ProductPrice.DiscountPercent != null && result.ProductPrice.DiscountPercent != 0 ? Container(
//                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
//                        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(5.0),
//                            color: Colors.orange
//                        ),
//                        child: Text(result.ProductPrice.DiscountPercent != null ? result.ProductPrice.DiscountPercent.toString() + ' %': '0 %',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
//                            color: Colors.white),),
//                      ) : Container(),
//                    ],
//                  ),
//                  Container(
////                    height: 35,
//                    margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Flexible(
//                          child: Text(name,
//                              overflow: TextOverflow.ellipsis, maxLines: 2 ,
//                              style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans',
//                              fontWeight: FontWeight.w700,
//                              color: Colors.black)),
//                        ),
//                      ],
//                    ),
//                  ),//Expanded(child: Container(),flex: 1,),
//                  Container(
//                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
//                    child: Align(
//                      alignment: Alignment.topLeft,
//                      child: Text(result.MinimumOrderQuantity.toString() + " " + unit,
//                        style: TextStyle(fontSize: 11.0, fontFamily: 'GoogleSans',
//                          fontWeight: FontWeight.w500,
//                          color: Colors.grey),
//                      ),
//                    ),
//                  ),
//                  Row(
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
//                        child: Align(
//                          alignment: Alignment.topLeft,
//                          child: Text('₹ ${result.ProductPrice.OfferPrice != null ? result.ProductPrice.OfferPrice.toString() : 0}',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
//                              fontWeight: FontWeight.w700,
//                              color: Colors.black),
//                          ),
//                        ),
//                      ),
//                      Container(
//                        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
//                        child: Align(
//                          alignment: Alignment.topLeft,
//                          child: Text(result.ProductPrice.Price != null ? '₹' + result.ProductPrice.Price.toString() : 0,style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
//                              fontWeight: FontWeight.w500,
//                              color: Colors.grey, decoration: TextDecoration.lineThrough),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                  InkWell(child:  Container(
//                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 7.0),
//                    padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(5.0),
//                        color: Const.primaryColor
//                        //color: Const.gray10
//                    ),
//                    child: Align(
//                      alignment: Alignment.center,
//                      child: Text('+ ADD',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
//                        color: Colors.white, fontWeight: FontWeight.w500,)),
//                    ),
//
//                  ),
//                    onTap: (){
//                      //Fluttertoast.showToast(msg: 'Delivery location not found, coming soon.');
//                      //myCartModal.addTocart(result);
//                      MyCartUtils().callAddToCartAPI(result.ProductId, result.ProductVariantId, result.IncrementalStep.toString(),
//                          "", result.ProductPrice.OfferPrice.toString());
//                    },)
//                ],
//              ),
//            ),
//          ),
//        )
//      ],
//    );
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
//            height: 280.0,
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
                            child: result.PrimaryMediaId==null||result.PrimaryMediaId.isEmpty?Image.asset("02-product.png",height: 100,width: 100,):
                            Image.network(ImageURL + result.PrimaryMediaId + '&h=150&w=150', height: 110.0, width: 110.0,),
//                            child: Image.asset("02-product.png",height: 100,width: 100,),
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
                      MyCartUtils().callAddToCartAPI(result.ProductId, result.ProductVariantId, result.IncrementalStep.toString(),
                          "", result.ProductPrice.OfferPrice.toString());
                    },)
                ],
              ),
            ),
          ),
        )
      ],
    );


  }

  Widget somethingWentWrong() {
    return Container(
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
  }

  void callAddToCartAPI(String productId, String varientId, String qty, String offerId, String amount) {
    ApiCall().addToCart(productId, varientId, qty, offerId, amount).then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
        callGetCartAPI();
      } else if (apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      }
    });
  }*/

  Widget productList() {

    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = MediaQuery.of(context).size.height - 76;
    double aspectRatio = 0.01;

    if(cardHeight < 550) {
      cardHeight = cardHeight + 20;
      aspectRatio = cardWidth / cardHeight;
    } else if(cardHeight > 550 && cardHeight < 600){
      cardHeight = cardHeight - 20;
      aspectRatio = cardWidth / cardHeight;
    } else if(cardHeight > 600 && cardHeight < 650) {
      cardHeight = cardHeight - 120;
      aspectRatio = cardWidth / cardHeight;
    } else if(cardHeight > 650 && cardHeight < 700) {
      cardHeight = cardHeight - 120;
      aspectRatio = cardWidth / cardHeight;
    } else if(cardHeight > 700 && cardHeight < 740) {
      cardHeight = cardHeight - 190;
      aspectRatio = cardWidth / cardHeight;
    } else {
      cardHeight = cardHeight - 200;
      aspectRatio = cardWidth / cardHeight;
    }

    return Container(
      height: MediaQuery.of(context).size.height - 76,
//      height: 275.0,

      child: PagewiseGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: aspectRatio >= 0.73 ? 0.66 : 0.60 , //0.66
        padding: EdgeInsets.all(5.0),
        itemBuilder: (context, entry, index) {
          return childView(context, entry);
        },
        noItemsFoundBuilder: (context) {
          return Container(child: Center(child: Text('Data Not Found'),),);
        },
        pageLoadController: PagewiseLoadController(
            pageSize: 10,
            pageFuture: (int pageIndex) {
              return getFutureList();
            }),
        loadingBuilder: (context) {
          return Container(child: Center(child: CircularProgressIndicator(),), height: MediaQuery.of(context).size.height,);
        },
      ),
    );
  }

  Widget getList() {
    /*FutureBuilder(
      future: ApiCall().recommendedForYou(pageNUmber.toString(), pageSize.toString()),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if(apiResponseModel.statusCode == 200) {
            DashboardProductResponseModel responseModel = DashboardProductResponseModel.fromJson(apiResponseModel.Result);
            return responseModel.Results;
          } else if(apiResponseModel.statusCode == 401) {
            Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
          } else {
            Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
          }
        } else if(snapshot.connectionState == ConnectionState.waiting) {
          return ListView();
        } else {
          return ListView();
        }
      },
    );*/
  }

  Future<List> getFutureList() async {

if(pageNUmber>1) {
  if (name == 'Best Selling Items') {
    getProduct =
        ApiCall().bestSellingItems(pageNUmber.toString(), pageSize.toString());
  } else if (name == "Vegeto's Exclusive") {
    getProduct =
        ApiCall().vegetosExclusive(pageNUmber.toString(), pageSize.toString());
  } else {
    getProduct =
        ApiCall().recommendedForYou(pageNUmber.toString(), pageSize.toString());
  }
}
    ApiResponseModel apiResponseModel = await getProduct;
    if(apiResponseModel.statusCode == 200) {
      DashboardProductResponseModel responseModel = DashboardProductResponseModel.fromJson(apiResponseModel.Result);
      pageNUmber++;
      return responseModel.Results;
    } else if(apiResponseModel.statusCode == 401) {
      Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
    } else {
      Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
    }
  }
}
