import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences _sharedPreferences;

  static const String keyIsLogIn = "key_isLogIn";
  static const String keyEmail = "key_email";

  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static void clearProfile() {
    isLogIn = false;
    email = "";
  }

  static bool get isLogIn => _sharedPreferences.getBool(keyIsLogIn) ?? false;
  static set isLogIn(bool value) =>
      _sharedPreferences.setBool(keyIsLogIn, value);

  static String get email => _sharedPreferences.getString(keyEmail) ?? "";
  static set email(String value) =>
      _sharedPreferences.setString(keyEmail, value);
}
