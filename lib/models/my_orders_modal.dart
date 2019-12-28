// To parse this JSON data, do
//
//     final myOrdersModal = myOrdersModalFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';
MyOrdersModal myOrdersModalFromJson(String str) => MyOrdersModal.fromJson(json.decode(str));

String myOrdersModalToJson(MyOrdersModal data) => json.encode(data.toJson());

class MyOrdersModal extends ChangeNotifier {
  List<Result> result;
  int statusCode;
  String message;
  bool isError;

  bool loaded=false;
  bool is_loading=false;


  MyOrdersModal({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory MyOrdersModal.fromJson(Map<String, dynamic> json) => MyOrdersModal(
    result: List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
    statusCode: json["StatusCode"],
    message: json["Message"],
    isError: json["IsError"],
  );

  Map<String, dynamic> toJson() => {
    "Result": List<dynamic>.from(result.map((x) => x.toJson())),
    "StatusCode": statusCode,
    "Message": message,
    "IsError": isError,
  };


  void setData(json) {
    result = List() ;
    if(json["Result"]!=null) {
      result = List<Result>.from(json["Result"].map((x) => Result.fromJson(x)));
      statusCode = json["StatusCode"];
      message = json["Message"];
      isError = json["IsError"];


    }
    loaded =true ;
    notifyListeners() ;
  }

  getOrders(){
    if(!is_loading){
      is_loading = true ;
      NetworkUtils.getRequest(endPoint: Constant.GetOrders).then((response){
        is_loading = false  ;
        print("getOrders = $response");

        setData(json.decode(response)) ;

      }).catchError((e){
        loaded =true ;
        setData({});
        //notifyListeners();

      });
    }


  }


}

class Result {
  dynamic invoiceNumber;
  dynamic offerId;
  double offerAmount;
  dynamic quotationId;
  dynamic quotation;
  List<dynamic> returnItems;
  List<TransactionLine> transactionLines;
  String buyerSupplierId;
  int paymentStatus;
  String paymentId;
  String id;
  dynamic transactionNumber;
  String businessId;
  String locationId;
  DateTime transactionDate;
  String status;
  dynamic referenceNo;
  dynamic additionalNote;
  double shippingCharges;
  ShippingDetails shippingDetails;
  double subTotal;
  double taxAmount;
  double totalAmount;
  List<dynamic> transactionDocuments;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  Result({
    this.invoiceNumber,
    this.offerId,
    this.offerAmount,
    this.quotationId,
    this.quotation,
    this.returnItems,
    this.transactionLines,
    this.buyerSupplierId,
    this.paymentStatus,
    this.paymentId,
    this.id,
    this.transactionNumber,
    this.businessId,
    this.locationId,
    this.transactionDate,
    this.status,
    this.referenceNo,
    this.additionalNote,
    this.shippingCharges,
    this.shippingDetails,
    this.subTotal,
    this.taxAmount,
    this.totalAmount,
    this.transactionDocuments,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    invoiceNumber: json["InvoiceNumber"],
    offerId: json["OfferId"],
    offerAmount: json["OfferAmount"],
    quotationId: json["QuotationId"],
    quotation: json["Quotation"],
    returnItems: List<dynamic>.from(json["ReturnItems"].map((x) => x)),
    transactionLines: List<TransactionLine>.from(json["TransactionLines"].map((x) => TransactionLine.fromJson(x))),
    buyerSupplierId: json["BuyerSupplierId"],
    paymentStatus: json["PaymentStatus"],
    paymentId: json["PaymentId"],
    id: json["Id"],
    transactionNumber: json["TransactionNumber"],
    businessId: json["BusinessId"],
    locationId: json["LocationId"],
    transactionDate: DateTime.parse(json["TransactionDate"]),
    status: json["Status"],
    referenceNo: json["ReferenceNo"],
    additionalNote: json["AdditionalNote"],
    shippingCharges: json["ShippingCharges"],
    shippingDetails: shippingDetailsValues.map[json["ShippingDetails"]],
    subTotal: json["SubTotal"],
    taxAmount: json["TaxAmount"],
    totalAmount: json["TotalAmount"],
    transactionDocuments: List<dynamic>.from(json["TransactionDocuments"].map((x) => x)),
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "InvoiceNumber": invoiceNumber,
    "OfferId": offerId,
    "OfferAmount": offerAmount,
    "QuotationId": quotationId,
    "Quotation": quotation,
    "ReturnItems": List<dynamic>.from(returnItems.map((x) => x)),
    "TransactionLines": List<dynamic>.from(transactionLines.map((x) => x.toJson())),
    "BuyerSupplierId": buyerSupplierId,
    "PaymentStatus": paymentStatus,
    "PaymentId": paymentId,
    "Id": id,
    "TransactionNumber": transactionNumber,
    "BusinessId": businessId,
    "LocationId": locationId,
    "TransactionDate": transactionDate.toIso8601String(),
    "Status": status,
    "ReferenceNo": referenceNo,
    "AdditionalNote": additionalNote,
    "ShippingCharges": shippingCharges,
    "ShippingDetails": shippingDetailsValues.reverse[shippingDetails],
    "SubTotal": subTotal,
    "TaxAmount": taxAmount,
    "TotalAmount": totalAmount,
    "TransactionDocuments": List<dynamic>.from(transactionDocuments.map((x) => x)),
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}

enum ShippingDetails { THIS_IS_THE_SHIPPING_DETAIL }

final shippingDetailsValues = EnumValues({
  "this is the shipping detail": ShippingDetails.THIS_IS_THE_SHIPPING_DETAIL
});

class TransactionLine {
  String id;
  String transactionId;
  String productId;
  String productVariantId;
  double quantity;
  String unitId;
  dynamic expiryDate;
  dynamic lotNumber;
  dynamic mfgDate;
  dynamic serialNumber;
  dynamic batchNumber;
  double taxAmount;
  double totalLineAmount;
  double unitPrice;
  List<dynamic> transactionLineDocuments;
  List<dynamic> transactionLineTaxes;

  TransactionLine({
    this.id,
    this.transactionId,
    this.productId,
    this.productVariantId,
    this.quantity,
    this.unitId,
    this.expiryDate,
    this.lotNumber,
    this.mfgDate,
    this.serialNumber,
    this.batchNumber,
    this.taxAmount,
    this.totalLineAmount,
    this.unitPrice,
    this.transactionLineDocuments,
    this.transactionLineTaxes,
  });

  factory TransactionLine.fromJson(Map<String, dynamic> json) => TransactionLine(
    id: json["Id"],
    transactionId: json["TransactionId"],
    productId: json["ProductId"],
    productVariantId: json["ProductVariantId"],
    quantity: json["Quantity"],
    unitId: json["UnitId"],
    expiryDate: json["ExpiryDate"],
    lotNumber: json["LotNumber"],
    mfgDate: json["MfgDate"],
    serialNumber: json["SerialNumber"],
    batchNumber: json["BatchNumber"],
    taxAmount: json["TaxAmount"],
    totalLineAmount: json["TotalLineAmount"],
    unitPrice: json["UnitPrice"],
    transactionLineDocuments: List<dynamic>.from(json["TransactionLineDocuments"].map((x) => x)),
    transactionLineTaxes: List<dynamic>.from(json["TransactionLineTaxes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "TransactionId": transactionId,
    "ProductId": productId,
    "ProductVariantId": productVariantId,
    "Quantity": quantity,
    "UnitId": unitId,
    "ExpiryDate": expiryDate,
    "LotNumber": lotNumber,
    "MfgDate": mfgDate,
    "SerialNumber": serialNumber,
    "BatchNumber": batchNumber,
    "TaxAmount": taxAmount,
    "TotalLineAmount": totalLineAmount,
    "UnitPrice": unitPrice,
    "TransactionLineDocuments": List<dynamic>.from(transactionLineDocuments.map((x) => x)),
    "TransactionLineTaxes": List<dynamic>.from(transactionLineTaxes.map((x) => x)),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
