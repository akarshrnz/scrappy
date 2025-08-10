import 'package:flutter/material.dart';
import 'package:scrappy/controller/service/auth_service.dart';
import 'package:scrappy/model/auth_model.dart';
import 'package:scrappy/model/register_response.dart';
import 'package:scrappy/views/screens/BottomNavNar.dart';
import 'package:scrappy/views/screens/LoginScreen.dart' show LoginScreen;
import 'package:scrappy/views/screens/HomeScreen.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool verifyOtpLoading = false;
  bool get isLoading => _isLoading;

  Future<bool?> registerUser({
  required String name,
  required String email,
  required String password,
  required String mobile,
}) async {
  print('registerUser called with:');
  print('  name: $name');
  print('  email: $email');
  print('  password: ${'*' * password.length}'); // Mask password
  print('  mobile: $mobile');

  _isLoading = true;
  notifyListeners();

  try {
    print('Calling _authService.register...');
    final response = await _authService.register(
      RegisterRequest(
        name: name,
        email: email,
        password: password,
        mobile: mobile,
      ),
    );
    print('Response status code: ${response.statusCode}');

    bool success = response.statusCode == "200";

    if (success) {
      print('Registration successful, generating OTP...');
      bool? res = await generateOtpForUser(
        email: email,
        mobile: mobile,
      );
      print('OTP generation result: $res');
      _isLoading = false;
      notifyListeners();
      return res;
    } else {
      print('Registration failed.');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  } catch (e, stackTrace) {
    print('Exception in registerUser: $e');
    print(stackTrace);
    _isLoading = false;
    notifyListeners();
    return null;
  }
}


 Future<bool?> generateOtpForUser({
  required String email,
  required String mobile,
}) async {
  print('generateOtpForUser called with: email=$email, mobile=$mobile');
  try {
    final otpResult = await _authService.generateOtp(
      email: email,
      mobile: mobile,
    );
    print('OTP generation service returned: $otpResult');
    return otpResult;
  } catch (e, stackTrace) {
    print('Exception in generateOtpForUser: $e');
    print(stackTrace);
    return null;
  }
}

Future<void> verifyOtpAndNavigate({
  required BuildContext context,
  required String email,
  required String mobile,
  required String mobileOtp,
}) async {
  print('verifyOtpAndNavigate called with: email=$email, mobile=$mobile, otp=$mobileOtp');
  verifyOtpLoading = true;
  notifyListeners();

  try {
    bool result = await _authService.verifyOtp(
      email: email,
      mobile: mobile,
      mobileOtp: mobileOtp,
    );
    print('OTP verification result: $result');

    verifyOtpLoading = false;
    notifyListeners();

    if (result) {
      print('OTP verified, navigating to LoginScreen');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } else {
      print('OTP verification failed');
    }
  } catch (e, stackTrace) {
    print('Exception in verifyOtpAndNavigate: $e');
    print(stackTrace);
    verifyOtpLoading = false;
    notifyListeners();
  }
}


    Future<void> loginAndNavigate({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      bool success = await _authService.login(
        email: email,
        password: password,
      );

      _isLoading = false;
      notifyListeners();

      if (success) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const BottomNavBar()),
          (route) => false,
        );
      }
    } catch (e) {
      print("login error $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  clearLoading(){
    _isLoading=false;
    verifyOtpLoading = false;
    notifyListeners();
  }
}
