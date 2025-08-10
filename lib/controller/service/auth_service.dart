import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scrappy/core/utils/appUrls.dart';
import 'package:scrappy/core/utils/app_const.dart';
import 'package:scrappy/model/auth_model.dart';
import 'package:scrappy/model/register_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<AuthResponse> register(RegisterRequest request) async {
  try {
    print("register response 0} - Starting registration");
    
    final response = await http.post(
      Uri.parse(AppApi.register),
      body: json.encode(request.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print("register body: ${response.body}");
    print("Response status code: ${response.statusCode}");
              final authResponse = AuthResponse.fromJson(json.decode(response.body));

    
    if (response.statusCode == 200 && authResponse.statusCode=="200" ) {
      print("register response 1} - Status 200 OK");
      print("Parsed AuthResponse successfully");
      return authResponse;
    } else {
      print("register response 2} - Status NOT 200");
      
      final responseBody = json.decode(response.body);
      print("Decoded response body: $responseBody");
      
      final errorMessage = responseBody['message'] ?? 'Failed to register';
      print("Error message extracted: $errorMessage");
      
      // AppConst.toastMsg(
      //   msg: errorMessage,
      //   backgroundColor: Colors.red,
      // );
      print("Toast message shown with error");
      
      throw Exception(errorMessage);
    }
  } catch (e) {
    print("register response 3} - Caught exception: $e");
    
    AppConst.toastMsg(
      msg: e.toString(),
      backgroundColor: Colors.red,
    );
    print("Toast message shown with exception");
    
    throw Exception('Something went wrong: $e');
  }
}


  Future<bool> generateOtp({
  required String email,
  required String mobile,
}) async {
  try {
    print("generateOtp called with email: $email, mobile: $mobile");

    final response = await http.post(
      Uri.parse(AppApi.generateOtp),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "email": email,
        "mobile": mobile,
      }),
    );

    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Decoded response data: $data");

      final message = data['message'] ?? 'No message';
      print("Message from server: $message");

      AppConst.toastMsg(
        msg: message,
        backgroundColor: Colors.green,
      );
      print("Toast shown with success message");

      final statusCode = data['status_code'] ?? '';
      print("status_code from response: $statusCode");

      return statusCode == "200";
    } else {
      print("generateOtp failed: status code not 200");
      return false;
    }
  } catch (e) {
    print("generateOtp caught exception: $e");
    return false;
  }
}


  Future<bool> verifyOtp({
  required String email,
  required String mobile,
  required String mobileOtp,
}) async {
  try {
    print("verifyOtp called with email: $email, mobile: $mobile, mobileOtp: $mobileOtp");

    final response = await http.post(
      Uri.parse(AppApi.verifyOtp),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "email": email,
        "mobile": mobile,
        "mobile_otp": mobileOtp,
      }),
    );

    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Decoded response data: $data");

      if (data['status_code'] == "200") {
        print("OTP verification successful");

        AppConst.toastMsg(
          msg: 'OTP verified. Please login to continue',
          backgroundColor: Colors.green,
        );
        print("Toast shown for success");

        // Uncomment if you want to debug tokens or user data
        // print("Access token: ${data['data'][0]['access_token']}");
        // print("User details: ${data['data'][0]['user_details']}");

        return true;
      } else {
        final errorMsg = data['message'] ?? 'OTP verification failed';
        print("OTP verification failed with message: $errorMsg");

        AppConst.toastMsg(
          msg: errorMsg,
          backgroundColor: Colors.red,
        );
        print("Toast shown for failure");
        return false;
      }
    } else {
      final responseBody = json.decode(response.body);
      final errorMsg = responseBody['message'] ?? "Something Went Wrong";
      print("Response status not 200, message: $errorMsg");

      AppConst.toastMsg(
        msg: errorMsg,
        backgroundColor: Colors.red,
      );
      print("Toast shown for non-200 response");
      return false;
    }
  } catch (e) {
    print("Exception caught in verifyOtp: $e");

    AppConst.toastMsg(
      msg: "Something Went Wrong",
      backgroundColor: Colors.red,
    );
    print("Toast shown for exception");
    return false;
  }
}


  Future<bool> login({
  required String email,
  required String password,
}) async {
  try {
    final Map<String, String> body = {
      "email": email,
      "password": password,
    };

    print("login called ${AppApi.login} body is $body");

    final response = await http.post(
      Uri.parse(AppApi.login),
      headers: {
        "Content-Type": "application/json",
        "Connection": "keep-alive",
        "Accept-Encoding": "gzip, deflate",
        "User-Agent": "Fetch Client",
        "Accept": "*/*",
        "Cache-Control": "no-cache"
      },
      body: jsonEncode(body),
    );

    print("login res ${response.statusCode} and body ${response.body}");

    Map<String, dynamic>? jsonData;
    try {
      jsonData = response.body.isNotEmpty
          ? jsonDecode(response.body) as Map<String, dynamic>
          : null;
    } catch (_) {
      jsonData = null;
    }

    if (response.statusCode == 200 &&
        jsonData != null &&
        jsonData['status_code']?.toString() == '200') {
      final authResponse = AuthResponse.fromJson(jsonData);
      if (authResponse.data == null || authResponse.data!.isEmpty) {
        AppConst.toastMsg(
            msg: jsonData['message'] ?? 'Login failed: No user data',
            backgroundColor: Colors.red);
        return false;
      }

      final firstUser = authResponse.data!.first;
      final token = firstUser.authToken ?? '';
      final userDetails = firstUser.userDetails;
      final userId = userDetails?.id;

      if (token.isEmpty || userId == null) {
        AppConst.toastMsg(
            msg: 'Login failed',
            backgroundColor: Colors.red);
        return false;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('userId', userId.toString());
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('user_name', userDetails?.name ?? '');
      await prefs.setString('user_email', userDetails?.email ?? '');
      await prefs.setString('user_mobile', userDetails?.mobile ?? '');
      // if (userDetails?.roleId != null) {
      //   await prefs.setInt('role_id', userDetails!.roleId!.toInt());
      // }
      await prefs.setString('dark_mode', userDetails?.darkMode ?? '');
      await prefs.setString(
          'user_json', jsonEncode(userDetails?.toJson() ?? {}));

      // ✅ Debug print everything stored in prefs
      print("------- SharedPreferences Data -------");
      for (String key in prefs.getKeys()) {
        print("$key: ${prefs.get(key)}");
      }
      print("---------------------------------------");

      AppConst.toastMsg(
          msg: jsonData['message'] ?? 'Login successful',
          backgroundColor: Colors.green);
      return true;
    } else {
      final msg = jsonData != null
          ? (jsonData['message'] ?? 'Login failed')
          : 'Something Went Wrong';
      AppConst.toastMsg(msg: msg, backgroundColor: Colors.red);
      return false;
    }
  } catch (e, stackTrace) {
    print("Login Error: $e\n$stackTrace");
    AppConst.toastMsg(
        msg: "Something Went Wrong", backgroundColor: Colors.red);
    return false;
  }
}



  Future<
    void
  >
  logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
