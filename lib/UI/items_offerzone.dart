import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class ItemsOfferzone extends StatefulWidget {
  @override
  _ItemsOfferzoneState createState() => _ItemsOfferzoneState();
}

class _ItemsOfferzoneState extends State<ItemsOfferzone> {
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
            'June Sale'
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 2, 15, 2),
              child: Image.asset('filter.png', height: 23, width: 23, color: Colors.white,),
            ),
          )
        ],
      ),
      body: buildList(context),
    );
  }

  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){},
          child: Card(
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Image.asset('Cherry-Tomatoes.png', height: 100.0, width: 100.0,),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.orange
                          ),
                          child: Text('12% OFF',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
                              color: Colors.white),),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children: <Widget>[

                        Text('Cherry Tomatoes', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                            color: Colors.black, fontWeight: FontWeight.w500),),

                        SizedBox(
                          width: 5,
                        ),
                        Text('1 gm', style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                            color: Color(0xff6c6c6c), fontWeight: FontWeight.w500),),

                        SizedBox(
                          width: 5,
                        ),

                        Row(
                          children: <Widget>[
                            Text('₹101 ',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                            ),

                            Text('₹96',style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                            ),
                            ),


                          ],
                        ),

                        SizedBox(
                          width: 5,
                        ),

                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: (){

                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: <Widget>[

                                Icon(Icons.add, color: Colors.white, size: 18,),

                                Text('ADD', style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13
                                ),),

                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

}
