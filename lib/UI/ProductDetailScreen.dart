
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/MyCartScreen.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class ProductDetailScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductDetailScreenState();
  }

}

class ProductDetailScreenState extends State<ProductDetailScreen>
{

  var pressed = false;
  bool descFlag = false;
  bool unitFlag = false;
  bool disclaimerFlag = false;
  bool shelfLifeFlag = false;
  bool termsFlag = false;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Washington Apple'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
            child: Icon(Icons.search, color: Colors.white,),
          ),
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
          ),


        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Const.gray_10,
          child: Column(
            children: <Widget>[
              productImageSlides(),
              Container(color: Colors.grey, height: 1.0,),
              nameAndPrice(),
              Container(color: Colors.grey, height: 1.0,),
              unitBar(),
              aboutProduct(),
              horizontalList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget productImageSlides()
  {
    List<Image> imageList = [
      Image.asset('assets/01-product.png', height: 100.0, width: 100.0,),
      Image.asset('assets/02-product.png', height: 100.0, width: 100.0,),
      Image.asset('assets/03-product.png', height: 100.0, width: 100.0,),
      Image.asset('assets/04-product.png', height: 100.0, width: 100.0,),
    ];

    return Stack(
      children: <Widget>[
        Container(
          height: 250.0,
          color: Colors.white,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                child: imageList[index],
              );
            },
          ),
        )
      ],
    );
  }

  Widget nameAndPrice()
  {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
            alignment: Alignment.centerLeft,
            child: Text('Washington Apple', style: TextStyle(fontSize: 20.0, fontFamily: 'GoogleSans', color: Colors.black,
                fontWeight: FontWeight.w800),),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('₹101 ',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('₹120 ',style: TextStyle(fontSize: 12.0, fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w500,
                      color: Colors.grey, decoration: TextDecoration.lineThrough),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 10.0),
                padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.orange
                ),
                child: Text('12% OFF',style: TextStyle(fontSize: 10.0, fontFamily: 'GoogleSans',
                    color: Colors.white),),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget unitBar()
  {
    _onSelected(int index) {
      setState(() => _selectedIndex = index);
    }

    var unitList = Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
              height: 50.0,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80.0,
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: _selectedIndex != null && _selectedIndex == index
                          ? Colors.orange
                          : Const.gray_10,
                    ),
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Container(
                            child: Text('500 GM', style: TextStyle(color: Colors.black, fontSize: 12.0, fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500)),
                          )
                        ],
                      ),
                      onTap: () {
                        _onSelected(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Const.primaryColor,
              ),
              alignment: Alignment.center,
              height: 40.0,
              child: Text('+ ADD', style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );



    return unitList;
  }

  Widget aboutProduct()
  {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            color: Const.gray_10,
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            height: 40.0,
            child: Column(
              children: <Widget>[
                Text('About Product', style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans', color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          description(),
          unit(),
          disclaimer(),
          shelfLife(),
          termsAndCondition(),
        ],
      ),
    );
  }

  Widget description()
  {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: Text('Description', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', color: Colors.black,
                      fontWeight: FontWeight.w500)),
                ),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      descFlag = !descFlag;
                      print(descFlag);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: descFlag ? Icon(Icons.keyboard_arrow_up, color: Colors.black,) :  Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                      )
                    ],
                  )
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Text(Const.product_detail_desc, maxLines: descFlag ? 20 : 2,
                  style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans', color: Const.dashboard_gray,
                      fontWeight: FontWeight.w500))
          ),

          Container(
            color: Colors.grey,
            height: 1.0,
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
          )
        ],
      ),
    );
  }

  Widget unit()
  {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: Text('Unit', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', color: Colors.black,
                      fontWeight: FontWeight.w500)),
                ),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      unitFlag = !unitFlag;
                      print(unitFlag);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: unitFlag ? Icon(Icons.keyboard_arrow_up, color: Colors.black,) :  Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                      )
                    ],
                  )
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('500 GM, 1KG', maxLines: unitFlag ? 20 : 2, textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans', color: Const.dashboard_gray,
                        fontWeight: FontWeight.w500)),
              )
          ),

          Container(
            color: Colors.grey,
            height: 1.0,
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
          )
        ],
      ),
    );
  }

  Widget disclaimer()
  {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: Text('Disclaimer', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', color: Colors.black,
                      fontWeight: FontWeight.w500)),
                ),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      disclaimerFlag = !disclaimerFlag;
                      print(disclaimerFlag);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: disclaimerFlag ? Icon(Icons.keyboard_arrow_up, color: Colors.black,) :  Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                      )
                    ],
                  )
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Const.product_detail_desc, maxLines: disclaimerFlag ? 20 : 2, textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans', color: Const.dashboard_gray,
                        fontWeight: FontWeight.w500)),
              )
          ),

          Container(
            color: Colors.grey,
            height: 1.0,
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
          )
        ],
      ),
    );
  }

  Widget shelfLife()
  {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: Text('Shelf Life', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', color: Colors.black,
                      fontWeight: FontWeight.w500)),
                ),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      shelfLifeFlag = !shelfLifeFlag;
                      print(shelfLifeFlag);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: shelfLifeFlag ? Icon(Icons.keyboard_arrow_up, color: Colors.black,) :  Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                      )
                    ],
                  )
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Const.product_detail_desc, maxLines: shelfLifeFlag ? 20 : 2, textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans', color: Const.dashboard_gray,
                        fontWeight: FontWeight.w500)),
              )
          ),

          Container(
            color: Colors.grey,
            height: 1.0,
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
          )
        ],
      ),
    );
  }

  Widget termsAndCondition()
  {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: Text('Terms & Conditions', style: TextStyle(fontSize: 16.0, fontFamily: 'GoogleSans', color: Colors.black,
                      fontWeight: FontWeight.w500)),
                ),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      termsFlag = !termsFlag;
                      print(termsFlag);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: termsFlag ? Icon(Icons.keyboard_arrow_up, color: Colors.black,) :  Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                      )
                    ],
                  )
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Const.product_detail_desc, maxLines: termsFlag ? 20 : 2, textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14.0, fontFamily: 'GoogleSans', color: Const.dashboard_gray,
                        fontWeight: FontWeight.w500)),
              )
          ),
        ],
      ),
    );
  }

  Widget horizontalList()
  {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
          child: Card(
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                      child: Text('Similar Products',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
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

  Widget childView(BuildContext context)
  {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context, SlideRightRoute(page: ProductDetailScreen()));
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

}