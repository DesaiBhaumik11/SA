import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/const.dart';

class SetDeliveryLocation extends StatefulWidget {
  @override
  _SetDeliveryLocationState createState() => _SetDeliveryLocationState();
}

class _SetDeliveryLocationState extends State<SetDeliveryLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                  SizedBox(height: 52,),
                Image.asset('delivery-location.png'),

                SizedBox(
                  height: 15,
                ),

                Text(
                  'Set your delivery location', style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500
                ),
                ),

                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Color(0xff009a00),
                          onPressed: (){

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: Text(
                              'Use my location', style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        Navigator.pushNamed(context, Const.setLocationManually);
                      },
                      child: Text(
                        'Set location Manually',
                        style: TextStyle(
                            color: Color(0xff393939),
                            fontSize: 17,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),




              ],
            ),
          ),
          Column(
            children:<Widget>[Expanded(child: Container()), FlatButton(
              onPressed: (){
                Navigator.pushNamed(context, Const.dashboard);
              },
              child: Text(
                'Skip for now',
                style: TextStyle(
                    color: Color(0xff2d2d2d),
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),
              ),
            )]
          )
        ],
      )
    );
  }
}
