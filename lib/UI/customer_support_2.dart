import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/expired_items.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class CustomerSupport2 extends StatefulWidget {
  @override
  _CustomerSupport2State createState() => _CustomerSupport2State();
}

class _CustomerSupport2State extends State<CustomerSupport2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      appBar: AppBar(
        backgroundColor: Const.appBar,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset(
              'back.png',
              height: 25,
            ),
          ),
        ),
        title: Text('Customer Support'),
      ),
      body: buildList(context),
    );
  }

  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              Navigator.of(context).push(SlideLeftRoute(page: ExpiredItems()));
            },
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 15, 12, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Expired items received',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black12,
                )
              ],
            ));
      },
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }
}
