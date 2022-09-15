import 'package:skindisease/models/GeneralClasses/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

Future<SharedPreferences> _sPrefs = SharedPreferences.getInstance();

Future<User> getSharedPref() async {
  final SharedPreferences prefs = await _sPrefs;

  Map<String, dynamic> userStr = jsonDecode(prefs.get("UseCredentials"));
  return new User(
      userID: userStr["userID"],
      userName: userStr["userName"],
      email: userStr["email"],
      status: userStr["status"],
      userType: int.parse(userStr["userType"]));
}
