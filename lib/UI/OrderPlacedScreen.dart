
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/OrderItems.dart';
import 'package:vegetos_flutter/UI/OrderSummery.dart';
import 'package:vegetos_flutter/UI/customer_Support_1.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class OrderPlacedScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderPlacedScreenState();
  }

}

class OrderPlacedScreenState extends State<OrderPlacedScreen>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffEDEDEE),
        bottomNavigationBar: BottomAppBar(
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
        ),
        appBar: AppBar(
          backgroundColor: Color(0xff47870d),
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
              'Order Placed'
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.transparent,

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
          ),
        ),
        body:TabBarView(
          children: <Widget>[
            Summary(),
            OrderItems(),

          ],
        ),
      ),
    );

  }
  
}

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {

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


  @override
  Widget build(BuildContext context) {
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
                         child: Text('FRI 31 MAY 2019', style: text),
                       ),
                       Expanded(
                         child: Text('11 AM - 3 PM', style: text),
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

                   Row(
                     children: <Widget>[

                       Image.asset('order-placed.png', height: 20,),

                       SizedBox(width: 8,),

                       Text('Order Placed', style: text,),


                     ],
                   )

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

                    Text('Home', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),),

                    Text('Partho Parekh', style: address,),
                    Text('Shayona Tailak 3, New SG Road, Gota', style: address,),
                    Text('Ahmedabad, Gujrat 38248', style: address,)

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
                        Text('VEG123456789', style: text,),
                      ],
                    ),

                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Inovice number', style: text,),
                        Text('VEGINV123456', style: text,),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Payment option', style: text,),
                        Text('Debit Card', style: text,),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total Items', style: text,),
                        Text('3 Items', style: text,),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Delivery charges', style: text,),
                        Text('FREE', style: TextStyle(
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
                        Text('-₹62', style: text,),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Wallet', style: text,),
                        Text('-₹32', style: text,),
                      ],
                    ),

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
                        Text('₹308', style: TextStyle(
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
