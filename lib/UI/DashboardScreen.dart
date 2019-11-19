
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/CategoriesScreen.dart';
import 'package:vegetos_flutter/UI/MyCartScreen.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class DashboardScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        child: drawer(context),
      ),
      body: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget> [
            appBar(context),
          ];
        },
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            color: Const.gray10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                searchBar(context),
                adViewWidget(),
                for(int i = 0; i < 5; i++)
                  horizontalList()
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget appBar(BuildContext context)
  {
    return SliverAppBar(
      automaticallyImplyLeading: true,
      floating: true,
      pinned: false,
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context, SlideRightRoute(page: MyCartScreen()));
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: Stack(
              children: <Widget>[
                Align(
                  child: Icon(Icons.shopping_cart),
                  alignment: Alignment.center,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 0.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 8.0,
                      child: Text('88',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans', color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
      title: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Set Delivery Location',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans'),textAlign: TextAlign.left,)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('No Location Found',style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans'),),
                    Icon(Icons.error, color: Colors.red, size: 20.0,)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget searchBar(BuildContext context)
  {
    return Container(
      height: 50.0,
      color: Const.primaryColor,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.pushNamed(context, Const.categories);
                    Navigator.push(context, SlideRightRoute(page: CategoriesScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Text('Categories',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          color: Const.dashboardGray, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Const.searchScreen);
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            child: Icon(Icons.search, color: Const.dashboardGray,),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            child: Text('Search Product',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500, color: Const.dashboardGray)),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget adViewWidget()
  {
    List<Image> imageList = <Image> [
      Image.asset('assets/ad01.png', fit: BoxFit.fill,),
      Image.asset('assets/ad02.png', fit: BoxFit.fill,)
    ];

    return Container(
      height: 180.0,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 2,
        controller: null,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: imageList[index],
          );
        },
      ),
    );
  }

  Widget childView(BuildContext context)
  {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Const.productDetail);
          },
          child: Container(
            width: 180.0,
            height: 270.0,
            child: Card(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset('assets/product01.png', height: 100.0, width: 100.0,),
                        ),
                        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
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
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                    child: Text('Parle Monacco Cheeselings Classic',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('300 gm',style: TextStyle(fontSize: 11.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('₹101 ',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('₹120 ',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey, decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Const.primaryColor
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('+ ADD',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                        color: Colors.white, fontWeight: FontWeight.w500,)),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );

  }

  Widget horizontalList()
  {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
          child: Card(
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                      child: Text('Best Selling Items',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('view all',style: TextStyle(fontSize: 13.0, fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w500,
                              color: Colors.green)),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 275.0,
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return childView(context);
                      }
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget drawer(BuildContext context)
  {
    double textWidth = MediaQuery.of(context).size.width*0.5;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child:
        SafeArea(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.loginScreen);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/mobile.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('Login',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.0,
                color: Const.navMenuDevider,
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/address.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Location ',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black), overflow: TextOverflow.ellipsis,  maxLines: 1,),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                            child: Image.asset('assets/edit-pencil.png', height: 20.0, width: 20.0,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 5.0,
                color: Const.navMenuDevider,
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/home.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Home',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.myOrders);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/myorders.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('My Orders',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/my_subscription.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('My Subscriptions',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.myCart);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/mycart.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('My Cart',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.myAddresses);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/my_addressess.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('My Addresses',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/shared_cart.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Shared Cart',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 10.0,
                              child: Text('88',style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans', color: Colors.white)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/wallet_menu.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Wallet',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.offerzone);
                },
                child: Container(
                  height: 50.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Image.asset('assets/offerzone.png', height: 20.0, width: 20.0,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Text('Offerzone',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                              color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.0,
                color: Const.navMenuDevider,
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/customer_support_menu.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Customer Support',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/rate-us.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Rate Us',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/share.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Share',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/about-vegetos.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('About Vegetos',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/about-app.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('About App Release',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset('assets/logout.png', height: 20.0, width: 20.0,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Logout',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
                            color: Colors.black)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ,
    );
  }



}

/*
class _sliverAppbarDelegate extends SliverPersistentHeaderDelegate
{
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _sliverAppbarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return SizedBox.expand(child: child,);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_sliverAppbarDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return maxHeight != oldDelegate.maxExtent || minHeight != oldDelegate.minExtent || child != oldDelegate.child;
  }

}*/
