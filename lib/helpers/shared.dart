import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();
  static SpHelper spHelper = SpHelper._();
  SharedPreferences? prefs;
  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveData(String key, String value) async {
    await prefs!.setString(key, value);
  }

  String? getData(String key) {
    return prefs!.getString(key);
  }

  Future<void> removeKey(String key) async {
    await prefs!.remove(key);
  }
}
