
import 'package:vegetos_flutter/models/TimeSlotListModel.dart';
import 'package:intl/intl.dart';

class DisplayShippingModel
{
  String Key;

  DateTime keyDate;

  List<TimeSlotListModel> Items;

  DisplayShippingModel({
    this.Key,
    this.keyDate,
    this.Items
  });

  factory DisplayShippingModel.fromJson(Map<String, dynamic> parsedData) {
    return DisplayShippingModel(
      Key: parsedData['Key'],
      keyDate: DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(parsedData['Key']),
      Items: parsedData['Items'] != null ? TimeSlotListModel.parseList(parsedData['Items']) : null,
    );
  }

  static List<DisplayShippingModel> parseList(listData) {
    var list = listData as List;
    List<DisplayShippingModel> jobList =
    list.map((data) => DisplayShippingModel.fromJson(data)).toList();
    return jobList;
  }
}