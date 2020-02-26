
import 'GetAllShippingSlotModel.dart';

class GetShippingOrderModel
{
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

  String shippingStatus;
  String shippingMode;

  GetAllShippingSlotModel shippingSchedule;

  String createdBy;

  String createdOn;

  GetShippingOrderModel({
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
    this.shippingStatus,
    this.shippingMode,
    this.shippingSchedule,
    this.createdBy,
    this.createdOn,
  });

  factory GetShippingOrderModel.fromJson(Map<String, dynamic> parsedData) {
    return GetShippingOrderModel(
      trancactionId: parsedData['TrancactionId'],
      userId: parsedData['UserId'],
      locationId: parsedData['LocationId'],
      userAddressId: parsedData['UserAddressId'],
      shippingScheduleId: parsedData['ShippingScheduleId'],
      name: parsedData['Name'],
      addressLine1: parsedData['AddressLine1'],
      addressLine2: parsedData['AddressLine2'],
      city: parsedData['City'],
      state: parsedData['State'],
      country: parsedData['Country'],
      pin: parsedData['Pin'],
      shippingStatus: parsedData['ShippingStatus'],
      shippingMode: parsedData['ShippingMode'],
      shippingSchedule: parsedData['ShippingSchedule'] != null ? GetAllShippingSlotModel.fromJson(parsedData['ShippingSchedule']) : new GetAllShippingSlotModel(),
      createdBy: parsedData['CreatedBy'],
      createdOn: parsedData['CreatedOn'],
    );
  }


  static List<GetShippingOrderModel> parseList(listData) {
    var list = listData as List;
    List<GetShippingOrderModel> jobList =
    list.map((data) => GetShippingOrderModel.fromJson(data)).toList();
    return jobList;
  }


}