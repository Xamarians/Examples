import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefrences {
  static const String AuthTokenKey = "AuthToken";
  static const String IsAuthenticatedKey = "IsAuthenticated";
  static const String UserEmailKey = "UserEmail";
  static const String UserTypeKey = "UserType";

  static Future<String> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(AuthTokenKey);
    if (value == null || value.isEmpty) value = "";
    return value;
  }

  static Future setAuthToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AuthTokenKey, value);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(UserEmailKey);
    if (value == null || value.isEmpty) value = "";
    return value;
  }

  static Future setUserEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(UserEmailKey, value);
  }

  static Future<bool> getIsAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getBool(IsAuthenticatedKey);
    if (value == null) value = false;
    return value;
  }

  static Future setIsAuthenticated(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IsAuthenticatedKey, value);
  }

  static Future getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(UserTypeKey);
    if (value == null || value.isEmpty) value = "";
    return value;
  }

  static Future setUserType(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(UserTypeKey, value);
  }
}
