import 'package:shared_preferences/shared_preferences.dart';

abstract class Cashing {
  static late SharedPreferences sharedPreferences;

  static Future<void> initApp() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveTheme(bool isDark) async {
    await sharedPreferences.setBool("isDark", isDark);
  }

  static bool getTheme() {
    return sharedPreferences.getBool("isDark") ?? false;
  }




}
