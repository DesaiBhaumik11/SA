import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/Utils/const.dart';

import 'payment_option_screen.dart';

class PromoCode extends StatefulWidget {
  @override
  _PromoCodeState createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
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
            'Promo Code'
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff2d2d2d)
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 4, bottom: 4),
                        hintText: 'Enter Promo Code',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                        )
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 10,
                  ),

                  InkWell(
                    onTap: (){
                      Navigator.push(context, SlideLeftRoute(page: PaymentOptionScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Const.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text('Apply', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12
                        ),),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, bottom: 5),
            child: Text(
              'Available Promos', style: TextStyle(
                color: Color(0xff2d2d2d),
                fontSize: 13,
                fontWeight: FontWeight.w500
            ),
            ),
          ),

          Expanded(
            child: buildList(context),
          )

        ],
      ),
    );
  }

  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){},
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(
                    children: <Widget>[

                      Text('SUMMER2019', style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Const.orange,
                      ),),


                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),


                      InkWell(
                        onTap: (){
                          Navigator.push(context, SlideLeftRoute(page: PaymentOptionScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Const.orange,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text('Apply', style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12
                            ),),
                          ),
                        ),
                      )



                    ],
                  ),

                  SizedBox(
                    height: 8,
                  ),


                  Text(
                    '40% off upto ₹100',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),


                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff2d2d2d)
                          ),
                        ),
                      )
                    ],
                  )


                ],
              ),
            ),
          ),
        );
      },
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }
}
