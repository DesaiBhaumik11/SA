import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';

import 'customer_Support2.dart';

class CustomerSupport1 extends StatefulWidget {
  @override
  _CustomerSupport1State createState() => _CustomerSupport1State();
}

class _CustomerSupport1State extends State<CustomerSupport1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      appBar: AppBar(
        backgroundColor: Color(0xff47870d),
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
            'Customer Support'
        ),
      ),
      body: buildList(context),
    );
  }

  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Navigator.of(context).push(SlideLeftRoute(page: CustomerSupport2()));
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
                        'Issue with delivered order', style: TextStyle(
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
          )
        );
      },
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

}
