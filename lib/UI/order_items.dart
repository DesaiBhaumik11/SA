
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/my_cart_screen.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/GetOrderByIdResponseModel.dart';
import 'package:vegetos_flutter/models/OrderedItemsViewsModel.dart';
import 'package:vegetos_flutter/models/ProductPriceModel.dart';
import 'package:vegetos_flutter/models/UnitsModel.dart';
import 'package:vegetos_flutter/models/my_cart.dart';

class OrderItems extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderItemsState();
  }
  GetOrderByIdResponseModel model;

  OrderItems(this.model);
}

class OrderItemsState extends State<OrderItems>
{
  String ImageURL = '';
  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((prefs) {
      setState((){
        ImageURL = prefs.getString("ImageURL");
      });

    });

    super.initState();
  }
  @override
  void setState(fn) {
    // TODO: implement setState
    if(mounted) {
      super.setState(fn);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          itemChild()
        ],
      ),
    );
  }


  Widget itemSubChild(OrderItemsViewModel orderItemsViewsModel)
  {
    String unit = "";

    if(orderItemsViewsModel!=null) {
      if (orderItemsViewsModel.units != null &&
          orderItemsViewsModel.units.length > 0) {
        unit = orderItemsViewsModel.units[0].Name;
      }
    }


    var child = Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5,color: Const.allBOxStroke),
          color: Colors.white
        ),
        padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    //child: Image.network('assets/01-product.png', height: 100.0, width: 100.0,),
                    child: orderItemsViewsModel.productVariantMedia==null||orderItemsViewsModel.productVariantMedia.length<=0 ?Image.asset("02-product.png",height: 100,width: 100,):
                    Image.network(ImageURL + orderItemsViewsModel.productVariantMedia[0] + '&h=150&w=150', height: 110.0, width: 110.0,),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child: Text('${orderItemsViewsModel.productDetails!=null && orderItemsViewsModel.productDetails.length>0 ? orderItemsViewsModel.productDetails[0].Name : ""}', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                          color: Colors.black, fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child: Text(orderItemsViewsModel.minimumOrderQuantity!=0 ? orderItemsViewsModel.minimumOrderQuantity.toString() + " "+ unit : "", style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                          color: Const.dashboardGray, fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:1,
                            child: Row(
                              children: <Widget>[
                                orderItemsViewsModel.price!=null && orderItemsViewsModel.quantity!=0 && orderItemsViewsModel.minimumOrderQuantity!=0 ?
                                Container(
                                  margin: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('₹ ${orderItemsViewsModel.offerAmount.toString() +"x"+ (orderItemsViewsModel.quantity / orderItemsViewsModel.minimumOrderQuantity).round().toString() }',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                    ),
                                  ),
                                ): Container(),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                  child: Text('₹ ${orderItemsViewsModel.totalLineAmount!=null ? orderItemsViewsModel.totalLineAmount : ""}',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

    return child;
  }

  Widget itemChild()
  {
    var subChild =Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        Container(
//          alignment: Alignment.centerLeft,
//          margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
//          child: Text('Exotic', style: TextStyle(fontFamily: 'GoogleSans',
//              fontWeight: FontWeight.w500, color: Const.locationGrey),),
//        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.model.orderItemsViewsModel.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: itemSubChild(widget.model.orderItemsViewsModel[index]),
            );
          },
        ),
      ],
    );

    return subChild;
  }


  Widget cartItemList()
  {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
          child: Text('Items in your cart', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500),),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: cartItemList(),
              onTap: () {

              },
            );
          },
        )
      ],
    );
  }

  Widget cartItemChild()
  {
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/01-product.png', height: 100.0, width: 100.0,),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.orange
                      ),
                      child: Text('12% OFF',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
                          color: Colors.white),),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text('Cherry Tomatoes', style: TextStyle(fontSize: 17.0, fontFamily: 'GoogleSans',
                            color: Colors.black, fontWeight: FontWeight.w500),),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text('1 KG', style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                            color: Const.dashboardGray, fontWeight: FontWeight.w500),),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('₹101 ',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 10.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('₹120 ',style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey, decoration: TextDecoration.lineThrough),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Image.asset('assets/plus.png', height: 20.0, width: 20.0,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Text('1',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Image.asset('assets/minus.png', height: 20.0, width: 20.0,),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}