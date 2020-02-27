import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/set_location_manually.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/SetLocationResponseModel.dart';

import '../Utils/const.dart';

class SetDeliveryLocation extends StatefulWidget {
  @override
  _SetDeliveryLocationState createState() => _SetDeliveryLocationState();
}

class _SetDeliveryLocationState extends State<SetDeliveryLocation> {

  bool showProgress = false;
  bool falseResult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Center(
            child: Visibility(
              visible: !falseResult,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 52,),
                  Image.asset('delivery-location.png'),

                  SizedBox(
                    height: 15,
                  ),

                  Text(
                    'Set your delivery location', style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500
                  ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Color(0xff009a00),
                            onPressed: (){
//                              Utility.checkEnabledLocationService()==false ? Fluttertoast.showToast(msg: 'Location Service not Enabled') :
                              setState(() {
                                !showProgress ?
                                Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) async {
                                  final coordinates = new Coordinates(position.latitude, position.longitude);
                                  var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
                                  var first = addresses.first;
                                  print("${first.featureName} : ${first.addressLine}");
                                  if(first.postalCode != null && first.postalCode.isNotEmpty) {
                                    callSetLocationApi(first.postalCode, first.addressLine);
                                  } else {
                                    Fluttertoast.showToast(msg: 'Pincode detail not found.');
                                  }
                                }) : null;
                                showProgress = true;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12, bottom: 12),
                              child: Text(
                                'Use my location', style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                              ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          Navigator.push(context, EnterExitRoute(enterPage: SetLocationManually()));
                        },
                        child: Text(
                          'Set location Manually',
                          style: TextStyle(
                              color: Color(0xff393939),
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: falseResult,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Image.asset('no-result.png', height: 200,),

                  SizedBox(
                    height: 10,
                  ),

                  Text('Uh Oh! We don\'t deliver here.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 23,
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Text('Currently we are not providing services in this',
                    style: TextStyle(
                        color: Color(0xff2d2d2d),
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                    ),
                  ),

                  Text('city/ area/ society. Please try again with',
                    style: TextStyle(
                        color: Color(0xff2d2d2d),
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                    ),
                  ),

                  Text('some other locations.',
                    style: TextStyle(
                        color: Color(0xff2d2d2d),
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  RaisedButton(
                    color: Const.primaryColorGreen,
                    onPressed: () {
                      Navigator.of(context).push(EnterExitRoute(enterPage: SetLocationManually(), exitPage: SetDeliveryLocation()));
                      setState(() {
                        falseResult = false;
                        showProgress = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text(
                        'Set Delivery Location', style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                      ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Visibility(
            visible: showProgress,
            child: Column(
                children:<Widget>[Expanded(child: Container()), FlatButton(
                  child: CircularProgressIndicator(backgroundColor: Const.primaryColorGreen,),
                )]
            ),
          )
        ],
      )
    );
  }



  void callSetLocationApi(String pincode, String address) {
    ApiCall().setContext(context).setLocation(pincode).then((apiResponseModel) async {
      if(apiResponseModel.statusCode == 200) {
//        SetLocationResponseModel setLocationResponseModel = SetLocationResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('BusinessLocationId', apiResponseModel.Result);
        sharedPreferences.setString('BusinessId', apiResponseModel.Result);
        sharedPreferences.setString('FullAddress', address);
        Navigator.of(context).pushAndRemoveUntil(
            EnterExitRoute(enterPage: DashboardScreen(), exitPage: SetDeliveryLocation()),
                (Route<dynamic> route) => false);
      } else if (apiResponseModel.statusCode == 401) {
        setState(() {
          falseResult = true;
          showProgress = false;
        });
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
        setState(() {
          falseResult = true;
          showProgress = false;
        });
      }
    });
  }
}
