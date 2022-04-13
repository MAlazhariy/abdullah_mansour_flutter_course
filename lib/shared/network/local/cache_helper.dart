import 'package:firstapp/models/shop_app/shop_app_models.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  /// I do not like shared preferences,
  /// so I'll use Hive instead of it.
  // static late SharedPreferences sharedPref;
  //
  // static init() async {
  //   sharedPref = await SharedPreferences.getInstance();
  // }
  //
  // static Future<bool> setBoolean({
  //   required String key,
  //   required bool value,
  // }) async {
  //   return sharedPref.setBool(key, value);
  // }
  //
  // static bool? getBool({
  //   required String key,
  // }) {
  //   return sharedPref.getBool(key);
  // }


  static final Box _box = Hive.box('shop_app');

  /// login data
  static void setToken(String token) {
    _box.put('token', token);
  }

  static String getToken(){
    return _box.get('token', defaultValue: '');
  }

  static void removeToken(){
    _box.delete('token');
  }


}

// @HiveType(typeId: 0)
// class _LoginModel extends HiveObject {
//
//   @HiveField(0)
//   late bool status;
//
//   @HiveField(1)
//   late String message;
//
//   @HiveField(2)
//   LoginUserData? data;
//
// }
