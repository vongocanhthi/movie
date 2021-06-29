import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/Util/constant.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/registry.dart';

class ApiManager {
  Future<List<Data>> getMovieList() async {
    var response = await http.get(
      "${base_url}movie/list",
      headers: {api_key: value_auth},
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)["data"];
      return jsonResponse.map((data) => Data.fromJson(data)).toList();
    } else {
      print("Error getMovieList");
    }
  }

  Future<RegistryReponse> Registry(
      {String full_name, String email, String password}) async {
    var map = Map<String, String>();
    map["full_name"] = full_name;
    map["email"] = email;
    map["password"] = password;

    var response = await http.post(
      "${base_url}user/registry",
      headers: {api_key: value_auth},
      body: map,
    );
    if (response.statusCode == 200) {
      return RegistryReponse.fromJson(json.decode(response.body));
    } else {
      print("Error Registry");
    }
  }

// Future<List<Data>> Login() async {
//   var response = await http.post(
//     "${base_url}user/login",
//     headers: {api_key: value_auth},
//   );
//   if (response.statusCode == 200) {
//     List jsonResponse = json.decode(response.body)["data"];
//     return jsonResponse.map((data) => Data.fromJson(data)).toList();
//   } else {
//     print("Error Login");
//   }
// }
}
