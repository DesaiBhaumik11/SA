
//created by Prashant on 08-01-2020
class UnitsModel
{
  String UnitId;

  String BaseUnitId;

  double BaseUnitMultiplier;

  int DecimalPlaces;

  String Language;

  String Code;

  String Name;

  UnitsModel({
    this.UnitId="",
    this.BaseUnitId="",
    this.BaseUnitMultiplier=0,
    this.DecimalPlaces=0,
    this.Language="",
    this.Code="",
    this.Name="",
  });

  factory UnitsModel.fromJson(Map<String, dynamic> parsedData) {
    return UnitsModel(
      UnitId: parsedData['UnitId'],
      BaseUnitId: parsedData['BaseUnitId'],
      BaseUnitMultiplier: parsedData['BaseUnitMultiplier'],
      DecimalPlaces: parsedData['DecimalPlaces'],
      Language: parsedData['Language'],
      Code: parsedData['Code'],
      Name: parsedData['Name'],
    );
  }

  static List<UnitsModel> parseList(listData) {
    var list = listData as List;
    List<UnitsModel> jobList =
    list.map((data) => UnitsModel.fromJson(data)).toList();
    return jobList;
  }
}