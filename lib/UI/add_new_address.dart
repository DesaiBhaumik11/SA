import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/Utils/const.dart';
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

  var title =TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500);
  String fName;

  var tappedIndex = -1;

  var addressLine1,addressLine2,city;

  @override
  void initState() {
    super.initState();

    fName = widget.edit ? widget.result.name : '';
    addressLine1 = widget.edit ? widget.result.addressLine1 : '';
    addressLine2 = widget.edit ? widget.result.addressLine2 : '';
    city = widget.edit ? widget.result.city : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Const.appBar,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset(
              'back.png',
              height: 25,
            ),
          ),
        ),
        title: Text(widget.edit?"Edit Address":'Add New Address'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, SlideLeftRoute(page: LocateMap(latLng:widget.edit?LatLng(widget.result.latitude,widget.result.longitude):null))).then((latLng){
                    Result result=
                      Result(
                      id:          widget.edit?widget.result.id:  Uuid().v4(),
                      name:          fName,
                      contactId:    widget.edit?widget.result.contactId:  Uuid().v4(),
                      addressLine1:  addressLine1,
                      addressLine2:  addressLine2,
                      city:          "AMBD",
                      country:       "DEMO",
                      state:         "DEMO STATE",
                      pin:           "151204",
                      latitude:      latLng.latitude,
                      longitude:     latLng.longitude,
                      isDefault:     false
                    );
                   widget.edit? Provider.of<AddressModal>(context).updateAddress(result,callback: addressChanged()):
                   Provider.of<AddressModal>(context).addAddress(result,callback: addressChanged());
                  });
                },
                color: Theme.of(context).primaryColor,
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
      body: ListView(
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
                  onChanged: (e)=>fName=e,
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
                  onChanged: (e)=>addressLine1=e,
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
                  onChanged: (e)=>addressLine2=e,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 7)),
                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  'Locality',
                  style: title,
                ),

                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (s) {
                          return FunkyOverlay();
                        });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, right: 15),
                    child: Text(
                      '$city',
                      style: text,
                    ),
                  ),
                ),

                Divider(
                  color: Colors.black,
                ),

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

                Text(
                  'My Friends\'s Home',
                  style: text,
                ),
              ],
            ),
          )
        ],
      ),
    );
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
                    tappedIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: tappedIndex == index
                          ? Const.orange
                          : Color(0xffb8b8b8),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        'Home',
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
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
    );
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
                            'locality-not-found.png',
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
