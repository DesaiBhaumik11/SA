import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationServiceUnavailable extends StatefulWidget {
  var s;
  LocationServiceUnavailable(this.s);
  @override
  _LocationServiceUnavailableState createState() => _LocationServiceUnavailableState();
}

class _LocationServiceUnavailableState extends State<LocationServiceUnavailable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Image.asset('no-result.png', height: 200,),

            SizedBox(
              height: 10,
            ),

            Text('Uh Oh! We don\'t deliver here.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 23,
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Text('Currently we are not providing services in this',
              style: TextStyle(
                  color: Color(0xff2d2d2d),
                  fontWeight: FontWeight.w500,
                  fontSize: 15
              ),
            ),

            Text('city/ area/ society. Please try again with',
              style: TextStyle(
                  color: Color(0xff2d2d2d),
                  fontWeight: FontWeight.w500,
                  fontSize: 15
              ),
            ),

            Text('some other locations.',
              style: TextStyle(
                  color: Color(0xff2d2d2d),
                  fontWeight: FontWeight.w500,
                  fontSize: 15
              ),
            ),

            SizedBox(
              height: 15,
            ),

            RaisedButton(
              color: Color(0xff009a00),
              onPressed: widget.s,
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Text(
                  'Set Delivery Location', style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
