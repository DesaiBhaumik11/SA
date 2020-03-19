import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/Enumaration.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/address_modal.dart';

import 'locate_on_map.dart';

class AddNewAddress extends StatefulWidget {
  Result result;

  bool edit;

  AddNewAddress({this.result, this.edit});

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  int _radioValue1 = -1;

  var text = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);

  TextEditingController textEditingController;
  List<String> NickArray = ["HOME","OFFICE","OTHER"];

  var title =TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500);
  String namePrefix,fName;

  var tappedIndex = -1;

  String addressLine1,addressLine2,city,mainAddress,state,pin,nickAddress='';

  bool isDataFilled = false;

  @override
  void setState(fn) {
    // TODO: implement setState
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    textEditingController = TextEditingController(text: '');
    _radioValue1 = widget.result.namePrefix!=null && widget.result.namePrefix.isNotEmpty? EnumNamePrefix.getNamePrefixInt(widget.result.namePrefix) : -1;
    fName = widget.result.name!=null ? widget.result.name : '';
    mainAddress = widget.result.addressLine2!=null ? widget.result.addressLine2 : '';
    addressLine1 = widget.result.addressLine1!=null ? widget.result.addressLine1 : '';
    addressLine2 = widget.result.addressLine2!=null ? widget.result.addressLine2 : '';
    city = widget.result.city!=null ? widget.result.city : '';
    state = widget.result.state!=null ? widget.result.state : '';
    pin = widget.result.pin!=null ? widget.result.pin : '';
    if(widget.edit){
      nickAddress = widget.result.title !=null ? widget.result.title : '';
      if(nickAddress.isNotEmpty && !NickArray.contains(nickAddress.toUpperCase())){
        NickArray.add(nickAddress.toUpperCase());
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
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
        title: Text(widget.edit?"Edit Address":'Add New Address', style: TextStyle(color: Const.textBlack),),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                onPressed: () {

                  if(fName.isEmpty || addressLine1.isEmpty || addressLine2.isEmpty || _radioValue1 == -1 || city.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please fill the data to continue');
                    return;
                  }
                  checkLocation();
                },
                color: isDataFilled ? Theme.of(context).primaryColor : Colors.grey[500],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Next',
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
      ),
      body:
      ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Radio(
                value: 0,
                activeColor: Const.orange,
                groupValue: _radioValue1,
                onChanged: (int e) {
                  setState(() {
                    _radioValue1 = e;
                  });
                  validation();
                },
              ),
              new Text(
                'Mr.',
                style: text,
              ),
              SizedBox(
                width: 10,
              ),
              new Radio(
                value: 1,
                activeColor: Const.orange,
                groupValue: _radioValue1,
                onChanged: (int e) {
                  setState(() {
                    _radioValue1 = e;
                  });
                  validation();
                },
              ),
              new Text(
                'Mrs.',
                style: text,
              ),
              SizedBox(
                width: 10,
              ),
              new Radio(
                value: 2,
                activeColor: Const.orange,
                groupValue: _radioValue1,
                onChanged: (int e) {
                  setState(() {
                    _radioValue1 = e;
                  });
                  validation();
                },
              ),
              new Text(
                'Miss',
                style: text,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  color: Colors.grey,
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  'Full Name',
                  style: title,
                ),
                // Text(cart_prod_qty!=null?cart_prod_qty:'Default Value'),
                TextFormField(
                  initialValue: fName,
                  style: text,
                  onChanged: (e) {
                    setState(() {
                      fName=e;
                    });
                    validation();
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 7)
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  'Flat/House/Office',
                  style: title,
                ),

                TextFormField(
                  initialValue: addressLine1,
                  style: text,
                  onChanged: (e) {
                    setState(() {
                      addressLine1=e;
                    });
                    validation();
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 7)),
                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  'Street/Socity/Area',
                  style: title,
                ),

                TextFormField(
                  initialValue: addressLine2,
                  style: text,
                  onChanged: (e) {
                    setState(() {
                      addressLine2=e;
                    });
                    validation();
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 7)),
                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  'Locality *',
                  style: title,
                ),

              TextFormField(
                initialValue: city+" , "+state,
                style: text,
                onChanged: (e) {
                  setState(() {
                    city=e;
                  });
                  validation();
                },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 7)),
              ),


                SizedBox(
                  height: 20,
                ),

                Text(
                  'PinCode *',
                  style: title,
                ),

                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10,left: 10 ,right: 10),
                    child: Text(
                      '$pin',
                      style: text,
                    ),
                  ),
                ),

                Divider(
                  color: Colors.black,
                ),

//                InkWell(
//                  onTap: () {
//                    showDialog(
//                        context: context,
//                        builder: (s) {
//                          return FunkyOverlay();
//                        });
//                  },
//                  child: Padding(
//                    padding: EdgeInsets.only(top: 10, right: 15),
//                    child: Text(
//                      '$city',
//                      style: text,
//                    ),
//                  ),
//                ),

//                Divider(
//                  color: Colors.black,
//                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  'Nickname of your address',
                  style: title,
                ),

                Container(
                  height: 60,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: buildList(context),
                ),

                Text(
                  'Create your own label',
                  style: title,
                ),

                SizedBox(
                  height: 10,
                ),

                TextFormField(
                  style: text,
                  textCapitalization: TextCapitalization.sentences,
                  controller: textEditingController,
                  maxLength: 10,
                  onChanged: (e) {
                    setState(() {
                      nickAddress='';
                    });
                    validation();
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 7),

                  hintText: "My Friend's Home"),
                ),
              ],
            ),
          )
        ],
      ),
    );

  }

  void checkLocation() {
    ProgressDialog progressDialog = Utility.progressDialog(
        context, "Checking Delivery Location..");
    progressDialog.show();
    ApiCall().setLocation(pin).then((apiResponseModel) {
      if(progressDialog!=null && progressDialog.isShowing()){
        progressDialog.dismiss();
      }
      if (apiResponseModel.statusCode == 200) {
        Result result_=
        Result(
            id:            widget.edit?widget.result.id:  Uuid().v4(),
            namePrefix:    EnumNamePrefix.getNamePrefix(_radioValue1),
            name:          fName,
            contactId:     widget.edit?widget.result.contactId:  Uuid().v4(),
            addressLine1:  addressLine1,
            addressLine2:  addressLine2,
            city:          city,
            country:       widget.result.country,
            state:         state,
            pin:           widget.result.pin,
            title:         nickAddress.isNotEmpty ? nickAddress : textEditingController!=null ? textEditingController.text.toString() : '',
            latitude:      widget.result.latitude,
            longitude:     widget.result.longitude,
            isDefault:     widget.edit?widget.result.isDefault : true
        );
        widget.edit? Provider.of<AddressModal>(context).updateAddress(result_,callback: addressChanged()):
        Provider.of<AddressModal>(context).addAddress(result_,callback: addressChanged());
      } else {
        Fluttertoast.showToast(
            msg: "Delivery Location not available");
      }
    });
  }

  void setCurrentLoaciton() {
    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) async {
      final coordinates = new Coordinates(
          position.latitude, position.longitude);
//      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//      var first = addresses.first;
//      print("${first.featureName} : ${first.addressLine}");
      Geocoder.local.findAddressesFromCoordinates(coordinates).then((address) {
        Navigator.push(context, SlideLeftRoute(
            page: LocateMap(latLng: widget.edit ? LatLng(
                widget.result.latitude, widget.result.longitude) : null,
              addressLine2: mainAddress,))).then((address) {
          Address add = address;
          Result result =
          Result(
            //    id:        widget.edit?widget.result.id:  Uuid().v4(),
              name:          fName,
              // contactId:  widget.edit?widget.result.contactId:  Uuid().v4(),
              addressLine1:  addressLine1,
              addressLine2:  addressLine2,
              city:          add.subAdminArea,
              country:       add.countryName,
              state:         add.adminArea,
              pin:           add.postalCode,
              latitude:      add.coordinates.latitude,
              longitude:     add.coordinates.longitude,
              isDefault:     true
          );
        });
      });
    });
  }
  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 3, right: 3, top: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if(textEditingController!=null) {
                      textEditingController.text = '';
                    }
                    tappedIndex = index;
                    nickAddress=NickArray[index];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: nickAddress == NickArray[index]
                          ? Const.orange
                          : Color(0xffb8b8b8),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        NickArray[index],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: tappedIndex == index
                              ? Color(0xffffffff)
                              : Color(0xff000000),
                        ),
                      ),

                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      itemCount: NickArray.length,
      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
    );
  }

  void validation() {
    setState(() {
      if(_radioValue1 != -1 && fName.isNotEmpty && addressLine1.isNotEmpty && addressLine2.isNotEmpty && city.isNotEmpty) {
        isDataFilled = true;
      } else {
        isDataFilled = false;
      }
    });
  }

  addressChanged(){
    Navigator.pop(context) ;
  }

}

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Material(
          color: Colors.white,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 35,
                ),
                child: Wrap(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/VegetosAssets/locality-not-found.png',
                            height: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            Const.localitydialog1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            Const.localitydialog2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  'okay',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}