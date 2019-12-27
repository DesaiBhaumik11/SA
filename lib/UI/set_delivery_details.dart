import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/my_addresses.dart';
import 'package:vegetos_flutter/UI/my_cart_screen.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/default_address.dart';
import 'package:vegetos_flutter/models/my_cart.dart';
import 'package:vegetos_flutter/models/shipping_slot_modal.dart';

import 'payment_option_screen.dart';
import 'choose_address.dart';

class SetDeliveryDetails extends StatefulWidget {
  @override
  _SetDeliveryDetailsState createState() => _SetDeliveryDetailsState();
}

class  _SetDeliveryDetailsState extends State<SetDeliveryDetails> {

  final List<String> day = List();
  final List<int> date = List();
  ShippingSlotModal shippingSlotModal ;
  static DefaultAddressModel addressModel;
  List<String> days=["S","M","T","W","T","F","S",];
  var tappedIndex = -1;
  int selectedRadioTile;
  bool defaultAddressFlag= false ;

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
    DateTime dateTime=DateTime.now();
    for(int a=0;a<30;a++)
      {
        date.add(dateTime.day);
        dateTime=dateTime.add(Duration(days: 1));
        day.add(days[dateTime.weekday-1]);
      }
  }


  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    shippingSlotModal=Provider.of<ShippingSlotModal>(context);
    if(addressModel==null){
      addressModel=Provider.of<DefaultAddressModel>(context);
    }
    if(!addressModel.loaded){
      addressModel.loadAddress(context);
    }else{
      if(addressModel.statusCode==200){
        defaultAddressFlag= true ;
      }
    }


    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      appBar: AppBar(
        backgroundColor: Const.appBar,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset('back.png', height: 25,),
          ),
        ),
        title: Text(
          'Set Delivery Details'
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              !addressModel.loaded?Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: SizedBox(height: 25,width: 35,child: CircularProgressIndicator(),)),
              ): defaultAddressFlag?
              Container(
                width: double.infinity,

                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            addressModel.result.name==null?"": addressModel.result.name, style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                          ),


                          InkWell(
                            onTap: (){
                              Navigator.push(context, SlideLeftRoute(page: MyAddresses()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Const.orange,
                                borderRadius: BorderRadius.all(Radius.circular(5))
                              ),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text('Change', style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                                ),),
                              ),
                            ),
                          )



                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Text("", style: TextStyle(
                          color: Color(0xff2d2d2d),
                          fontWeight: FontWeight.w400,
                          fontSize: 16
                      ),),

                      Text(addressModel.result.addressLine1, style: TextStyle(
                          color: Color(0xff2d2d2d),
                          fontWeight: FontWeight.w400,
                          fontSize: 16
                      ),),

                      Text(addressModel.result.addressLine2, style: TextStyle(
                          color: Color(0xff2d2d2d),
                          fontWeight: FontWeight.w400,
                          fontSize: 16
                      ),),

                    ],
                  ),
                ),
              ):
              InkWell(child: Container(padding: EdgeInsets.all(10),
                  height: 150
                  ,child:Card(child:
                  Center(
                    child: Text('No Default Address Available plaese Select your Default Address',
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(color:Colors.black ,fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),

                  ),
                  )),onTap: (){

                Navigator.pushNamed(context, Const.myAddresses,);

              },) ,

              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Text('Set Delivery schedule', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),),
              ),

              Container(
                height: 80,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: Padding(
                  padding: EdgeInsets.only(top: 0, left: 10),
                  child: buildList(context),
                ),
              ),

              Container(
                color: Colors.white,

                child:shippingList(context),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//
//  //                Container(
//  //                  height: 1,
//  //                  width: double.infinity,
//  //                  color: Colors.black12,
//  //                ),
//
//
//                 //   shipingListView() ,
//
//
//
//
//
//                    RadioListTile(
//                      value: 1,
//                      groupValue: selectedRadioTile,
//                      title: Text("7 AM - 11 AM", style: TextStyle(
//                        fontWeight: FontWeight.w500,
//                        color: Colors.black,
//                        fontSize: 16
//                      ),),
//
//                      onChanged: (val) {
//                        print("Radio Tile pressed $val");
//                        setSelectedRadioTile(val);
//                      },
//                      activeColor: Const.orange,
//                      selected: true,
//                    ),
//
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 15),
//                      child: Container(
//                        height: 1,
//                        width: double.infinity,
//                        color: Colors.black12,
//                      ),
//                    ),
//
//                    RadioListTile(
//                      value: 2,
//                      groupValue: selectedRadioTile,
//                      title: Text("11 AM - 3 AM", style: TextStyle(
//                          fontWeight: FontWeight.w500,
//                          color: Colors.black,
//                          fontSize: 16
//                      ),),
//
//                      onChanged: (val) {
//                        print("Radio Tile pressed $val");
//                        setSelectedRadioTile(val);
//                      },
//                      activeColor: Const.orange,
//                      selected: true,
//                    ),
//
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 15),
//                      child: Container(
//                        height: 1,
//                        width: double.infinity,
//                        color: Colors.black12,
//                      ),
//                    ),
//
//                    RadioListTile(
//                      value: 3,
//                      groupValue: selectedRadioTile,
//                      title: Text("3 AM - 7 AM", style: TextStyle(
//                          fontWeight: FontWeight.w500,
//                          color: Colors.black,
//                          fontSize: 16
//                      ),),
//
//                      onChanged: (val) {
//                        print("Radio Tile pressed $val");
//                        setSelectedRadioTile(val);
//                      },
//                      activeColor: Const.orange,
//                      selected: true,
//                    ),
//
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 15),
//                      child: Container(
//                        height: 1,
//                        width: double.infinity,
//                        color: Colors.black12,
//                      ),
//                    ),
//
//                    RadioListTile(
//                      value: 4,
//                      groupValue: selectedRadioTile,
//                      title: Text("7 AM - 11 AM", style: TextStyle(
//                          fontWeight: FontWeight.w500,
//                          color: Colors.black,
//                          fontSize: 16
//                      ),),
//
//                      onChanged: (val) {
//                        print("Radio Tile pressed $val");
//                        setSelectedRadioTile(val);
//                      },
//                      activeColor: Const.orange,
//                      selected: true,
//                    ),
//
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 15),
//                      child: Container(
//                        height: 1,
//                        width: double.infinity,
//                        color: Colors.black12,
//                      ),
//                    ),
//
//
//                  ],
//                )
              ),



            ],
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {

            //checkOutCall() ;

            if(defaultAddressFlag){
              Navigator.push(context, SlideLeftRoute(page: PaymentOptionScreen()));
            }else{
              Utility.toastMessage("Please add dfault address") ;
            }


          },
          child: Container(
            color: Const.primaryColor,
            height: 50.0,
            child: Center(
              child: Text(
                'Procced to Payment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
            )
          ),
        ),
      ),
    );
  }

  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(

          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(left: 22, right: 21, top: 15),
              child: Text(
                day[index].toString(), style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey
              ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 2),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    tappedIndex = index;
                  });
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                        color:  tappedIndex == index
                            ? Const.orange
                            : Color(0xfffffff),
                    borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                  child: Center(
                    child: Text(
                      date[index].toString(), style: TextStyle(
                        fontSize: 16,
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

          ],
        );
      },
      itemCount: date.length,
      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
    );
  }


  ListView shippingList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(

          children: <Widget>[
            RadioListTile(
              value: shippingSlotModal.checkedValue==index?0:1 ,
              groupValue: selectedRadioTile,
              title: Text("${shippingSlotModal.result[index].timeFrom} - ${shippingSlotModal
                  .result[index].timeTo}", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 16
              ),),

              onChanged: (val) {
                print("Radio Tile pressed $val");
                shippingSlotModal.updateCheckedValue(index);
                //setSelectedRadioTile(index);
              },
              activeColor: Const.orange,
              selected: shippingSlotModal.checkedValue==index ?true:false,
            ),


          ],
        );
      },
      itemCount: shippingSlotModal.result.length,
      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
    );
  }



  void checkOutCall() {
    SharedPreferences.getInstance().then((prefs){
      MyCartModal myCartModal = MyCartState.myCartModal ;
      ProgressDialog progressDialog  = Utility.progressDialog(context, "") ;
      progressDialog.show() ;
      NetworkUtils.postRequest(endpoint: Constant.Checkout  ,body: json.encode({

        "DeliveryAddressId": "${addressModel.result.id}",
        "Name": "${addressModel.result.name}",
        "AddressLine1": "${addressModel.result.addressLine1}",
        "AddressLine2": "${addressModel.result.addressLine2}",
        "City": "${addressModel.result.city}",
        "State": "${addressModel.result.state}",
        "Country": "${addressModel.result.country}",
        "Pin": "${addressModel.result.pin}",
        "MobileNo": "${prefs.getString("phone")}",
        "LocationId": "db9770e6-64f6-47d1-a986-9dd6a698ec83",
        "ShippingScheduleId": "f754b121-8082-4843-993a-c4f1a6442704",
        "BusinessId": "1e683706-2c1f-4d34-90a6-6afc796461fe",
        "ShippingDetails": "this is the shipping detail",
        "SubTotal": "${myCartModal.totalCost}",
        "TaxAmount": "2",
        "TotalAmount": "${myCartModal.totalCost}",
        "OfferAmount": "2",
        "CheckoutItems": MyCartState.myCartModal.result.cartItemViewModels ,

      })).then((res){
        print("checkOutCall Response $res") ;
        progressDialog.dismiss();
        var root = json.decode(res) ;

        if(root["Message"] =="Request successful."){
          Navigator.push(context, SlideLeftRoute(page: PaymentOptionScreen()));
        }else{
          Utility.toastMessage(root["Message"]) ;
        }
      }).catchError((e){
        print("checkOutCall catchError $e") ;
        progressDialog.dismiss();
      });

    }) ;


  }

}



