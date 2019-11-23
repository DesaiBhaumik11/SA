
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:vegetos_flutter/Utils/const.dart';

class SplashScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushNamed(context, Const.welcome);
    });

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: FractionalOffset.topCenter,
                child: Image.asset('assets/top_pattern.png'),
              ),
            ),
            
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Image.asset('assets/splash_logo.png'),
                ),
              )
            ),

            Positioned(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Image.asset('assets/bottom_pattern.png'),
              ),
            )
          ],
        ),
      ),
    );
  }

}