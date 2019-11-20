import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class ItemsSubscribed extends StatefulWidget {
  @override
  _ItemsSubscribedState createState() => _ItemsSubscribedState();
}

class _ItemsSubscribedState extends State<ItemsSubscribed> {

  var text = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15
  );

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
            'Cherry Tomatoes'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[



          ],
        ),
      ),
    );
  }
}
