import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/paging.dart';

class Film {
  bool error;
  int code;
  String message;
  Paging paging;
  List<Data> data;

  Film({this.error, this.code, this.message, this.paging, this.data});

  // factory Film.fromJson(Map<String, dynamic> json) => Film(
  //   error: json["error"],
  //   code: json["code"],
  //   message: json["message"],
  //   paging: json["paging"],
  //   data: json["data"],
  // );
}
