import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
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

  Future<String> registro(name, password, img, mail) async {
    File file_img = File(img);
    List<int> imageBytes = file_img.readAsBytesSync();
    final url = Uri.parse("http://192.168.0.19:5000/add-user");
    final response = await http.post(url,
        body: jsonEncode({
          "name": name,
          "password": password,
          "img": base64Encode(imageBytes),
          "mail": mail
        }));

    if (response.statusCode == 200) {
      final json_response = jsonDecode(response.body);
      if (json_response["data"] != "ya") {
        final pref = await SharedPreferences.getInstance();
        pref.setString("key", json_response["data"]);
      }
      return "ya";
    } else {
      return "Error de peticion";
    }
  }

  sendImg(img, key) async {
    File file_img = File(img);
    List<int> imageBytes = file_img.readAsBytesSync();
    final url = Uri.parse("http://192.168.0.19:5000/set-img-profile-user");
    final response = await http.post(url,
        body: jsonEncode({"img": base64Encode(imageBytes), "key": key}));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      return jsonResponse['status'];
    } else {
      return 'Error de peticion';
    }
  }

  Future<dynamic> getImg(key) async {
    final url = Uri.parse("http://192.168.0.19:5000/get-image-user?key=$key");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse['arrayPhoto']);
      return jsonResponse['arrayPhoto'];
    } else {
      return [];
    }
  }
}
