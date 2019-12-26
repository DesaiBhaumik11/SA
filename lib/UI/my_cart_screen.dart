
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/select_contact.dart';
import 'package:vegetos_flutter/UI/set_delivery_details.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';
import 'package:vegetos_flutter/models/my_cart.dart' as myCart;

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
  myCart.MyCartModal myCartModal ;

  RecommendedProductsModel  recommendedProductsModel ;

  @override
  Widget build(BuildContext context) {

    myCartModal = Provider.of<myCart.MyCartModal>(context);
    recommendedProductsModel = Provider.of<RecommendedProductsModel>(context) ;

    if(!recommendedProductsModel.loaded){
      recommendedProductsModel.loadProducts();

    }

    if(!myCartModal.loaded){
      myCartModal.getMyCart();
      return Material(child: Center(child: CircularProgressIndicator(),),);
    }

    return Scaffold(
      appBar: AppBar(
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
                  child: Text('${myCartModal.cartItemSize} Items', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: (){
              confirmDelete() ;
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Icon(Icons.delete, color: Colors.white,),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, SlideLeftRoute(page: SelectContact()));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Icon(Icons.share, color: Colors.white,),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Const.gray10,
          child: Column(
            children: <Widget>[
              priceTotalBox(),
              myCartModal.result==null||
                  myCartModal.result.cartItemViewModels.length==0?
              Container(padding: EdgeInsets.all(10),
                  height: 200
                  ,child:Card(child:
                  Center(
                    child: Text('No item in cart', style: TextStyle(color:Colors.black ,fontSize: 20.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                  ),
                  )):
              cartItemList(),
              horizontalList()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            checkOutCall();
            Navigator.push(context, SlideLeftRoute(page: SetDeliveryDetails()));
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
                        child: Text('You have savd ₹ 0', style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                            color: Colors.white, fontWeight: FontWeight.w500),),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("₹${myCartModal.totalCost}", style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
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

  Widget priceTotalBox()
  {
    return Container(
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
                      child: Text("₹${myCartModal.totalCost}", style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
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
                      child: Text('-₹ 0', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
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
                      child: Text('FREE', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
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
                      child: Text("₹${myCartModal.totalCost}", style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cartItemList()
  {
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
          itemCount: myCartModal.result ==null?0:myCartModal.result.cartItemViewModels.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: cartItemChild(myCartModal.result.cartItemViewModels[index]),
              onTap: () {

              },
            );
          },
        )
      ],
    );
  }

  Widget cartItemChild(myCart.CartItemViewModel cartItem)
  {
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      //child: Image.asset('assets/01-product.png', height: 100.0, width: 100.0,),
                      child: Image.network(cartItem.productMediaId==null?'assets/01-product.png':
                      '${DashboardScreen.appFirstModal.ImageUrl} ${cartItem.productMediaId} ', height: 100.0, width: 100.0,),
                    ),
                    Container(
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
                        child: Text('${cartItem.seoTag}' , style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                            color: Colors.black, fontWeight: FontWeight.w500),),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text('1 KG', style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
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
                                      child: Text("${cartItem.price}",style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 10.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("11" ,style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans',
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
                                    cartItem.quantity ++ ;
                                    myCartModal.totalCost = myCartModal.totalCost+ cartItem.price ;

                                    updateQuantity(cartItem.id , cartItem.quantity) ;

                                    setState(() {

                                    });

                                  },child:   Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Image.asset('assets/plus.png', height: 20.0, width: 20.0,),
                                  ),),


                                  Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Text("${cartItem.quantity}" ,style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,)),
                                  ),

                                  InkWell(onTap: (){

                                    if( cartItem.quantity>1){
                                      updateQuantity(cartItem.id , cartItem.quantity) ;
                                      cartItem.quantity--  ;
                                      myCartModal.totalCost = myCartModal.totalCost - cartItem.price ;
                                      setState(() {
                                      });
                                    }else{

                                      removetoCart(cartItem.id) ;

                                    }

                                  },child:    Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Image.asset('assets/minus.png', height: 20.0, width: 20.0,),
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

  Widget horizontalList()
  {
    return Stack(
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
                      child: Text('Recommended for you',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
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
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return childView(context , index );
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

  Widget childView(BuildContext context, int index ) {

    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {

            final ProductDetailModal productModal=Provider.of<ProductDetailModal>(context);
            showDialog(context: context,builder: (c)=>Center(child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator())));
              productModal.getProductDetail(recommendedProductsModel.result[index].id ,(){
              Navigator.pop(context);
              Navigator.pushNamed(context, Const.productDetail);
            }) ;
            //Navigator.pushNamed(context, Const.productDetail);
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
                          child: Image.network('${DashboardScreen.appFirstModal.ImageUrl}${recommendedProductsModel.result[index].productMediaId}', height: 100.0, width: 100.0,),
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
                          child: Text(recommendedProductsModel.result[index].seoTag,overflow: TextOverflow.ellipsis, maxLines: 2 ,style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('${recommendedProductsModel.result[index].quantity} ${recommendedProductsModel.result[index].unit}',style: TextStyle(fontSize: 11.0, fontFamily: 'GoogleSans',
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
                          child: Text('₹ ${recommendedProductsModel.result[index].price}',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
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
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Const.primaryColor
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: InkWell(child: Text('+ ADD',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                        color: Colors.white, fontWeight: FontWeight.w500,)),onTap:(){

                        myCartModal.addTocart(recommendedProductsModel.result[index] ) ;

                      },)
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );

  }


   AddItem(int index){

//    Map<String , String> map = Map() ;
//    map["Id"] = "" ;
//    map["CartId"] = "" ;
//    map["ProductId"] = recommendedProductsModel.result[index].id;
//    map["ProductVariantId"] = recommendedProductsModel.result[index].productVariantId ;
//    map["Quantity"] = "1" ;
//    map["OfferId"] = "" ;
//    map["Amount"] = "${recommendedProductsModel.result[index].price}" ;

     myCartModal.addTocart(recommendedProductsModel.result[index] ) ;






  }

  removetoCart(String id) {

    NetworkUtils.deleteRequest(endPoint: Constant.DeleteItem+id).then((res){
      print("removetoCart Response = $res");

      myCartModal.getMyCart() ;
    }) ;
  }


  void updateQuantity(String itemId , int quantity){

    myCartModal.updateQuantity(itemId,quantity) ;

//
//    print("${itemId}   >>> ${quantity}") ;
//    Map<String , String>  headersmap = Map() ;
//
//    NetworkUtils.postRequest(body: null,endpoint: Constant.UpdateQuantity+ itemId + "&quantity=${quantity}" ,headers: headersmap).then((res){
//
//      print("updateQuantity REsponse>>> $res") ;
//
//    }) ;



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

                  myCartModal.claerCart() ;
                  Navigator.of(context).pop();


              },
            ),
          ],
        );
      },
    );
  }

  void checkOutCall() {

    NetworkUtils.getRequest(endPoint: Constant.Checkout).then((res){

      print("checkOutCall Response>> $res");

    }).catchError((e){
      print("checkOutCall Error>> $e");
    }) ;

  }


}