import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferen {
  SharedPreferen();

  void addKeyUser(keyUser) async {
    SharedPreferences prefKey = await SharedPreferences.getInstance();
    prefKey.setString('key-user', keyUser);
  }

  getKeyUser() async {
    SharedPreferences prefKey = await SharedPreferences.getInstance();

    final String? keyUser = prefKey.getString("key");
    return keyUser ?? "";
  }
}
