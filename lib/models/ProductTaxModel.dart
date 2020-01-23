
//created by Prashant on 08-01-2020


import 'package:vegetos_flutter/models/search_products.dart' as t;

class ProductTaxModel
{
  String ProductId;

  String TaxId;

  String StartDate;

  String EndDate;

  String UpdatedBy;

  t.Tax Tax;

  String CreatedBy;

  String CreatedOn;

  String UpdatedOn;

  ProductTaxModel({
    this.ProductId,
    this.TaxId,
    this.StartDate,
    this.EndDate,
    this.UpdatedBy,
    this.Tax,
    this.CreatedBy,
    this.CreatedOn,
    this.UpdatedOn,
  });

  factory ProductTaxModel.fromJson(Map<String, dynamic> parsedData) {
    return ProductTaxModel(
      ProductId: parsedData['ProductId'],
      TaxId: parsedData['TaxId'],
      StartDate: parsedData['StartDate'],
      EndDate: parsedData['EndDate'],
      UpdatedBy: parsedData['UpdatedBy'],
      Tax: parsedData['Tax'] != null ? t.Tax.fromJson(parsedData['Tax']) : null,
      CreatedBy: parsedData['CreatedBy'],
      CreatedOn: parsedData['CreatedOn'],
      UpdatedOn: parsedData['UpdatedOn'],
    );
  }

  static List<ProductTaxModel> parseList(listData) {
    var list = listData as List;
    List<ProductTaxModel> jobList =
    list.map((data) => ProductTaxModel.fromJson(data)).toList();
    return jobList;
  }
}