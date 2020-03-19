import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/ProductChildRow.dart';
import 'package:vegetos_flutter/Utils/MyCartUtils.dart';
import 'package:vegetos_flutter/Utils/utility.dart';
import 'package:vegetos_flutter/models/CartCountModel.dart';
import 'package:vegetos_flutter/models/CartManager.dart';
import 'package:vegetos_flutter/models/DashboardProductResponseModel.dart';
import 'package:vegetos_flutter/UI/product_detail_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';
import 'package:vegetos_flutter/models/ProductDetailsModel.dart';
import 'package:vegetos_flutter/models/ProductPriceModel.dart';
import 'package:vegetos_flutter/models/ProductVariantMedia.dart';
import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';
import 'package:vegetos_flutter/models/UnitsModel.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';
import 'package:vegetos_flutter/models/best_selling_product.dart';
import 'package:vegetos_flutter/models/my_cart.dart';
import 'package:vegetos_flutter/models/product_common.dart' as bst;
import 'package:vegetos_flutter/models/product_detail.dart';
import 'package:vegetos_flutter/models/recommended_products.dart';
import 'package:vegetos_flutter/models/vegetos_exclusive.dart';

import 'my_cart_screen.dart';

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

  Future getProduct;
  String cartTotal = '0';
  String ImageURL = '';

  int pageNUmber = 1;
  bool isFromOutside = false;
  int pageSize = 10;
  ProgressDialog progressDialog;

  bool isCountLoading = false;
  double cartNumber = 0;
  GetCartResponseModel model = GetCartResponseModel();
  Map<String, dynamic> cartHashMap;
  ManagerItemViewModel managerItemViewModel;

  _AllProductScreenState(String name) {
    this.name = name;
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (name == 'Best Selling Items') {
      getProduct = ApiCall()
          .bestSellingItems(pageNUmber.toString(), pageSize.toString());
    } else if (name == "Vegeto's Exclusive") {
      getProduct = ApiCall()
          .vegetosExclusive(pageNUmber.toString(), pageSize.toString());
    } else {
      getProduct = ApiCall()
          .recommendedForYou(pageNUmber.toString(), pageSize.toString());
    }

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        ImageURL = prefs.getString("ImageURL");
      });
    });
    managerForCart();
    super.initState();
  }

  void managerForCart() {
    CartManagerResponseModel().callGetMyCartAPI();
    CartManagerResponseModel.streamController.stream.listen((hashMap) {
      setState(() {
        this.cartHashMap = hashMap;
        count();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //appFirstModal=Provider.of<AppFirstModal>(context);
    //myCartModal=Provider.of<MyCartModal>(context);
    //final bestSelling=Provider.of<BestSellingProductModel>(context);
    //final vegitosExclusive=Provider.of<VegetosExclusiveModel>(context);
    //final recommendedProducts=Provider.of<RecommendedProductsModel>(context);

    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset(
              'assets/OkAssets/LeftSideArrow.png',
              height: 25,
            ),
          ),
        ),
        title: Text(
          '$name',
          style: TextStyle(color: Const.textBlack),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          InkWell(
            onTap: () {
              //myCartModal.loaded =false ;
              Navigator.push(context, SlideRightRoute(page: MyCartScreen()))
                  .then((returnn) {
                pageNUmber = 1;
                isFromOutside = true;
                count();
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              child: isCountLoading
                  ? new Align(
                      alignment: Alignment.center,
                      child: new Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 2,
                        ),
                      ))
                  : Stack(
                      children: <Widget>[
                        Align(
                          child: Image.asset(
                            "assets/OkAssets/Mycart.png",
                            height: 28,
                            width: 28,
                          ),
                          alignment: Alignment.center,
                        ),
                        cartTotal == "0"
                            ? Container(
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 0.0),
                              )
                            : Container(
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 0.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                    backgroundColor: Const.widgetGreen,
                                    radius: 8.0,
                                    child: Text(cartTotal,
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            productList(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget childView(
      BuildContext context, ProductWithDefaultVarientModel productVariant) {

    String name = "";
    String unit = "";
    bool isAvailableInCart = false;
    int quantity = 0;

    for (int i = 0; i < productVariant.ProductDetails.length; i++) {
      if (productVariant.ProductDetails[i].Language == "En-US") {
        name = productVariant.ProductDetails[i].Name;
        break;
      }
    }

    for (int i = 0; i < productVariant.Units.length; i++) {
      if (productVariant.Units[i].Language == "En-US") {
        unit = productVariant.Units[i].Name;
        break;
      }
    }

    ProductPriceModel ProductPrice = new ProductPriceModel();
    ProductDetailsModel ProductDetail = new ProductDetailsModel();
    UnitsModel Units = new UnitsModel();
    ProductVariantMedia productVariantMedia = new ProductVariantMedia();

    if (productVariant != null &&
        cartHashMap != null &&
        cartHashMap.containsKey(productVariant.ProductId)) {
      this.managerItemViewModel = cartHashMap[productVariant.ProductId];

      productVariant.itemId = managerItemViewModel.itemId;

      quantity = productVariant.MinimumOrderQuantity;

//      if (productVariant.MinimumOrderQuantity >= 1000) {
//        quantity = productVariant.MinimumOrderQuantity / 1000;
//        unit = "Kg";
//      } else {
//        quantity = productVariant.MinimumOrderQuantity.floorToDouble();
//      }
      this.cartNumber = managerItemViewModel.quantity /
          managerItemViewModel.minimumOrderQuantity;

      if (productVariant.ProductPrice != null) {
        ProductPrice.OfferPrice = productVariant.ProductPrice.OfferPrice;
        ProductPrice.Price = productVariant.ProductPrice.Price;
        ProductPrice.DiscountPercent = productVariant.ProductPrice.DiscountPercent;
      }

      isAvailableInCart = true;
    } else {
      if (productVariant.ProductDetails != null &&
          productVariant.ProductDetails.length > 0) {
        ProductDetail = productVariant.ProductDetails[0];
      }

      if (productVariant.Units != null && productVariant.Units.length > 0) {
        Units = productVariant.Units[0];
      }

      quantity = productVariant.MinimumOrderQuantity;

      if (productVariant.ProductPrice != null) {
        ProductPrice.OfferPrice = productVariant.ProductPrice.OfferPrice;
        ProductPrice.Price = productVariant.ProductPrice.Price;
        ProductPrice.DiscountPercent =
            productVariant.ProductPrice.DiscountPercent;
      }

      isAvailableInCart = false;
    }

    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                    context,
                    EnterExitRoute(
                        enterPage:
                            ProductDetailScreen(productVariant.ProductId)))
                .then((returnn) {
              pageNUmber = 1;
              isFromOutside = true;
              count();
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
            decoration: BoxDecoration(
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              border: new Border.all(
                                  color: Colors.grey[500],
                                  width: 0.5,
                                  style: BorderStyle.solid),
                              color: Colors.white),
                          child: productVariant.PrimaryMediaId == null ||
                                  productVariant.PrimaryMediaId.isEmpty
                              ? Image.asset(
                                  "assets/VegetosAssets/02-product.png",
                                  height: 100,
                                  width: 100,
                                )
                              : Image.network(
                                  ImageURL +
                                      productVariant.PrimaryMediaId +
                                      '&h=150&w=150',
                                  height: 110.0,
                                  width: 110.0,
                                ),
                        ),
                      ),
                      ProductPrice.DiscountPercent != null &&
                              ProductPrice.DiscountPercent != 0.0
                          ? Container(
                              margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                              padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.0),
                                  color: Colors.orange),
                              child: Text(
                                ProductPrice.DiscountPercent != null
                                    ? ProductPrice.DiscountPercent.toString() + ' %'
                                    : '0 %',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'GoogleSans',
                                    color: Colors.white),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(name,
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
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      quantity.toString() + " " + unit,
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
                          '₹ ${ProductPrice.OfferPrice != null ? ProductPrice.OfferPrice.toString() : 0}',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    ProductPrice.DiscountPercent != null &&
                            ProductPrice.DiscountPercent != 0
                        ? Container(
                            margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                ProductPrice.Price != null
                                    ? '₹' + ProductPrice.Price.toString()
                                    : 0,
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'GoogleSans',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                !isAvailableInCart ?
                InkWell(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5.0, 8.0, 10.0, 8.0),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Const.primaryColor),
                    child: Text('+ ADD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  onTap: () {
                    addToCart(
                        productVariant.ProductId,
                        productVariant.IncrementalStep.toString(),
                        "",
                        ProductPrice.Price.toString(),
                        ProductPrice.OfferPrice.toString());
                  },
                ) :
                Visibility(
                  visible: true,
                  child: Expanded(
                    flex: 0,
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (managerItemViewModel.quantity ==
                                managerItemViewModel.incrementalStep) {
                              deleteCartItem(productVariant.itemId);
                            } else {
                              updateCartQuantity(
                                  productVariant.itemId,
                                  (managerItemViewModel.quantity -
                                      managerItemViewModel.incrementalStep)
                                      .toString());
                            }
                          },
                          child: Container(
                            margin:
                            EdgeInsets.fromLTRB(5.0, 8.0, 10.0, 8.0),
                            child: Image.asset(
                              'assets/OkAssets/minus.png',
                              height: 20.0,
                              width: 20.0,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.fromLTRB(5.0, 8.0, 10.0, 8.0),
                          child: Text(cartNumber.round().toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            updateCartQuantity(
                                productVariant.itemId,
                                (managerItemViewModel.quantity +
                                    managerItemViewModel.incrementalStep)
                                    .toString());
                          },
                          child: Container(
                            margin:
                            EdgeInsets.fromLTRB(5.0, 8.0, 10.0, 8.0),
                            child: Image.asset(
                              'assets/OkAssets/plus.png',
                              height: 20.0,
                              width: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  ///------------------------Add Cart Quantity----------------------------------///

  void addToCart(productId, qty, offerId, amount, offerAmount) {
    setState(() {
      isCountLoading = true;
    });
    CartManagerResponseModel().addToCart(productId, qty, offerId, amount, offerAmount).then((apiResponse) {
      setState(() {
        isCountLoading = false;
      });
      count();
    });
  }

  ///--------------------Update Cart Quantity----------------------------------///

  void updateCartQuantity(String itemId, String quantity) {
    setState(() {
      isCountLoading = true;
    });

    CartManagerResponseModel()
        .updateCartQuantity(itemId, quantity)
        .then((apiResponseModel) {
      setState(() {
        isCountLoading = false;
      });
      count();
    });
  }

  ///--------------------Delete Cart Quantity----------------------------------///

  void deleteCartItem(String itemId) {
    setState(() {
      isCountLoading = true;
    });
    CartManagerResponseModel().deleteCartItem(itemId).then((apiResponseModel) {
      setState(() {
        isCountLoading = false;
      });
      count();
    });
  }

  ///-----------------------------------Cart Count-----------------------------///

  void count() {
    setState(() {
      isCountLoading = false;
    });
    ApiCall().setContext(context).count().then((apiResponseModel) {
      String cartTotalStr = cartTotal;
      if (apiResponseModel.statusCode == 200) {
        CartCountModel cartCountModel =
            CartCountModel.fromJson(apiResponseModel.Result);
        if (cartCountModel != null && cartCountModel.count != null) {
          cartTotalStr = cartCountModel.count.toString();
        }
      } else {
//        Navigator.pushAndRemoveUntil(context, EnterExitRoute(enterPage: LoginScreen()),(c)=>false);
      }
      setState(() {
        cartTotal = cartTotalStr;
      });
    });
  }

  Widget somethingWentWrong() {
    return Container(
      height: 275.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: Colors.red,
            size: 25.0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
            child: Text("Items not loaded",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget productList() {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = MediaQuery.of(context).size.height - 76;
    double aspectRatio = 0.01;

    if (cardHeight < 550) {
      cardHeight = cardHeight + 20;
      aspectRatio = cardWidth / cardHeight;
    } else if (cardHeight > 550 && cardHeight < 600) {
      cardHeight = cardHeight - 20;
      aspectRatio = cardWidth / cardHeight;
    } else if (cardHeight > 600 && cardHeight < 650) {
      cardHeight = cardHeight - 120;
      aspectRatio = cardWidth / cardHeight;
    } else if (cardHeight > 650 && cardHeight < 700) {
      cardHeight = cardHeight - 120;
      aspectRatio = cardWidth / cardHeight;
    } else if (cardHeight > 700 && cardHeight < 740) {
      cardHeight = cardHeight - 190;
      aspectRatio = cardWidth / cardHeight;
    } else {
      cardHeight = cardHeight - 200;
      aspectRatio = cardWidth / cardHeight;
    }

    int count = 2;
    if (aspectRatio >= 0.9) {
      if (cardWidth >= 800) {
        count = 4;
      } else {
        count = 3;
      }
    }
    return Container(
      color: Colors.white70,
      height: MediaQuery.of(context).size.height - 76,
//      height: 275.0,

      child: PagewiseGridView.count(
        pageSize: 10,
        crossAxisCount: count,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: aspectRatio >= 0.9 && cardWidth >= 800
            ? 0.75
            : aspectRatio >= 0.73 ? 0.66 : 0.60,
        //0.66
        padding: EdgeInsets.all(5.0),
        itemBuilder: (context, entry, index) {
          return childView(context, entry);
        },
        pageFuture: (int pageIndex) {
          return getFutureList(pageIndex + 1);
        },
        noItemsFoundBuilder: (context) {
          return Container(
            child: Center(
              child: Text('Data Not Found'),
            ),
          );
        },
//        pageLoadController: PagewiseLoadController(
//            pageSize: 10,
//            pageFuture: (int pageIndex) {
//              return getFutureList();
//            }),
        loadingBuilder: (context) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            height: MediaQuery.of(context).size.height,
          );
        },
      ),
    );
  }

  Future<List> getFutureList(int index) async {
    if (index > 1 || isFromOutside) {
      isFromOutside = false;
      if (name == 'Best Selling Items') {
        getProduct =
            ApiCall().bestSellingItems(index.toString(), pageSize.toString());
      } else if (name == "Vegeto's Exclusive") {
        getProduct =
            ApiCall().vegetosExclusive(index.toString(), pageSize.toString());
      } else {
        getProduct =
            ApiCall().recommendedForYou(index.toString(), pageSize.toString());
      }
    }
    ApiResponseModel apiResponseModel = await getProduct;
    if (apiResponseModel.statusCode == 200) {
      DashboardProductResponseModel responseModel =
          DashboardProductResponseModel.fromJson(apiResponseModel.Result);
//      pageNUmber++;
      return responseModel.Results;
    } else if (apiResponseModel.statusCode == 401) {
      Fluttertoast.showToast(
          msg: apiResponseModel.message != null
              ? apiResponseModel.message
              : 'Something went wrong.!');
    } else {
      Fluttertoast.showToast(
          msg: apiResponseModel.message != null
              ? apiResponseModel.message
              : 'Something went wrong.!');
    }
  }
}
