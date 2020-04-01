import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/ManageLocation.dart';
import 'package:vegetos_flutter/Utils/Prefs.dart';

import 'dashboard_screen.dart';

class SetLocationManually extends StatefulWidget {
  @override
  _SetLocationManuallyState createState() => _SetLocationManuallyState();
}

class _SetLocationManuallyState extends State<SetLocationManually> {
  var wid = 1;

  bool falseResult = false;
  bool isProgress = false;

  @override
  void setState(fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/OkAssets/Search.png',
                          height: 25,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Set delivery Location',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xff009a00)),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for area, location or pincode',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 18),
                              contentPadding: EdgeInsets.only(bottom: 2),
                            ),
                            onChanged: (s) async {
                              /*var place = await PluginGooglePlacePicker.showAutocomplete(mode: PlaceAutocompleteMode.MODE_FULLSCREEN,
                                countryCode: "IN", typeFilter: TypeFilter.ESTABLISHMENT);
                            print(place);*/
                            },
                            onFieldSubmitted: (text) {
                              print(text);
                            },
                            onTap: () {
                              addressSearch();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                child: Visibility(
                  visible: isProgress,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Container(
                child: Visibility(
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
                        Container(
                          color: Color(0xff009a00),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 12, bottom: 12, left: 10, right: 10),
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
              ),
            ],
          ),
        ));
  }

  void showProgress(bool value) {
    setState(() {
      if (value) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
      isProgress = value;
    });
  }

  void callSetLocationApi(String pincode, String address) {
    ApiCall().setContext(context).setLocation(pincode).then((apiResponseModel) async {
      showProgress(false);
      if(apiResponseModel.statusCode == 200) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('BusinessLocationId', apiResponseModel.Result);
        sharedPreferences.setString(Prefs.DeliveryAddress, address);
        sharedPreferences.setString(Prefs.DeliveryAddressId, "");
        Navigator.of(context).pushAndRemoveUntil(EnterExitRoute(enterPage: DashboardScreen(), exitPage: SetLocationManually()), (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
        setState(() {
          falseResult = true;
        });
      }
    });
  }

  void addressSearch() async {
    ManageLocation().placeAutoCompleteShow(context).then((prediction) async {
      if(prediction != null) {
        showProgress(true);
        Address address = await ManageLocation().findAddressesFromQuery(prediction.description.toString());
        if(address!=null && address.postalCode != null && address.postalCode.isNotEmpty) {
          callSetLocationApi(address.postalCode, address.addressLine);
        } else {
          Fluttertoast.showToast(msg: 'Pincode detail not found.');
          showProgress(false);
        }
      } else {
        Fluttertoast.showToast(msg: 'Address not found.');
        showProgress(false);
      }
    });
  }
}
