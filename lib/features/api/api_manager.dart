import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/Util/constant.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/response.dart';

class ApiManager {
  Future<List<Data>> getMovieList(int per_page) async {
    var response = await http.get(
      "${base_url}movie/list?per_page=${per_page}",
      headers: {api_key: value_auth},
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)["data"];
      return jsonResponse.map((data) => Data.fromJson(data)).toList();
    } else {
      print("Error getMovieList");
    }
  }

  Future getForgotPassword(String email) async {
    var response = await http.get(
      "${base_url}user/forgot-password?email=${email}",
      headers: {api_key: value_auth},
    );

    if (response.statusCode == 200) {
      // return Response.fromJson(json.decode(response.body));
      return response.body;
    } else {
      print("Error getMovieList");
    }
  }

  Future<Response> Registry(
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
      return Response.fromJson(json.decode(response.body));
    } else {
      print("Error Registry");
    }
  }

  Future<Response> Login({String email, String password}) async {
    var map = Map<String, String>();
    map["email"] = email;
    map["password"] = password;

    var response = await http.post(
      "${base_url}user/login",
      headers: {api_key: value_auth},
      body: map,
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return Response.fromJson(json.decode(response.body));
    } else {
      print("Error Login");
    }
  }
}
