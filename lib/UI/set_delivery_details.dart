import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/my_addresses.dart';
import 'package:vegetos_flutter/UI/my_cart_screen.dart';
import 'package:vegetos_flutter/models/AddressModel.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/CheckoutRequestModel.dart';
import 'package:vegetos_flutter/models/DisplayShippingModel.dart';
import 'package:vegetos_flutter/models/GetAllShippingSlotModel.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart' as cart;
import 'package:vegetos_flutter/models/TimeSlotListModel.dart';
import 'package:vegetos_flutter/models/default_address.dart';
import 'package:vegetos_flutter/models/my_cart.dart';
import 'package:vegetos_flutter/models/shipping_slot_modal.dart';

import 'payment_option_screen.dart';
import 'choose_address.dart';

class SetDeliveryDetails extends StatefulWidget {

  cart.GetCartResponseModel myCartModal;

  SetDeliveryDetails(this.myCartModal);

  @override
  _SetDeliveryDetailsState createState() => _SetDeliveryDetailsState(myCartModal);
}

class _SetDeliveryDetailsState extends State<SetDeliveryDetails> {

  cart.GetCartResponseModel myCartModal;

  _SetDeliveryDetailsState(this.myCartModal);

  ShippingSlotModal shippingSlotModal;
  //static DefaultAddressModel addressModel;
  var tappedIndex = 0;
  int tappedIndexForRadio = 0;
  int selectedRadioTile;
  bool defaultAddressFlag = false;

  List<DisplayShippingModel> displayShippingSlotList;
  Future shippingSchedule = ApiCall().getAllShippingSchedule();
  //Future getMyDefaultAddress = ApiCall().getMyDefaultAddress();

  bool isDefaultAddressAvailable = false;
  //bool isOnlyFirstTime = true;
  AddressModel addressModel;



  @override
  void initState() {
    updateAddress();
    super.initState();
    selectedRadioTile = 0;
  }

  @override
  Widget build(BuildContext context) {
    shippingSlotModal = Provider.of<ShippingSlotModal>(context);

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
        title: Text('Set Delivery Details'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              addressContainer(),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Text(
                  'Set Delivery schedule',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              callGetDeliveryDatesAPI(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: InkWell(
          onTap: () {

            if (displayShippingSlotList[tappedIndex].Items.length - 1 >=
                tappedIndexForRadio) {
              print("Selected Date : " +
                  displayShippingSlotList[tappedIndex].Key);
              print("Selected ID : " +
                  displayShippingSlotList[tappedIndex]
                      .Items[tappedIndexForRadio]
                      .Id);
              print("Selected TimeSlot : " +
                  displayShippingSlotList[tappedIndex]
                      .Items[tappedIndexForRadio]
                      .TimeFrom +
                  " - " +
                  displayShippingSlotList[tappedIndex]
                      .Items[tappedIndexForRadio]
                      .TimeTo);

              if (isDefaultAddressAvailable) {
                checkouFunction();
              } else {
                Utility.toastMessage("Please add dfault address");
              }
            } else {
              Fluttertoast.showToast(msg: 'Please select time slot');
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
                      color: Colors.white),
                ),
              )),
        ),
      ),
    );
  }

  ListView buildList(BuildContext context, List<DisplayShippingModel> displayShippingSlotList) {
    return ListView.builder(
      itemBuilder: (context, index) {
        DisplayShippingModel displayShippingModel =
            displayShippingSlotList[index];
        int date = displayShippingModel.keyDate.day;
        String day = DateFormat('EEEE').format(displayShippingModel.keyDate);
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 21, top: 15),
              child: Text(
                day.substring(0, 1),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 2),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    tappedIndex = index;
                  });
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: tappedIndex == index
                          ? Const.orange
                          : Color(0xfffffff),
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Center(
                    child: Text(
                      date.toString(),
                      style: TextStyle(
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

            //shippingList(context, displayShippingModel),
          ],
        );
      },
      itemCount: displayShippingSlotList.length,
      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
    );
  }

  Widget shippingList(BuildContext context, DisplayShippingModel displayShippingSlot) {
    return displayShippingSlot != null
        ? ListView.builder(
            itemBuilder: (context, index) {
              TimeSlotListModel timeSlotListModel =
                  displayShippingSlot.Items[index];
              return Column(
                children: <Widget>[
                  RadioListTile(
                    value: shippingSlotModal.checkedValue == index ? 0 : 1,
                    groupValue: selectedRadioTile,
                    title: Text(
                      timeSlotListModel.TimeFrom +
                          " - " +
                          timeSlotListModel.TimeTo,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    onChanged: (val) {
                      print("Radio Tile pressed $index");
                      shippingSlotModal.updateCheckedValue(index);
                      tappedIndexForRadio = index;
                      //setSelectedRadioTile(index);
                    },
                    activeColor: Const.orange,
                    selected:
                        shippingSlotModal.checkedValue == index ? true : false,
                  ),
                ],
              );
            },
            itemCount: displayShippingSlot.Items.length,
            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
          )
        : Container();
  }

  Widget addressContainer() {
    return isDefaultAddressAvailable ? Container(
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
                        addressModel.name == null
                            ? ""
                            : addressModel.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context, SlideLeftRoute(page: MyAddresses())).then((result) {
                                updateAddress();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Const.orange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              'Change',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "",
                    style: TextStyle(
                        color: Color(0xff2d2d2d),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  Text(
                    addressModel.addressLine1,
                    style: TextStyle(
                        color: Color(0xff2d2d2d),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  Text(
                    addressModel.addressLine2,
                    style: TextStyle(
                        color: Color(0xff2d2d2d),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ) : noAddress();
  }

  Widget noAddress() {
    return InkWell(
      child: Container(
          padding: EdgeInsets.all(10),
          height: 150,
          child: Card(
            child: Center(
              child: Text(
                'No Default Address Available plaese Select your Default Address',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w500),
              ),
            ),
          )),
      onTap: () {
        Navigator.push(
          context,
          EnterExitRoute(enterPage: MyAddresses()),
        ).then((result) {
          updateAddress();
        });
      },
    );
  }

  Widget callGetDeliveryDatesAPI() {
    displayShippingSlotList != null ? displayShippingSlotList.clear() : null;
    return FutureBuilder(
      future: shippingSchedule,
      builder: (contest, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if (apiResponseModel.statusCode == 200) {
            displayShippingSlotList =
                DisplayShippingModel.parseList(apiResponseModel.Result);

            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 80,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    child: buildList(context, displayShippingSlotList),
                  ),
                  Container(
                    color: Colors.white,
                    child: shippingList(
                        context, displayShippingSlotList[tappedIndex]),
                  ),
                ],
              ),
            );
          } else if (apiResponseModel.statusCode == 401) {
            return Container();
          } else {
            return Container();
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  void updateAddress() {
    ApiCall().getMyDefaultAddress().then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        AddressModel addModel = AddressModel.fromJson(apiResponseModel.Result);
        setState(() {
          isDefaultAddressAvailable = true;
          addressModel = addModel;
        });
      } else if(apiResponseModel.statusCode == 204) {
        setState(() {
          isDefaultAddressAvailable = false;
        });
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
        setState(() {
          isDefaultAddressAvailable = false;
        });
      }
    });
  }

  void checkouFunction() async {

    List<cart.CartItemViewModel> cartList = myCartModal.cartItemViewModels;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mobile = prefs.getString("phone");
    String businessLocationId = prefs.getString("BusinessLocationId");
    String businessId = prefs.getString("BusinessId");

    CheckoutRequestModel model = CheckoutRequestModel();
    model.DeliveryAddressId = addressModel.id;
    model.Name = addressModel.name;
    model.AddressLine1 = addressModel.addressLine1;
    model.AddressLine2 = addressModel.addressLine2;
    model.City = addressModel.city;
    model.State = addressModel.state;
    model.Country = addressModel.country;
    model.Pin = addressModel.pin;
    model.MobileNo = mobile;
    model.LocationId = businessLocationId;
    model.ShippingScheduleId = displayShippingSlotList[tappedIndex].Items[tappedIndexForRadio].Id;
    model.BusinessId = businessId;
    model.ShippingDetails = "No Details available";
    model.SubTotal = myCartModal.SubTotal.toString();
    model.TaxAmount = "0";
    model.TotalAmount = myCartModal.totalAmount.toString();
    model.OfferAmount = "0";
//    model.CheckoutItems = cartList;

    callCheckoutAPI(model);
  }

  void callCheckoutAPI(CheckoutRequestModel model) {
    ApiCall().checkout(model).then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        Navigator.push(
            context,
            SlideLeftRoute(
                page: PaymentOptionScreen(
                    displayShippingSlotList[tappedIndex]
                        .Items[tappedIndexForRadio]
                        .Id)));
      } else if(apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
      }
    });
  }
}
