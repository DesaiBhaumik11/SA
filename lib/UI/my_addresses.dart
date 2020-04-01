import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/add_new_address.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/CommonWidget.dart';
import 'package:vegetos_flutter/Utils/Prefs.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/AddressModel.dart';
import 'package:vegetos_flutter/models/address_modal.dart';


class MyAddresses extends StatefulWidget {

  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {

  List<AddressModel> addressModels;
  String deliveryAddressId="";
  @override
  void initState() {
    // TODO: implement initState
    Prefs.getDeliveryAddressId().then((addressId){
      setState(() {
        deliveryAddressId = addressId;
      });
    });
    apiGetMyAddress();
    super.initState();
  }
  var address = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 15, color: Color(0xff2d2d2d));

  @override
  Widget build(BuildContext context) {

    if(addressModels==null){
      return Material(child: Center(child: CircularProgressIndicator(),),);
    }

    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15,),
            child: Image.asset(
              'assets/OkAssets/LeftSideArrow.png',
              height: 25,
            ),
          ),
        ),
        title: Text('My Addresses',style: TextStyle(color: Const.textBlack),),
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(height: 2, color: Const.allBOxStroke,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, SlideLeftRoute(page: AddNewAddress(result: new AddressModel(),edit: false))).then((addressModels_){
                  if(addressModels_ != null) {
                    AddressModel addressModel = addressModels_[0];
                    setState(() {
                      addressModels = addressModels_;
                      deliveryAddressId = addressModel.id;
                    });
                    Prefs.setDeliveryAddress(addressModel.addressLine1 + " , " + addressModel.addressLine2, addressModel.id);
                  }
                });
                },
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 20,top: 10, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/OkAssets/UseCurrantLocation.png',
                        height: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Add new address',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Const.widgetGreen,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 5),
              child: Text(
                'Saved Addresses',
                style: TextStyle(
                    color: Color(0xff2d2d2d),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ),
            addressModels!=null && addressModels.length>0 ?
            Expanded(child: buildList(context),):
            CommonWidget.noAddressAvailable(),
          ],
        ),
      ),
    );
  }

  ListView buildList(BuildContext context) {

    return ListView.builder(
      itemBuilder: (context, index) {
        AddressModel addressModel = addressModels[index];
        return InkWell(
          onTap: () {
            Prefs.setDeliveryAddress(addressModel.addressLine1+" , "+addressModel.addressLine2, addressModel.id).then((value){
              setState(() {
                deliveryAddressId = addressModel.id;
              });
            });
          },
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        addressModel.namePrefix != null && addressModel.namePrefix.isNotEmpty ?
                        addressModel.namePrefix +" "+addressModel.name :
                        addressModel.name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      addressModel.isDefault?
                      Image.asset(
                        'assets/OkAssets/Tick.png',
                        height: 18,
                      ):Container(),
                      SizedBox(
                        width: 4,
                      ),
                      deliveryAddressId.isNotEmpty && deliveryAddressId==addressModel.id ?
                      Image.asset(
                        'assets/OkAssets/locate-on-map.png',
                        height: 18,
                      ):Container(),

                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),

                      PopupMenuButton(
                        itemBuilder: (c) => ["Edit", "Delete","Set Default"]
                            .map((i) => PopupMenuItem(
                                    child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    if (i == "Edit") {
                                      Navigator.push(context, SlideLeftRoute(page: AddNewAddress(result: addressModel,edit: true))).then((addressModels_){
                                        if(addressModels_!=null) {
                                          setState(() {
                                            addressModels = addressModels_;
                                          });
                                        }
                                      });
                                    } else if(i == "Delete"){
                                      showDialog(
                                          context: context,
                                          builder: (s) {
                                            return FunkyOverlay(addressModel.id);
                                          }).then((value){
                                        if(value == true){
                                          apiDeleteAddress(addressModel.id);
                                        }
                                      });
                                    } else {
                                      apiSetMyDefaultAddress(addressModel.id);
                                    }
                                  },
                                  title: Text(i),
                                )))
                            .toList(),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 15),
                          child: Image.asset(
                            'assets/OkAssets/Edit.png',
                            height: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    addressModel.addressLine1,
                    style: address,
                  ),
                  Text(
                    addressModel.addressLine2,
                    style: address,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        addressModel.subLocality + " , " + addressModel.city + " , " + addressModel.pin,
                        style: address,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      addressModel.title!=null && addressModel.title.isNotEmpty ?
                      CommonWidget().buildNickAddress(context, addressModel.title) : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: addressModels == null ? 0 : addressModels.length,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

  void apiGetMyAddress(){
    ApiCall().setContext(context).getMyAddress().then((apiResponseModel){
      if(apiResponseModel.statusCode == 200){
        setState(() {
          addressModels = AddressModel.parseList(apiResponseModel.Result);
        });
      }else{
        setState(() {
          addressModels = new List();
        });
      }
    });
  }

  void apiGetMyDefaultAddress(){
    ApiCall().setContext(context).getMyDefaultAddress().then((apiResponseModel){
      if(apiResponseModel.statusCode==200){
        setState(() {
          addressModels = AddressModel.parseList(apiResponseModel.Result);
        });
      }
    });
  }

  void apiSetMyDefaultAddress(String addressId){
    ApiCall().setContext(context).setDefaultAddress(addressId).then((apiResponseModel){
      if(apiResponseModel.statusCode == 200){
        AddressModel addModel = AddressModel.fromJson(apiResponseModel.Result);
        Prefs.setDeliveryAddress(addModel.addressLine1+" , "+addModel.addressLine2, addModel.id).then((value){
          apiGetMyAddress();
        });
      }
    });
  }

  void apiDeleteAddress(String addressId){
    ApiCall().setContext(context).deleteAddress(addressId).then((apiResponseModel){
      if(apiResponseModel.statusCode==200) {
        List<AddressModel> addressModels_ = AddressModel.parseList(apiResponseModel.Result);
        if (addressModels_ != null && addressModels_.length > 0) {
          int idx = addressModels_.indexWhere((e) => e.isDefault == true);
          if (idx == -1) {
            apiSetMyDefaultAddress(addressModels_[0].id);
          } else {
            setState(() {
              addressModels = addressModels_;
            });
          }
        } else {
          Prefs.setDeliveryAddress("", "");
          setState(() {
            addressModels = new List();
          });
        }
      }else if(apiResponseModel.statusCode==204){
        Prefs.setDeliveryAddress("", "");
        setState(() {
          addressModels = new List();
        });
      }else {
        setState(() {
          addressModels;
        });
      }
    });
  }
}

class FunkyOverlay extends StatefulWidget {
  var id;

  FunkyOverlay(id){
    this.id=id;
  }

  @override
  State<StatefulWidget> createState() => FunkyOverlayState(id);
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  var id;
  FunkyOverlayState(id){
    this.id=id;
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Material(
          color: Colors.white,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 35),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/VegetosAssets/cancel-subscription.png',
                          height: 150,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          Const.deleteAddressConfirm,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  Navigator.pop(context,true);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            RaisedButton(
                                color: Const.greyLight,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
