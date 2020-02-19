//created by prashant on 08-01-2020
class ApiResponseModel<T> {
  int statusCode;

  String message;

  T Result;

  String serverTime;

  bool isError;

  bool loaded = false;

  bool _loading = true;

  String Version;

  bool tokenExpired=false;

  ApiResponseModel({
    this.statusCode=-1,
    this.message,
    this.Result,
    this.isError,
    this.Version,
    this.serverTime,
    this.tokenExpired});

  factory ApiResponseModel.fromJson(Map<String, dynamic> parsedData) {
    return ApiResponseModel(
        statusCode: parsedData['StatusCode']!=null ? parsedData['StatusCode'] :-1 ,
        message: parsedData['Message'],
        Result: parsedData['Result'],
        isError: parsedData['isError'],
        Version: parsedData['Version'],
        serverTime: parsedData['serverTime']);
  }
}
