
//created by Prashant on 08-01-2020
class ProductDetailsModel
{
  String Language;

  String Name;

  String Summary;

  String Description;

  ProductDetailsModel({
    this.Language,
    this.Name,
    this.Summary,
    this.Description,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> parsedData) {
    return ProductDetailsModel(
      Language: parsedData['Language'],
      Name: parsedData['Name'],
      Summary: parsedData['Summary'],
      Description: parsedData['Description'],
    );
  }

  static List<ProductDetailsModel> parseList(listData) {
    var list = listData as List;
    List<ProductDetailsModel> jobList =
    list.map((data) => ProductDetailsModel.fromJson(data)).toList();
    return jobList;
  }
}