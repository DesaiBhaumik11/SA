import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Utils/const.dart';

import 'dashboard_screen.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  var title = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.grey
  );

  var text = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          FlatButton(
            onPressed: (){
              Navigator.push(context, EnterExitRoute(enterPage: DashboardScreen()));
            },
            child: Text(
              'Skip for now',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,

              ),
            ),
          )

        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[


            SizedBox(height: 70),


            Image.asset('profile.png', height: 170, ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Update Profile', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19
                ),),
              ],
            ),

            SizedBox(height: 7),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Get update your profile for better', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('app experience', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
              ],
            ),

            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only( top: 20),
                    child: Text(
                      'Full Name', style: title,
                    ),
                  ),

                  TextFormField(
                    style: text,
                    initialValue: "Parth Parekh",
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5)
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only( top: 20),
                    child: Text(
                      'Email Address', style: title,
                    ),
                  ),

                  TextFormField(
                    style: text,
                    initialValue: "Parth@test.in",
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5)
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only( top: 20),
                    child: Text(
                      'Referral code', style: title,
                    ),
                  ),

                  TextFormField(
                    initialValue: "ASFFRDF",
                    style: text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5)
                    ),
                  ),




                ],
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          Navigator.push(context, EnterExitRoute(enterPage: DashboardScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Update Profile', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),

            SizedBox(height: 50,),

          ],
        ),
      ),
    );
  }
}
