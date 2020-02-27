import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/CategoryWiseProductListScreen.dart';
import 'package:vegetos_flutter/UI/dashboard_screen.dart';
import 'package:vegetos_flutter/UI/search_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/CartCountModel.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart' as appfc;
import 'package:vegetos_flutter/models/categories_model.dart';

import 'my_cart_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoriesScreenState();
  }
}

class CategoriesScreenState extends State<CategoriesScreen> {

  String ImageURL = '';
  String cartTotal = '0';

  @override
  void setState(fn) {
    // TODO: implement setState
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        ImageURL = prefs.getString("ImageURL");
      });
    });
    count();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final CategoriesModel categoriesModel =
        Provider.of<CategoriesModel>(context);

    if (!categoriesModel.isLoaded) {
      categoriesModel.loadCategories();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Const.appBar,
        title: Text('All Categories'),
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
        actions: <Widget>[
          InkWell(
            child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
              child:
              Stack(
                children: <Widget>[
                  Align(
                    child: Icon(Icons.search),
                    alignment: Alignment.center,
                  ),

                ],
              ),
            ),
            onTap: () {
              Navigator.push(context, EnterExitRoute(enterPage: SearchScreen())).then((returnn){
                count();
              });
            },
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Icon(Icons.shopping_cart),
                    alignment: Alignment.center,
                  ),
                  cartTotal =="0" ? Container(margin: EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 0.0),) :
                  Container(
                    margin: EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 0.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 8.0,
                        child: Text("${cartTotal}",
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
            onTap: () {
              Navigator.push(context, SlideRightRoute(page: MyCartScreen())).then((returnn){
                count();
              });
            },
          )
        ],
      ),
      body: !categoriesModel.isLoaded
          ? Container()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (c, index) => Container(
                margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: InkWell(
                  onTap: () {
                    if (categoriesModel.result[index].subCategories.length >
                        0) {
                      categoriesModel.setSubVisibility(index);
                    }
                  },
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0)),
                              margin:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                child: categoriesModel.result[index].mediaId !=
                                        null
                                    ? Image.network(
                                        ImageURL +
                                            categoriesModel
                                                .result[index].mediaId +
                                            "&h=100&w=100",
                                        height: 90,
                                        width: 100,
                                      )
                                    : Image.asset(
                                        '02-product.png',
                                        height: 100.0,
                                        width: 100.0,
                                      ),
                              ),

                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                        categoriesModel.result[index].name !=
                                                null
                                            ? categoriesModel.result[index].name
                                            : '',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'GoogleSans',
                                            fontWeight: FontWeight.w500)),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0.0, 5.0, 10.0, 10.0),
                                    child: Text(
                                        categoriesModel.result[index]
                                                    .Description !=
                                                null
                                            ? categoriesModel
                                                .result[index].Description
                                            : '',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: 'GoogleSans',
                                            color: Const.dashboardGray)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          child: categoriesSubChild(
                              categoriesModel.result[index].subCategories,
                              context),
                          visible: categoriesModel.result[index].showSubs,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: categoriesModel.result.length,
            ),
    );
  }

  void count(){
    ApiCall().setContext(context).count().then((apiResponseModel){
      String cartTotalStr="0";
      if(apiResponseModel.statusCode == 200) {
        CartCountModel cartCountModel = CartCountModel.fromJson(apiResponseModel.Result);
        if(cartCountModel!=null && cartCountModel.count!=null) {
          cartTotalStr = cartCountModel.count.toString();
        }
      }else{
//        Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: LoginScreen()),(c)=>false);
      }
      setState(() {
        cartTotal = cartTotalStr;
      });
    });
  }

  Widget categoriesSubChild(
      List<Result> subCategoriesList, BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      crossAxisCount: 3,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(subCategoriesList.length, (index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(EnterExitRoute(
                enterPage: CategoryWiseProductListScreen(
                    subCategoriesList[index].id, subCategoriesList[index].name),
                exitPage: CategoriesScreen())).then((returnn){
                  count();
            });
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: subCategoriesList[index].mediaId == null ||
                          subCategoriesList[index].mediaId.isEmpty
                      ? Image.asset(
                          "02-product.png",
                          height: 70,
                          width: 70,
                        )
                      : Image.network(
                          "${ImageURL}${subCategoriesList[index].mediaId}",
                          height: 70.0,
                          width: 70.0,
                        ),
                ),
                Container(
                  child: Text(subCategoriesList[index].name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w300)
                  ),
                  alignment: Alignment.center,
                )
              ],
            ),
          ),
        );
      }),

//      children: <Widget>[
//        child,
//        child,
//        child,
//        child,
//      ],
    );
  }
}
