import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetos_flutter/Animation/EnterExitRoute.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/categories_screen.dart';
import 'package:vegetos_flutter/UI/my_cart_screen.dart';
import 'package:vegetos_flutter/UI/product_detail_screen.dart';
import 'package:vegetos_flutter/Utils/ApiCall.dart';
import 'package:vegetos_flutter/Utils/MyCartUtils.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/CartCountModel.dart';
import 'package:vegetos_flutter/models/CartManager.dart';
import 'package:vegetos_flutter/models/GetCartResponseModel.dart';
import 'package:vegetos_flutter/models/ProductDetailsModel.dart';
import 'package:vegetos_flutter/models/ProductPriceModel.dart';
import 'package:vegetos_flutter/models/ProductVariantMedia.dart';
import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';
import 'package:vegetos_flutter/models/UnitsModel.dart';
import 'package:vegetos_flutter/models/categories_model.dart' as category;
import 'package:vegetos_flutter/models/my_cart.dart' as myCart;
import 'package:vegetos_flutter/models/search_products.dart' as sModal;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var wid = 1;
  Timer timer;
  myCart.MyCartModal myCartModal;

  String CAT_ID = "";
  category.CategoriesModel categoriesModel;

  String cartTotal = '0';

  bool search = false;
  String ImageURL = '';
  bool isCountLoading = false, isSearchLoading = false;

  bool isSearch = false;

  int typedMillis = 0;

  TextEditingController searchController = TextEditingController();

  List<ProductWithDefaultVarientModel> searchList;

  GetCartResponseModel model = GetCartResponseModel();
  Map<String, dynamic> cartHashMap;
  ManagerItemViewModel managerItemViewModel;
  double cartNumber = 0;

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
    MyCartUtils().callCartCountAPI();
    MyCartUtils.streamController.stream.listen((cartCount) {
      setState(() {
        cartTotal = cartCount;
      });
    });
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    myCartModal = Provider.of<myCart.MyCartModal>(context);
    categoriesModel = Provider.of<category.CategoriesModel>(context);

    final sModal.SearchModel searchModel =
        Provider.of<sModal.SearchModel>(context);
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      body: Container(
        color: Colors.white70,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
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
                          'assets/OkAssets/LeftSideArrow.png',
                          height: 25,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(
                          color: Const.textBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: searchController,
                        onChanged: (e) {
                          /*search=true;
                        if(timer!=null){
                          timer.cancel();
                        }
                        timer=Timer(Duration(milliseconds: 500), (){
                          if(e.isEmpty){
                            searchModel.searching(false);
                          }else{
                            searchModel.searching(true);

                            String id = _SheetWidState._category.isEmpty||_SheetWidState._category[0].isEmpty||_SheetWidState._category[0]==null? "":categoriesModel.result.singleWhere((result)=>result.name==_SheetWidState._category[0]).id ;

                            String url = e + "&categoryId=${id}&brandId=&manufacturerId=" ;

                            print("urlll>>> ${url}") ;

                            searchModel.searchProducts(url);
                          }

                        });*/

                          if (e != null && e.isNotEmpty && e.length > 3) {
                            if (typedMillis + 300 <
                                new DateTime.now().millisecondsSinceEpoch) {
                              Future.delayed((Duration(milliseconds: 300)))
                                  .then((_) {
                                typedMillis =
                                    new DateTime.now().millisecondsSinceEpoch;
                                callSearchProductAPI(e);
                              });
                            }
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search...",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Const.textBlack)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: isSearchLoading
                          ? new Align(
                              alignment: Alignment.center,
                              child: new Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Const.iconOrange,
                                  strokeWidth: 2,
                                ),
                              ))
                          : Container(),
                    ),
                    InkWell(
                      onTap: () {
                        searchController.text = '';
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/OkAssets/Cencelicone.png',
                          height: 18,
                          width: 18,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, SlideRightRoute(page: MyCartScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: isCountLoading
                            ? new Align(
                                alignment: Alignment.center,
                                child: new Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Const.iconOrange,
                                    strokeWidth: 2,
                                  ),
                                ))
                            : Stack(
                                children: <Widget>[
                                  Align(
                                    child: Image.asset(
                                      'assets/OkAssets/Mycart.png',
                                      height: 28,
                                      width: 28,
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  cartTotal == "0"
                                      ? Container(
                                          margin: EdgeInsets.fromLTRB(
                                              15.0, 10.0, 5.0, 0.0),
                                        )
                                      : Container(
                                          margin: EdgeInsets.fromLTRB(
                                              15.0, 15.0, 5.0, 0.0),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Const.widgetGreen,
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
              ),
            ),
            Divider(
              height: 1,
              color: Const.allBOxStroke,
            ),
            Container(
              height: 40,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Visibility(
                      visible: searchList != null ? true : false,
                      child: Text(
                        searchList != null
                            ? searchList.length.toString() + ' Result Found'
                            : "0 Result found",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Const.textBlack),
                      ),
                    ),
                  ),
                  /*FlatButton(
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
                )*/
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Const.allBOxStroke,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: isSearch
                  ? searchList != null && searchList.isNotEmpty
                      ? buildGridList()
                      : Whoops()
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  GridView buildGridList() {
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

    int counts = 2;
    if (aspectRatio >= 0.9) {
      if (cardWidth >= 800) {
        counts = 4;
      } else {
        counts = 3;
      }
    }
    print(aspectRatio);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: counts,
        childAspectRatio: aspectRatio >= 0.9 && cardHeight >= 800
            ? 0.75
            : aspectRatio >= 0.73 ? 0.72 : 0.61,
        //  childAspectRatio: aspectRatio - 0.075,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        ProductWithDefaultVarientModel productVariant = searchList[index];
        String name = "";
        String unit = "";
        String desc = "";
        //double quantity = 0;
        int quantity = 0;
        bool isAvailableInCart = false;

        for (int i = 0; i < productVariant.ProductDetails.length; i++) {
          if (productVariant.ProductDetails[i].Language == "En-US") {
            name = productVariant.ProductDetails[i].Name;
            desc = productVariant.ProductDetails[i].Description;
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

          productVariant.MinimumOrderQuantity = managerItemViewModel.quantity;

          if(productVariant.MinimumOrderQuantity >= 1000) {
           // quantity = productVariant.MinimumOrderQuantity / 1000;
            quantity = managerItemViewModel.minimumOrderQuantity;
          //  unit = "Kg";
          } else {
           // quantity = productVariant.MinimumOrderQuantity.floorToDouble();
            quantity = managerItemViewModel.minimumOrderQuantity;
          }
          this.cartNumber = managerItemViewModel.quantity / managerItemViewModel.minimumOrderQuantity;

          if (productVariant.ProductPrice != null) {
//            ProductPrice.OfferPrice = productVariant.ProductPrice.OfferPrice * cartNumber;
//            ProductPrice.Price = productVariant.ProductPrice.Price * cartNumber;
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

          //quantity = productVariant.MinimumOrderQuantity.floorToDouble();
          quantity = productVariant.MinimumOrderQuantity;

          if (productVariant.ProductPrice != null) {
            ProductPrice.OfferPrice = productVariant.ProductPrice.OfferPrice;
            ProductPrice.Price = productVariant.ProductPrice.Price;
            ProductPrice.DiscountPercent = productVariant.ProductPrice.DiscountPercent;
          }

          isAvailableInCart = false;
        }

        if (ProductDetail != null) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(SlideRightRoute(
                      page: ProductDetailScreen(productVariant.ProductId)))
                  .then((prefs) {
                count();
              });
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
              decoration: BoxDecoration(
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: new Border.all(
                                  color: Colors.grey[500],
                                  width: 0.5,
                                  style: BorderStyle.solid),
                              color: Colors.white),
                          width: double.maxFinite,
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
                        ProductPrice.DiscountPercent != null &&
                                ProductPrice.DiscountPercent != 0
                            ? Container(
                                margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                                padding:
                                    EdgeInsets.fromLTRB(3.0, 2.0, 3.0, 2.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
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
                  ),
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                          child: Text(
                            name,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'GoogleSans',
                                color: Const.textBlack,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          child: Text(
                              quantity.toString() +
                                  " " +
                                  unit,
                            style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'GoogleSans',
                                color: Color(0xff6c6c6c),
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                              child: Text(
                                '₹ ' + ProductPrice.OfferPrice.toString(),
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'GoogleSans',
                                    fontWeight: FontWeight.w700,
                                    color: Const.textBlack),
                              ),
                            ),
                            ProductPrice.DiscountPercent != null &&
                                    ProductPrice.DiscountPercent != 0
                                ? Container(
                                    margin:
                                        EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        ProductPrice.Price != null
                                            ? '₹' +
                                                ProductPrice.Price.toString()
                                            : 0,
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontFamily: 'GoogleSans',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        !isAvailableInCart ?
                        InkWell(
                          onTap: () {
                            addToCart(
                                productVariant.ProductId,
                                productVariant.IncrementalStep.toString(),
                                "",
                                productVariant.ProductPrice.Price.toString(),
                                productVariant.ProductPrice.OfferPrice
                                    .toString());
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5.0, 8.0, 10.0, 0.0),
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                        ) :
                        Visibility(
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
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
      itemCount: searchList.length,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
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

  ///--------------------------------------------------------------------------///


  ///------------------------Add Cart Quantity----------------------------------///

  void addToCart(productId, qty, offerId, amount, offerAmount) {
    setState(() {
      isCountLoading = true;
    });
    CartManagerResponseModel().addToCart((productId), qty, offerId, amount, offerAmount).then((apiResponseModel){
      setState(() {
        isCountLoading = false;
      });
      count();
    });
  }

  ///--------------------------------------------------------------------------///

  ListView buildList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        ProductWithDefaultVarientModel productVariant = searchList[index];
        String name = "";
        String unit = "";
        String desc = "";
        for (int i = 0; i < productVariant.ProductDetails.length; i++) {
          if (productVariant.ProductDetails[i].Language == "En-US") {
            name = productVariant.ProductDetails[i].Name;
            desc = productVariant.ProductDetails[i].Description;
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

        if (ProductDetail != null) {
          return GestureDetector(
            onTap: () {
//              Navigator.push(context, EnterExitRoute(enterPage: ProductDetailScreen(productVariant.ProductId)));
              Navigator.of(context)
                  .push(SlideRightRoute(
                      page: ProductDetailScreen(productVariant.ProductId)))
                  .then((prefs) {
                count();
              });
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                decoration: BoxDecoration(
                    border: new Border.all(
                        color: Colors.grey[500],
                        width: 0.5,
                        style: BorderStyle.solid),
                    color: Colors.white),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
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
//                            child: Image.asset("02-product.png",height: 100,width: 100,),
                            ),
                          ),
//                          ProductPrice.DiscountPercent != null && ProductPrice.DiscountPercent != 0 ?
//                          Container(
//                            padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
//                            decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(5.0),
//                                color: Colors.orange),
//                            child: Text(
//                                ProductPrice.DiscountPercent != null ?
//                                ProductPrice.DiscountPercent.toString() : null,
//                              style: TextStyle(
//                                  fontSize: 10.0,
//                                  fontFamily: 'GoogleSans',
//                                  color: Colors.white),
//                            ),
//                          ) : Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'GoogleSans',
                                  color: Const.textBlack,
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            width: MediaQuery.of(context).size.width * 0.55,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Text(
                              desc,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'GoogleSans',
                                  color: Color(0xff6c6c6c),
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '₹ ' + ProductPrice.OfferPrice.toString(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'GoogleSans',
                                    fontWeight: FontWeight.w700,
                                    color: Const.textBlack),
                              ),
                              ProductPrice.DiscountPercent != null &&
                                      ProductPrice.DiscountPercent != 0
                                  ? Container(
                                      margin: EdgeInsets.fromLTRB(
                                          5.0, 5.0, 0.0, 0.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          ProductPrice.Price != null
                                              ? '₹' +
                                                  ProductPrice.Price.toString()
                                              : 0,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontFamily: 'GoogleSans',
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              ProductPrice.DiscountPercent != null &&
                                      ProductPrice.DiscountPercent != 0
                                  ? Container(
                                      margin: EdgeInsets.fromLTRB(
                                          5.0, 5.0, 0.0, 0.0),
                                      padding: EdgeInsets.fromLTRB(
                                          3.0, 2.0, 3.0, 2.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
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
                          SizedBox(
                            width: 5,
                          ),
                          RaisedButton(
                            color: Const.widgetGreen,
                            //color: Const.gray10,
                            onPressed: () {
                              addToCart(
                                  productVariant.ProductId,
                                  productVariant.IncrementalStep.toString(),
                                  "",
                                  productVariant.ProductPrice.Price.toString(),
                                  productVariant.ProductPrice.OfferPrice
                                      .toString());
                            },
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
                                        fontWeight: FontWeight.w500,
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
        } else {
          return Container();
        }
      },
      itemCount: searchList.length,
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
              decoration: BoxDecoration(
                  border: new Border.all(
                      color: Colors.grey[500],
                      width: 0.5,
                      style: BorderStyle.solid),
                  color: Colors.white),
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
      itemCount: 0,
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

  void callSearchProductAPI(String searchString) {
    setState(() {
      isSearchLoading = true;
    });
    ApiCall()
        .setContext(context)
        .searchProduct(searchString)
        .then((apiResponseModel) {
      setState(() {
        isSearchLoading = false;
      });
      if (apiResponseModel.statusCode == 200) {
        List<ProductWithDefaultVarientModel>
            productWithDefaultVarientModelList =
            ProductWithDefaultVarientModel.parseList(apiResponseModel.Result);
        setState(() {
          searchList = productWithDefaultVarientModelList;
          FocusScope.of(context).requestFocus(FocusNode());
          isSearch = true;
        });
      } else if (apiResponseModel.statusCode == 401) {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : '');
      } else {
        Fluttertoast.showToast(
            msg: apiResponseModel.message != null
                ? apiResponseModel.message
                : '');
      }
    });
  }
}

class Whoops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 120),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.only(bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/VegetosAssets/no-result.png',
                height: 200,
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
                onPressed: () {
                  Navigator.push(
                      context, EnterExitRoute(enterPage: CategoriesScreen()));
                },
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

  static List<String> _category = [];
  List<String> _category_items = [];

  List<String> _discount = [];

  List<String> _price = [];
  category.CategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    categoriesModel = Provider.of<category.CategoriesModel>(context);

    for (var i = 0; i < categoriesModel.result.length; i++) {
      _category_items.add("${categoriesModel.result[i].name}");
    }

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
                        Image.asset('assets/VegetosAssets/selected-refine.png',
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
                          'assets/VegetosAssets/filter.png',
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
                                  labels: _category_items,
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
                                    print("_category    ${_category}");
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
