
class GetAllShippingSlotModel
{
  String Id;

  String Date;

  String TimeFrom;

  String TimeTo;

  bool IsHoliday;

  Object ShippingOrders;

  String CreatedBy;

  String CreatedOn;

  GetAllShippingSlotModel({
    this.Id,
    this.Date,
    this.TimeFrom,
    this.TimeTo,
    this.IsHoliday,
    this.ShippingOrders,
    this.CreatedBy,
    this.CreatedOn
  });

  factory GetAllShippingSlotModel.fromJson(Map<String, dynamic> parsedData) {
    return GetAllShippingSlotModel(
      Id: parsedData['Id'],
      Date: parsedData['Date'],
      TimeFrom: parsedData['TimeFrom'],
      TimeTo: parsedData['TimeTo'],
      IsHoliday: parsedData['IsHoliday'],
      ShippingOrders: parsedData['ShippingOrders'],
      CreatedBy: parsedData['CreatedBy'],
      CreatedOn: parsedData['CreatedOn'],
    );
  }

  static List<GetAllShippingSlotModel> parseList(listData) {
    var list = listData as List;
    List<GetAllShippingSlotModel> jobList =
    list.map((data) => GetAllShippingSlotModel.fromJson(data)).toList();
    return jobList;
  }
}