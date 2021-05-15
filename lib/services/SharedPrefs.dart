import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static String IS_SERVICE_ON = "isServiceOn";

  SharedPreferences _sharedPreferences;

  Map<String, dynamic> defaults = {};

  //constructor
  PrefService();

  void putSharedBool(String key, dynamic value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool(key, value);
  }

  void putSharedInt(String key, dynamic value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setInt(key, value);
  }

  void putSharedDouble(String key, dynamic value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setDouble(key, value);
  }

  void putSharedString(String key, dynamic value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(key, value);
  }

  Future<bool> getSharedBool(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(key) != null
        ? _sharedPreferences.getBool(key)
        : false;
  }

  Future<int> getSharedInt(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getInt(key) != null
        ? _sharedPreferences.getInt(key)
        : false;
  }

  Future<double> getSharedDouble(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getDouble(key) != null
        ? _sharedPreferences.getDouble(key)
        : false;
  }

  Future<String> getSharedString(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString(key) != null
        ? _sharedPreferences.getString(key)
        : "";
  }

  getShared(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.get(key);
  }
}

final prefService = PrefService();
