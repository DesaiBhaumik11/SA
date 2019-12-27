import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';
import 'package:vegetos_flutter/models/best_selling_product.dart';
import 'package:vegetos_flutter/models/my_cart.dart';
import 'package:vegetos_flutter/models/product_common.dart' as bst;
import 'package:vegetos_flutter/models/product_detail.dart';
import 'package:vegetos_flutter/models/recommended_products.dart';
import 'package:vegetos_flutter/models/vegetos_exclusive.dart';

class AllProductScreen extends StatefulWidget {
  String name = "";

  AllProductScreen(String name) {
    this.name = name;
  }

  @override
  _AllProductScreenState createState() => _AllProductScreenState(name);
}

class _AllProductScreenState extends State<AllProductScreen> {
  MyCartModal myCartModal;
  static AppFirstModal appFirstModal;

  String name;

  _AllProductScreenState(String name) {
    this.name = name;
  }

  @override
  Widget build(BuildContext context) {
    appFirstModal = Provider.of<AppFirstModal>(context);
    myCartModal = Provider.of<MyCartModal>(context);
    final bestSelling = Provider.of<BestSellingProductModel>(context);
    final vegitosExclusive = Provider.of<VegetosExclusiveModel>(context);
    final recommendedProducts = Provider.of<RecommendedProductsModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${name}'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Const.gray10,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              name == "Best Selling Items"
                  ? bestSelling.loaded
                      ? horizontalList("Best Selling Items", bestSelling.result)
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                  : name == "Vegeto's Exclusive"
                      ? vegitosExclusive.loaded
                          ? horizontalList(
                              "Vegeto's Exclusive", vegitosExclusive.result)
                          : Container()
                      : recommendedProducts.loaded
                          ? horizontalList(
                              "Recommended for you", recommendedProducts.result)
                          : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget horizontalList(String s, List<bst.Result> products) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 150) / 2;
    final double itemWidth = size.width / 2;

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
          child: Card(
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    children: List.generate(products.length, (index) {
                      return childView(context, products[index]);
                    }),

//      children: <Widget>[
//        child,
//        child,
//        child,
//        child,
//      ],
                  ),

//                  ListView.builder(
//                      physics: BouncingScrollPhysics(),
//                      itemCount: products.length,
//                      scrollDirection: Axis.horizontal,
//                      itemBuilder: (context, index) {
//                        return childView(context,products[index]);
//                      }
//                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget childView(BuildContext context, bst.Result result) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            final ProductDetailModal productModal =
                Provider.of<ProductDetailModal>(context);
            showDialog(
                context: context,
                builder: (c) => Center(
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator())));
            productModal.getProductDetail(result.id, () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Const.productDetail);
            });
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
                          child: result.productMediaId == null ||
                                  result.productMediaId.isEmpty
                              ? Image.asset(
                                  "02-product.png",
                                  height: 100,
                                  width: 100,
                                )
                              : Image.network(
                                  "${appFirstModal.ImageUrl}${result.productMediaId}",
                                  height: 100.0,
                                  width: 100.0,
                                ),
                        ),
                        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
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
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                              result.name == null ? "Product" : result.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'GoogleSans',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${result.quantity} ${result.unit} ',
                        style: TextStyle(
                            fontSize: 11.0,
                            fontFamily: 'GoogleSans',
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
                          child: Text(
                            '₹ ${result.price}',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '₹120 ',
                            style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Const.primaryColor),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('+ ADD',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ),
                    onTap: () {
                      myCartModal.addTocart(result);
                    },
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
