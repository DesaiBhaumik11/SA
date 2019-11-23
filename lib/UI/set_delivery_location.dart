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
      body: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 300),
        child: Column(
          children: <Widget>[

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

            Expanded(
              flex: 1,
              child: Container(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
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
                )
              ],
            ),


          ],
        ),
      )
    );
  }
}
