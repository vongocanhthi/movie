import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/features/api/api_manager.dart';
import 'package:movie/features/home/home_page.dart';
import 'package:movie/features/model/response.dart';
import 'package:movie/util/constant.dart';
import 'package:movie/util/util.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel{

  Future<void> loginWithEmail(BuildContext context, String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      Response response = await ApiManager().Login(
        email: email,
        password: password,
      );

      if (response.message == check_email_login) {
        Toast(context, "Tài khoản không tồn tại");
      } else if (response.message == check_password) {
        Toast(context, "Mật khẩu không chính xác");
      } else if (response.message == "") {
        Toast(context, "Đăng nhập thành công");

        Future.delayed(Duration(seconds: 1), () {
          _loginSuccess(context);
        });
      }
    } else {
      Toast(context,
          "Vui lòng nhập thông tin tài khoản");
    }
  }

  void _loginSuccess(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}