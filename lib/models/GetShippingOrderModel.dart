
import 'GetAllShippingSlotModel.dart';

class GetShippingOrderModel
{
  String TrancactionId;

  String UserId;

  String LocationId;

  String UserAddressId;

  String ShippingScheduleId;

  String Name;

  String AddressLine1;

  String AddressLine2;

  String City;

  String State;

  String Country;

  String Pin;

  GetAllShippingSlotModel ShippingSchedule;

  String CreatedBy;

  String CreatedOn;

  GetShippingOrderModel({
    this.TrancactionId,
    this.UserId,
    this.LocationId,
    this.UserAddressId,
    this.ShippingScheduleId,
    this.Name,
    this.AddressLine1,
    this.AddressLine2,
    this.City,
    this.State,
    this.Country,
    this.Pin,
    this.ShippingSchedule,
    this.CreatedBy,
    this.CreatedOn,
  });

  factory GetShippingOrderModel.fromJson(Map<String, dynamic> parsedData) {
    return GetShippingOrderModel(
      TrancactionId: parsedData['TrancactionId'],
      UserId: parsedData['UserId'],
      LocationId: parsedData['LocationId'],
      UserAddressId: parsedData['UserAddressId'],
      ShippingScheduleId: parsedData['ShippingScheduleId'],
      Name: parsedData['Name'],
      AddressLine1: parsedData['AddressLine1'],
      AddressLine2: parsedData['AddressLine2'],
      City: parsedData['City'],
      State: parsedData['State'],
      Country: parsedData['Country'],
      Pin: parsedData['Pin'],
      ShippingSchedule: parsedData['ShippingSchedule'] != null ? GetAllShippingSlotModel.fromJson(parsedData['ShippingSchedule']) : null,
      CreatedBy: parsedData['CreatedBy'],
      CreatedOn: parsedData['CreatedOn'],
    );
  }


  static List<GetShippingOrderModel> parseList(listData) {
    var list = listData as List;
    List<GetShippingOrderModel> jobList =
    list.map((data) => GetShippingOrderModel.fromJson(data)).toList();
    return jobList;
  }


}