
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/PaymentOptionScreen.dart';
import 'package:vegetos_flutter/UI/set_delivery_details.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
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
                  child: Text('3 Items', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Icon(Icons.share, color: Colors.white,),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Const.gray_10,
          child: Column(
            children: <Widget>[
              priceTotalBox(),
              cartItemList(),
              horizontalList()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
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
                        child: Text('You have savd ₹104', style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                            color: Colors.white, fontWeight: FontWeight.w500),),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('₹400', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
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
                      child: Text('₹504', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
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
                      child: Text('-₹104', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
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
              Container(color: Const.gray_10, height: 1.0, margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),),
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
                      child: Text('₹400', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
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
          child: Text('Items ifn your cart', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: cartItemChild(),
              onTap: () {

              },
            );
          },
        )
      ],
    );
  }

  Widget cartItemChild()
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
                      child: Image.asset('assets/01-product.png', height: 100.0, width: 100.0,),
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
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text('Cherry Tomatoes', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                            color: Colors.black, fontWeight: FontWeight.w500),),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text('1 KG', style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                            color: Const.dashboard_gray, fontWeight: FontWeight.w500),),
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
                                      child: Text('₹101 ',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 10.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('₹120 ',style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans',
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
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Image.asset('assets/plus.png', height: 20.0, width: 20.0,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Text('1',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Image.asset('assets/minus.png', height: 20.0, width: 20.0,),
                                  ),
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
                        return childView(context);
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

  Widget childView(BuildContext context)
  {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Const.productDetail);
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
                          child: Image.asset('assets/product01.png', height: 100.0, width: 100.0,),
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
                    child: Text('Parle Monacco Cheeselings Classic',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('300 gm',style: TextStyle(fontSize: 11.0, fontFamily: 'GoogleSans',
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
                          child: Text('₹101 ',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
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
                      child: Text('+ ADD',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                        color: Colors.white, fontWeight: FontWeight.w500,)),
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

}