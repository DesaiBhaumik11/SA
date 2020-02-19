
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/product_detail_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/MyCartUtils.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/CartCountModel.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';
import 'package:vegetos_flutter/models/ProductDetailsModel.dart';
import 'package:vegetos_flutter/models/ProductPriceModel.dart';
import 'package:vegetos_flutter/models/ProductVariantMedia.dart';
import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';
import 'package:vegetos_flutter/models/UnitsModel.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';
import 'package:vegetos_flutter/models/my_cart.dart';
import 'package:vegetos_flutter/models/product_detail.dart';
import 'package:vegetos_flutter/models/search_products.dart';
import 'package:vegetos_flutter/models/product_common.dart' as bst;

import 'my_cart_screen.dart';

class CategoryWiseProductListScreen extends StatefulWidget
{
  String categoryId;
  String categoryName;

  CategoryWiseProductListScreen(this.categoryId, this.categoryName);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryWiseProductListScreenState(categoryId, categoryName);
  }

}

class CategoryWiseProductListScreenState extends State<CategoryWiseProductListScreen>
{
  AppFirstModal appFirstModal;
  String categoryId;
  String categoryName;

  MyCartModal myCartModal ;
  String ImageURL = '';
  CategoryWiseProductListScreenState(this.categoryId, this.categoryName);

  String cartTotal = '0';
  Future getProductWithDefaultVarient;
  ProgressDialog progressDialog ;

  @override
  void setState(fn) {
    // TODO: implement setState
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getProductWithDefaultVarient = ApiCall().GetProductWithDefaultVarientAPI(categoryId);
    count();
    SharedPreferences.getInstance().then((prefs) {
      ImageURL = prefs.getString("ImageURL");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //myCartModal=Provider.of<MyCartModal>(context);
    appFirstModal = Provider.of<AppFirstModal>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Const.appBar,
        title: Text(categoryName != null ? categoryName : ''),
        actions: <Widget>[
          InkWell(
            child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
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
                            style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'GoogleSans',
                                color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context, EnterExitRoute(enterPage: MyCartScreen())).then((returnn){
                count();
              });
            },
          )
        ],
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset('back.png', height: 25,),
          ),
        ),
      ),
      body: Container(
        child: callGetProductWithDefaultVarientAPI(categoryId),
      ),
    );
  }

  Widget callGetProductWithDefaultVarientAPI(String categoryId) {
    return FutureBuilder(
      future: getProductWithDefaultVarient,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if(apiResponseModel.statusCode == 200) {
            List<ProductWithDefaultVarientModel> modelList = ProductWithDefaultVarientModel.parseList(apiResponseModel.Result);
            return horizontalList(modelList);
          } else if(apiResponseModel.statusCode == 401) {
            return noItemFound();
          } else {
            return noItemFound();
          }
        } else if(snapshot.connectionState == ConnectionState.waiting) {
          return Container(child: Center(child: CircularProgressIndicator(),),);
        } else {
          return noItemFound();
        }
      },
    );
  }

  Widget horizontalList(List<ProductWithDefaultVarientModel> products) {

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
      cardHeight = cardHeight - 95;
      aspectRatio = cardWidth / cardHeight;
    } else if(cardHeight > 700 && cardHeight < 740) {
      cardHeight = cardHeight - 190;
      aspectRatio = cardWidth / cardHeight;
    } else {
      cardHeight = cardHeight - 200;
      aspectRatio = cardWidth / cardHeight;
    }

    return products != null && products.isNotEmpty ? Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        shrinkWrap: true,
        padding: EdgeInsets.all(5.0),
        childAspectRatio: aspectRatio >= 0.73 ? 0.66 : 0.60 , //0.66
        physics: BouncingScrollPhysics(),
        //padding: const EdgeInsets.all(4.0),
        children: List.generate(products.length,(index){
          return childView(products[index]);
        }),
      ),
    ) : noItemFound();
  }


  Widget childView(ProductWithDefaultVarientModel productVariant) {

    String name = "";
    String unit = "";
    for(int i = 0; i < productVariant.ProductDetails.length; i++) {
      if(productVariant.ProductDetails[i].Language == "En-US") {
        name = productVariant.ProductDetails[i].Name;
        break;
      }
    }

    for(int i = 0; i < productVariant.Units.length; i++) {
      if(productVariant.Units[i].Language == "En-US") {
        unit = productVariant.Units[i].Name;
        break;
      }
    }
    ProductPriceModel ProductPrice=new ProductPriceModel();
    ProductDetailsModel ProductDetail=new ProductDetailsModel();
    UnitsModel Units=new UnitsModel();
    ProductVariantMedia productVariantMedia=new ProductVariantMedia();

    if(productVariant!=null){

      if(productVariant.ProductDetails!=null && productVariant.ProductDetails.length>0){
        ProductDetail = productVariant.ProductDetails[0];
      }
      if(productVariant.Units!=null && productVariant.Units.length>0){
        Units=productVariant.Units[0];
      }
      if(productVariant.ProductPrice!=null){
        ProductPrice = productVariant.ProductPrice;
      }
    }


    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
//            final ProductDetailModal productModal=Provider.of<ProductDetailModal>(context);
//            showDialog(context: context,builder: (c)=>Center(child: SizedBox(
//                height: 25,
//                width: 25,
//                child: CircularProgressIndicator())));
//            productModal.getProductDetail(productVariant.ProductId,(){
//              Navigator.pop(context);
//              Navigator.push(context, EnterExitRoute(enterPage: ProductDetailScreen(productVariant.ProductId)));
//            }) ;
            Navigator.push(context, EnterExitRoute(enterPage: ProductDetailScreen(productVariant.ProductId))).then((returnn){
              count();
            });
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
                            child: productVariant.PrimaryMediaId==null||productVariant.PrimaryMediaId.isEmpty?Image.asset("02-product.png",height: 100,width: 100,):
                            Image.network(ImageURL + productVariant.PrimaryMediaId + '&h=150&w=150', height: 110.0, width: 110.0,),
//                            child: Image.asset("02-product.png",height: 100,width: 100,),
                          ),
                          margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        ),
                      ),
                      ProductPrice.DiscountPercent != null && ProductPrice.DiscountPercent != 0.0 ? Container(
                        margin: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.orange
                        ),
                        child: Text(ProductPrice.DiscountPercent != null ? ProductPrice.DiscountPercent.toString() + ' %': '0 %',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
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
                      child: Text(productVariant.MinimumOrderQuantity.toString() + " " + unit,style: TextStyle(fontSize: 11.0, fontFamily: 'GoogleSans',
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
                          child: Text('₹ ${ProductPrice.OfferPrice != null ? ProductPrice.OfferPrice.toString() : 0}',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(ProductPrice.Price != null ? '₹' + ProductPrice.Price.toString() : 0,style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
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
                      //myCartModal.addTocart(productModal);
                      addToCart(productVariant.ProductId, productVariant.ProductVariantId, productVariant.IncrementalStep.toString(),
                          "", ProductPrice.OfferPrice.toString());
                    },)
                ],
              ),
            ),
          ),
        )
      ],
    );
//    return Stack(
//      children: <Widget>[
//        GestureDetector(
//          onTap: () {
//            //final ProductDetailModal productModal=Provider.of<ProductDetailModal>(context);
//            showDialog(context: context,builder: (c)=>Center(child: SizedBox(
//                height: 25,
//                width: 25,
//                child: CircularProgressIndicator())));
//
//            final ProductDetailModal productModal=Provider.of<ProductDetailModal>(context);
//            productModal.getProductDetail(model.ProductId,(){
//              Navigator.pop(context);
//              Navigator.push(context, EnterExitRoute(enterPage: ProductDetailScreen(model.ProductId)));
//            }) ;
//            //Navigator.of(context).push(EnterExitRoute(enterPage: ProductDetailScreen(), exitPage: CategoryWiseProductListScreen('', '')));
//
//          },
//          child: Container(
//            //width: 180.0,
//            height: 280.0,
//            child: Card(
//              child: Column(
//                children: <Widget>[
//                  Stack(
//                    //alignment: Alignment.center,
//                    children: <Widget>[
//                      Center(
//                        child: Container(
//                          width: 110.0,
//                          height: 110.0,
//                          //alignment: Alignment.center,
//                          child: Card(
//                            elevation: 0.0,
//                            clipBehavior: Clip.antiAliasWithSaveLayer,
//                            shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(5.0)
//                            ),
//                            child: mediaList != null && mediaList.isNotEmpty ?
//                            Image.network("${appFirstModal.ImageUrl}${mediaList[0] + '&h=150&w=150'}", height: 110.0, width: 110.0,) :
//                            Image.asset("02-product.png",height: 100,width: 100,),
//                          ),
//                          margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
//                        ),
//                      ),
//                      productPriceModel.DiscountPercent != null && productPriceModel.DiscountPercent != 0 ? Container(
//                        margin: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
//                        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(5.0),
//                            color: Colors.orange
//                        ),
//                        child: Text(productPriceModel.DiscountPercent != null ? productPriceModel.DiscountPercent.toString() + ' %': '0 %',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
//                            color: Colors.white),),
//                      ) : Container(),
//                    ],
//                  ),
//                  Container(
//                    margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
//                    child: Row(
//                      children: <Widget>[
//                        Flexible(
//                          child: Text(name ,overflow: TextOverflow.ellipsis, maxLines: 2 ,
//                              style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans',
//                                  fontWeight: FontWeight.w700,
//                                  color: Colors.black)),
//                        ),
//                      ],
//                    ),
//                  ),Expanded(child: Container(),flex: 1,),
//                  Container(
//                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
//                    child: Align(
//                      alignment: Alignment.topLeft,
//                      child: Text('1 ' + unit ,style: TextStyle(fontSize: 11.0, fontFamily: 'GoogleSans',
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
//                          child: Text(productPriceModel.OfferPrice != null ? '₹ ' + productPriceModel.OfferPrice.toString() : '₹ 0',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
//                              fontWeight: FontWeight.w700,
//                              color: Colors.black),
//                          ),
//                        ),
//                      ),
//                      Container(
//                        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
//                        child: Align(
//                          alignment: Alignment.topLeft,
//                          child: Text(productPriceModel.Price != null ? '₹' + productPriceModel.Price.toString() : '₹ 0',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
//                              fontWeight: FontWeight.w500,
//                              color: Colors.grey, decoration: TextDecoration.lineThrough),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                  InkWell(child:  Container(
//                    margin: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
//                    padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(5.0),
//                      //color: Const.gray10
//                      color: Const.primaryColor
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
//
//                      MyCartUtils().callAddToCartAPI(model.ProductId, model.ProductVariantId,
//                          model.IncrementalStep.toString(), "", productPriceModel.OfferPrice.toString());
//                    },)
//                ],
//              ),
//            ),
//          ),
//        ),
//      ],
//    );

  }

  Widget noItemFound() {
    return Container(
      color: Colors.white,
      //width: double.infinity,
      //margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'no-result.png',
            height: 200,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Whoops!',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              'Sorry!We could not find the product you were looking for. could not find the product you were looking for.',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2d2d2d)
              ),
              textAlign: TextAlign.center,
            ),
          ),

          /*Text(
            'looking for. Please check out our \'categories\'',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xff2d2d2d)),
          ),
          Text(
            'for more options.',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xff2d2d2d)),
          ),*/
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
  void count(){
    ApiCall().setContext(context).count().then((apiResponseModel){
      String cartTotalStr="0";
      if(progressDialog!=null && progressDialog.isShowing()){
        progressDialog.dismiss();
      }
      if(apiResponseModel.statusCode == 200) {
        CartCountModel cartCountModel = CartCountModel.fromJson(apiResponseModel.Result);
        if(cartCountModel!=null && cartCountModel.count!=null) {
          cartTotalStr = cartCountModel.count.toString();
        }
      }else{
//        Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: LoginScreen()),(c)=>false);
      }
      setState(() {
        cartTotal = cartTotalStr;
      });
    });
  }
  void addToCart(productId, varientId, qty, offerId, amount){
    progressDialog  = Utility.progressDialog(context, "") ;
    progressDialog.show() ;
    ApiCall().setContext(context).addToCart(productId, varientId, qty, offerId, amount).then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      }
      count();
    });
  }

  /*void callAddToCartAPI(String productId, String varientId, String qty, String offerId, String amount) {
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
  }

  void callGetCartAPI() {
    ApiCall().getCart().then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        GetCartResponseModel getCartResponseModel = GetCartResponseModel.fromJson(apiResponseModel.Result);
        setState(() {
          cartTotal = getCartResponseModel.cartItemViewModels.length.toString();
        });
      } else if(apiResponseModel.statusCode == 401) {
          //
      } else {
          //
      }
    });
  }*/

}