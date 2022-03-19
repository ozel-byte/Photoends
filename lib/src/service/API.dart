import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:robbin/src/service/SharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Api();

  Future<String> login(name, password) async {
    final url = Uri.parse(
        "http://192.168.0.19:5000/login?name=$name&password=$password");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json_response = jsonDecode(response.body);
      if (json_response["status"] == "ok") {
        final pref = await SharedPreferences.getInstance();
        pref.setString("key", json_response["data"]);
        print(json_response['data']);
        return json_response["status"].toString();
      } else {
        return json_response["status"].toString();
      }
    } else {
      return "no se pudo realizar la peticion";
    }
  }

  Future<String> registro(name, password) async {
    final url = Uri.parse("http://192.168.0.19:5000/add-user");
    final response = await http.post(url,
        body: jsonEncode({"name": name, "password": password}));

    if (response.statusCode == 200) {
      final json_response = jsonDecode(response.body);
      final pref = await SharedPreferences.getInstance();
      pref.setString("key", json_response["data"]);
      return json_response["status"].toString();
    } else {
      return "Error de peticion";
    }
  }

  sendImg(img) async {
    final url = Uri.parse("http://192.168.0.19:5000/set-img-profile-user");
    final response = await http.post(url, body: jsonEncode({"img": img}));
  }
}