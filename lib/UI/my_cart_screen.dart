
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/all_product_screen.dart';
import 'package:vegetos_flutter/UI/categories_screen.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/login.dart';
import 'package:vegetos_flutter/UI/product_detail_screen.dart';
import 'package:vegetos_flutter/UI/select_contact.dart';
import 'package:vegetos_flutter/UI/set_delivery_details.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/DashboardProductResponseModel.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';
import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';
import 'package:vegetos_flutter/models/my_cart.dart' as myCart;
import 'package:vegetos_flutter/models/product_common.dart' as bst;

import 'package:vegetos_flutter/models/product_common.dart';
import 'package:vegetos_flutter/models/product_detail.dart';
import 'package:vegetos_flutter/models/recommended_products.dart';

class MyCartScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyCartState();
  }

}

class MyCartState extends State<MyCartScreen>
{
   static myCart.MyCartModal myCartModal ;

  //RecommendedProductsModel  recommendedProductsModel ;

  String cartTotalItems = "0";
  String totalSaving = "0";
  String checkoutTotal = "0";
  String ImageURL = '';

  bool isDataAvailable = false;

   Future recommendedFuture;

  GetCartResponseModel model = GetCartResponseModel();

  @override
  void initState() {
    // TODO: implement initState
    callGetMyCartAPI();
    recommendedFuture = ApiCall().recommendedForYou("1", "10");
    SharedPreferences.getInstance().then((prefs) {
      ImageURL = prefs.getString("ImageURL");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    myCartModal = Provider.of<myCart.MyCartModal>(context);
    /*recommendedProductsModel = Provider.of<RecommendedProductsModel>(context) ;

    if(!recommendedProductsModel.loaded){
      recommendedProductsModel.loadProducts();
    }*/

    if(!myCartModal.loaded){
      myCartModal.getMyCart();
      return Material(child: Center(child: CircularProgressIndicator(),),);
    }

    return Scaffold(
      appBar: cartAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              model.cartItemViewModels != null && model.cartItemViewModels.isNotEmpty ? cartWidgets() : noItemsInYourCart(),
              recommendedContainer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: checkoutBottomBar(),
    );
  }

  Widget priceTotalBox(GetCartResponseModel model) {
    return Visibility(
      visible: true,
      child: Container(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text('M.R.P', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text("₹${model.totalAmount.toString()}", style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text('Product Discount', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text('-₹ '+ model.discount.toString(), style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            Text('Delivery Charge ', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                            Icon(Icons.help_outline, color: Const.primaryColor, size: 20.0,),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text('₹ ' + model.deliveryCharges.toString(), style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.primaryColor),),
                      ),
                    ],
                  ),
                ),
                Container(color: Const.gray10, height: 1.0, margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text('Sub Total', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text("₹${model.SubTotal.toString()}", style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cartItemList(GetCartResponseModel model) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
          child: Text('Items in your cart', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: model.cartItemViewModels.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
          itemBuilder: (context, index) {
            return ListTile(
              title: cartItemChild(model.cartItemViewModels[index]),
              onTap: () {

              },
            );
          },
        )
      ],
    );
  }

  Widget cartItemChild(CartItemViewModel cartItem) {

    String name = "";
    String unit = "";
    for(int i = 0; i < cartItem.ProductDetails.length; i++) {
      if(cartItem.ProductDetails[i].Language == "En-US") {
        name = cartItem.ProductDetails[i].Name;
        break;
      }
    }

    for(int i = 0; i < cartItem.Units.length; i++) {
      if(cartItem.Units[i].Language == "En-US") {
        unit = cartItem.Units[i].Name;
        break;
      }
    }

    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      //child: Image.asset('assets/01-product.png', height: 100.0, width: 100.0,),
                      /*child: Image.network(cartItem.productMediaId==null?'assets/02-product.png':
                      '${DashboardScreenState.appFirstModal.ImageUrl} ${cartItem.productMediaId} ', height: 100.0, width: 100.0,),*/
                      child: cartItem.productMediaId != null && cartItem.productMediaId.isNotEmpty ?
                      Image.network(ImageURL + cartItem.productMediaId, height: 100.0, width: 100.0,) :
                      Image.asset('assets/02-product.png', height: 100.0, width: 100.0,),
                      /*child: Image.asset(cartItem.productMediaId==null?'assets/02-product.png':
                      '${ImageURL} ${cartItem.productMediaId} ', height: 100.0, width: 100.0,),*/
                    ),
                    /*Container(
                      padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.orange
                      ),
                      child: Text('12% OFF',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
                          color: Colors.white),),
                    ),*/
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[

//                      InkWell(onTap: (){
//                        removetoCart(cartItem.id) ;
//                      },child:   Container(
//                        alignment: Alignment.topRight,
//                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
//                        child: Text('Remove' , style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans',
//                            color: Colors.black, fontWeight: FontWeight.w500),),
//
//                      ),) ,

                     Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text(name , style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                            color: Colors.black, fontWeight: FontWeight.w500),),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text(cartItem.MinimumOrderQuantity.toString() + " " + unit, style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                            color: Const.dashboardGray, fontWeight: FontWeight.w500),),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("${cartItem.ProductPrice.OfferPrice}",style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 10.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(cartItem.ProductPrice.Price.toString() ,style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey, decoration: TextDecoration.lineThrough),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Row(
                                children: <Widget>[

                                  InkWell(onTap: (){

                                    if(cartItem.quantity > cartItem.MinimumOrderQuantity) {
                                      updateCartQuantity(cartItem.itemId, (cartItem.quantity - cartItem.IncrementalStep).toString());
                                    } else {
                                      deleteCartItem(cartItem.itemId);
                                    }

                                  },child:    Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Image.asset('assets/minus.png', height: 20.0, width: 20.0,),
                                  ),),


                                  Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Text((cartItem.quantity / cartItem.MinimumOrderQuantity).round().toString() ,style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,)),
                                  ),


                                  InkWell(onTap: (){
                                    /*cartItem.quantity ++ ;
                                    myCartModal.totalCost = myCartModal.totalCost+ cartItem.price ;

                                    updateQuantity(cartItem.itemId , cartItem.quantity) ;

                                    setState(() {

                                    });*/

                                    updateCartQuantity(cartItem.itemId, (cartItem.quantity + cartItem.IncrementalStep).toString());

                                  },child:   Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Image.asset('assets/plus.png', height: 20.0, width: 20.0,),
                                  ),),


                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cartWidgets() {
    return Column(
      children: <Widget>[
        priceTotalBox(model),
        cartItemList(model),
      ],
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
                           child: Text(name,
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
                       child: Text(result.MinimumOrderQuantity.toString() + " " + unit,
                         style: TextStyle(fontSize: 11.0, fontFamily: 'GoogleSans',
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
                           child: Text('₹ ${result.ProductPrice.OfferPrice != null ? result.ProductPrice.OfferPrice : 0}',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
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
                       callAddToCartAPI(result.ProductId, result.ProductVariantId, result.IncrementalStep.toString(), "", result.ProductPrice.OfferPrice.toString());
                     },)
                 ],
               ),
             ),
           ),
         )
       ],
     );

   }

  void confirmDelete() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("My Cart"),
          content: new Text("Are you sure you want clear your cart items?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                callClearCartAPI();
              },
            ),
          ],
        );
      },
    );
  }

  Widget callGetMyCartAPI() {

    ApiCall().getCart().then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        GetCartResponseModel getCartResponseModel = GetCartResponseModel.fromJson(apiResponseModel.Result);
        setState(() {
          model = getCartResponseModel;
          if(model.discount != null) {
            totalSaving = model.discount.toString();
          } else {
            totalSaving = "0";
          }

          if(model.SubTotal != null) {
            checkoutTotal = model.SubTotal.toString();
          } else {
            checkoutTotal = "0";
          }

          if(model.cartItemViewModels != null) {
            cartTotalItems = model.cartItemViewModels.length.toString();
          } else {
            cartTotalItems = "0";
          }

          setState(() {
            isDataAvailable = true;
          });
        });
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
      }
    });
  }

  Widget noItemsInYourCart() {
    return Container(
        padding: EdgeInsets.all(10),
        height: 400,
        child:Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/profile.png', height: 200, width: 200,),
                Text('No items in cart',
                  style: TextStyle(color:Colors.black ,fontSize: 20.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(EnterExitRoute(enterPage: CategoriesScreen()));
                    },
                    color: Colors.green,
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                    child: Text('Start Shopping', style:
                    TextStyle(color:Colors.white ,fontSize: 20.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget cartAppBar() {
    return AppBar(
      backgroundColor: Const.appBar,
      automaticallyImplyLeading: true,
      leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Image.asset('back.png', height: 25,),
        ),
      ),
      title: Container(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text('My Cart', style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('${cartTotalItems} Items', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Visibility(
          visible: model.cartItemViewModels != null ? true : false,
          child: InkWell(
            onTap: (){
              confirmDelete();
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Icon(Icons.delete, color: Colors.white,),
            ),
          ),
        ),
        Visibility(
          visible: model.cartItemViewModels != null ? true : false,
          child: InkWell(
            onTap: (){
              Navigator.push(context, SlideLeftRoute(page: SelectContact()));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Icon(Icons.share, color: Colors.white,),
            ),
          ),
        )
      ],
    );
  }

  Widget checkoutBottomBar() {
    return BottomAppBar(
      child: Visibility(
        visible: model.cartItemViewModels != null ? true : false,
        child: InkWell(
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              Map<String, dynamic> tokenMap = Const.parseJwt(prefs.getString('AUTH_TOKEN'));
              if(tokenMap['anonymous'].toString().toLowerCase() == "true") {
                Navigator.push(context, EnterExitRoute(enterPage: LoginScreen()));
              } else {
                if(model.cartItemViewModels != null && model.cartItemViewModels.isNotEmpty) {
                  Navigator.push(context, SlideLeftRoute(page: SetDeliveryDetails(model)));
                } else {
                  Fluttertoast.showToast(msg: 'No items in your cart');
                }
              }
            });
          },
          child: Container(
            color: Const.primaryColor,
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            height: 50.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Checkout', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                              color: Colors.white, fontWeight: FontWeight.w500),textAlign: TextAlign.left,),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('You have savd ₹ ' + totalSaving, style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                            color: Colors.white, fontWeight: FontWeight.w500),),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("₹${checkoutTotal}", style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                        color: Colors.white, fontWeight: FontWeight.w500),textAlign: TextAlign.left,),
                  ),
                ),
                Icon(Icons.arrow_forward, color: Colors.white,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateCartQuantity(String itemId, String quantity) {
    ApiCall().updateQuantity(itemId, quantity).then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        callGetMyCartAPI();
      } else if(apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
      }
    });
  }

  void deleteCartItem(String itemId) {
     ApiCall().deleteItem(itemId).then((apiResponseModel) {
       if(apiResponseModel.statusCode == 200) {
         callGetMyCartAPI();
       } else if(apiResponseModel.statusCode == 401) {
         Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
       } else {
         Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
       }
     });
   }

  void callClearCartAPI() {
    ApiCall().clearCart().then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        callGetMyCartAPI();
      } else if(apiResponseModel.statusCode == 401){
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
      }
    });
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
             return somethingWentWrong();
           } else {
             return somethingWentWrong();
           }
         } else if(snapshot.connectionState == ConnectionState.waiting) {
           return Container(child: Center(child: CircularProgressIndicator(),),height: 275.0,);
         } else {
           return somethingWentWrong();
         }
       },
     );
   }

   Widget somethingWentWrong() {
     return InkWell(
       onTap: () {
         callRecommendedForYouAPI();
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

   void callAddToCartAPI(String productId, String varientId, String qty, String offerId, String amount) {
     ApiCall().addToCart(productId, varientId, qty, offerId, amount).then((apiResponseModel) {
       if(apiResponseModel.statusCode == 200) {
         Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
         callGetMyCartAPI();
       } else if (apiResponseModel.statusCode == 401) {
         Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
       } else {
         Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
       }
     });
   }

}