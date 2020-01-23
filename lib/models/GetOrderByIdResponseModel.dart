
import 'GetShippingOrderModel.dart';
import 'ProductWithDefaultVarientModel.dart';

class GetOrderByIdResponseModel
{
  double TotalAmount;

  double DeliveryCharges;

  double SubTotal;

  double Discount;

  GetShippingOrderModel ShippingOrder;

  String OrderId;

  String InvoiceNumber;

  int PaymentMode;

  List<ProductWithDefaultVarientModel> OrderedItemsViewsModel;

  int ItemCount;

  GetOrderByIdResponseModel({
    this.TotalAmount,
    this.DeliveryCharges,
    this.SubTotal,
    this.Discount,
    this.ShippingOrder,
    this.OrderId,
    this.InvoiceNumber,
    this.PaymentMode,
    this.OrderedItemsViewsModel,
    this.ItemCount,
  });

  factory GetOrderByIdResponseModel.fromJson(Map<String, dynamic> parsedData) {
    return GetOrderByIdResponseModel(
      TotalAmount: parsedData['TotalAmount'],
      DeliveryCharges: parsedData['DeliveryCharges'],
      SubTotal: parsedData['SubTotal'],
      Discount: parsedData['Discount'],
      ShippingOrder: parsedData['ShippingOrder'] != null ? GetShippingOrderModel.fromJson(parsedData['ShippingOrder']) : null,
      OrderId: parsedData['OrderId'],
      InvoiceNumber: parsedData['InvoiceNumber'],
      PaymentMode: parsedData['PaymentMode'],
      OrderedItemsViewsModel: parsedData['OrderedItemsViewsModel'] != null ?
            ProductWithDefaultVarientModel.parseList(parsedData['OrderedItemsViewsModel']) : null,
      ItemCount: parsedData['ItemCount'],
    );
  }
}