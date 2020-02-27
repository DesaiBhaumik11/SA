
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
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
import 'package:vegetos_flutter/models/StatusMangement.dart';
import 'package:vegetos_flutter/models/temp.dart';

class   OrderPlacedScreen extends StatefulWidget
{

  String orderId;
  bool IsFromPayment;
  OrderPlacedScreen(this.orderId,this.IsFromPayment);

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
              if(widget.IsFromPayment) {
                Navigator.pushAndRemoveUntil(
                    context, EnterExitRoute(enterPage: DashboardScreen()), (
                    c) => false);
              }else{
                Navigator.pop(context);
              }
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
            if(widget.IsFromPayment) {
              Navigator.pushAndRemoveUntil(
                  context, EnterExitRoute(enterPage: DashboardScreen()), (
                  c) => false);
            }else{
              Navigator.pop(context);
            }
          },
          child: callGetOrderById(widget.orderId),
        ),
      ),

    );

  }
  
  Widget TabBody(GetOrderByIdResponseModel model,List<StatusManagement> statusManagements) {
    return Container(
      child: TabBarView(
        children: <Widget>[
          Summary(model,controller,statusManagements),
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
            List<StatusManagement> statusManagements =StatusManagement.getStatusMangement(responseModel.status, responseModel.shippingOrder.shippingStatus, responseModel.paymentStatus);
            return TabBody(responseModel,statusManagements);
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
  List<StatusManagement> statusManagements;
  
  Summary(this.model,this.controller,this.statusManagements);

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

  bool isCanCancelOrder=false;

  var currentStep=1;

 @override
  void initState() {
    // TODO: implement initState
   String status=widget.model.status;
   String shippingStatus=widget.model.shippingOrder.shippingStatus;
   if((status==EnumOrderStatus.Ordered || status==EnumOrderStatus.Confirmed) && shippingStatus==EnumShippingStatus.Pending){
     isCanCancelOrder=true;
   }
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
                     child: widget.statusManagements.length<=0 ? Container() : s.CustomStepper(
                       steps:
                       statusStep(widget.statusManagements),
//                       [
//                       s.Step(title: Text("Draft"),   isActive: true,state: s.StepState.start),
//                       s.Step(title: Text("Confirmed"),state: currentStep>=1?s.StepState.complete:s.StepState.indexed,isActive: currentStep>=1,),
//                       s.Step(title: Text("Dispatched",),state: currentStep>=2?s.StepState.complete:s.StepState.indexed,isActive: currentStep>=2),
//                       s.Step(title: Text("Delivered"),state: currentStep==3?s.StepState.complete:s.StepState.complete,isActive: currentStep==3)


//                     ],
                     type: s.StepperType.horizontal,
                     currentStep: widget.statusManagements.length-1,
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
                         color: Colors.green,
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
                        Text(widget.model.paymentMode, style: text,),
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


            !isCanCancelOrder ? Container() :
            GestureDetector(
              onTap: () {
                apiOrderCancellationRequestById(widget.model.id);
              },
              child: Container(
                color: Const.primaryColor,
                height: 50.0,
                child: Center(
                  child: Text(
                    'Cancel Order',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

 List<s.Step> statusStep(List<StatusManagement> list){
   List<s.Step> steps=new List();
   for(int i=0;i<list.length;i++){
     StatusManagement statusManagement=list.elementAt(i);
     steps.add(new s.Step(title: Text(statusManagement.status,maxLines: 2,textAlign: TextAlign.center,style: TextStyle(
         fontSize: 13,
         fontWeight: FontWeight.w500,
         color: Color(0xff2d2d2d),
     ),), state: statusManagement.state,isActive: statusManagement.isActive));
   }
   return steps;
 }
  void apiOrderCancellationRequestById(String transactionId) {
    ProgressDialog progressDialog = Utility.progressDialog(context, "");
    progressDialog.show();
    ApiCall().setContext(context).orderCancellationRequestById(transactionId).then((apiResponseModel) {
      if(progressDialog!=null && progressDialog.isShowing()){
        progressDialog.dismiss();
      }
      if(apiResponseModel.statusCode == 200) {
        GetOrderByIdResponseModel responseModel = GetOrderByIdResponseModel.fromJson(apiResponseModel.Result);
       Navigator.pop(context);
       Navigator.push(context, EnterExitRoute(enterPage: OrderPlacedScreen(responseModel.id,false)));
      } else if(apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : 'Something went wrong.!');
      }
    });
  }
}


