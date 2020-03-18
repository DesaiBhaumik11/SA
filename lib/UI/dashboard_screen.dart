import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:package_info/package_info.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/about_vegetos.dart';
import 'package:vegetos_flutter/UI/profile.dart';
import 'package:vegetos_flutter/UI/splash_screeen.dart';
import 'package:vegetos_flutter/Utils/DeviceTokenController.dart';
import 'package:vegetos_flutter/models/AddressModel.dart';
import 'package:vegetos_flutter/models/AppFirstStartResponseModel.dart';
import 'package:vegetos_flutter/models/CartCountModel.dart';
import 'package:vegetos_flutter/models/CartManager.dart';
import 'package:vegetos_flutter/models/DashboardProductResponseModel.dart';
import 'package:vegetos_flutter/UI/all_product_screen.dart';
import 'package:vegetos_flutter/UI/categories_screen.dart';
import 'package:vegetos_flutter/UI/login.dart';
import 'package:vegetos_flutter/UI/my_addresses.dart';
import 'package:vegetos_flutter/UI/my_cart_screen.dart';
import 'package:vegetos_flutter/UI/my_orders.dart';
import 'package:vegetos_flutter/UI/product_detail_screen.dart';
import 'package:vegetos_flutter/UI/search_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';
import 'package:vegetos_flutter/models/ProductDetailsModel.dart';
import 'package:vegetos_flutter/models/ProductPriceModel.dart';
import 'package:vegetos_flutter/models/ProductVariantMedia.dart';
import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';
import 'package:vegetos_flutter/models/UnitsModel.dart';
import 'package:vegetos_flutter/models/address_modal.dart';
import 'package:vegetos_flutter/models/app_first_modal.dart';
import 'package:vegetos_flutter/models/product_common.dart' as bst;
import 'package:vegetos_flutter/models/categories_model.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardScreenState();
  }
}

class DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  //MyCartModal myCartModal ;
  static int cartSize = 0;
  static AppFirstModal appFirstModal;

  static AddressModal addressModal;

  bool allCals = true;

  String phoneNumber;

  bool isAnnonymous = true;

  String deliveryAddress = '';
  bool isCountLoading = false;
  String cartTotal = '0';
  String ImageURL = '';
  double cartNumber = 0;

  Future bestSellingFuture;
  Future exclusiveFuture;
  Future recommendedFuture;
  ProgressDialog progressDialog;

  String version = "";

  String cartTotalItems = "0";
  GetCartResponseModel model = GetCartResponseModel();
  Map<String, dynamic> cartHashMap;
  ManagerItemViewModel managerItemViewModel;

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
    SharedPreferences.getInstance().then((prefs) {
      Map<String, dynamic> tokenMap =
          Const.parseJwt(prefs.getString('AUTH_TOKEN'));
      if (tokenMap['anonymous'].toString().toLowerCase() == "true") {
        setState(() {
          isAnnonymous = true;
        });
      } else {
        setState(() {
          isAnnonymous = false;
        });
      }

      String businessLocationId = prefs.getString('BusinessLocationId');
      String address = prefs.getString('FullAddress');
      if (businessLocationId != null && businessLocationId.isNotEmpty) {
        deliveryAddress = address;
      }
      ImageURL = prefs.getString("ImageURL");
    });

    getVeriosnCode();
    getMyDefaultAddress();
    count();
    bestSellingFuture = ApiCall().bestSellingItems("1", "10");
    exclusiveFuture = ApiCall().vegetosExclusive("1", "10");
    recommendedFuture = ApiCall().recommendedForYou("1", "10");

    WidgetsBinding.instance.addObserver(this);

    managerForCart();
    super.initState();
  }

  void managerForCart() {
    CartManagerResponseModel().callGetMyCartAPI();
    CartManagerResponseModel.streamController.stream.listen((hashMap) {
      setState(() {
        this.cartHashMap = hashMap;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      phoneNumber = prefs.getString("phone");
    });

    appFirstModal = Provider.of<AppFirstModal>(context);
    final cat = Provider.of<CategoriesModel>(context);

    addressModal = Provider.of<AddressModal>(context);

    if (!cat.isLoaded) {
      cat.loadCategories();
    }

    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      drawer: Drawer(
        child: drawer(context),
      ),
      body: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            appBar(context),
          ];
        },
        body: SingleChildScrollView(
          //physics: BouncingScrollPhysics(),
          child: Container(
            color: Colors.white70,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                searchBar(context),
                browsByProduct(),
                //adViewWidget(),
                /*bestSelling.loaded?horizontalList(context , "Best Selling Items",bestSelling.result):Center(child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CircularProgressIndicator(),
                ),),*/
                //bestSellingContainer(),
                //vegitosExclusive.loaded?horizontalList(context,"Vegeto's Exclusive",vegitosExclusive.result):Container(),
                //recommendedProducts.loaded?horizontalList(context,"Recommended for you",recommendedProducts.result):Container(),
                //vegetosExclusiveContainer(),
                //recommendedContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  browsByProduct() {
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
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                      child: Text("Browse By Product",
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
                                    builder: (context) =>
                                        AllProductScreen('Browse By Product')));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                browseByProductAPI(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget browseByProductAPI() {
    return FutureBuilder(
      future: bestSellingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if (apiResponseModel.statusCode == 200) {
            DashboardProductResponseModel responseModel =
                DashboardProductResponseModel.fromJson(apiResponseModel.Result);
            return productGridList(responseModel.Results);
          } else if (apiResponseModel.statusCode == 401) {
            return somethingWentWrong(1);
          } else {
            return somethingWentWrong(1);
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            height: 475.0,
          );
        } else {
          return somethingWentWrong(1);
        }
      },
    );
  }

  Widget productGridList(List<ProductWithDefaultVarientModel> products) {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = MediaQuery.of(context).size.height;
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
      cardHeight = cardHeight - 20;
      aspectRatio = cardWidth / cardHeight;
    }

    return Container(
      height: 550.0,
      //   margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,

        //  childAspectRatio: aspectRatio >= 0.73 ? 0.70 : 0.55, //0.66
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: aspectRatio >= 0.73 ? 1.2 : 1.6,
        ),
        itemBuilder: (context, index) {
          return gridChildView(context, products[index]);
        },
      ),
    );
  }

  ///--------------------Grid Child For Browse By Product----------------------///

  Widget gridChildView(
      BuildContext context, ProductWithDefaultVarientModel productVariant) {

    ProductPriceModel ProductPrice = ProductPriceModel();
    ProductDetailsModel ProductDetail = new ProductDetailsModel();
    UnitsModel Units = new UnitsModel();
    ProductVariantMedia productVariantMedia = new ProductVariantMedia();

    bool isAvailableInCart = false;

    String name = "";
    String unit = "";
    double quantity = 0;

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

    if (productVariant != null &&
        cartHashMap != null &&
        cartHashMap.containsKey(productVariant.ProductId)) {

      this.managerItemViewModel = cartHashMap[productVariant.ProductId];

      productVariant.itemId = managerItemViewModel.itemId;

      productVariant.MinimumOrderQuantity = managerItemViewModel.quantity;

      if(productVariant.MinimumOrderQuantity >= 1000) {
        quantity = productVariant.MinimumOrderQuantity / 1000;
        unit = "Kg";
      } else {
        quantity = productVariant.MinimumOrderQuantity.floorToDouble();
      }
      this.cartNumber = managerItemViewModel.quantity / managerItemViewModel.minimumOrderQuantity;

      if (productVariant.ProductPrice != null) {
        ProductPrice.OfferPrice = productVariant.ProductPrice.OfferPrice * cartNumber;
        ProductPrice.Price = productVariant.ProductPrice.Price * cartNumber;
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

      quantity = productVariant.MinimumOrderQuantity.floorToDouble();

      if (productVariant.ProductPrice != null) {
        ProductPrice.OfferPrice = productVariant.ProductPrice.OfferPrice;
        ProductPrice.Price = productVariant.ProductPrice.Price;
        ProductPrice.DiscountPercent = productVariant.ProductPrice.DiscountPercent;
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
                    enterPage: ProductDetailScreen(productVariant.ProductId)));
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
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
                        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      ),
                      ProductPrice.DiscountPercent != null &&
                              ProductPrice.DiscountPercent != 0
                          ? Container(
                              margin: EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 0.0),
                              padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.0),
                                  color: Colors.orange),
                              child: Text(
                                ProductPrice.DiscountPercent != null
                                    ? ProductPrice.DiscountPercent.toString() +
                                        ' %'
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
                  margin: EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 5.0),
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
                      quantity.toString() +
                          " " +
                          unit,
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
                          '₹ ${ProductPrice.OfferPrice.toString()}',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    ProductPrice.Price != null &&
                            ProductPrice.Price != 0
                        ? Container(
                            margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                    '₹' + ProductPrice.Price.toString(),
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
                          margin: EdgeInsets.fromLTRB(5.0, 8.0, 10.0, 8.0),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              //color: Const.gray10
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
                          setState(() {
                            addToCart(
                                productVariant.ProductId,
                                productVariant.IncrementalStep.toString(),
                                "",
                                ProductPrice.Price.toString(),
                                ProductPrice.OfferPrice.toString());
                          });
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
                                  if (productVariant.MinimumOrderQuantity ==
                                      productVariant.IncrementalStep) {
                                    deleteCartItem(productVariant.itemId);
                                  } else {
                                    updateCartQuantity(
                                        productVariant.itemId,
                                        (productVariant.MinimumOrderQuantity -
                                                productVariant.IncrementalStep)
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
                                      (productVariant.MinimumOrderQuantity +
                                              productVariant.IncrementalStep)
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

  ///--------------------------------------------------------------------------///

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

  ///--------------------------------------------------------------------------///

  ///---------------------Did Change App LifeCycle-----------------------------///
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      count();
    }
  }

  ///--------------------------------------------------------------------------///

  ///---------------------------AppBar-----------------------------------------///

  Widget appBar(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      pinned: true,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Image.asset(
          "assets/OkAssets/hamburgerbutto.png",
          scale: 4.5,
        ),
        iconSize: 15,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(SlideRightRoute(page: MyCartScreen()))
                .then((prefs) {
              count();
              getMyDefaultAddressByPrefs();
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
                              margin: EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 0.0),
                            )
                          : Container(
                              margin: EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 0.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  backgroundColor: Const.widgetGreen,
                                  radius: 8.0,
                                  child: Text(
                                      cartTotal != null ? cartTotal : "",
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
      title: Stack(
        children: <Widget>[
          InkWell(
            child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Flexible(
                          child: Text(
                        'Set Delivery Location',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'GoogleSans',
                            color: Const.widgetGreen),
                        textAlign: TextAlign.left,
                      )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      new Flexible(
                        child: Text(
                          deliveryAddress.isNotEmpty
                              ? deliveryAddress
                              : 'Location not set!',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'GoogleSans',
                              color: Const.textBlack),
                          maxLines: 1,
//                        overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(SlideRightRoute(page: MyAddresses()))
                  .then((prefs) {
                count();
                getMyDefaultAddressByPrefs();
              });
            },
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(SlideRightRoute(page: MyAddresses()))
                        .then((prefs) {
                      count();
                      getMyDefaultAddressByPrefs();
                    });
                  },
                  child: Align(
                    child: deliveryAddress.isNotEmpty
                        ? Image.asset(
                            "assets/OkAssets/Search.png",
                            height: 22,
                            width: 23,
                          )
                        : Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 20.0,
                          ),
                    alignment: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///--------------------------------------------------------------------------///

  ///---------------------------Search Bar-------------------------------------///

  Widget searchBar(BuildContext context) {
    return Container(
      height: 50.0,
      color: Const.iconOrange,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                            context, SlideRightRoute(page: CategoriesScreen()))
                        .then((returnn) {
                      count();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Text('Categories',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'GoogleSans',
                              color: Const.textBlack,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                                EnterExitRoute(enterPage: SearchScreen()))
                            .then((ret) {
                          count();
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            child: Image.asset(
                              "assets/OkAssets/Search.png",
                              height: 20,
                              width: 25,
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            child: Text('Search Product',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'GoogleSans',
                                    fontWeight: FontWeight.w500,
                                    color: Const.textBlack)),
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

  ///--------------------------------------------------------------------------///

  ///---------------------------Ad View---------------------------------------///
  Widget adViewWidget() {
    List<Image> imageList = <Image>[
      Image.asset(
        'assets/ad01.png',
        fit: BoxFit.fill,
      ),
      Image.asset(
        'assets/ad02.png',
        fit: BoxFit.fill,
      )
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
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: imageList[index],
          );
        },
      ),
    );
  }

  ///--------------------------------------------------------------------------///

  ///------------------------Child View---------------------------------------///
  Widget childView(
      BuildContext context, ProductWithDefaultVarientModel productVariant) {
    String name = "";
    String unit = "";
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

    if (productVariant != null) {
      if (productVariant.ProductDetails != null &&
          productVariant.ProductDetails.length > 0) {
        ProductDetail = productVariant.ProductDetails[0];
      }
      if (productVariant.Units != null && productVariant.Units.length > 0) {
        Units = productVariant.Units[0];
      }
      if (productVariant.ProductPrice != null) {
        ProductPrice = productVariant.ProductPrice;
      }
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
                .then((ret) {
              count();
            });
          },
          child: Container(
            width: 180.0,
            child: Card(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 110.0,
                          height: 110.0,
                          child: Card(
                            elevation: 0.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: productVariant.PrimaryMediaId == null ||
                                    productVariant.PrimaryMediaId.isEmpty
                                ? Image.asset(
                                    "02-product.png",
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
                          margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        ),
                      ),
                    ],
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
                        productVariant.MinimumOrderQuantity.toString() +
                            " " +
                            unit,
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
                      ProductPrice.DiscountPercent != null &&
                              ProductPrice.DiscountPercent != 0
                          ? Container(
                              margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                              padding: EdgeInsets.fromLTRB(3.0, 2.0, 3.0, 2.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.orange),
                              child: Text(
                                ProductPrice.DiscountPercent != null
                                    ? ProductPrice.DiscountString + ' %'
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
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
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
                      addToCart(
                          productVariant.ProductId,
                          productVariant.IncrementalStep.toString(),
                          "",
                          ProductPrice.Price.toString(),
                          ProductPrice.OfferPrice.toString());
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

  ///-----------------------------Drawer--------------------------------------///

  Widget drawer(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                if (isAnnonymous) {
                  Navigator.push(
                      context, EnterExitRoute(enterPage: LoginScreen()));
                } else {
                  Navigator.push(context, EnterExitRoute(enterPage: Profile()));
                }
              },
              child: Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: !isAnnonymous
                            ? Image.asset(
                                'assets/OkAssets/DrawerIcon/LoginUser.png',
                                height: 25.0,
                                width: 25.0,
                              )
                            : Image.asset(
                                'assets/OkAssets/DrawerIcon/mobile.png',
                                height: 25.0,
                                width: 25.0,
                              ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('$phoneNumber',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 3.0,
              color: Const.allBOxStroke,
            ),
            /*Container(
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
              ),*/
            InkWell(
              onTap: () {
                //Navigator.pushNamed(context, Const.myOrders);
                Navigator.pushAndRemoveUntil(context,
                    EnterExitRoute(enterPage: DashboardScreen()), (c) => false);
              },
              child: Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset(
                          'assets/OkAssets/DrawerIcon/Dashboard.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('Dashboard',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Const.textBlack)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, EnterExitRoute(enterPage: MyOrders()));
              },
              child: Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset(
                          'assets/OkAssets/DrawerIcon/MyOrder.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('My Orders',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Const.textBlack)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            /*InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.mySubscriptions);
                },
                child: Container(
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
              ),*/
            InkWell(
              onTap: () {
                Navigator.push(
                        context, EnterExitRoute(enterPage: MyCartScreen()))
                    .then((ret) {
                  count();
                });
              },
              child: Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset(
                          'assets/OkAssets/DrawerIcon/MyCart.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('My Cart',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Const.textBlack)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                        context, EnterExitRoute(enterPage: MyAddresses()))
                    .then((ret) {
                  getMyDefaultAddressByPrefs();
                });
              },
              child: Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset(
                          'assets/OkAssets/DrawerIcon/MyAddress.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('My Addresses',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Const.textBlack)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            /*InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.sharedCart);
                },
                child: Container(
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
              ),*/
            /*InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Const.wallet);
                },
                child: Container(
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
              ),*/
            /*InkWell(
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
              ),*/
            Container(
              height: 3.0,
              color: Const.allBOxStroke,
            ),
            /*Container(
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
              ),*/
            /*Container(
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
              ),*/
            /*InkWell(child: Container(
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
              ),onTap: (){
                //Navigator.pop(context) ;

//                WcFlutterShare.share(
//                    sharePopupTitle: 'Share',
//                    subject: 'This is subject',
//                    text: 'This is text',
//                    mimeType: 'text/plain');
                //Share.share('check out my website https://example.com', subject: 'Look what I made!');
              },),*/
            InkWell(
              onTap: () {
                Navigator.push(
                    context, EnterExitRoute(enterPage: AboutVegetos()));
              },
              child: Container(
                height: 50.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Image.asset(
                          'assets/OkAssets/DrawerIcon/Aboutus.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        child: Text('About Us',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w500,
                                color: Const.textBlack)),
                      )
                    ],
                  ),
                ),
              ),
            ),
//              InkWell(
//                onTap: (){
//                  Navigator.push(context, EnterExitRoute(enterPage: AboutAppRelease()));
//                },
//                child: Container(
//                  height: 50.0,
//                  child: Align(
//                    alignment: Alignment.center,
//                    child: Row(
//                      children: <Widget>[
//                        Container(
//                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
//                          child: Image.asset('assets/about-app.png', height: 20.0, width: 20.0,),
//                        ),
//                        Container(
//                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
//                          child: Text('About App Release',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
//                              color: Colors.black)),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//              ),

            !isAnnonymous
                ? InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (s) {
                            return FunkyOverlay();
                          });
                    },
                    child: Container(
                      height: 50.0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                              child: Image.asset(
                                'assets/OkAssets/DrawerIcon/Logout.png',
                                height: 25.0,
                                width: 25.0,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                              child: Text('Logout',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'GoogleSans',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
//              Container(
//                  alignment: Alignment.bottomCenter,
//                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
//                  child: Align(
//                    alignment: Alignment.center,
//                    child: Row(
//                      children: <Widget>[
//                        Container(
//                          margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
//                          child: Text('App Version: ',style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
//                              color: Colors.black)),
//                        ),
//                        Container(
//                          child: Text(version,style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500,
//                              color: Colors.black)),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
          ],
        ),
      ),
    );
  }

  ///-----------------------Call Best Selling Items API----------------------------///

  Widget callBestSellingItemsAPI() {
    return FutureBuilder(
      future: bestSellingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if (apiResponseModel.statusCode == 200) {
            DashboardProductResponseModel responseModel =
                DashboardProductResponseModel.fromJson(apiResponseModel.Result);
            return productList(responseModel.Results);
          } else if (apiResponseModel.statusCode == 401) {
            return somethingWentWrong(1);
          } else {
            return somethingWentWrong(1);
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            height: 275.0,
          );
        } else {
          return somethingWentWrong(1);
        }
      },
    );
  }

  ///-----------------------Call Best Selling Items Container-----------------------///

  Widget bestSellingContainer() {
    return Container(
      child: Stack(
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
                        child: Text('Best Selling Items',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Text('view all',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'GoogleSans',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllProductScreen(
                                            'Best Selling Items'))).then((ret) {
                                  count();
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  callBestSellingItemsAPI(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///--------------------------------------------------------------------------///

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

  ///--------------------Call Vegetos Exclusive Product API-------------------///

  Widget callVegetosExclusiveProductAPI() {
    return FutureBuilder(
      future: exclusiveFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if (apiResponseModel.statusCode == 200) {
            DashboardProductResponseModel responseModel =
                DashboardProductResponseModel.fromJson(apiResponseModel.Result);
            return productList(responseModel.Results);
          } else if (apiResponseModel.statusCode == 401) {
            return somethingWentWrong(2);
          } else {
            return somethingWentWrong(2);
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            height: 275.0,
          );
        } else {
          return somethingWentWrong(2);
        }
      },
    );
  }

  ///-----------------------Vegetos Exclusive Container------------------------///

  Widget vegetosExclusiveContainer() {
    return Container(
      child: Stack(
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
                        child: Text("Vegeto's Exclusive",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Text('view all',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'GoogleSans',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllProductScreen(
                                            "Vegeto's Exclusive"))).then((ret) {
                                  count();
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  callVegetosExclusiveProductAPI(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///----------------------Call Recommended For You API------------------------///

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
            return somethingWentWrong(3);
          } else {
            return somethingWentWrong(3);
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            height: 275.0,
          );
        } else {
          return somethingWentWrong(3);
        }
      },
    );
  }

  ///--------------------------Recommended Container--------------------------///

  Widget recommendedContainer() {
    return Container(
      child: Stack(
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
                        child: Text("Recommended for you",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Text('view all',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'GoogleSans',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllProductScreen(
                                            "Recommended for you"))).then(
                                    (ret) {
                                  count();
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  callRecommendedForYouAPI(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///----------------------------Something Went Wrong-------------------------///

  Widget somethingWentWrong(int index) {
    return InkWell(
      onTap: () {
//        1 == Best Selling
//        2 == Vegetos Exclusive
//        3 == Recommended
        if (index == 1) {
          callBestSellingItemsAPI();
        } else if (index == 2) {
          callVegetosExclusiveProductAPI();
        } else if (index == 3) {
          callRecommendedForYouAPI();
        } else {}
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

  ///--------------------------------------------------------------------------///

  /*void callGetCartAPI() {
    ApiCall().getCart().then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        GetCartResponseModel getCartResponseModel = GetCartResponseModel.fromJson(apiResponseModel.Result);
        setState(() {
          if(getCartResponseModel.cartItemViewModels != null) {
            cartTotal = getCartResponseModel.cartItemViewModels.length.toString();
          }
        });
      } else if(apiResponseModel.statusCode == 401) {

      } else {

      }
    });
  }*/

  ///--------------------------------------------------------------------------///

  /*void callAddToCartAPI(String productId, String varientId, String qty, String offerId, String amount) {
    ApiCall().addToCart(productId, varientId, qty, offerId, amount).then((apiResponseModel) {
      if(apiResponseModel.statusCode == 200) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
        MyCartUtils().callCartCountAPI();
      } else if (apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      } else {
        Fluttertoast.showToast(msg: apiResponseModel.message != null ? apiResponseModel.message : '');
      }
    });
  }*/

  ///---------------------------Dispose Method Call Here------------------///

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  ///-----------------------Get My Default Address By Prefs---------------------///

  void getMyDefaultAddressByPrefs() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        deliveryAddress = prefs.getString('FullAddress');
      });
    });
  }

  ///--------------------------Get My Default Address--------------------------///

  void getMyDefaultAddress() {
    ApiCall()
        .setContext(context)
        .getMyDefaultAddress()
        .then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        AddressModel addModel = AddressModel.fromJson(apiResponseModel.Result);
        setState(() {
          deliveryAddress = addModel.addressLine1;
        });
      } else {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : 'Something went wrong.!');
        getMyDefaultAddressByPrefs();
      }
    });
  }

  ///--------------------------Count In Cart-----------------------------------///

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

  ///--------------------------Add to Cart API--------------------------------///

  void addToCart(productId, qty, offerId, amount, offerAmount) {
    setState(() {
      isCountLoading = true;
    });
    CartManagerResponseModel()
        .addToCart(productId, qty, offerId, amount, offerAmount)
        .then((apiResponseModel) {
      setState(() {
        isCountLoading = false;
      });
      count();
    });
  }

  ///--------------------------Get Version Code Here--------------------------///

  Future<String> getVeriosnCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

///---------------------------------CLASS END----------------------------------///

}

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Material(
          color: Colors.white,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 35),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/VegetosAssets/cancel-subscription.png',
                          height: 150,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          Const.logout1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  logoutAPI(context);
                                  // Navigator.pushNamed(context, Const.loginScreen);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            RaisedButton(
                                color: Const.greyLight,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 8),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void logoutAPI(BuildContext context) {
    ApiCall().logout().then((apiResponseModel) {
      String uuid = Uuid().v4();
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool("login", false);
        prefs.setString("UUID", uuid);
        prefs.setString("JWT_TOKEN", "");
        prefs.setString("AUTH_TOKEN", "");
        prefs.setString("phone", "Guest User");
        DeviceTokenController().ValidateDeviceToken().then((token) {
          callAppFirstStartAPI(context);
        });
      });
    });
  }

  void callAppFirstStartAPI(BuildContext context) {
    ApiCall().appFirstStart().then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        AppFirstStartResponseModel appFirstStartResponseModel =
            AppFirstStartResponseModel.fromJson(apiResponseModel.Result);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("AUTH_TOKEN", appFirstStartResponseModel.token);
          Navigator.pushAndRemoveUntil(
              context, EnterExitRoute(enterPage: LoginScreen()), (c) => false);
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context, EnterExitRoute(enterPage: SplashScreen()), (c) => false);
      }
    });
  }

  Future<String> getJwtToken([uuid]) async {
    // uuid = uuid + randomAlphaNumeric(10) ;

    String manufacturer, model, osVersion;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      manufacturer = androidInfo.manufacturer;
      model = androidInfo.model;
      osVersion = androidInfo.version.release;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      model = iosInfo.model;
      osVersion = iosInfo.utsname.version;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map<String, dynamic> map = Map();
    map["id"] = uuid;
    map["appversion"] = packageInfo.version;

    map["appversioncode"] = packageInfo.buildNumber;
    map["manufacturer"] = Platform.isIOS ? "Apple" : manufacturer;
    map["model"] = model;
    map["os"] = Platform.isAndroid ? "Android" : "Ios";
    map["osversion"] = osVersion;
//    map["platform"]=        Platform.isAndroid?"Android":"Ios";
    //   map["nbf"]=        "1577355877";
    map["platform"] = "Mobile";
    map["notificationid"] = "";
    print("Map = $map");

    final key = '2C39927D43F04E1CBAB1615841D94000';
    final claimSet = new JwtClaim(
      issuer: 'com.archisys.vegetos',
      audience: <String>['com.archisys.artis'],
      otherClaims: map,
    );
    String token = issueJwtHS256(claimSet, key);

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("JWT_TOKEN", token);
    });
    print("JWT token DASHBOARD  =  $token");

    return token;
  }
}
