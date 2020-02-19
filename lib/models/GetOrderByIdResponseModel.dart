
import 'package:vegetos_flutter/models/OrderedItemsViewsModel.dart';

import 'GetShippingOrderModel.dart';
import 'ProductWithDefaultVarientModel.dart';

class GetOrderByIdResponseModel
{

  String invoiceNumber;
  double offerAmount;
  int paymentStatus;
  String paymentId;
  String id;
  DateTime transactionDate;
  int status;
  double shippingCharges;
  double subTotal;
  double taxAmount;
  double totalAmount;
  double totalPaid;
  String orderId;
  GetShippingOrderModel shippingOrder;
  int paymentMode;
  List<OrderItemsViewModel> orderItemsViewsModel;
  int itemCount;
  double discount;


  GetOrderByIdResponseModel({
    this.invoiceNumber,
    this.offerAmount,
    this.paymentStatus=0,
    this.paymentId="",
    this.id="",
    this.transactionDate,
    this.status,
    this.shippingCharges=0,
    this.subTotal,
    this.taxAmount,
    this.totalAmount,
    this.totalPaid,
    this.orderId="",
    this.shippingOrder,
    this.paymentMode=2,
    this.orderItemsViewsModel,
    this.itemCount,
    this.discount
  });

  factory GetOrderByIdResponseModel.fromJson(Map<String, dynamic> json) {
    return GetOrderByIdResponseModel(
      invoiceNumber:  json['InvoiceNumber'] != null ?  json['InvoiceNumber'] : "",
      offerAmount: json["OfferAmount"],
      paymentStatus: json["PaymentStatus"],
      paymentId: json["PaymentId"],
      id: json["Id"],
      transactionDate: DateTime.parse(json["TransactionDate"]),
      status: json["Status"],
      shippingCharges: json["ShippingCharges"],
      subTotal: json["SubTotal"],
      taxAmount: json["TaxAmount"],
      totalAmount: json["TotalAmount"],
      totalPaid: json["TotalPaid"],
      orderId: json["OrderId"],
      shippingOrder: json['ShippingOrder'] != null ? GetShippingOrderModel.fromJson(json['ShippingOrder']) : null,
      paymentMode: json['PaymentMode'],
      orderItemsViewsModel: json['OrderItemsViewModel'] != null ? OrderItemsViewModel.parseList(json['OrderItemsViewModel']) : null,
      itemCount: json['ItemCount'],
      discount: json['Discount']!=null ? json['Discount'] : 0.0,
    );
  }
}

