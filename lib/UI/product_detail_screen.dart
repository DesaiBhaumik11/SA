import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/FarmerPofile.dart';
import 'package:vegetos_flutter/models/ApiResponseModel.dart';
import 'package:vegetos_flutter/models/CartCountModel.dart';
import 'package:vegetos_flutter/models/CartManager.dart';
import 'package:vegetos_flutter/models/DashboardProductResponseModel.dart';
import 'package:vegetos_flutter/UI/my_cart_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';
import 'package:vegetos_flutter/models/ProductDetailsModel.dart';
import 'package:vegetos_flutter/models/ProductPriceModel.dart';
import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';
import 'package:vegetos_flutter/models/UnitsModel.dart';
import 'package:vegetos_flutter/models/my_cart.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatefulWidget {

  String productId;

  ProductDetailScreen(this.productId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductDetailScreenState();
  }

  String ImageUrl = "";
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductWithDefaultVarientModel productModal;
  ProductPriceModel ProductPrice = new ProductPriceModel();
  ProductDetailsModel ProductDetail = new ProductDetailsModel();
  UnitsModel Units = new UnitsModel();
  MyCartModal cartModal;

  bool isAvailableInCart = false;

  double cartNumber = 0;
  GetCartResponseModel models = GetCartResponseModel();
  Map<String, dynamic> cartHashMap;
  ManagerItemViewModel managerItemViewModel;

  var pressed = false;
  bool descFlag = false;
  bool unitFlag = false;
  bool disclaimerFlag = false;
  bool shelfLifeFlag = false;
  bool termsFlag = false;

  int _selectedIndex = 0;

  String cartTotal = "0";

  Future getProductById;

  String ImageURL = "";

  bool isCountLoading = false;

  DashboardProductResponseModel model = DashboardProductResponseModel();

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
      ImageURL = prefs.getString("ImageURL");
    });
    getProductById = ApiCall().setContext(context).getProductDetailById(widget.productId);
    managerForCart();
    super.initState();
  }

  /// -------------------Function that Listen CartManager---------------------------///

  void managerForCart() {
    CartManagerResponseModel().callGetMyCartAPI();
    CartManagerResponseModel.streamController.stream.listen((hashMap){
      setState(() {
        this.cartHashMap = hashMap;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
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
          "Product Detail",
          style: TextStyle(color: Const.textBlack),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context, SlideRightRoute(page: MyCartScreen()));
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
                            height: 25,
                            width: 25,
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
          ),
        ],
      ),
      body: callproductDetailAPi(widget.productId),
    );
  }

  Widget productImageSlides() {
    List<Image> imageList = [
      productModal.PrimaryMediaId == null || productModal.PrimaryMediaId.isEmpty
          ? Image.asset(
              "assets/VegetosAssets/02-product.png",
              height: 100,
              width: 100,
            )
          : Image.network(
              "$ImageURL${productModal.PrimaryMediaId}",
              height: 100.0,
              width: 100.0,
            ),
    ];

    return Stack(
      children: <Widget>[
        Container(
          height: 250.0,
          color: Colors.white,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: imageList.length,
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

  Widget nameAndPrice() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              ProductDetail.Name,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'GoogleSans',
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 5.0, 2.0, 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '₹ ${ProductPrice.OfferPrice != null ? ProductPrice.OfferPrice.toString() : "0"} ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
              ),
              Container(
                  //  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "/ " +
                        productModal.MinimumOrderQuantity.toString() +
                        " " +
                        Units.Name,
                    maxLines: unitFlag ? 20 : 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'GoogleSans',
                        color: Const.dashboardGray,
                        fontWeight: FontWeight.w500)),
              )),
              Container(
                margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    ProductPrice.Price != null
                        ? '₹ ' + ProductPrice.Price.toString()
                        : '₹0',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget unitBar() {
    _onSelected(int index) {
      setState(() => _selectedIndex = index);
    }
    if (productModal != null && cartHashMap != null && cartHashMap.containsKey(widget.productId)) {
      this.managerItemViewModel = cartHashMap[widget.productId];
      this.productModal.itemId = managerItemViewModel.itemId;
      isAvailableInCart = true;
      this.cartNumber = managerItemViewModel.quantity / managerItemViewModel.minimumOrderQuantity;
    } else {
      isAvailableInCart = false;
    }
    var unitList = Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              height: 50.0,
              child: ListView.builder(
                itemCount: 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100.0,
                    margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: _selectedIndex != null && _selectedIndex == index
                          ? Colors.orange
                          : Const.gray10,
                    ),
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                            child: Text(
                                productModal.MinimumOrderQuantity.toString() +
                                    " " +
                                    Units.Name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontFamily: 'GoogleSans',
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
          !isAvailableInCart ?
          InkWell(
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Const.primaryColor,
                //color: Const.gray10,
              ),
              alignment: Alignment.center,
              height: 40.0,
              child: Text(
                '+ ADD',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              addToCart(
                  productModal.ProductId,
                  productModal.IncrementalStep.toString(),
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
                      if (managerItemViewModel.quantity == managerItemViewModel.incrementalStep) {
                        deleteCartItem(productModal.itemId);
                      } else {
                        updateCartQuantity(
                            productModal.itemId,
                            (managerItemViewModel.quantity - managerItemViewModel.incrementalStep)
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
                          productModal.itemId,
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
    );

    return unitList;
  }

  /// ---------------------------Add Cart Quantity Api----------------------------------///

  void addToCart(productId, qty, offerId, amount, offerAmount) {
    setState(() {
      isCountLoading = true;
    });
    CartManagerResponseModel()
        .addToCart(productId, qty, offerId, amount, offerAmount)
        .then((apiResponse) {
      setState(() {
        isCountLoading = false;
      });
      count();
    });
  }

  /// ---------------------------Update Cart Quantity Api----------------------------------///

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

  /// ---------------------------Delete Cart Quantity Api----------------------------------///

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

  Widget aboutProduct() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Divider(
            height: 2,
            color: Const.allBOxStroke,
          ),
          Container(
            alignment: Alignment.centerLeft,
            color: Colors.white70,
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            height: 40.0,
            child: Column(
              children: <Widget>[
                Text('About Product',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'GoogleSans',
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Divider(
            height: 2,
            color: Const.allBOxStroke,
          ),
          description(),
          //unit(),
          //disclaimer(),
          //shelfLife(),
          //termsAndCondition(),
        ],
      ),
    );
  }

  Widget description() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: Text('Description',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'GoogleSans',
                          color: Colors.black,
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
                        child: descFlag
                            ? Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                      )
                    ],
                  )),
            ],
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Text("${ProductDetail.Description}",
                  maxLines: descFlag ? 20 : 2,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'GoogleSans',
                    color: Const.dashboardGray,
                    fontWeight: FontWeight.w500,
                  ))),
          Container(
            color: Const.allBOxStroke,
            height: 1.0,
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
          )
        ],
      ),
    );
  }

  Widget unit() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: Text('Unit',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'GoogleSans',
                          color: Colors.black,
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
                        child: unitFlag
                            ? Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                      )
                    ],
                  )),
            ],
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    productModal.MinimumOrderQuantity.toString() +
                        " " +
                        Units.Name,
                    maxLines: unitFlag ? 20 : 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'GoogleSans',
                        color: Const.dashboardGray,
                        fontWeight: FontWeight.w500)),
              )),
          Container(
            color: Colors.grey,
            height: 1.0,
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
          )
        ],
      ),
    );
  }

  Widget disclaimer() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: Text('Disclaimer',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'GoogleSans',
                          color: Colors.black,
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
                        child: disclaimerFlag
                            ? Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                      )
                    ],
                  )),
            ],
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Const.productDetailDesc,
                    maxLines: disclaimerFlag ? 20 : 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'GoogleSans',
                        color: Const.dashboardGray,
                        fontWeight: FontWeight.w500)),
              )),
          Container(
            color: Colors.grey,
            height: 1.0,
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
          )
        ],
      ),
    );
  }

  Widget shelfLife() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: Text('Shelf Life',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'GoogleSans',
                          color: Colors.black,
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
                        child: shelfLifeFlag
                            ? Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                      )
                    ],
                  )),
            ],
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Const.productDetailDesc,
                    maxLines: shelfLifeFlag ? 20 : 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'GoogleSans',
                        color: Const.dashboardGray,
                        fontWeight: FontWeight.w500)),
              )),
          Container(
            color: Colors.grey,
            height: 1.0,
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
          )
        ],
      ),
    );
  }

  Widget termsAndCondition() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: Text('Terms & Conditions',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'GoogleSans',
                          color: Colors.black,
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
                        child: termsFlag
                            ? Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                      )
                    ],
                  )),
            ],
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Const.productDetailDesc,
                    maxLines: termsFlag ? 20 : 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'GoogleSans',
                        color: Const.dashboardGray,
                        fontWeight: FontWeight.w500)),
              )),
        ],
      ),
    );
  }

  Widget horizontalList() {
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
                      child: Text('Similar Products',
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
                          child: Text('view all',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'GoogleSans',
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
                      }),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget childView(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            //Navigator.push(context, SlideRightRoute(page: ProductDetailScreen()));
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
                          child: Image.asset(
                            'product01.png',
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
                    child: Text('Parle Monacco Cheeselings Classic',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.w700,
                            color: Colors.black)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '300 gm',
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
                            '₹101 ',
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
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        //color: Const.primaryColor
                        color: Const.gray10),
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
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget callproductDetailAPi(String productId) {
    return FutureBuilder(
      future: getProductById,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          ApiResponseModel apiResponseModel = snapshot.data;
          if (apiResponseModel.statusCode == 200) {
            productModal = ProductWithDefaultVarientModel.fromJson(
                apiResponseModel.Result);

            ProductPrice = productModal.ProductPrice;
            if (productModal.ProductDetails != null &&
                productModal.ProductDetails.length > 0) {
              ProductDetail = productModal.ProductDetails[0];
            }
            if (productModal.Units != null && productModal.Units.length > 0) {
              Units = productModal.Units[0];
            }

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                color: Const.gray10,
                child: Column(
                  children: <Widget>[
                    productImageSlides(),
                    Container(
                      color: Colors.grey,
                      height: 1.0,
                    ),
                    nameAndPrice(),
                    Container(
                      color: Colors.grey,
                      height: 1.0,
                    ),
                    unitBar(),
                    farmer(),
                    aboutProduct(),
                    //horizontalList(),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }


  Widget farmer() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(height: 2, color: Const.allBOxStroke,),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.only(left: 5),
              child: Text("Know Farmer",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Const.textBlack,
                ),
              )
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                child: Image.network(
                  "https://us.123rf.com/450wm/adsniks/adsniks1807/adsniks180700027/105287783-indian-farmer-holding-crop-plant-in-his-wheat-field.jpg?ver=6",
                  height: 70,
                  width: 70,
                ),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(" Ramjibhai Desai",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Const.textBlack
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset("assets/OkAssets/Locationo.png", width: 15,height: 15),
                      Text("Moti Marad, Tq-Dhoraji, Dt-Rajkot",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Const.textBlack
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Const.primaryColor,
                        //color: Const.gray10,
                      ),
                      alignment: Alignment.center,
                      height: 22.0,
                      child: Text(
                        'View Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, EnterExitRoute(enterPage: FarmerProfile()));
                    },
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 10,),
          Divider(height: 2, color: Const.allBOxStroke,),
        ],
      ),
    );
  }
  void callGetProductDetailByIdAPI(String productId) {
    ApiCall()
        .setContext(context)
        .getProductDetailById(productId)
        .then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        ProductWithDefaultVarientModel responseModel =
            ProductWithDefaultVarientModel.fromJson(apiResponseModel.Result);
        productModal = responseModel;
      } else if (apiResponseModel.statusCode == 401) {
      } else {}
    });
  }
}
