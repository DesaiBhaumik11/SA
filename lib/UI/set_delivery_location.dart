import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/set_location_manually.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/ManageLocation.dart';
import 'package:vegetos_flutter/Utils/Prefs.dart';

import '../Utils/const.dart';

class SetDeliveryLocation extends StatefulWidget {
  @override
  _SetDeliveryLocationState createState() => _SetDeliveryLocationState();
}

class _SetDeliveryLocationState extends State<SetDeliveryLocation> {
  bool falseResult = false;
  bool isProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              // color: Colors.grey,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    "assets/OkAssets/FarmBackground.png",
                  ))),
          child: Stack(
            children: <Widget>[
              Center(
                child: Visibility(
                  visible: !falseResult,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 52,
                      ),
                      Image.asset('assets/OkAssets/SetLocation.png'),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '',
                        //'Set your delivery location',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
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
                                onPressed: () {
                                  setCurrentLocation();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12),
                                  child: Text(
                                    'Use my location',
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
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
                            onPressed: () {
                              ManageLocation.locationPermission().then((value) {
                                if (value == false || value == null) {
                                  return;
                                } else {
                                  Navigator.push(
                                      context,
                                      EnterExitRoute(
                                          enterPage: SetLocationManually()));
                                }
                              });
                            },
                            child: Text(
                              'Set Manually',
                              style: TextStyle(
                                  color: Color(0xff393939),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
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
                      Image.asset(
                        'assets/OkAssets/Unservicebleareaerror.png',
                        height: 200,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Uh Oh! We don\'t deliver here.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 23,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Currently we are not providing services in this',
                        style: TextStyle(
                            color: Color(0xff2d2d2d),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(
                        'city/ area/ society. Please try again with',
                        style: TextStyle(
                            color: Color(0xff2d2d2d),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(
                        'some other locations.',
                        style: TextStyle(
                            color: Color(0xff2d2d2d),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RaisedButton(
                        color: Const.widgetGreen,
                        onPressed: () {
                          Navigator.of(context).push(EnterExitRoute(
                              enterPage: SetLocationManually(),
                              exitPage: SetDeliveryLocation()));
                          setState(() {
                            falseResult = false;
                            isProgress = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: Text(
                            'Set Delivery Location',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isProgress,
                child: Column(children: <Widget>[
                  Expanded(child: Container()),
                  Container(
                    child: CircularProgressIndicator(
                      backgroundColor: Const.iconOrange,
                    ),
                  )
                ]),
              )
            ],
          ),
        ));
  }

  void showProgress1(bool value) {
    setState(() {
      isProgress = value;
    });
  }

  void setCurrentLocation() async {
    bool locationPermission = await ManageLocation.locationPermission();
    if (locationPermission == false || locationPermission == null) {
      showProgress1(false);
    } else {
      showProgress1(true);
      Address address = await ManageLocation().getCurrentAddress();
      if (address != null &&
          address.postalCode != null &&
          address.postalCode.isNotEmpty) {
        callSetLocationApi(address.postalCode, address.addressLine);
      } else {
        Fluttertoast.showToast(msg: 'Pincode detail not found.');
        showProgress1(false);
      }
    }
  }

  void callSetLocationApi(String pincode, String address) {
    ApiCall()
        .setContext(context)
        .setLocation(pincode)
        .then((apiResponseModel) async {
      showProgress1(false);
      if (apiResponseModel.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(
            'BusinessLocationId', apiResponseModel.Result);
        sharedPreferences.setString(Prefs.DeliveryAddress, address);
        sharedPreferences.setString(Prefs.DeliveryAddressId, "");
        Navigator.of(context).pushAndRemoveUntil(
            EnterExitRoute(
                enterPage: DashboardScreen(), exitPage: SetLocationManually()),
            (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : '');
        setState(() {
          falseResult = true;
        });
      }
    });
  }
}
