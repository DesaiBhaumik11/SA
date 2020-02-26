import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vegetos_flutter/Provider/DataProvider.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutVegetos extends StatefulWidget {
  @override
  _AboutVegetosState createState() => _AboutVegetosState();
}

class _AboutVegetosState extends State<AboutVegetos> {

  String kHtmlPP = "";
  String kHtmlTC = "";
  String kHtmlAV = "";

  @override
  void initState() {
    // TODO: implement initState
    DataProvider().loadPrivacyPolicy().then((va){setState(() {kHtmlPP = va;});});
    DataProvider().loadTermsAndCondition().then((val) {setState(() {kHtmlTC = val;});});
    DataProvider().loadAboutVegetos().then((val) {setState(() {kHtmlAV = val;});});
    super.initState();
  }


  var heading = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  var title = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  var text = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500,
    color: Colors.black54
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
            'About Vegetos'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[

            Container(
              color: Colors.white,
              child: ExpansionTile(
                initiallyExpanded: true,
                backgroundColor: Colors.white,
                title: Text(
                  'About Vegetos', style: title,
                ),
                children: <Widget>[

                  Padding(
                    padding:EdgeInsets.fromLTRB(15, 0, 15, 15) ,
                    child: kHtmlAV.isEmpty ? Container() :HtmlWidget(
                      kHtmlAV,
                      webView: false,
                      textStyle: text,
                    ),
                  )

                ],
              ),
            ),
//
//
            SizedBox(height: 15,),

            Container(
              color: Colors.white,
              child: ExpansionTile(
                backgroundColor: Colors.white,
                title: Text(
                  'Privacy Policy', style: title,
                ),
                children: <Widget>[

                  Padding(
                    padding:EdgeInsets.fromLTRB(10, 0, 5, 15) ,
                    child:  HtmlWidget(
                      kHtmlPP,
                      webView: false,
                      textStyle: text,
                      hyperlinkColor: Colors.black,
                    ),
                  )

                ],
              ),
            ),

            SizedBox(height: 15,),

            Container(
              color: Colors.white,
              child: ExpansionTile(
                backgroundColor: Colors.white,
                title: Text(
                  'Terms & Conditions', style: title,
                ),
                children: <Widget>[

                  Padding(
                    padding:EdgeInsets.fromLTRB(10, 0, 5, 15) ,
                    child: HtmlWidget(
                      kHtmlTC,
                      webView: false,
                      textStyle: text,
                    ),
                  )

                ],
              ),
            ),

            SizedBox(height: 15,),

            Container(
              color: Colors.white,
              child: ExpansionTile(
                backgroundColor: Colors.white,
                title: Text(
                  'Contact Us', style: title,
                ),
                children: <Widget>[

                  Padding(
                    padding:EdgeInsets.fromLTRB(10, 0, 10, 15) ,
                    child: Text(Const.contactus, style: text,),
                  )

                ],
              ),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
