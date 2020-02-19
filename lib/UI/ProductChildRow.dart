
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/product_detail_screen.dart';
import 'package:vegetos_flutter/Utils/MyCartUtils.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/ProductDetailsModel.dart';
import 'package:vegetos_flutter/models/ProductPriceModel.dart';
import 'package:vegetos_flutter/models/ProductVariantMedia.dart';
import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';
import 'package:vegetos_flutter/models/UnitsModel.dart';
import 'package:vegetos_flutter/models/product_detail.dart';

class ProductChildRow{

  static String ImageURL = '';

  static Widget _ProductChildRow(BuildContext context, ProductWithDefaultVarientModel productVariant) {

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

//    return Column(
//      children: <Widget>[
//        InkWell(
//          onTap: () {
//            final ProductDetailModal productModal=Provider.of<ProductDetailModal>(context);
//            showDialog(context: context,builder: (c)=>Center(child: SizedBox(
//                height: 25,
//                width: 25,
//                child: CircularProgressIndicator())));
//            productModal.getProductDetail(productModal.ProductId,(){
//              Navigator.pop(context);
//              Navigator.push(context, EnterExitRoute(enterPage: ProductDetailScreen(productModal.ProductId)));
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
//                          child: productModal.PrimaryMediaId==null||productModal.PrimaryMediaId.isEmpty?Image.asset("02-product.png",height: 100,width: 100,)
//                              :Image.network(ImageURL + productModal.PrimaryMediaId + '&h=150&w=150' , height: 110.0, width: 110.0,),
////                          child: Image.asset("02-product.png",height: 100,width: 100,),
//                        ),
//                        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
//                      ),
//                      productModal.ProductPrice.DiscountPercent != null && productModal.ProductPrice.DiscountPercent != 0 ? Container(
//                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
//                        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(5.0),
//                            color: Colors.orange
//                        ),
//                        child: Text(productModal.ProductPrice.DiscountPercent != null ? productModal.ProductPrice.DiscountPercent.toString() + ' %': '0 %',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
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
//                      child: Text(productModal.MinimumOrderQuantity.toString() + " " + unit,
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
//                          child: Text('₹ ${productModal.ProductPrice.OfferPrice != null ? productModal.ProductPrice.OfferPrice.toString() : 0}',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
//                              fontWeight: FontWeight.w700,
//                              color: Colors.black),
//                          ),
//                        ),
//                      ),
//                      Container(
//                        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
//                        child: Align(
//                          alignment: Alignment.topLeft,
//                          child: Text(productModal.ProductPrice.Price != null ? '₹' + productModal.ProductPrice.Price.toString() : 0,style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
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
//                      //myCartModal.addTocart(productModal);
//                      MyCartUtils().callAddToCartAPI(productModal.ProductId, productModal.ProductVariantId, productModal.IncrementalStep.toString(),
//                          "", productModal.ProductPrice.OfferPrice.toString());
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
            productModal.getProductDetail(productVariant.ProductId,(){
              Navigator.pop(context);
              Navigator.push(context, EnterExitRoute(enterPage: ProductDetailScreen(productVariant.ProductId)));
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
                      MyCartUtils().callAddToCartAPI(productVariant.ProductId, productVariant.ProductVariantId, productVariant.IncrementalStep.toString(),
                          "", ProductPrice.OfferPrice.toString());
                    },)
                ],
              ),
            ),
          ),
        )
      ],
    );


  }
}