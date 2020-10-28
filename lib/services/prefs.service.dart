import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<dynamic> getObjectByKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.get(key);
    if (data != null) {
      return jsonDecode(data);
    }

    return null;
  }

  static Future<bool> storeObjectByKey(String key, dynamic obj) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(obj);
    return prefs.setString(key, json);
  }
}
