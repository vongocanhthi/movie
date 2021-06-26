import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/Util/constant.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/film.dart';

class ApiManager {
  // Future<List<Film>> getMovieList() async {
  //   var response = await http.get(
  //     Uri.parse(url),
  //     headers: {api_key: value_auth},
  //   );
  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((data) => Film.fromJson(data)).toList();
  //   } else {
  //     print("Error call api");
  //   }
  // }
}
