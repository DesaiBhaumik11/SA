
class AppFirstStartResponseModel
{
  String token;

  AppFirstStartResponseModel({
    this.token,
  });

  factory AppFirstStartResponseModel.fromJson(Map<String, dynamic> json) => AppFirstStartResponseModel(
    token: json["Token"],
  );

  Map<String, dynamic> toJson() => {
    "Token": "Bearer " + token,
  };
}