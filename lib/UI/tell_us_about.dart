import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/Utils/const.dart';

class TellUsAbout extends StatefulWidget {
  @override
  _TellUsAboutState createState() => _TellUsAboutState();
}

class _TellUsAboutState extends State<TellUsAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
            child: Image.asset('assets/OkAssets/LeftSideArrow.png', height: 25,),
          ),
        ),
        title: Text(
          'Tell us about',
          style: TextStyle(color: Const.textBlack),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Const.allBOxStroke)
              ),
              child: TextFormField(
                maxLines: 15,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87
                ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Write your issue here...',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87
                  )
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (s) {
                            return FunkyOverlay();
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Submit', style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}


class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.white,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
            child: Container(
              color: Colors.white,
              child: Wrap(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Image.asset('confirmation.png', height: 150,),

                      SizedBox(
                        height: 10,
                      ),

                      Text('We are sorry for your trouble.', style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),),

                      Text('Ok will get back to you soon', style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),),

                      SizedBox(
                        height: 10,
                      ),


                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: (){


                          Navigator.of(context)
                              .pushAndRemoveUntil(EnterExitRoute(enterPage: DashboardScreen()) , (Route<dynamic> route) => false);

                          // Navigator.pop(context) ;

                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text('Thanks', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),),
                        )
                      )
                    ],
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
