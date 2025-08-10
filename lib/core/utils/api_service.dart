import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scrappy/controller/service/header.dart';

class ApiResult<T> {
  final T? data;
  final String? error;

  ApiResult.success(this.data) : error = null;
  ApiResult.failure(this.error) : data = null;

  bool get isSuccess => data != null;
}

enum RequestMethod { get, post, put, delete }

class ApiService {
  static Future<ApiResult<T>> request<T>({
    required String url,
    required RequestMethod method,
    Map<String, dynamic>? body,
    required T Function(dynamic) parser,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final headers = Header.header(pref);

    http.Response response;

    // Start request log
    print("[API SERVICE] REQUEST START");
    print("[API SERVICE] URL: $url");
    print("[API SERVICE] Method: ${method.name.toUpperCase()}");
    print("[API SERVICE] Headers: $headers");
    if (body != null) {
      print("[API SERVICE] Body: ${jsonEncode(body)}");
    }

    final startTime = DateTime.now();

    try {
      switch (method) {
        case RequestMethod.post:
          response = await http.post(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(body),
          );
          break;

        case RequestMethod.put:
          response = await http.put(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(body),
          );
          break;

        case RequestMethod.delete:
          response = await http.delete(
            Uri.parse(url),
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          break;

        case RequestMethod.get:
          response = await http.get(
            Uri.parse(url),
            headers: headers,
          );
          break;
      }

      final duration = DateTime.now().difference(startTime).inMilliseconds;
      print("[API SERVICE] RESPONSE RECEIVED in ${duration}ms");
      print("[API SERVICE] Status Code: ${response.statusCode}");
      print("[API SERVICE] Raw Body: ${response.body}");

      final decoded = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("[API SERVICE] Request successful");
        return ApiResult.success(parser(decoded));
      } else {
        final errorMsg = decoded is Map && decoded['message'] != null
            ? decoded['message'].toString()
            : "Something went wrong";
        print("[API SERVICE] Request failed with error: $errorMsg");
        return ApiResult.failure(errorMsg);
      }
    } catch (e) {
      print("[API SERVICE] Exception occurred inside catch: $e");
      return ApiResult.failure("Something went wrong");
    }
  }
}
