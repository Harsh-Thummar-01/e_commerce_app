import 'package:e_commerce_app/Model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() {
    return _instance;
  }

  SharedPrefs._internal();

  static SharedPreferences? _sharedPreferences;

   init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  set name(String value) => _sharedPreferences!.setString("name", value);

  String get name => _sharedPreferences!.getString("name") ?? '';
}

final sharedPrefs = SharedPrefs();

