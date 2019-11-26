import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final CategoriesModel categoriesModel =Provider.of<CategoriesModel>(context);
    if(!categoriesModel.isLoaded){
      categoriesModel.loadCategories();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Const.appBar,
        title: Text('All Categories'),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset('back.png', height: 25,),
          ),
        ),
        actions: <Widget>[
          Container(
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
                      child: Text('88',
                          style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: 'GoogleSans',
                              color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: !categoriesModel.isLoaded?Container():ListView.builder(

        physics: BouncingScrollPhysics(),
        itemBuilder:(c,index)=> Container(
          margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: InkWell(
            onTap: () {
              categoriesModel.setSubVisibility(index);
            },
            child: Card(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: Image.asset(
                          'assets/vegitables.png',
                          height: 100.0,
                          width: 100.0,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(categoriesModel.result[index].name,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'GoogleSans',
                                      fontWeight: FontWeight.w500)),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 10.0),
                              child: Text(categoriesModel.result[index].id,
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
                  Visibility(child: categoriesSubChild(),
                  visible:categoriesModel.result[index].showSubs,)
                ],
              ),
            ),
          ),
        ),
        itemCount: categoriesModel.result.length,
      ),
    );
  }



  Widget categoriesSubChild() {
    var child = Container(
      margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: Column(
        children: <Widget>[

          Container(

            child: Image.asset(
              'assets/04-product.png',
              height: 70.0,
              width: 70.0,
            ),
          ),
          Container(
            child: Text(Const.categoryTitle,
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w300)),
            alignment: Alignment.center,
          )
        ],
      ),
    );

    return GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      crossAxisCount: 3,
      children: <Widget>[
        child,
        child,
        child,
        child,
      ],
    );
  }
}
