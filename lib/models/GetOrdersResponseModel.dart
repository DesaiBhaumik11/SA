
import 'package:intl/intl.dart';
import 'package:vegetos_flutter/Utils/Enumaration.dart';

class GetOrdersResponseModel
{
  dynamic invoiceNumber;
  dynamic offerId;
  double offerAmount;
  dynamic quotationId;
  dynamic quotation;
  List<dynamic> returnItems;
  List<dynamic> transactionLines;
  String buyerSupplierId;
  String paymentStatus;
  String paymentId;
  String id;
  dynamic transactionNumber;
  String businessId;
  String locationId;
  DateTime transactionDate;
  String displayTransactionData;
  int status;
  dynamic referenceNo;
  dynamic additionalNote;
  double shippingCharges;
  String shippingDetails;
  double subTotal;
  double taxAmount;
  double totalAmount;
  List<dynamic> transactionDocuments;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  GetOrdersResponseModel({
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
    this.displayTransactionData,
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

  factory GetOrdersResponseModel.fromJson(Map<String, dynamic> json) {
    return GetOrdersResponseModel(
      invoiceNumber: json["InvoiceNumber"],
      offerId: json["OfferId"],
      offerAmount: json["OfferAmount"],
      quotationId: json["QuotationId"],
      quotation: json["Quotation"],
      returnItems: json["ReturnItems"] != null ? List<dynamic>.from(json["ReturnItems"].map((x) => x)) : null,
      transactionLines: json["TransactionLines"],
      buyerSupplierId: json["BuyerSupplierId"],
      paymentStatus: json["PaymentStatus"],
      paymentId: json["PaymentId"],
      id: json["Id"],
      transactionNumber: json["TransactionNumber"],
      businessId: json["BusinessId"],
      locationId: json["LocationId"],
      transactionDate: json["TransactionDate"] != null ? DateTime.parse(json["TransactionDate"]) : null,
      displayTransactionData: json["TransactionDate"] != null ? DateFormat(EnumDateFormat.dateMonth).format(DateTime.parse(json["TransactionDate"])) : null,
      status: json["Status"],
      referenceNo: json["ReferenceNo"],
      additionalNote: json["AdditionalNote"],
      shippingCharges: json["ShippingCharges"],
      shippingDetails: json["ShippingDetails"],
      subTotal: json["SubTotal"],
      taxAmount: json["TaxAmount"],
      totalAmount: json["TotalAmount"],
      transactionDocuments: json["TransactionDocuments"],
      updatedBy: json["UpdatedBy"],
      createdBy: json["CreatedBy"],
      createdOn: DateTime.parse(json["CreatedOn"]),
      updatedOn: json["UpdatedOn"],
    );
  }

  static List<GetOrdersResponseModel> parseList(listData) {
    var list = listData as List;
    List<GetOrdersResponseModel> jobList =
    list.map((data) => GetOrdersResponseModel.fromJson(data)).toList();
    jobList.sort((a, b) => b.createdOn.compareTo(a.createdOn));
    return jobList;
  }
}