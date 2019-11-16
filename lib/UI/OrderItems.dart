
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class OrderItems extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderItemsState();
  }

}

class OrderItemsState extends State<OrderItems>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          itemChild()
        ],
      ),
    );
  }


  Widget itemSubChild()
  {
    var child = Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/01-product.png', height: 100.0, width: 100.0,),
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
                                      child: Text('₹45 x 1 ',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Text('₹45',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,)),
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

    return child;
  }

  Widget itemChild()
  {
    var subChild =Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: Text('Exotic', style: TextStyle(fontFamily: 'GoogleSans',
              fontWeight: FontWeight.w500, color: Const.location_grey),),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: itemSubChild(),
            );
          },
        ),
      ],
    );

    return subChild;
  }

  Widget itemListwithChild()
  {
    var list = ListView.builder(
      itemCount: 5,
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
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: cartItemList(),
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
                                      child: Text('₹120 ',style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans',
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

}