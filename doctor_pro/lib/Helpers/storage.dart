import 'package:shared_preferences/shared_preferences.dart';

class StroageController {
  static get(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("loginToken");
  }

  static set(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(value);
    await prefs.setString(key, value);
  }
}
