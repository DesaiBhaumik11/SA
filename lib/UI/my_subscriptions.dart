import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/Utils/const.dart';

import 'item_subscribed.dart';

class MySubscriptions extends StatefulWidget {
  @override
  _MySubscriptionsState createState() => _MySubscriptionsState();
}

class _MySubscriptionsState extends State<MySubscriptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset('assets/OkAssets/LeftSideArrow.png', height: 25,),
          ),
        ),

        title: Text(
          'My Subscriptions',
          style: TextStyle(color: Const.textBlack),
        ),
      ),
      body: buildList(context),
    );
  }


  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Const.allBOxStroke),
              color: Colors.white
            ),
            padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
            margin: EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: Image.asset('Cherry-Tomatoes.png', height: 100.0, width: 100.0,),
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
                                            child: Text('₹45 x 2 ',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
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
                                          child: Text('₹90',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
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
                    ),
                  ],
                ),

                Divider(
                  color: Colors.grey,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 6, right: 10),
                  child: Row(
                    children: <Widget>[

                      Image.asset('order-confirmed.png', height: 22,),

                      SizedBox(
                        width: 10,
                      ),

                      Text('Ongoing', style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),),



                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.push(context, SlideLeftRoute(page: ItemsSubscribed()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Const.widgetGreen,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text('View details', style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12
                            ),),
                          ),
                        ),
                      )

                    ],
                  ),
                )
              ],
            ),
          )
        );
      },
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

}
