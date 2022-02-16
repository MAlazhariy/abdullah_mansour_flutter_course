import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static SharedPreferences sharedPref;

  static init() async {
    sharedPref = await SharedPreferences.getInstance();
  }


  static Future<bool> setBoolean ({
    @required String key,
    @required bool value,
}) async {
    return sharedPref.setBool(key, value);
  }


  static bool getBool ({
    @required String key,
}){
    return sharedPref.getBool(key);
  }

}