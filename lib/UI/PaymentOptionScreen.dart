
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/OrderPlacedScreen.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class PaymentOptionScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentOptionScreenState();
  }

}

class PaymentOptionScreenState extends State<PaymentOptionScreen>
{
  bool isPromoAplied = true;
  bool wallet = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: Text('Payment Options', style: TextStyle(fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
      ),
      body: Container(
        color: Const.gray_10,
        child: Column(
          children: <Widget>[
            priceTotalBox(),
            promoContainer(),
            walletContainer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            //Navigator.pushNamed(context, Const.paymentOption);
            Navigator.of(context).push(SlideRightRoute(page: OrderPlacedScreen()));
          },
          child: Container(
            color: Const.primaryColor,
            height: 50.0,
            child: Center(
              child: Text('Procced to Payment', style: TextStyle(fontSize: 18.0, fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w500, color: Colors.white),),
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
                      child: Text('M.R.P', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.location_grey),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('₹504', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.location_grey),),
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
                      child: Text('Product Discount', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.location_grey),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('-₹104', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.location_grey),),
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
                          Text('Delivery Charge ', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w500, color: Const.location_grey),),
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
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text('Promo/Discount', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.location_grey),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('-₹62', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.location_grey),),
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
                          fontWeight: FontWeight.w500, color: Const.location_grey),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('-₹30', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.location_grey),),
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
                      child: Text('Sub Total', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Colors.black),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('₹400', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Colors.black),),
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
                      child: Text('Your Savings', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.location_grey),),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text('₹104', style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500, color: Const.location_grey),),
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

  Widget promoContainer()
  {
    var promo = Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.asset('assets/promocode.png', height: 25.0, width: 25.0,),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              child: Text('Apply Promo Code', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w500, color: Const.location_grey),),
            ),
          ),
          Expanded(
            flex: 0,
            child: Icon(Icons.arrow_forward_ios, color: Const.location_grey,),
          ),
        ],
      ),
    );

    var appliedPromo = Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.asset('assets/promocode.png', height: 25.0, width: 25.0,),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text('SUMMER19 - 40% off upto ₹100', style: TextStyle(fontSize: 18.0, fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w500, color: Const.location_grey),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Promo code applied successfully', style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w500, color: Const.location_grey),),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text('- ₹62', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w500, color: Const.location_grey),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text('Remove', style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w500, color: Colors.red),),
              ),
            ],
          )
        ],
      ),
    );

    return isPromoAplied ? appliedPromo : promo;
  }

  Widget walletContainer()
  {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.asset('assets/wallet.png', height: 25.0, width: 25.0,),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: Text('Wallet', style: TextStyle(fontSize: 18.0, fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w500, color: Const.location_grey),),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Total Balance: ₹30', style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.w500, color: Const.location_grey),),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Checkbox(
              value: wallet,
              activeColor: Const.primaryColor,
              onChanged: (b) {
                setState(() {
                  wallet = b;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

}