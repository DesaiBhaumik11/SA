import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      body: Column(
        children: <Widget>[

          Container(
            width: double.infinity,
            height: 81,
            color: Color(0xff47870d),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image.asset('back.png', height: 25,),
                    ),
                  ),

                  Expanded(
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search...",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Colors.white
                        )
                      ),
                    ),
                  ),


                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            child: Image.asset('cart.png', height: 27,),
                            alignment: Alignment.center,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 0.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.orange,
                                radius: 8.0,
                                child: Text('3',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans', color: Colors.white)),
                              ),
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('4 Result Found', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),),
              ),

              FlatButton(
                onPressed: (){
                  _settingModalBottomSheet(context);
                },
                child: Row(
                  children: <Widget>[
                    Image.asset('filter.png', height: 15,),

                    SizedBox(width: 10,),

                    Text('Filter',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    )
                    
                  ],
                ),
              )

            ],
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

                        Text('₹101 ',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
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


void _settingModalBottomSheet(context){
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          color: Colors.white,
          child: new Wrap(
            children: <Widget>[


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  FlatButton(
                    onPressed: (){},
                    child: Row(
                      children: <Widget>[

                        Image.asset('selected-refine.png', height: 18 ,),

                        SizedBox(
                          width: 5,
                        ),

                        Text(
                          'Refine By',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        )

                      ],
                    ),
                  ),

                  FlatButton(
                    onPressed: (){},
                    child: Row(
                      children: <Widget>[

                        Image.asset('selected-refine.png', height: 18 ,),

                        SizedBox(
                          width: 5,
                        ),

                        Text(
                          'Sort By',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        )

                      ],
                    ),
                  )

                ],
              ),

              Divider(
                color: Colors.grey,
              ),

              Visibility(
                visible: true,
                child: Column(
                  children: <Widget>[


                  ],
                ),
              )


            ],
          ),
        );
      }
  );
}

