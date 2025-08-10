import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String? token;
  String? userId;
  String? name;
  String? email;
  String? mobile;
  // String? roleId;
  String? darkMode;
  Map<String, dynamic>? userJson;
  bool isLoggedIn = false;

  /// Load data from SharedPreferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
    userId = prefs.getString('userId');
    name = prefs.getString('user_name');
    email = prefs.getString('user_email');
    mobile = prefs.getString('user_mobile');
    // roleId = prefs.getString('role_id');
    darkMode = prefs.getString('dark_mode');
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  

    notifyListeners();
  }

  /// Save user data into SharedPreferences + Provider
  Future<void> saveUserData({
    required String token,
    required String userId,
    required String name,
    required String email,
    required String mobile,
    required String roleId,
    required String darkMode,
    required Map<String, dynamic> userJson,
    required bool isLoggedIn,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
    await prefs.setString('userId', userId);
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_mobile', mobile);
    await prefs.setString('role_id', roleId);
    await prefs.setString('dark_mode', darkMode);
    await prefs.setString('user_json', jsonEncode(userJson));
    await prefs.setBool('isLoggedIn', isLoggedIn);

    await loadUserData(); // refresh provider values
  }

  /// Clear user data from SharedPreferences + Provider
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    token = null;
    userId = null;
    name = null;
    email = null;
    mobile = null;
    // roleId = null;
    darkMode = null;
    userJson = {};
    isLoggedIn = false;
    notifyListeners();
  }
}
