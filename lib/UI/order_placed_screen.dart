
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/custom_stepper.dart' as s;
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/my_cart_screen.dart';
import 'package:vegetos_flutter/UI/order_items.dart';
import 'package:vegetos_flutter/UI/customer_support_1.dart';
import 'package:vegetos_flutter/UI/payment_option_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/Enumaration.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/GetOrderByIdResponseModel.dart';
import 'package:vegetos_flutter/models/temp.dart';

class   OrderPlacedScreen extends StatefulWidget
{

  String orderId;

  OrderPlacedScreen(this.orderId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderPlacedScreenState();
  }

}

class OrderPlacedScreenState extends State<OrderPlacedScreen> with SingleTickerProviderStateMixin
{

  TabController controller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(controller == null) {
      controller=new TabController(length: 2, vsync: this);
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffEDEDEE),
        /*bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: () {
              //Navigator.pushNamed(context, Const.paymentOption);
              Navigator.of(context).push(SlideLeftRoute(page: CustomerSupport1()));
            },
            child: Container(
              color: Const.primaryColor,
              height: 50.0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                    Image.asset('customer-support.png', height: 25,),

                    SizedBox(width: 10,),

                    Text('Customer Support', style: TextStyle(fontSize: 18.0, fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.w500, color: Colors.white),),
                  ],
                ),
              ),
            ),
          ),
        ),*/
        appBar: AppBar(
          backgroundColor: Const.appBar,
          elevation: 0,
          leading: InkWell(
            onTap: (){
              //Navigator.pop(context);
              Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: DashboardScreen()),(c)=>false);
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset('back.png', height: 25,),
            ),
          ),
          title: Text(
              'Order Placed'
          ),
          bottom: TabBar(
            //unselectedLabelColor: Colors.black,
            //indicatorColor: Colors.transparent,

            tabs: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text('Summary', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text('Items', style: TextStyle(
                fontWeight: FontWeight.w500,
                    fontSize: 16
                ),),
              )
            ],
            controller: controller,
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: DashboardScreen()),(c)=>false);
          },
          child: callGetOrderById(widget.orderId),
        ),
      ),

    );

  }
  
  Widget TabBody(GetOrderByIdResponseModel model) {
    return Container(
      child: TabBarView(
        children: <Widget>[
          Summary(model,controller),
          OrderItems(model),
        ],
        controller: controller,
      ),
    );
  }


  Widget callGetOrderById(String orderId) {
    return FutureBuilder(
      future: ApiCall().setContext(context).getOrderById(orderId),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if(apiResponseModel.statusCode == 200) {
            GetOrderByIdResponseModel responseModel = GetOrderByIdResponseModel.fromJson(apiResponseModel.Result);
//            GetOrderByIdResponseModelZ responseModelZ= GetOrderByIdResponseModelZ.fromJson(apiResponseModel.Result);
//            responseModelZ.toString();
            return TabBody(responseModel);
//            return Container(child: Center(child: Text("Not Working Now"),),);
          } else if(apiResponseModel.statusCode == 401) {
            return somethingWentWrong();
          } else {
            return somethingWentWrong();
          }
        } else if(snapshot.connectionState == ConnectionState.waiting) {
          return Container(child: Center(child: CircularProgressIndicator(),),);
        } else {
          return somethingWentWrong();
        }
      },
    );
  }

  Widget somethingWentWrong() {
    return InkWell(
      onTap: () {
        //callGetOrderById('');
      },
      child: Container(
        height: 275.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error, color: Colors.red, size: 25.0,),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
              child: Text("Items not loaded",
                  style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
  
}

class Summary extends StatefulWidget {

  GetOrderByIdResponseModel model;
  TabController controller;
  
  Summary(this.model,this.controller);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> with SingleTickerProviderStateMixin {

  var title= TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  var text = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xff2d2d2d)
  );

  var address = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  var currentStep=1;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    String day_ = widget.model.shippingOrder.shippingSchedule!=null && widget.model.shippingOrder.shippingSchedule.date!=null ? widget.model.shippingOrder.shippingSchedule.date : "";
     String day = day_.isNotEmpty ? DateFormat(EnumDateFormat.app).format(widget.model.shippingOrder.shippingSchedule.dateTime) : "";
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(top: 17, left: 15, bottom: 5),
              child: Text(
                'Delivery Slot', style: title,
              ),
            ),

           Container(
             color: Colors.white,
             child: Padding(
               padding: EdgeInsets.all(15),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[

                   Row(
                     children: <Widget>[
                       Expanded(
                         child: Text('Date', style: TextStyle(
                             fontWeight: FontWeight.w500,
                             color: Colors.grey,
                             fontSize: 12
                         ),),
                       ),
                       Expanded(
                         child: Text('Timeslot', style: TextStyle(
                             fontWeight: FontWeight.w500,
                             color: Colors.grey,
                             fontSize: 12
                         ),),
                       )
                     ],
                   ),

                   SizedBox(height: 5,),

                   Row(
                     children: <Widget>[
                       Expanded(
                         child: Text(day, style: text),
                       ),
                       Expanded(
                         child: Text(widget.model.shippingOrder.shippingSchedule.timeFrom + " - " +
                             widget.model.shippingOrder.shippingSchedule.timeTo, style: text),
                       )
                     ],
                   ),

                   Divider(
                     color: Colors.grey,
                   ),

                   Text('Status', style: TextStyle(
                       fontWeight: FontWeight.w500,
                       color: Colors.grey,
                       fontSize: 12
                   ),),

                   SizedBox(height: 5,),

                   SizedBox(
                     height: 100,
                     child: s.CustomStepper(
                       steps: [
                       s.Step(title: Text("Draft"),   isActive: true,state: s.StepState.start),
                       s.Step(title: Text("Confirmed"),state: currentStep>=1?s.StepState.complete:s.StepState.indexed,isActive: currentStep>=1,),
                       s.Step(title: Text("Dispatched",),state: currentStep>=2?s.StepState.complete:s.StepState.indexed,isActive: currentStep>=2),
                       s.Step(title: Text("Delivered"),state: currentStep==3?s.StepState.complete:s.StepState.complete,isActive: currentStep==3)
                     ],
                     type: s.StepperType.horizontal,
                     currentStep: currentStep,
                     ),
                   ),

                   Container(
                     alignment: Alignment.bottomRight,
                     child: InkWell(
                       onTap: (){
                        widget.controller.animateTo(1);

                       },
                       child:  Text(
                         "Items Details >>",
                         textAlign: TextAlign.end,style: TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 15,
                       ),

                       ),
                     ),

                   ),

                 ],
               ),
             ),
           ),


            Padding(
              padding: EdgeInsets.only(top: 17, left: 15, bottom: 5),
              child: Text(
                'Delivery Address', style: title,
              ),
            ),

            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(widget.model.shippingOrder.name, style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),),

                    Text(widget.model.shippingOrder.addressLine1 + widget.model.shippingOrder.addressLine2 +
                        widget.model.shippingOrder.city + " , " +  widget.model.shippingOrder.state + " , " +
                        widget.model.shippingOrder.country + " , " + widget.model.shippingOrder.pin, style: address,),
                    //Text('${PaymentOptionScreenState.addressModel.result.addressLine2}', style: address,),
                    //Text('${PaymentOptionScreenState.addressModel.result.city}', style: address,)

                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 17, left: 15, bottom: 5),
              child: Text(
                'Payment Details', style: title,
              ),
            ),

            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Order ID', style: text,),
                        Text(widget.model.orderId, style: text,),
                      ],
                    ),

                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Inovice number', style: text,),
                        Text(widget.model.invoiceNumber, style: text,),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Payment option', style: text,),
                        Text('Online', style: text,),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total Items', style: text,),
                        Text(widget.model.itemCount.toString() + ' Items', style: text,),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Delivery charges', style: text,),
                        Text(widget.model.shippingCharges.toString(), style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                        ),),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Discount/Promo', style: text,),
                        Text("-₹ " + widget.model.discount.toString(), style: text,),
                      ],
                    ),

                    SizedBox(height: 5,),

                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Wallet', style: text,),
                        Text('-₹0.0', style: text,),
                      ],
                    ),*/

                    SizedBox(height: 7,),

                    Divider(
                      color: Colors.grey,
                    ),

                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Sub Total', style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),),
                        Text("₹ " + widget.model.totalAmount.toString(), style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),),
                      ],
                    ),

                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10, left: 15, bottom: 5),
              child: Text(
                'Disclaimer:Please check the product at the time of delivery.', style: TextStyle(
                color: Colors.black54,
                fontSize: 10,
                fontWeight: FontWeight.w500
              ),
              ),
            ),

            SizedBox(height: 35,),

          ],
        ),
      ],
    );
  }
}
