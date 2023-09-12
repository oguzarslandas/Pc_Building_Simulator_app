import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  //Shared preferences nesnesi oluşmuşsa aynı nesneyi tekrar çağırıyoruz.
  static late SharedPreferences _prefs;
  static initialize() async {
    if (_prefs != null) {
      return _prefs;
    } else {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  //Shared prefs üzerine telefon numarasını kayıt ediyoruz
  static Future<Future<bool>> savePhone(String phone) async {
    return _prefs.setString('phone', phone);
  }

  //Shared prefs üzerine token kayıt ediyoruz
  static Future<Future<bool>> saveToken(String token) async {
    return _prefs.setString('token', token);
  }

  //Shared prefs üzerine kodu kayıt ediyoruz
  static Future<Future<bool>> saveCode(String code) async {
    return _prefs.setString("code", code);
  }

  //Kayıtlı verileri siler
  static Future<Future<bool>> sharedClear() async {
    return _prefs.clear();
  }

  //Login bilgisini tutar
  static Future<Future<bool>> login() async {
    return _prefs.setBool('login', true);
  }

  static Future<Future<bool>> logout() async {
    return _prefs.setBool('login', false);
  }

  //Kayıtlı verileri alıyoruz
  static String get getPhone => _prefs.getString("phone") ?? "null";
  static String get getCode => _prefs.getString("code") ?? "null";
  static bool get getLogin => _prefs.getBool('login') ?? false;
}