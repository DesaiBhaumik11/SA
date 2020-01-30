


import 'package:vegetos_flutter/models/GetCartResponseModel.dart';

class CheckoutRequestModel
{
  String DeliveryAddressId;

  String Name;

  String AddressLine1;

  String AddressLine2;

  String City;

  String State;

  String Country;

  String Pin;

  String MobileNo;

  String LocationId;

  String ShippingScheduleId;

  String BusinessId;

  String ShippingDetails;

  String SubTotal;

  String TaxAmount;

  String TotalAmount;

  String OfferAmount;

//  List<CartItemViewModel> CheckoutItems;

  CheckoutRequestModel({
    this.DeliveryAddressId,
    this.Name,
    this.AddressLine1,
    this.AddressLine2,
    this.City,
    this.State,
    this.Country,
    this.Pin,
    this.MobileNo,
    this.LocationId,
    this.ShippingScheduleId,
    this.BusinessId,
    this.ShippingDetails,
    this.SubTotal,
    this.TaxAmount,
    this.TotalAmount,
    this.OfferAmount,
//    this.CheckoutItems,
  });
}