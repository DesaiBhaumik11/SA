import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class ItemsOfferzone extends StatefulWidget {
  @override
  _ItemsOfferzoneState createState() => _ItemsOfferzoneState();
}

class _ItemsOfferzoneState extends State<ItemsOfferzone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      appBar: AppBar(
        backgroundColor: Const.appBar,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset('back.png', height: 25,),
          ),
        ),

        title: Text(
            'June Sale'
        ),
      ),
    );
  }
}
