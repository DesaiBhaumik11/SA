import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TellUsAbout extends StatefulWidget {
  @override
  _TellUsAboutState createState() => _TellUsAboutState();
}

class _TellUsAboutState extends State<TellUsAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      appBar: AppBar(
        backgroundColor: Color(0xff47870d),
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
            'Tell us about'
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(15),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
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

                      Text('Vegetos will get back to you soon', style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),),

                      SizedBox(
                        height: 10,
                      ),


                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          Navigator.pop(context);
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
