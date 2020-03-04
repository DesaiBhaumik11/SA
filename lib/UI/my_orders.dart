import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/order_placed_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/Enumaration.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/GetOrderByIdResponseModel.dart';
import 'package:vegetos_flutter/models/GetOrdersResponseModel.dart';
import 'package:vegetos_flutter/models/my_orders_modal.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  //MyOrdersModal myOrdersModal ;

  Future future;
   var text = TextStyle(
     fontWeight: FontWeight.w500,
   );

   @override
  void initState() {
    // TODO: implement initState
     future=ApiCall().setContext(context).getOrders();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    /*myOrdersModal = Provider.of<MyOrdersModal>(context) ;
    if(!myOrdersModal.loaded){
      myOrdersModal.getOrders();

    }*/

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset('assets/OkAssets/LeftSideArrow.png', height: 25,),
          ),
        ),

        title: Text(
            'My Orders',
                style: TextStyle(color: Const.textBlack),
        ),
      ),
      body: callGetOrdersAPI(),

    );
  }

  ListView buildList(List<GetOrderByIdResponseModel> result) {
    return ListView.builder(
      itemBuilder: (context, index) {
        GetOrderByIdResponseModel model = result[index];
        return InkWell(
          onTap: (){
            Navigator.push(context, EnterExitRoute(enterPage: OrderPlacedScreen(result[index].id,false)));
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
                        'InvoiceNumber:',style: text,
                      ),
                      Text(
                          '${model.invoiceNumber==null? '':model.invoiceNumber}', style: text,
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
                        '${model.transactionDate != null ? DateFormat(EnumDateFormat.dateMonth).format(model.transactionDate) : null}', style: text,
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
                        '₹ ${model.totalAmount}', style: text,
                      )
                    ],
                  ),

                  Divider(
                    color: Colors.black12,
                  ),
                  
                  Row(
                    children: <Widget>[


//                      Image.asset('order-confirmed.png', height: 22,),

                      Image.asset(displayOrderIcon(model.status), height: 20,),

                      SizedBox(width: 10,),

                      Text(Utility.displayOrderStatus(model.status,model.shippingOrder.shippingStatus),
                        style: TextStyle(
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
                          Navigator.push(context, EnterExitRoute(enterPage: OrderPlacedScreen(result[index].id,false)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Const.orange,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
      itemCount: result.length,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

  Widget callGetOrdersAPI() {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if(apiResponseModel.statusCode == 200) {
            List<GetOrderByIdResponseModel> getOrdersResponseModelList = GetOrderByIdResponseModel.parseList(apiResponseModel.Result);

            return buildList(getOrdersResponseModelList);
          } else if(apiResponseModel.statusCode == 401){
            return Container();
          } else {
            return Container();
          }
        } else if(snapshot.connectionState == ConnectionState.waiting) {
          return Container(child: Center(child: CircularProgressIndicator(),));
        } else {
          return Container();
        }
      },
    );
  }

  String displayOrderIcon(String status) {

   if(status== EnumOrderStatus.getString(OrderStatus.Ordered)) {
     return "assets/VegetosAssets/order-placed.png";
   }else if(status== EnumOrderStatus.getString(OrderStatus.Confirmed)){
     return "assets/VegetosAssets/order_confirmed.png";
   }else if(status== EnumOrderStatus.getString(OrderStatus.Cancelled)){
     return "assets/VegetosAssets/order_cancelled.png";
   }else {
     return "assets/VegetosAssets/order_delivered.png";
   }
//      case EnumOrderStatus.getString(OrderStatus.Ordered):
//        return "assets/order_confirmed.png";
//      case EnumOrderStatus.getString(OrderStatus.Ordered):
//        return "assets/order_cancelled.png";
//      case EnumOrderStatus.getString(OrderStatus.Ordered):
//        return "assets/order_delivered.png";
//      case EnumOrderStatus.getString(OrderStatus.Ordered):
//        return "assets/order_confirmed.png";
//      case EnumOrderStatus.getString(OrderStatus.Ordered):
//        return "assets/order_cancelled.png";
//      case EnumOrderStatus.getString(OrderStatus.Ordered):
//        return "assets/order_cancelled.png";
//      case EnumOrderStatus.getString(OrderStatus.Ordered):
//        return "assets/order_confirmed.png";
//      case EnumOrderStatus.getString(OrderStatus.Ordered):
//        return "assets/order_placed.png";
//    }
  }

   String displayOrderStatus(int status) {
     switch(status)
     {
       case 0:
         return "Order Draft";
       case 1:
         return "Order Pending";
       case 2:
         return "Order Failed";
       case 3:
         return "Ordered";
       case 4:
         return "Order Confirmed";
       case 5:
         return "Order Rejected";
       case 6:
         return "Order Cancelled";
       case 7:
         return "Order InTransit";
       case 8:
         return "Order Received";
     }
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

            Image.asset('assets/VegetosAssets/whoops.png', height: 180,),

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
                Navigator.push(context, EnterExitRoute(enterPage: DashboardScreen()));
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


