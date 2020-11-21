import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static Future<bool> saveId({
    String name,
    String value,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(name, value);
  }

  static Future<String> getId({String name}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(name);
  }
}
