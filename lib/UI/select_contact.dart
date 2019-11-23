import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/const.dart';

class SelectContact extends StatefulWidget {
  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {

  List colorsChange=[
   Color(0xFFEB443D),
   Color(0xFF434DB2),
    Color(0xFF3BCFF2),
   Color(0xFFE01E64),
   Color(0xFF59AE4F),
   Color(0xFF009BEE),
    Color(0xFFF5572E),
    Color(0xFFF8C219),
    Color(0xFF6433B4),
    Color(0xFF3B8FF2)
  ];

  var tappedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Select Contact'
        ),
        actions: <Widget>[

          FlatButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (s) {
                    return FunkyOverlay();
                  });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Share', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),),
            ),
          ),

        ],
      ),
      body: buildList(context),
    );
  }

  ListView buildList(BuildContext context)  {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
          },
          child: InkWell(
            onTap: (){},
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    children: <Widget>[

                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: colorsChange[index],
                        ),
                        child: Center(
                          child: Text(
                            'A', style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 16
                          ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10,),

                      Text('Aarav', style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                      ),),

                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),

                      InkWell(
                        onTap: (){
                          setState(() {
                            tappedIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(Icons.check,
                              color: Theme.of(context).primaryColor
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black12,
                  ),
                )
              ],
            ),
          )
        );
      },
      itemCount: 10,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Material(
          color: Colors.white,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Padding(
                padding: EdgeInsets.symmetric( vertical: 35),
                child:  Wrap(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Image.asset('user-not-found-error.png', height: 130,),

                        SizedBox(
                          height: 20,
                        ),

                        Text(Const.userNotVeg,textAlign: TextAlign.center, style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),),


                        SizedBox(
                          height: 20,
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50))
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  child: Text('Ok', style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),),
                                )
                            ),

                          ],
                        ),
                      ],
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}

