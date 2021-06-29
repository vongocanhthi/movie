import 'package:movie/features/model/user.dart';

class RegistryReponse {
  bool error;
  int code;
  String message;

  RegistryReponse({this.error, this.code, this.message});

  factory RegistryReponse.fromJson(Map<String, dynamic> json) => RegistryReponse(
    error: json["error"],
    code: json["code"],
    message: json["message"],
  );
}