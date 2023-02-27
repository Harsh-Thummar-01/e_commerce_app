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

  logOut() {
    _sharedPreferences?.clear();
  }

  set uid(String value) => _sharedPreferences!.setString("uid", value);

  String get uid => _sharedPreferences!.getString("uid") ?? '';

  set email(String value) => _sharedPreferences!.setString("email", value);

  String get email => _sharedPreferences!.getString("email") ?? '';

  set userName(String value) =>
      _sharedPreferences!.setString("userName", value);

  String get userName => _sharedPreferences!.getString("userName") ?? '';

  set currentStreet(String value) =>
      _sharedPreferences!.setString("currentStreet", value);

  String get currentStreet =>
      _sharedPreferences!.getString("currentStreet") ?? '';

  set currentLocality(String value) =>
      _sharedPreferences!.setString("currentLocality", value);

  String get currentLocality =>
      _sharedPreferences!.getString("currentLocality") ?? '';

  set currentCountry(String value) =>
      _sharedPreferences!.setString("currentCountry", value);

  String get currentCountry =>
      _sharedPreferences!.getString("currentCountry") ?? '';

  // set firstName(String value) =>
  //     _sharedPreferences!.setString("firstName", value);

  // String get firstName => _sharedPreferences!.getString("firstName") ?? '';

  // set lastName(String value) =>
  //     _sharedPreferences!.setString("lastName", value);

  // String get lastName => _sharedPreferences!.getString("lastName") ?? '';

  // set comment(String value) => _sharedPreferences!.setString("comment", value);

  // String get comment => _sharedPreferences!.getString("comment") ?? '';

  // set imageUrl(String value) =>
  //     _sharedPreferences!.setString("imageUrl", value);

  // String get imageUrl => _sharedPreferences!.getString("imageUrl") ?? '';

  // set favoriteProduct(String value) =>
  //     _sharedPreferences!.setString("favProduct", value);

  // String get favoriteProduct =>
  //     _sharedPreferences!.getString("favProduct") ?? '';
}

final sharedPrefs = SharedPrefs();
