
class GetDefaultsResponseModel
{
  String ImageUrl;

  GetDefaultsResponseModel({
    this.ImageUrl
  });

  factory GetDefaultsResponseModel.fromJson(Map<String, dynamic> parsedData) {
    return GetDefaultsResponseModel(
      ImageUrl: parsedData['ImageUrl'],
    );
  }
}