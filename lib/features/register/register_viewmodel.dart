import 'package:flutter/cupertino.dart';
import 'package:movie/features/api/api_manager.dart';
import 'package:movie/features/model/response.dart';
import 'package:movie/util/constant.dart';
import 'package:movie/util/util.dart';
import 'package:stacked/stacked.dart';

class RegisterViewModel extends BaseViewModel {
  Future<void> register(BuildContext context, String _name, String _email,
      String _password, String _confirm_password) async {
    if (_name.isNotEmpty &&
        _email.isNotEmpty &&
        _password.isNotEmpty &&
        _confirm_password.isNotEmpty) {
      Response response = await ApiManager().Registry(
        full_name: _name,
        email: _email,
        password: _password,
      );

      if (_confirm_password == _password) {
        if (response.message == check_email_registry) {
          Toast(context, "Tài khoản đã tồn tại");
        } else if (response.message == "") {
          Toast(context, "Đăng ký tài khoản thành công");

          Future.delayed(Duration(seconds: 2), () {
            Navigator.pop(context);
          });
        }
      } else {
        Toast(context, "Mật khẩu không trùng khớp");
      }
    }
  }
}
