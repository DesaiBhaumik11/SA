import 'dart:ffi';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

import 'PaymentOptionScreen.dart';
import 'choose_address.dart';

class SetDeliveryDetails extends StatefulWidget {
  @override
  _SetDeliveryDetailsState createState() => _SetDeliveryDetailsState();
}

class _SetDeliveryDetailsState extends State<SetDeliveryDetails> {

  final List<String> day = ['S', 'M', 'T', 'W', 'T', 'F', 'S','S', 'M', 'T', 'W', 'T', 'F', 'S'];

  final List<int> date = [1, 2, 3,4, 5,6, 7,8, 9, 10, 11, 12, 13, 14];


  var tappedIndex = -1;

  int selectedRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }


  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  List<GroupModel> _group = [
    GroupModel(
      text: "Flutter.dev",
      index: 1,
    ),
    GroupModel(
      text: "Inducesmile.com",
      index: 2,
    ),
    GroupModel(
      text: "Google.com",
      index: 3,
    ),
    GroupModel(
      text: "Yahoo.com",
      index: 4,
    ),
  ];


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
          'Set Delivery Details'
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                width: double.infinity,

                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Text(
                            'Home', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                          ),


                          InkWell(
                            onTap: (){
                              Navigator.push(context, SlideLeftRoute(page: ChooseAddress()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffE36130),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                              ),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text('Change', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                                ),),
                              ),
                            ),
                          )



                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Text('Partho Parekh', style: TextStyle(
                          color: Color(0xff2d2d2d),
                          fontWeight: FontWeight.w400,
                          fontSize: 16
                      ),),

                      Text('Shayona Tilak 3, New SG Road, Gota,', style: TextStyle(
                          color: Color(0xff2d2d2d),
                          fontWeight: FontWeight.w400,
                          fontSize: 16
                      ),),

                      Text('Ahmedabad, Gujarat 38248', style: TextStyle(
                          color: Color(0xff2d2d2d),
                          fontWeight: FontWeight.w400,
                          fontSize: 16
                      ),),

                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Text('Set Delivery schedule', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),),
              ),

              Container(
                height: 80,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: Padding(
                  padding: EdgeInsets.only(top: 0, left: 10),
                  child: buildList(context),
                ),
              ),

              Container(
                color: Colors.white,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

  //                Container(
  //                  height: 1,
  //                  width: double.infinity,
  //                  color: Colors.black12,
  //                ),


                    RadioListTile(
                      value: 1,
                      groupValue: selectedRadioTile,
                      title: Text("7 AM - 11 AM", style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16
                      ),),

                      onChanged: (val) {
                        print("Radio Tile pressed $val");
                        setSelectedRadioTile(val);
                      },
                      activeColor: Color(0xffE36130),
                      selected: true,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                    ),

                    RadioListTile(
                      value: 2,
                      groupValue: selectedRadioTile,
                      title: Text("11 AM - 3 AM", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16
                      ),),

                      onChanged: (val) {
                        print("Radio Tile pressed $val");
                        setSelectedRadioTile(val);
                      },
                      activeColor: Color(0xffE36130),
                      selected: true,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                    ),

                    RadioListTile(
                      value: 3,
                      groupValue: selectedRadioTile,
                      title: Text("3 AM - 7 AM", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16
                      ),),

                      onChanged: (val) {
                        print("Radio Tile pressed $val");
                        setSelectedRadioTile(val);
                      },
                      activeColor: Color(0xffE36130),
                      selected: true,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                    ),

                    RadioListTile(
                      value: 4,
                      groupValue: selectedRadioTile,
                      title: Text("7 AM - 11 AM", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16
                      ),),

                      onChanged: (val) {
                        print("Radio Tile pressed $val");
                        setSelectedRadioTile(val);
                      },
                      activeColor: Color(0xffE36130),
                      selected: true,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                    ),


                  ],
                )
              ),



            ],
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {

            Navigator.push(context, SlideLeftRoute(page: PaymentOptionScreen()));
          },
          child: Container(
            color: Const.primaryColor,
            height: 50.0,
            child: Center(
              child: Text(
                'Procced to Payment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
            )
          ),
        ),
      ),
    );
  }

  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(

          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(left: 22, right: 21, top: 15),
              child: Text(
                day[index].toString(), style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey
              ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 2),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    tappedIndex = index;
                  });
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color:  tappedIndex == index
                          ? Color(0xffE36130)
                          : Color(0xfffffff),
                    borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                  child: Center(
                    child: Text(
                      date[index].toString(), style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: tappedIndex == index
                            ? Color(0xffffffff)
                            : Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        );
      },
      itemCount: 14,
      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
    );
  }
}


class GroupModel {
  String text;
  int index;
  GroupModel({this.text, this.index});
}

