import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/add_new_address.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/models/address_modal.dart';
import 'package:vegetos_flutter/models/default_address.dart';

class MyAddresses extends StatefulWidget {
  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  AddressModal  addressModal ;
  DefaultAddressModel defaultAddressModel ;


  var address = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 15, color: Color(0xff2d2d2d));

  @override
  Widget build(BuildContext context) {
     addressModal=Provider.of<AddressModal>(context);

     if(defaultAddressModel==null){
       defaultAddressModel=Provider.of<DefaultAddressModel>(context);
     }


    if(!addressModal.loaded){
      addressModal.getMyAddresses();
      return Material(child: Center(child: CircularProgressIndicator(),),);
    }

    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
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
        title: Text('My Addresses'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: AddNewAddress(edit: false)));
            },
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'current-location.png',
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
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, bottom: 5),
            child: Text(
              'Saved Addresses',
              style: TextStyle(
                  color: Color(0xff2d2d2d),
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: buildList(context),
          )
        ],
      ),
    );
  }

  ListView buildList(BuildContext context) {

    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
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
                        addressModal.result[index].name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      addressModal.result[index].isDefault?
                      Image.asset(
                        'tick-orange.png',
                        height: 18,
                      ):Container(),


                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      PopupMenuButton(
                        itemBuilder: (c) => [/*"Edit", */"Delete","Set Default"]
                            .map((i) => PopupMenuItem(
                                    child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    if (i == "Edit") {
                                      Navigator.push(
                                          context,
                                          SlideLeftRoute(page: AddNewAddress(result:addressModal.result[index],edit: true)));
                                    } else if(i=="Delete"){
                                      showDialog(
                                          context: context,
                                          builder: (s) {
                                            return FunkyOverlay(addressModal.result[index].id);
                                          });
                                    }else{

                                      addressModal.defaultAddress = addressModal.result[index].name + " , " +
                                          addressModal.result[index].city ;

                                      addressModal.setDefaultAddress(addressModal.result[index].id) ;

                                      defaultAddressModel.loadAddress(context) ;

                                    }
                                  },
                                  title: Text(i),
                                )))
                            .toList(),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 15),
                          child: Image.asset(
                            'edit-pencil.png',
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
                    addressModal.result[index].name,
                    style: address,
                  ),
                  Text(
                    addressModal.result[index].addressLine1,
                    style: address,
                  ),
                  Text(
                    addressModal.result[index].addressLine2,
                    style: address,
                  )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: addressModal.result==null?0:addressModal.result.length,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
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
                          'cancel-subscription.png',
                          height: 150,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          Const.deleteAddressConfir,
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
                                  Provider.of<AddressModal>(context).deleteAddress(id,callback:(){
                                    Navigator.pop(context);
                                  });
                                //  Navigator.pop(context);
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
