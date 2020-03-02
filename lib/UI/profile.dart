import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Utils/const.dart';

import 'my_addresses.dart';
import 'my_cart_screen.dart';
import 'my_orders.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String mobile = "", email = "", name = "";

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((prefs) {
      Map<String, dynamic> tokenMap =
          Const.parseJwt(prefs.getString('AUTH_TOKEN'));
      setState(() {
        if (tokenMap['name'] != null &&
            tokenMap['name'].toString().toLowerCase() != "") {
          name = tokenMap['name'].toString();
        }
        if (tokenMap['mobile'] != null &&
            tokenMap['mobile'].toString().toLowerCase() != "") {
          String isd = "";
          if (tokenMap['countrycode'] != null &&
              tokenMap['countrycode'].toString().toLowerCase() != "true") {
            isd = tokenMap['countrycode'].toString();
          }
          mobile = isd + tokenMap['mobile'].toString();
        }
        if (tokenMap['email'] != null &&
            tokenMap['email'].toString().toLowerCase() != "true") {
          email = tokenMap['email'].toString();
        }
      });
    });
    super.initState();
  }

  var text = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset(
              'assets/OkAssets/LeftSideArrow.png',
              height: 25,
            ),
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Const.textBlack),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Const.allBOxStroke),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                              ),
                            ),
//                            GestureDetector(
//                              onTap: (){},
//                              child: Padding(
//                                padding: EdgeInsets.symmetric(horizontal: 15),
//                                child: Image.asset('edit-pencil.png', height: 15,),
//                              ),
//                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: <Widget>[
                            Text(
                              email,
                              style: text,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
//                            GestureDetector(
//                              onTap: (){},
//                              child: Padding(
//                                padding: EdgeInsets.symmetric(horizontal: 15),
//                                child: Image.asset('edit-pencil.png', height: 12,),
//                              ),
//                            )
                          ],
                        ),
                        Text(
                          mobile,
                          style: text,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Const.allBOxStroke),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context, EnterExitRoute(enterPage: MyOrders()));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/myorders.png',
                                height: 23.0,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'My Orders',
                                style: text,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black26,
                      ),

                      /*InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, Const.mySubscriptions);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[

                              Image.asset('my_subscription.png', height: 23.0,),

                              SizedBox(width: 15,),

                              Text('My Subscriptions', style: text,),

                            ],
                          ),
                        ),
                      ),*/

                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black26,
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              EnterExitRoute(enterPage: MyCartScreen()));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'mycart.png',
                                height: 23.0,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'My Cart',
                                style: text,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black26,
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              EnterExitRoute(enterPage: MyAddresses()));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'my_addressess.png',
                                height: 23.0,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'My Address',
                                style: text,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black26,
                      ),

//                      InkWell(
//                        onTap: (){
//                          //Navigator.pushNamed(context, Const.sharedCart);
//                        },
//                        child: Padding(
//                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                          child: Row(
//                            children: <Widget>[
//
//                              Image.asset('shared_cart.png', height: 23.0,),
//
//                              SizedBox(width: 15,),
//
//                              Text('Shared Cart', style: text,),
//
//                              Expanded(
//                                flex: 1,
//                                child: Container(),
//                              ),
//
//                              Container(
//                                height: 30,
//                                width: 30,
//                                decoration: BoxDecoration(
//                                    color: Const.orange,
//                                  borderRadius: BorderRadius.all(Radius.circular(100))
//                                ),
//                                child: Center(
//                                  child: Text('3', style: TextStyle(
//                                      color: Colors.white,
//                                      fontWeight: FontWeight.w500,
//                                      fontSize: 15
//                                  ),),
//                                ),
//                              )
//
//                            ],
//                          ),
//                        ),
//                      ),
//
//                      Container(
//                        width: double.infinity,
//                        height: 1,
//                        color: Colors.black26,
//                      ),
//
//                      InkWell(
//                        onTap: (){
//                          //Navigator.pushNamed(context, Const.wallet);
//                        },
//                        child: Padding(
//                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                          child: Row(
//                            children: <Widget>[
//
//                              Image.asset('wallet_menu.png', height: 23.0,),
//
//                              SizedBox(width: 15,),
//
//                              Text('Wallet', style: text,),
//
//                            ],
//                          ),
//                        ),
//                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
