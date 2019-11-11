
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/UI/OrderItems.dart';
import 'package:vegetos_flutter/UI/OrderSummery.dart';

class OrderPlacedScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderPlacedScreenState();
  }

}

class OrderPlacedScreenState extends State<OrderPlacedScreen>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: Text('Order Placed', style: TextStyle(fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            OrderItems(),
          ],
        ),
      ),
    );
  }

}