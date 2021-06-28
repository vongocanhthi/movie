import 'package:movie/features/model/hfilm.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/paging.dart';

class HFilm {
  bool error;
  int code;
  String message;
  Paging paging;
  List<Data> data;

  HFilm({this.error, this.code, this.message, this.paging, this.data});

  factory HFilm.fromJson(Map<String, dynamic> json) => HFilm(
        error: json["error"],
        code: json["code"],
        message: json["message"],
        paging: json["paging"],
        data: json["data"],
      );
}
