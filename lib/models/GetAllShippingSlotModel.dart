
import 'package:intl/intl.dart';

class GetAllShippingSlotModel
{
  String id;

  String date;

  DateTime dateTime;

  String timeFrom;

  String timeTo;

  bool isHoliday;

//  Object ShippingOrders;

  String createdBy;

  String createdOn;

  GetAllShippingSlotModel({
    this.id,
    this.date="",
    this.dateTime,
    this.timeFrom="",
    this.timeTo="",
    this.isHoliday,
//    this.ShippingOrders,
    this.createdBy,
    this.createdOn
  });

  factory GetAllShippingSlotModel.fromJson(Map<String, dynamic> parsedData) {
    String date=parsedData['Date']!=null ? parsedData['Date'] : "";
    String timefrom=parsedData['TimeFrom']!=null ? parsedData['TimeFrom'] : "";
    String timeto=parsedData['TimeTo']!=null ? parsedData['TimeTo'] : "";
    if(date!=""){
      if(timefrom!=""){
        DateTime dateTime=DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date.split("T")[0]+"T"+timefrom);
        timefrom = new DateFormat("hh:mm a").format(dateTime);
      }
      if(timeto!=""){
        DateTime dateTime=DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date.split("T")[0]+"T"+timeto);
        timeto = new DateFormat("hh:mm a").format(dateTime);
      }
    }
    return GetAllShippingSlotModel(
      id: parsedData['Id'],
      date: date,
      dateTime: parsedData['Date']!=null ? DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(parsedData['Date']) : null,
      timeFrom: timefrom,
      timeTo: timeto,
      isHoliday: parsedData['IsHoliday'],
//      ShippingOrders: parsedData['ShippingOrders'],
      createdBy: parsedData['CreatedBy'],
      createdOn: parsedData['CreatedOn'],
    );
  }

  static List<GetAllShippingSlotModel> parseList(listData) {
    var list = listData as List;
    List<GetAllShippingSlotModel> jobList =
    list.map((data) => GetAllShippingSlotModel.fromJson(data)).toList();
    return jobList;
  }
}