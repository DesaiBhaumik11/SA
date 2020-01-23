
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Utils/const.dart';

/*
class OrderSummery extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderSummeryState();
  }

}

class OrderSummeryState extends State<OrderSummery>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            deliveryContent(),
            paymentDetail(),
            //disclaimer(),
          ],
        ),
      ),
    );
  }

  Widget deliveryContent()
  {
    var content = Container(
      color: Const.gray10,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: Text('Delivery Slot', style: TextStyle(fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w500, color: Const.locationGrey),),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Date', style: TextStyle(fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500, color: Const.grey800), textAlign: TextAlign.left,),
                            Text('FRI 31 MAY 2019', style: TextStyle(fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500, color: Const.locationGrey),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Timeslot', style: TextStyle(fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500, color: Const.grey800), textAlign: TextAlign.left,),
                            Text('11 AM - 3 PM', style: TextStyle(fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500, color: Const.locationGrey),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  color: Const.gray10,
                  height: 1.0,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('status', style: TextStyle(fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.grey800), textAlign: TextAlign.left,),
                      Row(
                        children: <Widget>[
                          Image.asset('assets/order_placed.png', height: 15.0, width: 15.0,),
                          Container(
                            margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            child: Text('Order Placed', style: TextStyle(fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500, color: Const.locationGrey), textAlign: TextAlign.left,),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: Text('Delivery Address', style: TextStyle(fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w500, color: Const.locationGrey),),
          ),
          Container(
            color: Colors.white,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Home', style: TextStyle(fontFamily: 'GoogleSans', fontSize: 18.0,
                    fontWeight: FontWeight.w700, color: Const.locationGrey), textAlign: TextAlign.left,),
                Text('Partho Parekh', style: TextStyle(fontFamily: 'GoogleSans', fontSize: 15.0,
                    fontWeight: FontWeight.w500, color: Const.grey800), textAlign: TextAlign.left,),
                Expanded(
                  flex: 0,
                  child: Text(Const.demoAddress, style: TextStyle(fontFamily: 'GoogleSans', fontSize: 15.0,
                      fontWeight: FontWeight.w500, color: Const.grey800), textAlign: TextAlign.left,),
                ),
              ],
            ),
          )
        ],
      ),
    );

    return content;
  }

  Widget paymentDetail()
  {
    var paymentContent = Container(
      color: Const.gray10,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: Text('Payment Details', style: TextStyle(fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w500, color: Const.locationGrey),),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text('Order ID', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text('VEG123456789', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
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
                        child: Text('Invoice number', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text('VEGINV123456', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
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
                            Text('Payment option', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500, color: Const.locationGrey),),
                            Icon(Icons.help_outline, color: Const.primaryColor, size: 20.0,),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text('Online', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
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
                        child: Text('Total Items', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text('-', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
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
                        child: Text('Delivery Charge', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text('-', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.primaryColor),),
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
                        child: Text('Discount/Promo', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text('-', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
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
                        child: Text('Wallet', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text('-', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Const.locationGrey),),
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
                        child: Text('Sub Total', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Colors.black),),
                      ),
                      Expanded(
                        flex: 0,
                        child: Text('-', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500, color: Colors.black),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Text(Const.disclaimer, style: TextStyle(fontFamily: 'GoogleSans', fontSize: 12.0,
                  fontWeight: FontWeight.w500, color: Const.grey800),),
            ),
          )
        ],
      ),
    );

    return paymentContent;
  }

}*/
