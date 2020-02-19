// To parse this JSON data, do
//
//     final getOrderByIdResponseModelZ = getOrderByIdResponseModelZFromJson(jsonString);

import 'dart:convert';

GetOrderByIdResponseModelZ getOrderByIdResponseModelZFromJson(String str) => GetOrderByIdResponseModelZ.fromJson(json.decode(str));

String getOrderByIdResponseModelZToJson(GetOrderByIdResponseModelZ data) => json.encode(data.toJson());

class GetOrderByIdResponseModelZ {
  String invoiceNumber;
  double offerAmount;
  String toContactId;
  int paymentStatus;
  String paymentId;
  String id;
  String fromBusinessId;
  String fromContactId;
  String locationId;
  DateTime transactionDate;
  int status;
  double shippingCharges;
  double subTotal;
  double taxAmount;
  double totalAmount;
  double totalPaid;
  String orderId;
  ShippingOrder shippingOrder;
  int paymentMode;
  List<OrderItemsViewModel> orderItemsViewModel;
  int itemCount;

  GetOrderByIdResponseModelZ({
    this.invoiceNumber,
    this.offerAmount,
    this.toContactId,
    this.paymentStatus,
    this.paymentId,
    this.id,
    this.fromBusinessId,
    this.fromContactId,
    this.locationId,
    this.transactionDate,
    this.status,
    this.shippingCharges,
    this.subTotal,
    this.taxAmount,
    this.totalAmount,
    this.totalPaid,
    this.orderId,
    this.shippingOrder,
    this.paymentMode,
    this.orderItemsViewModel,
    this.itemCount,
  });

  factory GetOrderByIdResponseModelZ.fromJson(Map<String, dynamic> json) => GetOrderByIdResponseModelZ(
    invoiceNumber: json["InvoiceNumber"],
    offerAmount: json["OfferAmount"],
    toContactId: json["ToContactId"],
    paymentStatus: json["PaymentStatus"],
    paymentId: json["PaymentId"],
    id: json["Id"],
    fromBusinessId: json["FromBusinessId"],
    fromContactId: json["FromContactId"],
    locationId: json["LocationId"],
    transactionDate: DateTime.parse(json["TransactionDate"]),
    status: json["Status"],
    shippingCharges: json["ShippingCharges"],
    subTotal: json["SubTotal"],
    taxAmount: json["TaxAmount"],
    totalAmount: json["TotalAmount"],
    totalPaid: json["TotalPaid"],
    orderId: json["OrderId"],
    shippingOrder: ShippingOrder.fromJson(json["ShippingOrder"]),
    paymentMode: json["PaymentMode"],
    orderItemsViewModel: List<OrderItemsViewModel>.from(json["OrderItemsViewModel"].map((x) => OrderItemsViewModel.fromJson(x))),
    itemCount: json["ItemCount"],
  );

  Map<String, dynamic> toJson() => {
    "InvoiceNumber": invoiceNumber,
    "OfferAmount": offerAmount,
    "ToContactId": toContactId,
    "PaymentStatus": paymentStatus,
    "PaymentId": paymentId,
    "Id": id,
    "FromBusinessId": fromBusinessId,
    "FromContactId": fromContactId,
    "LocationId": locationId,
    "TransactionDate": transactionDate.toIso8601String(),
    "Status": status,
    "ShippingCharges": shippingCharges,
    "SubTotal": subTotal,
    "TaxAmount": taxAmount,
    "TotalAmount": totalAmount,
    "TotalPaid": totalPaid,
    "OrderId": orderId,
    "ShippingOrder": shippingOrder.toJson(),
    "PaymentMode": paymentMode,
    "OrderItemsViewModel": List<dynamic>.from(orderItemsViewModel.map((x) => x.toJson())),
    "ItemCount": itemCount,
  };
}

class OrderItemsViewModel {
  double price;
  String productVariantId;
  String productId;
  String brandId;
  String seoTag;
  double quantity;
  int minimumOrderQuantity;
  int incrementalStep;
  List<Unit> units;
  List<ProductDetail> productDetails;
  List<String> productVariantMedia;
  ProductPrice productPrice;
  ProductTax productTax;

  OrderItemsViewModel({
    this.price,
    this.productVariantId,
    this.productId,
    this.brandId,
    this.seoTag,
    this.quantity,
    this.minimumOrderQuantity,
    this.incrementalStep,
    this.units,
    this.productDetails,
    this.productVariantMedia,
    this.productPrice,
    this.productTax,
  });

  factory OrderItemsViewModel.fromJson(Map<String, dynamic> json) => OrderItemsViewModel(
    price: json["Price"],
    productVariantId: json["ProductVariantId"],
    productId: json["ProductId"],
    brandId: json["BrandId"],
    seoTag: json["SEOTag"],
    quantity: json["Quantity"],
    minimumOrderQuantity: json["MinimumOrderQuantity"],
    incrementalStep: json["IncrementalStep"],
    units: List<Unit>.from(json["Units"].map((x) => Unit.fromJson(x))),
    productDetails: List<ProductDetail>.from(json["ProductDetails"].map((x) => ProductDetail.fromJson(x))),
    productVariantMedia: List<String>.from(json["ProductVariantMedia"].map((x) => x)),
    productPrice: ProductPrice.fromJson(json["ProductPrice"]),
    productTax: ProductTax.fromJson(json["ProductTax"]),
  );

  Map<String, dynamic> toJson() => {
    "Price": price,
    "ProductVariantId": productVariantId,
    "ProductId": productId,
    "BrandId": brandId,
    "SEOTag": seoTag,
    "Quantity": quantity,
    "MinimumOrderQuantity": minimumOrderQuantity,
    "IncrementalStep": incrementalStep,
    "Units": List<dynamic>.from(units.map((x) => x.toJson())),
    "ProductDetails": List<dynamic>.from(productDetails.map((x) => x.toJson())),
    "ProductVariantMedia": List<dynamic>.from(productVariantMedia.map((x) => x)),
    "ProductPrice": productPrice.toJson(),
    "ProductTax": productTax.toJson(),
  };
}

class ProductDetail {
  String productVariantId;
  String language;
  String name;
  String summary;
  String description;
  String createdBy;
  DateTime createdOn;

  ProductDetail({
    this.productVariantId,
    this.language,
    this.name,
    this.summary,
    this.description,
    this.createdBy,
    this.createdOn,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productVariantId: json["ProductVariantId"],
    language: json["Language"],
    name: json["Name"],
    summary: json["Summary"],
    description: json["Description"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductVariantId": productVariantId,
    "Language": language,
    "Name": name,
    "Summary": summary,
    "Description": description,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
  };
}

class ProductPrice {
  String productId;
  String productVariantId;
  DateTime applicableFrom;
  bool isTaxInclusive;
  String businessLocationId;
  double price;
  double discountPercent;
  double offerPrice;
  String createdBy;
  DateTime createdOn;

  ProductPrice({
    this.productId,
    this.productVariantId,
    this.applicableFrom,
    this.isTaxInclusive,
    this.businessLocationId,
    this.price,
    this.discountPercent,
    this.offerPrice,
    this.createdBy,
    this.createdOn,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
    productId: json["ProductId"],
    productVariantId: json["ProductVariantId"],
    applicableFrom: DateTime.parse(json["ApplicableFrom"]),
    isTaxInclusive: json["IsTaxInclusive"],
    businessLocationId: json["BusinessLocationId"],
    price: json["Price"],
    discountPercent: json["DiscountPercent"],
    offerPrice: json["OfferPrice"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductVariantId": productVariantId,
    "ApplicableFrom": applicableFrom.toIso8601String(),
    "IsTaxInclusive": isTaxInclusive,
    "BusinessLocationId": businessLocationId,
    "Price": price,
    "DiscountPercent": discountPercent,
    "OfferPrice": offerPrice,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
  };
}

class ProductTax {
  String productId;
  String taxId;
  DateTime startDate;
  Tax tax;
  String createdBy;
  DateTime createdOn;

  ProductTax({
    this.productId,
    this.taxId,
    this.startDate,
    this.tax,
    this.createdBy,
    this.createdOn,
  });

  factory ProductTax.fromJson(Map<String, dynamic> json) => ProductTax(
    productId: json["ProductId"],
    taxId: json["TaxId"],
    startDate: DateTime.parse(json["StartDate"]),
    tax: Tax.fromJson(json["Tax"]),
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "TaxId": taxId,
    "StartDate": startDate.toIso8601String(),
    "Tax": tax.toJson(),
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
  };
}

class Tax {
  String id;
  String name;
  double rate;
  List<dynamic> taxes;
  String updatedBy;
  String createdBy;
  DateTime createdOn;
  DateTime updatedOn;

  Tax({
    this.id,
    this.name,
    this.rate,
    this.taxes,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    id: json["Id"],
    name: json["Name"],
    rate: json["Rate"],
    taxes: List<dynamic>.from(json["Taxes"].map((x) => x)),
    updatedBy: json["UpdatedBy"] == null ? null : json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Rate": rate,
    "Taxes": List<dynamic>.from(taxes.map((x) => x)),
    "UpdatedBy": updatedBy == null ? null : updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn == null ? null : updatedOn.toIso8601String(),
  };
}

class Unit {
  String unitId;
  int decimalPlaces;
  String language;
  String code;
  String name;

  Unit({
    this.unitId,
    this.decimalPlaces,
    this.language,
    this.code,
    this.name,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    unitId: json["UnitId"],
    decimalPlaces: json["DecimalPlaces"],
    language: json["Language"],
    code: json["Code"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "UnitId": unitId,
    "DecimalPlaces": decimalPlaces,
    "Language": language,
    "Code": code,
    "Name": name,
  };
}

class ShippingOrder {
  String trancactionId;
  String userId;
  String locationId;
  String userAddressId;
  String shippingScheduleId;
  String name;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String country;
  String pin;
  String createdBy;
  DateTime createdOn;

  ShippingOrder({
    this.trancactionId,
    this.userId,
    this.locationId,
    this.userAddressId,
    this.shippingScheduleId,
    this.name,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.pin,
    this.createdBy,
    this.createdOn,
  });

  factory ShippingOrder.fromJson(Map<String, dynamic> json) => ShippingOrder(
    trancactionId: json["TrancactionId"],
    userId: json["UserId"],
    locationId: json["LocationId"],
    userAddressId: json["UserAddressId"],
    shippingScheduleId: json["ShippingScheduleId"],
    name: json["Name"],
    addressLine1: json["AddressLine1"],
    addressLine2: json["AddressLine2"],
    city: json["City"],
    state: json["State"],
    country: json["Country"],
    pin: json["Pin"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "TrancactionId": trancactionId,
    "UserId": userId,
    "LocationId": locationId,
    "UserAddressId": userAddressId,
    "ShippingScheduleId": shippingScheduleId,
    "Name": name,
    "AddressLine1": addressLine1,
    "AddressLine2": addressLine2,
    "City": city,
    "State": state,
    "Country": country,
    "Pin": pin,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
  };
}
