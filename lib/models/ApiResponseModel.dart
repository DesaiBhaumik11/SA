class ApiResponseModel<T> {
  int statusCode;

  String message;

  T data;

  String serverTime;

  ApiResponseModel({this.statusCode, this.message, this.data, this.serverTime});

  factory ApiResponseModel.fromJson(Map<String, dynamic> parsedData) {
    return ApiResponseModel(
        statusCode: parsedData['statusCode'],
        message: parsedData['message'],
        data: parsedData['data'],
        serverTime: parsedData['serverTime']);
  }
}
