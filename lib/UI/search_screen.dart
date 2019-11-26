import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/product_common.dart';
import 'package:vegetos_flutter/models/search_products.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var wid = 1;
  Timer timer;

  bool search=false;
  @override
  Widget build(BuildContext context) {
    final SearchModel searchModel=Provider.of<SearchModel>(context);
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 81,
            color: Const.appBar,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
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
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (e){
                        search=true;
                        if(timer!=null){
                          timer.cancel();
                        }
                        timer=Timer(Duration(milliseconds: 500), (){
                          if(e.isEmpty){
                            searchModel.searching(false);
                          }else{
                            searchModel.searching(true);
                            searchModel.searchProducts(e);
                          }

                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search...",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Colors.white)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            child: Image.asset(
                              'cart.png',
                              height: 23,
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15.0, 15.0, 5.0, 0.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.orange,
                                radius: 8.0,
                                child: Text('3',
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontFamily: 'GoogleSans',
                                        color: Colors.white)),
                              ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Visibility(
                  visible: search &&searchModel.search &&searchModel.result!=null&&searchModel.result.length>0,
                  child: Text('${searchModel.result!=null?searchModel.result.length:"0"} Result Found',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  _settingModalBottomSheet(context);
                },
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'filter.png',
                      height: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Filter',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: !searchModel.search||!search?searchHistory(context):(searchModel.result==null||searchModel.result.length==0?Center(child: Text("No products"),):buildList(context,searchModel.result)),
          ),
        ],
      ),
    );
  }

  ListView buildList(BuildContext context, List<Result> result) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
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
                          child: Image.network(
                            "${result[index].productImage}",
                            height: 100.0,
                            width: 100.0,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.orange),
                          child: Text(
                            '12% OFF',
                            style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'GoogleSans',
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          result[index].seoTags,
                          style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'GoogleSans',
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${result[index].alertQuantity} gm",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'GoogleSans',
                              color: Color(0xff6c6c6c),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '₹100',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Text(
                                  'ADD',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: result.length,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

  ListView searchHistory(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          child: Card(
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'pomegranate-furit.png',
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Pomegranate',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'in',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff6c6c6c),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'Fruits & Vegatables',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SheetWid();
        });
  }
}

class Whoops extends StatefulWidget {
  @override
  _WhoopsState createState() => _WhoopsState();
}

class _WhoopsState extends State<Whoops> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 120),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'no-result.png',
              height: 140,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Whoops!',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Sorry!We could not find the product you were',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2d2d2d)),
            ),
            Text(
              'looking for. Please check out our \'categories\'',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2d2d2d)),
            ),
            Text(
              'for more options.',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2d2d2d)),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {},
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'Explore Catergory',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SheetWid extends StatefulWidget {
  @override
  _SheetWidState createState() => _SheetWidState();
}

class _SheetWidState extends State<SheetWid> {
  var slidePanel = 0;

  var tileTitle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);

  var radioTitle = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xff262626));

  bool newest = false;
  bool popularity = false;
  bool priceLow = false;
  bool priceHigh = false;

  bool buttons = false;

  List<String> _checked = [];

  List<String> _category = [];

  List<String> _discount = [];

  List<String> _price = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: new Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        slidePanel = 1;
                        buttons = true;
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Image.asset('selected-refine.png',
                            height: 18,
                            color: buttons ? Colors.black : Colors.grey),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Refine By',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: buttons ? Colors.black : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        slidePanel = 0;
                        buttons = false;
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'filter.png',
                          height: 18,
                          color: buttons ? Colors.grey : Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Sort By',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: buttons ? Colors.grey : Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          slidePanel == 0
              ? Column(
                  children: <Widget>[
                    CheckboxGroup(
                      labels: <String>[
                        "Newest arrival",
                        "Popularity",
                        "Price low ",
                        "Wednesday",
                      ],
                      checked: _checked,
                      labelStyle: radioTitle,
                      onChange: (bool isChecked, String label, int index) => print(
                          "isChecked: $isChecked   label: $label  index: $index"),
                      onSelected: (List selected) => setState(() {
                        if (selected.length > 1) {
                          selected.removeAt(0);
                        } else {}
                        _checked = selected;
                      }),
                    ),
//              InkWell(
//                onTap: (){
//                  setState(() {
//                    newest = !newest;
//                  });
//                },
//                child: Padding(
//                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
//                  child: Row(
//                    children: <Widget>[
//
//                      Checkbox(
//                        value: newest,
//                        activeColor: Theme.of(context).primaryColor,
//                        onChanged: (bool e){
//                          setState(() {
//                            newest = e;
//                          });
//                        },
//                        checkColor: Colors.white,
//                      ),
//
//                      Text(
//                        'Newest', style: tileTitle,
//                      ),
//
//                    ],
//                  ),
//                ),
//              ),
//
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 10),
//                child: Container(
//                  height: 1,
//                  width: double.infinity,
//                  color: Colors.black12,
//                ),
//              ),
//
//
//              InkWell(
//                onTap: (){
//                  setState(() {
//                    popularity = !popularity;
//                  });
//                },
//                child: Padding(
//                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
//                  child: Row(
//                    children: <Widget>[
//
//                      Checkbox(
//                        value: popularity,
//                        activeColor: Theme.of(context).primaryColor,
//                        onChanged: (bool e){
//                          setState(() {
//                            popularity = e;
//                          });
//                        },
//                        checkColor: Colors.white,
//                      ),
//
//                      Text(
//                        'Popularity', style: tileTitle,
//                      ),
//
//                    ],
//                  ),
//                ),
//              ),
//
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 10),
//                child: Container(
//                  height: 1,
//                  width: double.infinity,
//                  color: Colors.black12,
//                ),
//              ),
//
//              InkWell(
//                onTap: (){
//                  setState(() {
//                    priceLow = !priceLow;
//                  });
//                },
//                child: Padding(
//                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
//                  child: Row(
//                    children: <Widget>[
//
//                      Checkbox(
//                        value: priceLow,
//                        activeColor: Theme.of(context).primaryColor,
//                        onChanged: (bool e){
//                          setState(() {
//                            priceLow= e;
//                          });
//                        },
//                        checkColor: Colors.white,
//                      ),
//
//                      Text(
//                        'Price Low to High', style: tileTitle,
//                      ),
//
//                    ],
//                  ),
//                ),
//              ),
//
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 10),
//                child: Container(
//                  height: 1,
//                  width: double.infinity,
//                  color: Colors.black12,
//                ),
//              ),
//
//              InkWell(
//                onTap: (){
//                  setState(() {
//                    priceHigh = !priceHigh;
//                  });
//                },
//                child: Padding(
//                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
//                  child: Row(
//                    children: <Widget>[
//
//                      Checkbox(
//                        value: priceHigh,
//                        activeColor: Theme.of(context).primaryColor,
//                        onChanged: (bool e){
//                          setState(() {
//                            priceHigh = e;
//                          });
//                        },
//                        checkColor: Colors.white,
//                      ),
//
//                      Text(
//                        'Price Hign to Low', style: tileTitle,
//                      ),
//
//                    ],
//                  ),
//                ),
//              ),
//
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            color: Color(0xffced2d8),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                'Reset',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 270,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            ExpansionTile(
                              title: Text(
                                'Category',
                                style: tileTitle,
                              ),
                              children: <Widget>[
                                CheckboxGroup(
                                  labels: <String>[
                                    "Demo",
                                    "Demo1",
                                  ],
                                  checked: _category,
                                  labelStyle: radioTitle,
                                  onChange: (bool isChecked, String label,
                                          int index) =>
                                      print(
                                          "isChecked: $isChecked   label: $label  index: $index"),
                                  onSelected: (List selected) => setState(() {
                                    if (selected.length > 1) {
                                      selected.removeAt(0);
                                    } else {}
                                    _category = selected;
                                  }),
                                ),
                              ],
                            ),
                            ExpansionTile(
                              title: Text(
                                'Discount',
                                style: tileTitle,
                              ),
                              children: <Widget>[
                                CheckboxGroup(
                                  labels: <String>[
                                    "Demo",
                                    "Demo1",
                                  ],
                                  checked: _discount,
                                  labelStyle: radioTitle,
                                  onChange: (bool isChecked, String label,
                                          int index) =>
                                      print(
                                          "isChecked: $isChecked   label: $label  index: $index"),
                                  onSelected: (List selected) => setState(() {
                                    if (selected.length > 1) {
                                      selected.removeAt(0);
                                    } else {}
                                    _discount = selected;
                                  }),
                                ),
                              ],
                            ),
                            ExpansionTile(
                              title: Text(
                                'Price',
                                style: tileTitle,
                              ),
                              children: <Widget>[
                                CheckboxGroup(
                                  labels: <String>[
                                    "0-100",
                                    "101-500",
                                    "501-1000",
                                  ],
                                  checked: _price,
                                  labelStyle: radioTitle,
                                  onChange: (bool isChecked, String label,
                                          int index) =>
                                      print(
                                          "isChecked: $isChecked   label: $label  index: $index"),
                                  onSelected: (List selected) => setState(() {
                                    if (selected.length > 1) {
                                      selected.removeAt(0);
                                    } else {}
                                    _price = selected;
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text(
                                  'Apply',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RaisedButton(
                              color: Color(0xffced2d8),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text(
                                  'Reset',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
        ],
      ),
    );
  }
}
