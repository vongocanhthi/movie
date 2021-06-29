import 'package:movie/features/model/user.dart';

class Response {
  bool error;
  int code;
  String message;

  Response({this.error, this.code, this.message});

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    error: json["error"],
    code: json["code"],
    message: json["message"],
  );
}