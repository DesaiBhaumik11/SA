import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

abstract class NetworkUtils{
  static String _baseUrl="http://artismicro.archisys.biz:5101/";
  static Future<String> postRequest({Map<String,String> body,String endpoint,Map<String,String> headers}) async{
    // set up POST request arguments
    String url = '$_baseUrl$endpoint';
    Map<String, String> headerMap = headers??new Map();
    Map<String, String> bodyMap =body??new Map();
    Response response = await post(url, headers: headerMap,body: bodyMap);
    return response.body;
  }

  static Future<String> getRequest({String endPoint}) async {
    String url="$_baseUrl$endPoint";
    print("Url = $url");
    Response response=await get(url);
    return response.body;
  }

  static bool trustSelfSigned = true;
  static HttpClient _getHttpClient() {
    HttpClient httpClient = new HttpClient()
      ..connectionTimeout = const Duration(seconds: 10)
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }
  static Future<String> fileUploadMultipart({Map<String,String> body,String pathKey,String endPoint,String fileName,String filePath, OnUploadProgressCallback onUploadProgress}) async {

    final url = '$_baseUrl$endPoint';
    print("url multipart = $url");
    print("body multipart = $body");
    print("filePath multipart = $filePath");
    print("fileName multipart = $fileName");

    final httpClient = _getHttpClient();

    final request = await httpClient.postUrl(Uri.parse(url));

    int byteCount = 0;

//     final fileStreamFile = file.openRead();
//
//     var multipart = MultipartFile("file", fileStreamFile, file.lengthSync(),
//         filename: fileUtil.basename(file.path));

    var requestMultipart = MultipartRequest("", Uri.parse("uri"));
    if(filePath!=null&&filePath.isNotEmpty)
      {
        var multipart = await MultipartFile.fromPath(pathKey, filePath);
        requestMultipart.files.add(multipart);
      }
    requestMultipart.fields.addAll(body);

    var msStream = requestMultipart.finalize();

    var totalByteLength = requestMultipart.contentLength;

    request.contentLength = totalByteLength;

    request.headers.set(
        HttpHeaders.contentTypeHeader, requestMultipart.headers[HttpHeaders.contentTypeHeader]);

    Stream<List<int>> streamUpload = msStream.transform(
      new StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
            // CALL STATUS CALLBACK;
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
        },
      ),
    );

    await request.addStream(streamUpload);

    final httpResponse = await request.close();
//
    var statusCode = httpResponse.statusCode;

    return await readResponseAsString(httpResponse);
  }

  static Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = new Completer<String>();
    var contents = new StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}