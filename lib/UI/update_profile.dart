import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[


            SizedBox(height: 70),


            Image.asset('verify.png', height: 170, ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Verify OTP', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19
                ),),
              ],
            ),

            SizedBox(height: 7),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Enter the six digit OTP sent on', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('your mobile number to continue', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
              ],
            ),

            SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}
