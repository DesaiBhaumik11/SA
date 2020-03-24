import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/all_product_screen.dart';
import 'package:vegetos_flutter/UI/categories_screen.dart';
import 'package:vegetos_flutter/UI/login.dart';
import 'package:vegetos_flutter/UI/product_detail_screen.dart';
import 'package:vegetos_flutter/UI/set_delivery_details.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/CartCountModel.dart';
import 'package:vegetos_flutter/models/CartManager.dart';
import 'package:vegetos_flutter/models/DashboardProductResponseModel.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';
import 'package:vegetos_flutter/models/ProductDetailsModel.dart';
import 'package:vegetos_flutter/models/ProductPriceModel.dart';
import 'package:vegetos_flutter/models/ProductVariantMedia.dart';
import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';
import 'package:vegetos_flutter/models/UnitsModel.dart';
import 'package:vegetos_flutter/models/my_cart.dart' as myCart;
import 'package:vegetos_flutter/models/product_common.dart' as bst;

import 'package:vegetos_flutter/models/product_detail.dart';

class MyCartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyCartState();
  }
}

class MyCartState extends State<MyCartScreen> {
  //RecommendedProductsModel  recommendedProductsModel ;

  /// ------------------------------------Initialize Variable-----------------------------------------------///
  String cartTotalItems = "0";
  String totalSaving = "0";
  String checkoutTotal = "0";
  bool isCountLoading = false;
  String ImageURL = '';

  double cartNumber = 0;
  String cartTotal = "";

  bool isDataAvailable = true;

  bool isAvailableInCart = false;

  Future recommendedFuture;
  GetCartResponseModel model = GetCartResponseModel();
  Map<String, dynamic> cartHashMap;
  ManagerItemViewModel managerItemViewModel;

  /// --------------------InitState Call When Widget Build------------------------///

  @override
  void initState() {
    // TODO: implement initState
    recommendedFuture = ApiCall().recommendedForYou("1", "10");
    SharedPreferences.getInstance().then((prefs) {
      ImageURL = prefs.getString("ImageURL");
    });
    managerForCart();
    super.initState();
  }

  /// -------------------Function that Listen CartManager---------------------------///

  void managerForCart() {
    CartManagerResponseModel().callGetMyCartAPI().then((apiResponseModel) {
      BindData(apiResponseModel);
    });
    CartManagerResponseModel.streamController.stream.listen((hashMap) {
      setState(() {
        this.cartHashMap = hashMap;
      });
    });
  }

  /// -------------------Function call When StateChange-------------------------------///

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  /// ----------------------------Build Method -----------------------------------------///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: cartAppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white70,
          child: Column(
            children: <Widget>[
              model != null &&
                      model.cartItemViewModels != null &&
                      model.cartItemViewModels.isNotEmpty
                  ? cartWidgets()
                  : !isDataAvailable
                      ? noItemsInYourCart()
                      : Container(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
              recommendedContainer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: checkoutBottomBar(),
    );
  }

  /// -----------------------------Price Total Box Widget----------------------------------///

  Widget priceTotalBox(GetCartResponseModel model) {
    return Visibility(
      visible: true,
      child: Container(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Const.allBOxStroke)),
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'M.R.P',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        "₹${model.totalAmount.toString()}",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Product Discount',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        '-₹ ' + model.discount.toString(),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Delivery Charge ',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.help_outline,
                            color: Const.primaryColor,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        '₹ ' + model.deliveryCharges.toString(),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500,
                            color: Const.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Const.allBOxStroke,
                height: 1.0,
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Sub Total',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        "₹${model.SubTotal.toString()}",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ------------------------------Cart Item list--------------------------------------///

  Widget cartItemList(GetCartResponseModel model) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
          child: Text(
            'Items in your cart',
            style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w500),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: model.cartItemViewModels.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
          itemBuilder: (context, index) {
            return ListTile(
              title: cartItemChild(model.cartItemViewModels[index]),
              onTap: () {},
            );
          },
        )
      ],
    );
  }

  /// ---------------------------Cart Item List Child----------------------------------///
  Widget cartItemChild(CartItemViewModel cartItem) {

    String name = "";
    String unit = "";
    int quantity = 0;

    for (int i = 0; i < cartItem.ProductDetails.length; i++) {
      if (cartItem.ProductDetails[i].Language == "En-US") {
        name = cartItem.ProductDetails[i].Name;
        break;
      }
    }

    for (int i = 0; i < cartItem.Units.length; i++) {
      if (cartItem.Units[i].Language == "En-US") {
        unit = cartItem.Units[i].Name;
        break;
      }
    }

    quantity = cartItem.MinimumOrderQuantity;

//    if(cartItem.quantity >= 1000 && unit == "Grams") {
//      quantity = (cartItem.quantity / 1000);
//      unit = "Kg";
//    } else {
//      quantity = cartItem.quantity.floorToDouble();
//    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            EnterExitRoute(
                enterPage: ProductDetailScreen(cartItem.id)));
      },
      child: Container(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Const.allBOxStroke)),
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: cartItem.productMediaId != null &&
                                  cartItem.productMediaId.isNotEmpty
                              ? Image.network(
                                  ImageURL + cartItem.productMediaId,
                                  height: 100.0,
                                  width: 100.0,
                                )
                              : Image.asset(
                                  'assets/VegetosAssets/02-product.png',
                                  height: 100.0,
                                  width: 100.0,
                                ),
                        ),
                      ],
                    ),
                  ),
                  cartItem.ProductPrice.DiscountPercent != null &&
                          cartItem.ProductPrice.DiscountPercent != 0
                      ? Container(
                          margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                          padding: EdgeInsets.fromLTRB(3.0, 2.0, 3.0, 2.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.orange),
                          child: Text(
                            cartItem.ProductPrice.DiscountPercent != null
                                ? cartItem.ProductPrice.DiscountString + ' %'
                                : '0 %',
                            style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'GoogleSans',
                                color: Colors.white),
                          ),
                        )
                      : Container(),
                ],
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text(
                          name,
                          style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'GoogleSans',
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text(
                          quantity.toString() + " " + unit,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'GoogleSans',
                              color: Const.dashboardGray,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "₹ ${cartItem.ProductPrice.OfferPrice}",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: 'GoogleSans',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      runAlignment: WrapAlignment.start,
                                      children: <Widget>[
                                        cartItem.ProductPrice.DiscountPercent != null && cartItem.ProductPrice.DiscountPercent != 0
                                            ? Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0.0, 5.0, 5.0, 5.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    '₹ ${cartItem.ProductPrice.Price}',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontFamily: 'GoogleSans',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey,
                                                        decoration: TextDecoration
                                                            .lineThrough),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      if (cartItem.quantity >
                                          cartItem.MinimumOrderQuantity) {
                                        updateCartQuantity(
                                            cartItem.itemId,
                                            (cartItem.quantity -
                                                    cartItem.IncrementalStep)
                                                .toString());
                                      } else {
                                        deleteCartItem(cartItem.itemId);
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                      child: Image.asset(
                                        'assets/OkAssets/minus.png',
                                        height: 20.0,
                                        width: 20.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                    child: Text(
                                        (cartItem.quantity /
                                                cartItem.MinimumOrderQuantity)
                                            .round()
                                            .toString(),
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
                                          cartItem.itemId,
                                          (cartItem.quantity +
                                                  cartItem.IncrementalStep)
                                              .toString());
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                      child: Image.asset(
                                        'assets/OkAssets/plus.png',
                                        height: 20.0,
                                        width: 20.0,
                                      ),
                                    ),
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

  /// ---------------------------Cart Widgets-----------------------------------------///

  Widget cartWidgets() {
    return Column(
      children: <Widget>[
        priceTotalBox(model),
        cartItemList(model),
      ],
    );
  }

  /// ---------------------------Cart Recommended Container-------------------------------///

  Widget recommendedContainer() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                      child: Text("Recommended for you",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                      child: ButtonTheme(
                        height: 28,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Const.widgetGreen,
                          child: Text("view all",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'GoogleSans',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllProductScreen(
                                            "Recommended for you"))).then((value) {
                                  managerForCart();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                callRecommendedForYouAPI(),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// -----------------------------Cart Count Number------------------------------------///

  void count() {
    ApiCall().setContext(context).count().then((apiResponseModel) {
      setState(() {
        isCountLoading = false;
      });
      String cartTotalStr = "0";
      if (apiResponseModel.statusCode == 200) {
        CartCountModel cartCountModel =
        CartCountModel.fromJson(apiResponseModel.Result);
        if (cartCountModel != null && cartCountModel.count != null) {
          cartTotalStr = cartCountModel.count.toString();
        }
      }
      setState(() {
         cartTotal = cartTotalStr;
      });
    });
  }


  /// ---------------------------Cart Recommended List ----------------------------------///

  Widget productList(List<ProductWithDefaultVarientModel> products) {
    return Container(
      height: 275.0,
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: products.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return childView(context, products[index]);
          }),
    );
  }

  /// ---------------------------Cart Recommended List Child ----------------------------------///

  Widget childView(BuildContext context, ProductWithDefaultVarientModel result) {

    ProductPriceModel ProductPrice = new ProductPriceModel();
    ProductDetailsModel ProductDetail = new ProductDetailsModel();
    UnitsModel Units = new UnitsModel();
    ProductVariantMedia productVariantMedia = new ProductVariantMedia();

    bool isAvailableInCart = false;

    String name = "";
    String unit = "";
    int quantity = 0;

    for (int i = 0; i < result.ProductDetails.length; i++) {
      if (result.ProductDetails[i].Language == "En-US") {
        name = result.ProductDetails[i].Name;
        break;
      }
    }

    for (int i = 0; i < result.Units.length; i++) {
      if (result.Units[i].Language == "En-US") {
        unit = result.Units[i].Name;
        break;
      }
    }

    if (result != null &&
        cartHashMap != null &&
        cartHashMap.containsKey(result.ProductId)) {
      this.managerItemViewModel = cartHashMap[result.ProductId];

      result.itemId = managerItemViewModel.itemId;

      result.MinimumOrderQuantity = managerItemViewModel.quantity;

      if (result.ProductDetails != null && result.ProductDetails.length > 0) {
        ProductDetail = result.ProductDetails[0];
      }

      if (result.Units != null && result.Units.length > 0) {
        Units = result.Units[0];
      }

      if (result.MinimumOrderQuantity >= 1000) {
       // quantity = result.MinimumOrderQuantity / 1000;
        quantity = managerItemViewModel.minimumOrderQuantity;
       // unit = "Kg";
      } else {
       // quantity = result.MinimumOrderQuantity.floorToDouble();
        quantity = managerItemViewModel.minimumOrderQuantity;
      }
      this.cartNumber = managerItemViewModel.quantity /
          managerItemViewModel.minimumOrderQuantity;

      if (result.ProductPrice != null) {
        result.ProductPrice.OfferPrice = result.ProductPrice.OfferPrice;
        result.ProductPrice.Price = result.ProductPrice.Price;
        result.ProductPrice.DiscountPercent = result.ProductPrice.DiscountPercent;
      }

      isAvailableInCart = true;
    } else {
      if (result.ProductDetails != null && result.ProductDetails.length > 0) {
        ProductDetail = result.ProductDetails[0];
      }

      if (result.Units != null && result.Units.length > 0) {
        Units = result.Units[0];
      }

     // quantity = result.MinimumOrderQuantity.floorToDouble();
      quantity = result.MinimumOrderQuantity;

      if (result.ProductPrice != null) {
        result.ProductPrice.OfferPrice = result.ProductPrice.OfferPrice;
        result.ProductPrice.Price = result.ProductPrice.Price;
        result.ProductPrice.DiscountPercent =
            result.ProductPrice.DiscountPercent;
      }
      isAvailableInCart = false;
    }

    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            final ProductDetailModal productModal =
                Provider.of<ProductDetailModal>(context);
            productModal.getProductDetail(result.ProductId, () {
              Navigator.push(
                      context,
                      EnterExitRoute(
                          enterPage: ProductDetailScreen(result.ProductId)))
                  .then((value) {});
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 15),
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
            width: 180.0,
            height: 280.0,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: new Border.all(
                          color: Const.allBOxStroke,
                          width: 0.5,
                          style: BorderStyle.solid),
                      color: Colors.white),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 110.0,
                          height: 110.0,
                          child: result.PrimaryMediaId == null ||
                                  result.PrimaryMediaId.toString().isEmpty
                              ? Image.asset(
                                  "assets/VegetosAssets/02-product.png",
                                  height: 100,
                                  width: 100,
                                )
                              : Image.network(
                                  ImageURL +
                                      result.PrimaryMediaId +
                                      '&h=150&w=150',
                                  height: 110.0,
                                  width: 110.0,
                                ),
                          margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        ),
                      ),
                      result.ProductPrice.DiscountPercent != null &&
                              result.ProductPrice.DiscountPercent != 0
                          ? Container(
                              margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                              padding: EdgeInsets.fromLTRB(3.0, 2.0, 3.0, 2.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.orange),
                              child: Text(
                                result.ProductPrice.DiscountPercent != null
                                    ? result.ProductPrice.DiscountString + ' %'
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
                  margin: EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 5.0),
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
                      margin: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '₹ ${result.ProductPrice.OfferPrice != null ? result.ProductPrice.OfferPrice : 0}',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    result.ProductPrice.DiscountPercent != null &&
                            result.ProductPrice.DiscountPercent != 0
                        ? Container(
                            margin: EdgeInsets.fromLTRB(5.0, 4.0, 0.0, 0.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                result.ProductPrice.Price != null
                                    ? '₹' + result.ProductPrice.Price.toString()
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
                !isAvailableInCart
                    ? InkWell(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5.0, 8.0, 10.0, 0.0),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                          callAddToCartAPI(
                              result.ProductId,
                              result.IncrementalStep.toString(),
                              "",
                              result.ProductPrice.Price.toString(),
                              result.ProductPrice.OfferPrice.toString());
                        },
                      )
                    : Visibility(
                        visible: true,
                        child: Expanded(
                          flex: 0,
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  if (result.MinimumOrderQuantity ==
                                      result.IncrementalStep) {
                                    deleteCartItem(result.itemId);
                                  } else {
                                    updateCartQuantity(
                                        result.itemId,
                                        (result.MinimumOrderQuantity -
                                                result.IncrementalStep)
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
                                child: Text(cartNumber.floor().toString(),
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
                                      result.itemId,
                                      (result.MinimumOrderQuantity +
                                              result.IncrementalStep)
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

  /// ---------------------------Cart Confirm Delete ----------------------------------///

  void confirmDelete() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: new Text("My Cart"),
          content: new Text("Are you sure you want clear your cart items?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                callClearCartAPI();
              },
            ),
          ],
        );
      },
    );
  }

  /// ---------------------------Cart Bind Data ----------------------------------///

  void BindData(ApiResponseModel apiResponseModel) {
    if (apiResponseModel.statusCode == 200) {
      GetCartResponseModel getCartResponseModel =
          GetCartResponseModel.fromJson(apiResponseModel.Result);
      setState(() {
        model = getCartResponseModel;
        if (model.discount != null) {
          totalSaving = model.discount.toString();
        } else {
          totalSaving = "0";
        }

        if (model.SubTotal != null) {
          checkoutTotal = model.SubTotal.toString();
        } else {
          checkoutTotal = "0";
        }

        if (model.cartItemViewModels != null &&
            model.cartItemViewModels.length > 0) {
          cartTotalItems = model.cartItemViewModels.length.toString();
          isDataAvailable = true;
        } else {
          cartTotalItems = "0";
          isDataAvailable = false;
        }
      });
    } else if (apiResponseModel.statusCode == 204) {
      setState(() {
        model = null;
        isDataAvailable = false;
      });
    } else {
      Fluttertoast.showToast(
          msg: apiResponseModel.message != null
              ? apiResponseModel.message
              : 'Something went wrong.!');
    }
  }

  /// ---------------------Show when no Item Available in cart-------------------------///

  Widget noItemsInYourCart() {
    return Container(
        padding: EdgeInsets.all(10),
        height: 400,
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/VegetosAssets/profile.png',
                  height: 200,
                  width: 200,
                ),
                Text(
                  'No items in cart',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(EnterExitRoute(enterPage: CategoriesScreen()))
                          .then((value) {});
                    },
                    color: Colors.green,
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                    child: Text(
                      'Start Shopping',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  /// ------------------------------Cart AppBar -------------------------------------///

  Widget cartAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: true,
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
      title: Container(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Cart',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w500,
                      color: Const.textBlack),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$cartTotalItems Items',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w500,
                      color: Const.textBlack),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        isCountLoading
            ? new Align(
                alignment: Alignment.center,
                child: new Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Const.iconOrange,
                    strokeWidth: 2,
                  ),
                ))
            : Visibility(
                visible: model != null &&
                        model.cartItemViewModels != null &&
                        isDataAvailable == true
                    ? true
                    : false,
                child: InkWell(
                  onTap: () {
                    confirmDelete();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Image.asset(
                      "assets/OkAssets/Delete.png",
                      height: 25,
                      width: 25,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  /// ---------------------------Cart Checkout Bottom Bar --------------------------------///

  Widget checkoutBottomBar() {
    return BottomAppBar(
      child: Visibility(
        visible: model != null &&
                model.cartItemViewModels != null &&
                isDataAvailable == true
            ? true
            : false,
        child: InkWell(
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              Map<String, dynamic> tokenMap =
                  Const.parseJwt(prefs.getString('AUTH_TOKEN'));
              if (tokenMap['anonymous'].toString().toLowerCase() == "true") {
                Navigator.push(
                    context, EnterExitRoute(enterPage: LoginScreen()));
              } else {
                if (model != null &&
                    model.cartItemViewModels != null &&
                    model.cartItemViewModels.isNotEmpty) {
                  Navigator.push(
                      context, SlideLeftRoute(page: SetDeliveryDetails(model)));
                } else {
                  Fluttertoast.showToast(msg: 'No items in your cart');
                }
              }
            });
          },
          child: Container(
            color: Const.primaryColor,
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            height: 50.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Checkout',
                            style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'GoogleSans',
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'You have saved ₹ ' + totalSaving,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "₹$checkoutTotal",
                      style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'GoogleSans',
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ---------------------------Update Cart Quantity Api----------------------------------///

  void updateCartQuantity(String itemId, String quantity) {
    setState(() {
      isCountLoading = true;
    });
    CartManagerResponseModel()
        .updateCartQuantity(itemId, quantity)
        .then((apiResponseModel) {
      BindData(apiResponseModel);
      setState(() {
        isCountLoading = false;
      });
    });
  }

  /// ---------------------------Delete Cart Quantity Api----------------------------------///

  void deleteCartItem(String itemId) {
    setState(() {
      isCountLoading = true;
    });
    CartManagerResponseModel().deleteCartItem(itemId).then((apiResponseModel) {
      BindData(apiResponseModel);
      setState(() {
        isCountLoading = false;
      });
    });
  }

  /// -------------------------------Clear Cart Api-------------------------------------///

  void callClearCartAPI() {
    setState(() {
      isCountLoading = true;
    });
    CartManagerResponseModel().clearCartItems().then((apiResponseModel) {
      BindData(apiResponseModel);
      setState(() {
        isCountLoading = false;
      });
    });
  }

  /// ---------------------------Recommended Item Api----------------------------------///

  Widget callRecommendedForYouAPI() {
    return FutureBuilder(
      future: recommendedFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if (apiResponseModel.statusCode == 200) {
            DashboardProductResponseModel responseModel =
                DashboardProductResponseModel.fromJson(apiResponseModel.Result);
            return productList(responseModel.Results);
          } else if (apiResponseModel.statusCode == 401) {
            return somethingWentWrong();
          } else {
            return somethingWentWrong();
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            height: 275.0,
          );
        } else {
          return somethingWentWrong();
        }
      },
    );
  }

  /// ---------------------------Something  Went Wrong Widget-------------------------------///

  Widget somethingWentWrong() {
    return InkWell(
      onTap: () {
        callRecommendedForYouAPI();
      },
      child: Container(
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
      ),
    );
  }

  /// ---------------------------Add to Cart Item Api----------------------------------///

  void callAddToCartAPI(String productId, String qty, String offerId,
      String amount, String offerAmount) {
    setState(() {
      isCountLoading = true;
    });
    CartManagerResponseModel()
        .addToCart(productId, qty, offerId, amount, offerAmount)
        .then((apiResponseModel) {
      BindData(apiResponseModel);
      setState(() {
        isCountLoading = false;
      });
    });
  }
}
