
import 'package:intl/intl.dart';

class TimeSlotListModel
{
  String Id;

  String Date;

  String TimeFrom;

  String TimeTo;

  bool IsHoliday;

  bool isSelected;

  TimeSlotListModel({
    this.Id,
    this.Date,
    this.TimeFrom,
    this.TimeTo,
    this.IsHoliday,
    this.isSelected,
  });

  factory TimeSlotListModel.fromJson(Map<String, dynamic> parsedData) {
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

    return TimeSlotListModel(
      Id: parsedData['Id'],
      Date: parsedData['Date'],
      TimeFrom: timefrom,
      TimeTo: timeto,
      IsHoliday: parsedData['IsHoliday'],
      isSelected: false,
    );
  }
  static List<TimeSlotListModel> parseList(listData) {
    var list = listData as List;
    List<TimeSlotListModel> jobList =
    list.map((data) => TimeSlotListModel.fromJson(data)).toList();
    return jobList;
  }

}