import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/const.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var text = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
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
            'Profile'
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
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Row(
                          children: <Widget>[
                            Text('Partho Parekh', style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                            ),),
                            GestureDetector(
                              onTap: (){},
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset('edit-pencil.png', height: 15,),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 10,),

                        Row(
                          children: <Widget>[
                            Text('Parth@archisys.in', style: text,),
                            GestureDetector(
                              onTap: (){},
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset('edit-pencil.png', height: 12,),
                              ),
                            )
                          ],
                        ),

                        Text('9638697123', style: text,),

                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15,),

                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[

                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, Const.myOrders);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[

                              Image.asset('assets/myorders.png', height: 23.0,),

                              SizedBox(width: 15,),

                              Text('My Orders', style: text,),

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
                      ),

                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black26,
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, Const.myCart);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[

                              Image.asset('mycart.png', height: 23.0,),

                              SizedBox(width: 15,),

                              Text('My Cart', style: text,),

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
                        onTap: (){
                          Navigator.pushNamed(context, Const.myAddresses);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[

                              Image.asset('my_addressess.png', height: 23.0,),

                              SizedBox(width: 15,),

                              Text('My Address', style: text,),

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
                        onTap: (){
                          Navigator.pushNamed(context, Const.sharedCart);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[

                              Image.asset('shared_cart.png', height: 23.0,),

                              SizedBox(width: 15,),

                              Text('Shared Cart', style: text,),

                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),

                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Const.orange,
                                  borderRadius: BorderRadius.all(Radius.circular(100))
                                ),
                                child: Center(
                                  child: Text('3', style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15
                                  ),),
                                ),
                              )

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
                        onTap: (){
                          Navigator.pushNamed(context, Const.wallet);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Row(
                            children: <Widget>[

                              Image.asset('wallet_menu.png', height: 23.0,),

                              SizedBox(width: 15,),

                              Text('Wallet', style: text,),

                            ],
                          ),
                        ),
                      ),

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
