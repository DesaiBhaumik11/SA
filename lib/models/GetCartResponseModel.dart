
import 'package:vegetos_flutter/models/ProductDetailsModel.dart';
import 'package:vegetos_flutter/models/ProductPriceModel.dart';
import 'package:vegetos_flutter/models/ProductTaxModel.dart';
import 'package:vegetos_flutter/models/UnitsModel.dart';

class GetCartResponseModel {
  String cartId;
  List<CartItemViewModel> cartItemViewModels=List();
  double totalAmount;
  double deliveryCharges;
  double discount;
  double SubTotal;

  GetCartResponseModel({
    this.cartId,
    this.cartItemViewModels,
    this.totalAmount,
    this.deliveryCharges,
    this.discount,
    this.SubTotal,
  });

  factory GetCartResponseModel.fromJson(Map<String, dynamic> json) {
    return GetCartResponseModel(
      cartId: json["CartId"],
      cartItemViewModels: json["CartItemViewModels"] != null ? CartItemViewModel.parseList(json["CartItemViewModels"]) : null,
      totalAmount: json["TotalAmount"],
      deliveryCharges: json["DeliveryCharges"],
      discount: json["Discount"],
      SubTotal: json["SubTotal"],
    );
  }

  Map<String, dynamic> toJson() => {
    "CartId": cartId,
    "CartItemViewModels": List<dynamic>.from(cartItemViewModels.map((x) => x.toJson())),
    "TotalAmount": totalAmount,
    "DeliveryCharges": deliveryCharges,
    "Discount": discount,
  };

  static List<GetCartResponseModel> parseList(listData) {
    var list = listData as List;
    List<GetCartResponseModel> jobList =
    list.map((data) => GetCartResponseModel.fromJson(data)).toList();
    return jobList;
  }
}

class CartItemViewModel {
  String itemId;
  String ProductId;
  String name;
  String description;
  double price;
  double Amount;
  String unit;
  dynamic categoryId;
  String productVariantId;
  String productVariantGroupId;
  String productMediaId;
  double offer;
  String id;
  String brandId;
  double discountPercent;
  String seoTag;
  String businessId;
  int quantity;
  double cartItemTotal;

  int MinimumOrderQuantity;
  int IncrementalStep;

  List<ProductDetailsModel> ProductDetails;
  List<UnitsModel> Units;
  ProductTaxModel ProductTax;
  ProductPriceModel ProductPrice;

  CartItemViewModel({
    this.itemId,
    this.ProductId,
    this.name,
    this.description,
    this.price,
    this.Amount,
    this.unit,
    this.categoryId,
    this.productVariantId,
    this.productVariantGroupId,
    this.productMediaId,
    this.offer,
    this.id,
    this.brandId,
    this.discountPercent,
    this.seoTag,
    this.businessId,
    this.quantity,
    this.cartItemTotal,

    this.MinimumOrderQuantity,
    this.IncrementalStep,

    this.ProductDetails,
    this.Units,
    this.ProductTax,
    this.ProductPrice,
  });

  factory CartItemViewModel.fromJson(Map<String, dynamic> json) => CartItemViewModel(
    itemId: json["ItemId"],
    ProductId: json["ItemId"],
    name: json["Name"],
    description: json["Description"],
    price: json["Price"],
    Amount: json["Price"],
    unit: json["Unit"],
    categoryId: json["CategoryId"],
    productVariantId: json["ProductVariantId"],
    productVariantGroupId: json["ProductVariantGroupId"],
    productMediaId: json["ProductMediaId"],
    offer: json["Offer"],
    id: json["Id"],
    brandId: json["BrandId"],
    discountPercent: json["DiscountPercent"],
    seoTag: json["SEOTag"],
    businessId: json["BusinessId"],
    quantity: json["Quantity"],
    cartItemTotal: json["CartItemTotal"],

    MinimumOrderQuantity: json['MinimumOrderQuantity'],
    IncrementalStep: json['IncrementalStep'],

    ProductDetails: json['ProductDetails'] != null ? ProductDetailsModel.parseList(json['ProductDetails']) : null,
    Units: json['Units'] != null ? UnitsModel.parseList(json['Units']) : null,
    ProductTax: json['ProductTax'] != null ? ProductTaxModel.fromJson(json['ProductTax']) : null,
    ProductPrice: json['ProductPrice'] != null ? ProductPriceModel.fromJson(json['ProductPrice']) : null,
  );

  Map<String, dynamic> toJson() => {
    "ItemId": itemId,
    "ProductId": itemId,
    "Name": name,
    "Description": description,
    "Price": price,
    "Amount": Amount,
    "Unit": unit,
    "CategoryId": categoryId,
    "ProductVariantId": productVariantId,
    "ProductVariantGroupId": productVariantGroupId,
    "ProductMediaId": productMediaId,
    "Offer": offer,
    "Id": id,
    "BrandId": brandId,
    "DiscountPercent": discountPercent,
    "SEOTag": seoTag,
    "BusinessId": businessId,
    "Quantity": quantity,
    "CartItemTotal": cartItemTotal,
  };

  static List<CartItemViewModel> parseList(listData) {
    var list = listData as List;
    List<CartItemViewModel> jobList =
    list.map((data) => CartItemViewModel.fromJson(data)).toList();
    return jobList;
  }
}