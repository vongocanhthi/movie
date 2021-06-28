import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/Util/constant.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/hfilm.dart';

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
      print("Error call api");
    }
  }
}
