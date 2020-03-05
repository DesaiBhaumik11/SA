import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:dotted_border/dotted_border.dart';


import 'items_offerzone.dart';

class Offerzone extends StatefulWidget {
  @override
  _OfferzoneState createState() => _OfferzoneState();
}

class _OfferzoneState extends State<Offerzone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset('assets/OkAssets/LeftSideArrow.png', height: 25,),
          ),
        ),

        title: Text(
            'Offerzone',
          style: TextStyle(color: Const.textBlack),
        ),
      ),
      body: buildList(context),
    );
  }

  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, SlideLeftRoute(page: ItemsOfferzone()));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5,color: Const.allBOxStroke),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[

                  Container(
                    width: double.infinity,
                    height: 125,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/VegetosAssets/offerzone_01.png',

                        ),
                        fit: BoxFit.cover
                      )
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          Const.offerzone1, style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        ),

                        SizedBox(height: 5,),

                        Text(
                          Const.offerzone2, style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                        ),


                        SizedBox(
                          height: 15,
                        ),


                        DottedBorder(
                          color: Const.orange,
                          strokeWidth: 1,
                            strokeCap: StrokeCap.butt,
                            borderType: BorderType.Rect,
                            radius: Radius.circular(5),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              child: Text(
                                'OKGREENSFIRST50',
                                style: TextStyle(
                                  color: Const.orange,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          )
                        )


                      ],
                    ),
                  )

                ],
              )
            ),
          ),
        );
      },
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(5, 7, 5, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

}


