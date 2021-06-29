import 'package:movie/features/model/hfilm.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/paging.dart';

class HFilm {
  bool error;
  int code;
  String message;

  HFilm({this.error, this.code, this.message});

  factory HFilm.fromJson(Map<String, dynamic> json) => HFilm(
        error: json["error"],
        code: json["code"],
        message: json["message"],
      );
}
