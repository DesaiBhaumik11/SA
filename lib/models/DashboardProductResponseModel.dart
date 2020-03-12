


import 'package:vegetos_flutter/models/ProductWithDefaultVarientModel.dart';

class DashboardProductResponseModel
{
  List<ProductWithDefaultVarientModel> Results;

  int CurrentPage;

  int PageCount;

  int PageSize;

  int RowCount;

  int FirstRowOnPage;

  int LastRowOnPage;

  DashboardProductResponseModel({
    this.Results,
    this.CurrentPage,
    this.PageCount,
    this.PageSize,
    this.RowCount,
    this.FirstRowOnPage,
    this.LastRowOnPage,
  });

  factory DashboardProductResponseModel.fromJson(Map<String, dynamic> parsedData) {
    return DashboardProductResponseModel(
      Results: parsedData['Results'] != null ? ProductWithDefaultVarientModel.parseList(parsedData['Results']) : null,
      CurrentPage: parsedData['CurrentPage'],
      PageCount: parsedData['PageCount'],
      PageSize: parsedData['PageSize'],
      RowCount: parsedData['RowCount'],
      FirstRowOnPage: parsedData['FirstRowOnPage'],
      LastRowOnPage: parsedData['LastRowOnPage'],
    );
  }

}