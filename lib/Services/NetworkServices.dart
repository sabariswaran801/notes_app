import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:dio/io.dart';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/Url/Url.dart';

class NetworkService {
  final dio = Dio();

  Future<void> dioCertificate() async {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
  }

  Future<dynamic> getApiConnection({required String url}) async {
    try {
      log("gmgker");
      // await dioCertificate();
      // var baseUrl = await getBaseUrlFromLocal();
      log("url : \x1B[31m${ApiUrl.baseUrl}$url\x1B[0m");
      final fullUrl = Uri.parse('${ApiUrl.baseUrl}$url').toString();
      final response = await dio.get(fullUrl);
      log("hbhyyb$response");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Warning ${response.statusCode}");
      }
    } on SocketException {
      throw ('No internet Connection');
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e, stacktrace) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        timeInSecForIosWeb: 3,
      );
      log("Non-Dio error: $e");
      log(stacktrace.toString());
    }
  }

  Future<dynamic> postApiConnection({
    required String url,
    required params,
  }) async {
    try {
      // dio.options.headers['content-Type'] = 'application/json';
      // dio.options.headers['API_KEY'] = 'Hj5LwBABDeapPayv4auMkXWgKvj8B5LV9';

      var body = jsonEncode(params);
      log("url : \x1B[31m${ApiUrl.baseUrl + url}\x1B[0m");
      log("params : \x1B[32m$body\x1B[0m");

      var response = await dio.post(ApiUrl.baseUrl + url, data: body);

      if (response.statusCode == 200) {
        log("response : ${response.data}");
        return response.data;
      } else {
        throw Exception("Warning ${response.statusCode}");
      }
    } on SocketException {
      throw ('No internet Connection');
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e, stacktrace) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        timeInSecForIosWeb: 3,
      );
      log("Non-Dio error: $e");
      log(stacktrace.toString());
    }
  }

  Future<dynamic> putApiConnection({
    required String url,
    required Map<String, dynamic> params,
  }) async {
    try {
      var body = jsonEncode(params);
      log("url : \x1B[31m${ApiUrl.baseUrl + url}\x1B[0m");
      log("params : \x1B[32m$body\x1B[0m");

      var response = await dio.put(
        ApiUrl.baseUrl + url,
        data: body,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        log("response : ${response.data}");
        return response.data;
      } else {
        throw Exception("Warning ${response.statusCode}");
      }
    } on SocketException {
      throw ('No internet Connection');
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e, stacktrace) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        timeInSecForIosWeb: 3,
      );
      log("Non-Dio error: $e");
      log(stacktrace.toString());
      rethrow;
    }
  }

  Future<dynamic> deleteApiConnection({required String url}) async {
    try {
      log("url : \x1B[31m${ApiUrl.baseUrl + url}\x1B[0m");

      var response = await dio.delete(
        ApiUrl.baseUrl + url,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        log("response : ${response.data}");
        return response.data;
      } else {
        throw Exception("Warning ${response.statusCode}");
      }
    } on SocketException {
      throw ('No internet Connection');
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e, stacktrace) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        timeInSecForIosWeb: 3,
      );
      log("Non-Dio error: $e");
      log(stacktrace.toString());
      rethrow;
    }
  }
}

void _handleDioError(DioException e) {
  String message;
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      message = "Connection timeout. Please try again.";
      break;
    case DioExceptionType.sendTimeout:
      message = "Request send timeout.";
      break;
    case DioExceptionType.receiveTimeout:
      message = "Server took too long to respond.";
      break;
    case DioExceptionType.badResponse:
      message = "Server error: Something went wrong. Try again.";
      break;
    case DioExceptionType.cancel:
      message = "Request was cancelled.";
      break;
    case DioExceptionType.connectionError:
      message = "No internet connection.";
      break;
    case DioExceptionType.unknown:
    default:
      message = "Server error: Something went wrong. Try again.";
  }

  Fluttertoast.showToast(msg: message, timeInSecForIosWeb: 3);
}
