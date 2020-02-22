
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/location_service_unavailable.dart';
import 'package:vegetos_flutter/UI/set_delivery_location.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/models/SetLocationResponseModel.dart';

import '../Utils/const.dart';
import 'dashboard_screen.dart';

class SetLocationManually extends StatefulWidget {
  @override
  _SetLocationManuallyState createState() => _SetLocationManuallyState();
}

class _SetLocationManuallyState extends State<SetLocationManually> {
  var wid=1;

  bool falseResult = false;
  bool isProgress = false;

  @override
  void setState(fn) {
    // TODO: implement setState
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    /*PluginGooglePlacePicker.initialize(
      androidApiKey: "AIzaSyAbnNcaXfrNc69sdUZCCExMmixYnrM3EXE",
      iosApiKey: "AIzaSyAbnNcaXfrNc69sdUZCCExMmixYnrM3EXE",
    );*/
    super.initState();
  }

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

                  /*InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image.asset('close.png', height: 17,),
                    ),
                  ),*/

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
                        color: Color(0xff009a00),
                        //onPressed: widget.s,
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
            ),

          ],
        ),
      )
    );
  }
  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return index==3?InkWell(
          onTap: (){
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
            });
          },
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

  void callSetLocationApi(String pincode, String address) {
    ApiCall().setContext(context).setLocation(pincode).then((apiResponseModel) async {
      if(apiResponseModel.statusCode == 200) {
//        SetLocationResponseModel setLocationResponseModel = SetLocationResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('BusinessLocationId', apiResponseModel.Result);
        sharedPreferences.setString('FullAddress', address);
        Navigator.of(context).pushAndRemoveUntil(
            EnterExitRoute(enterPage: DashboardScreen(), exitPage: SetLocationManually()),
                (Route<dynamic> route) => false);
      } else if (apiResponseModel.statusCode == 401) {
        setState(() {
          falseResult = true;
          isProgress = false;
        });
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
        setState(() {
          falseResult = true;
          isProgress = false;
        });
      }
    });
  }

  void addressSearch() async {

    const kGoogleApiKeyAndroid = "AIzaSyDj54G_XSDIigixDKuzC5tunS7ShSdr-kY";
    const kGoogleApiKeyIos = "AIzaSyDj54G_XSDIigixDKuzC5tunS7ShSdr-kY";

     PlacesAutocomplete.show(
        context: context,
        apiKey: Platform.isIOS ? kGoogleApiKeyIos : kGoogleApiKeyAndroid,
        hint: "Search for area, location or pincode",
         //components: [Component(Component.country, "fr")],
        onError: (e) {
          Fluttertoast.showToast(msg: e != null ? e.errorMessage.toString() : '');
        },
        mode: Mode.overlay, // Mode.fullscreen
       //logo: Image.asset('02-product.png'),
        language: "IN",
        ).then((p) async {
          if(p != null) {
            setState(() {
              FocusScope.of(context).requestFocus(FocusNode());
              isProgress = true;
            });
            print(p.description.toString());
            var addresses = await Geocoder.local.findAddressesFromQuery(p.description.toString());
            var first = addresses.first;
            if(first.postalCode != null && first.postalCode.isNotEmpty) {
              callSetLocationApi(first.postalCode, first.addressLine);
            } else if (first.coordinates.latitude != null && first.coordinates.longitude != null
                && first.coordinates.latitude != 0 && first.coordinates.longitude != 0) {
              var add = await Geocoder.local.findAddressesFromCoordinates(first.coordinates);
              var second = add.first;
              if(second.postalCode != null && second.postalCode.isNotEmpty) {
                callSetLocationApi(second.postalCode, second.addressLine);
              } else {
                Fluttertoast.showToast(msg: 'Pincode detail not found.');
              }
            } else {
              Fluttertoast.showToast(msg: 'Pincode detail not found.');
            }
          } else {
            //Fluttertoast.showToast(msg: 'Address not found.');
          }
     });
  }
}


