
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
    return TimeSlotListModel(
      Id: parsedData['Id'],
      Date: parsedData['Date'],
      TimeFrom: parsedData['TimeFrom'],
      TimeTo: parsedData['TimeTo'],
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