import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/ManageLocation.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/utility.dart';

class LocateMap extends StatefulWidget {

  var latLng;
  String addressLine2;

  LocateMap({this.addressLine2, this.latLng});
  @override
  _LocateMapState createState() => _LocateMapState();
}

class _LocateMapState extends State<LocateMap> {

  var text = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  Set<Marker> markers = Set();

  bool singleCard = false;

  CameraPosition _kGooglePlex;

  LatLng latLng;

 // TextEditingController textEditingController;
  String displayAddress="";

  var completeAddress;
  String pincode="";

  GoogleMapController controller;
  @override
  void initState() {
   // textEditingController = TextEditingController(text: widget.addressLine2);
    displayAddress = widget.addressLine2;
    super.initState();
    if(widget.latLng != null){
      latLng = widget.latLng;
      _kGooglePlex = CameraPosition(
        target: latLng,
        zoom: 14.4746,
      );
     // onMapTap(latLng);
    }else{
      _kGooglePlex = CameraPosition(
        target: LatLng(37.42796133580664, -122.085749655962),
        zoom: 14.4746,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset(
              'assets/OkAssets/LeftSideArrow.png',
              height: 25,
            ),
          ),
        ),
        title: Text('Locate on map', style: TextStyle(color: Const.textBlack),),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            markers: markers,
            onTap: onMapTap,
            myLocationEnabled: true,

            onMapCreated: (c) async {
              controller = c;
              if(widget.latLng != null){
                controller.animateCamera(CameraUpdate.newLatLng(latLng));
                onMapTap(latLng);
              }else {
                var add = await ManageLocation().findAddressesFromQuery(widget.addressLine2);
                controller.animateCamera(CameraUpdate.newLatLng(LatLng(add.coordinates.latitude, add.coordinates.longitude)));
                onMapTap(LatLng(add.coordinates.latitude, add.coordinates.longitude));
              }
            },
            initialCameraPosition: _kGooglePlex,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                child: InkWell(
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.search),
                        SizedBox(width: 10,),
                        new Flexible(child: Text(displayAddress,style: text,maxLines: 2,
                        ))
                      ],
                    ),
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.fromLTRB(5, 5, 30, 5),
                    margin: EdgeInsets.fromLTRB(0, 0, 40, 0),

                  ),onTap: (){
                  searchPlace();
                },
                )),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/OkAssets/locate-on-map.png',
                            height: 20,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Place pin on your location',
                            style: text,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                if (latLng != null) {
                                  checkLocation();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please pick a location");
                                }
                              },
                              color: Theme.of(context).primaryColor,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Save Address',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void searchPlace(){
    ManageLocation().placeAutoCompleteShow(context).then((_address){
      if(_address!=null){
        setState(() {
          displayAddress = _address.description;
          search();
        });
      }
    });
  }

  void search(){
    if(displayAddress != null && displayAddress.isNotEmpty) {
      ManageLocation().findAddressesFromQuery(displayAddress).then((add) {
        controller.animateCamera(CameraUpdate.newLatLng(LatLng(add.coordinates.latitude, add.coordinates.longitude)));
        onMapTap(LatLng(add.coordinates.latitude, add.coordinates.longitude));
      });
    }
  }

  void checkLocation() {
    ProgressDialog progressDialog = Utility.progressDialog(
        context, "Checking Delivery Location..");
    progressDialog.show();
    ApiCall().setLocation(pincode).then((apiResponseModel) {
      if(progressDialog != null && progressDialog.isShowing()){
        progressDialog.dismiss();
      }
      if (apiResponseModel.statusCode == 200) {
        Navigator.of(context).pop(completeAddress);
      } else {
        Fluttertoast.showToast(
            msg: "Delivery Location not available");
      }
    });
  }

  void onMapTap(LatLng argument) {
    _createMarkerImageFromAsset("assets/OkAssets/locate-on-map.png").then((b) {
      setState(() {
        markers.add(
          Marker(
            markerId: MarkerId('value'),
            icon: b,
            position: argument,
          ),
        );
        latLng = argument;
        ManageLocation().findAddressesFromCoordinates(Coordinates(argument.latitude, argument.longitude)).then((add) {
          setState(() {
            widget.addressLine2 = add.toString();
            displayAddress = add.addressLine;
            completeAddress = add;
            pincode = add.postalCode;
          });
        });
      });
    });
  }

  Future<BitmapDescriptor> _createMarkerImageFromAsset(String iconPath) async {
    ImageConfiguration configuration = ImageConfiguration();
    var bitmapImage =
        await BitmapDescriptor.fromAssetImage(configuration, iconPath);
    return bitmapImage;
  }
}
