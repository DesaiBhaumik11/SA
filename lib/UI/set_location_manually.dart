import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/const.dart';
import 'location_service_unavailable.dart';

class SetLocationManually extends StatefulWidget {
  @override
  _SetLocationManuallyState createState() => _SetLocationManuallyState();
}

class _SetLocationManuallyState extends State<SetLocationManually> {
  var wid=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[


            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[

                  InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image.asset('search-icon.png', height: 20,),
                    ),
                  ),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          'Set delivery Location',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xff009a00)
                          ),
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search for area, location or pincode',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 18
                            ),
                            contentPadding: EdgeInsets.only(bottom: 2),

                          ),
                        )

                      ],
                    ),
                  ),

                  InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image.asset('close.png', height: 17,),
                    ),
                  ),

                ],
              ),
            ),

            Divider(
              color: Colors.grey,
            ),

            Expanded(
              child: wid==1?buildList(context):Center(child: LocationServiceUnavailable((){
                setState(() {
                  wid=1;
                });
              }),),
            ),

            Visibility(
              visible: wid==1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Const.dashboard);
                    },textColor: Color(0xff2d2d2d),
                    child: Text(
                      'Skip for now',
                     style: TextStyle(
                         color: Color(0xff2d2d2d),
                         fontSize: 15,
                         fontWeight: FontWeight.w500
                     ),
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      )
    );
  }
  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return index==3?InkWell(
          onTap: (){},
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
            child: Row(
              children: <Widget>[
                Image.asset('current-location.png', height: 18,),
                SizedBox(width: 10,),

                Text(
                  'Use my current location',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),
        )
            :Column(
          children: <Widget>[
            ListTile(
              onTap: (){
                setState((){
                  wid=2;
                });
              },
              title: Text('Vikasgruah Road', style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),),
              subtitle: Text(
                'Fatehpura, Paldi, Ahmedabad, Gujarat',
                style: TextStyle(
                    color: Color(0xff464646),
                    fontSize: 13,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black12,
            )
          ],
        );
      },
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }
}


