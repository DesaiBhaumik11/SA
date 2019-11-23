import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/tell_us_about.dart';
import 'package:vegetos_flutter/Utils/const.dart';

class ExpiredItems extends StatefulWidget {
  @override
  _ExpiredItemsState createState() => _ExpiredItemsState();
}

class _ExpiredItemsState extends State<ExpiredItems> {

  var title= TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  bool select = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: (){
            Navigator.push(context, SlideLeftRoute(page: TellUsAbout()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Proceed', style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),),
          ),
        ),
      ),
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
            'Expired items received'
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(top: 17, left: 15, bottom: 5),
            child: Text(
              'Please select the expired items', style: title,
            ),
          ),

          Expanded(
            child: buildList(context),
          )

        ],
      ),
    );
  }

  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
            onTap: (){
              setState(() {
                select = !select;
              });
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.fromLTRB(10.0, 10, 10.0, 10.0),
                child: Row(
                  children: <Widget>[

                    Checkbox(
                      activeColor: Const.orange,
                      value: select,
                      onChanged: (bool value){
                        setState(() {
                          select = value;
                        });
                      },
                    ),

                    SizedBox(),

                    Container(
                      margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: Image.asset('assets/01-product.png', height: 100.0, width: 100.0,),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                              child: Text('Cherry Tomatoes', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                                  color: Colors.black, fontWeight: FontWeight.w500),),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                              child: Text('1 KG', style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                                  color: Const.dashboardGray, fontWeight: FontWeight.w500),),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex:1,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text('₹45 x 1 ',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                          child: Text('₹45',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        );
      },
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }
}
