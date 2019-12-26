import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/my_orders_modal.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  MyOrdersModal myOrdersModal ;

   var text = TextStyle(
     fontWeight: FontWeight.w500,
   );

  @override
  Widget build(BuildContext context) {
    myOrdersModal = Provider.of<MyOrdersModal>(context) ;

    if(!myOrdersModal.loaded){
      myOrdersModal.getOrders();
    }

    return Scaffold(
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
            'My Orders'
        ),
      ),
      body: myOrdersModal.result==null||
          myOrdersModal.result.length==0? Container(padding: EdgeInsets.all(10),
          height: 200
          ,child:Card(child:
          Center(
            child: Text('No Orders Avalable', style: TextStyle(color:Colors.black ,fontSize: 20.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
          ),
          )):buildList(context),
    );
  }

  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Order ID',style: text,
                      ),

                      Text(
                          'VEG123456789', style: text,
                      )
                    ],
                  ),

                  SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Order Placed',style: text,
                      ),

                      Text(
                        '25 MAy 2019', style: text,
                      )
                    ],
                  ),

                  SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Sub Total',style: text,
                      ),

                      Text(
                        '₹ 304', style: text,
                      )
                    ],
                  ),

                  Divider(
                    color: Colors.black12,
                  ),
                  
                  Row(
                    children: <Widget>[


//                      Image.asset('order-confirmed.png', height: 22,),

                      Image.asset('order-delivered.png', height: 20,),

                      SizedBox(width: 10,),

                      Text(
                        'Order Delivered', style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, Const.orderPlacedScreen);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Const.orange,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            child: Text('View details', style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 10
                            ),),
                          ),
                        ),
                      )
                      
                    ],
                  )

                ],
              ),
            ),
          ),
        );
      },
      itemCount: myOrdersModal.result==null?0:myOrdersModal.result.length ,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

}


class WhoopsOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Image.asset('whoops.png', height: 180,),

            SizedBox(
              height: 10,
            ),

            Text('Whoops!',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 23,
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Text('You haven\'t placed any orders yet.',
              style: TextStyle(
                  color: Color(0xff2d2d2d),
                  fontWeight: FontWeight.w500,
                  fontSize: 15
              ),
            ),


            SizedBox(
              height: 15,
            ),

            RaisedButton(
              color: Color(0xff009a00),
              onPressed: (){
                Navigator.pushNamed(context, Const.dashboard);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Text(
                  'Start Shopping', style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }








}
