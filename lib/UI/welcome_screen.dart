
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/set_delivery_location.dart';
import 'package:vegetos_flutter/Utils/const.dart';

class WelcomeScreenState extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WelcomeScreen();
  }

}

class WelcomeScreen extends State<WelcomeScreenState>
{
  int currentPageValue;

  Widget circleBar(bool isActive)
  {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive? 12 : 8,
      width: isActive? 12 : 8,
      decoration: BoxDecoration(
        color: isActive? Colors.green : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slideShow();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);


    return WillPopScope(
      child: Scaffold(

        body: slideShow()
    ),) ;
  }

  Widget slideShow()
  {
    List<Widget> widgetList = <Widget> [
      welcomeScreen1(),
      welcomeScreen2(),
      welcomeScreen3(),
    ];

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: widgetList.length,
          onPageChanged: (int page) {
            getChangedPageAndMoveBar(page);
          },
          controller: null,
          itemBuilder: (BuildContext context, int index) {
            return widgetList[index];
          },
        ),
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 35),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for(int i = 0; i < widgetList.length; i++)
                    if (i == currentPageValue) ...[circleBar(true)] else
                      circleBar(false),
                ],
              ),
            )
          ],
        ),
        Visibility(
          visible: currentPageValue == widgetList.length -1
            ? true
            : false,
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: FlatButton(
                  onPressed: (){
                    SharedPreferences.getInstance().then((prefs){
                      prefs.setString("phone", "Guest User");
                    }) ;
                    Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: SetDeliveryLocation(),
                        exitPage: WelcomeScreenState()),(c)=>false);
                    //Navigator.pushNamed(context, Const.setDeliveryLocation);
                  },
                  child: Text(
                    'Skip'
                  ),
                ),
              )
            ),
          ),
        )
      ],
    );
  }



  Widget welcomeScreen1()
  {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Align(
              alignment: FractionalOffset.topCenter,
              child: Image.asset('assets/welcome_top_pattern.png'),
            ),
          ),

          Positioned(
            child: Align(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 0,
                      child: Image.asset('assets/guide_01.png', height: 180.0,),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                        child: Text(Const.welcome1Title, style: TextStyle(fontSize: 22.0,
                            fontFamily: 'GoogleSans', fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(Const.welcome1Desc, style: TextStyle(fontSize: 15.0,
                              fontFamily: 'GoogleSans', fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget welcomeScreen2()
  {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Align(
              alignment: FractionalOffset.topCenter,
              child: Image.asset('assets/welcome_top_pattern.png'),
            ),
          ),

          Positioned(
            child: Align(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 0,
                      child: Image.asset('assets/guide_02.png', height: 180.0,),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                        child: Text(Const.welcome2Title, style: TextStyle(fontSize: 22.0,
                            fontFamily: 'GoogleSans', fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(Const.welcome2Desc, style: TextStyle(fontSize: 15.0,
                              fontFamily: 'GoogleSans', fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget welcomeScreen3()
  {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Align(
              alignment: FractionalOffset.topCenter,
              child: Image.asset('assets/welcome_top_pattern.png'),
            ),
          ),

          Positioned(
            child: Align(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 0,
                      child: Image.asset('assets/guide_03.png', height: 180.0,),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                        child: Text(Const.welcome3Title, style: TextStyle(fontSize: 22.0,
                            fontFamily: 'GoogleSans', fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(Const.welcome3Desc, style: TextStyle(fontSize: 15.0,
                              fontFamily: 'GoogleSans', fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



}