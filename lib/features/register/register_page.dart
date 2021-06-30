import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/Util/util.dart';
import 'package:movie/features/api/api_manager.dart';
import 'package:movie/features/model/response.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _name = "";
  String _email = "";
  String _password = "";
  String _confirm_password = "";

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Đăng ký",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontFamily: "UVN BaiSau"),
                        ),
                      ),
                      SizedBox(height: 20),
                      divider_white,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              child: Text(
                                "Bạn chưa điền họ tên",
                                style: TextStyle(
                                    color: yellow_color,
                                    fontSize: 12,
                                    fontFamily: "OpenSans Regular"),
                              ),
                              visible: _name.isEmpty ? true : false,
                            ),
                            TextField(
                              onChanged: (name) {
                                _name = name;
                              },
                              decoration: InputDecoration(
                                  hintText: "Họ tên",
                                  hintStyle:
                                  TextStyle(color: Colors.white.withOpacity(0.7)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.7)))),
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Visibility(
                              child: Text(
                                "Bạn chưa điền email",
                                style: TextStyle(
                                    color: yellow_color,
                                    fontSize: 12,
                                    fontFamily: "OpenSans Regular"),
                              ),
                              visible: _email.isEmpty ? true : false,
                            ),
                            TextField(
                              onChanged: (email) {
                                _email = email;
                              },
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle:
                                  TextStyle(color: Colors.white.withOpacity(0.7)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.7)))),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 10),
                            Visibility(
                              child: Text(
                                "Bạn chưa tạo mật khẩu",
                                style: TextStyle(
                                    color: yellow_color,
                                    fontSize: 12,
                                    fontFamily: "OpenSans Regular"),
                              ),
                              visible: _password.isEmpty ? true : false,
                            ),
                            TextField(
                              onChanged: (password) {
                                _password = password;
                              },
                              decoration: InputDecoration(
                                  hintText: "Mật khẩu",
                                  hintStyle:
                                  TextStyle(color: Colors.white.withOpacity(0.7)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.7)))),
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                            ),
                            SizedBox(height: 10),
                            Visibility(
                              child: Text(
                                "Bạn chưa xác nhận mật khẩu",
                                style: TextStyle(
                                    color: yellow_color,
                                    fontSize: 12,
                                    fontFamily: "OpenSans Regular"),
                              ),
                              visible: _confirm_password.isEmpty ||
                                  (_confirm_password != _password)
                                  ? true
                                  : false,
                            ),
                            TextField(
                              onChanged: (confirm_password) {
                                _confirm_password = confirm_password;
                              },
                              decoration: InputDecoration(
                                  hintText: "Xác nhận mật khẩu",
                                  hintStyle:
                                  TextStyle(color: Colors.white.withOpacity(0.7)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.7)))),
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                color: orange_color,
                                child: Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "OpenSans Regular",
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () async {
                                  //todo
                                  setState(() {});
                                  if (_name.isNotEmpty &&
                                      _email.isNotEmpty &&
                                      _password.isNotEmpty &&
                                      _confirm_password.isNotEmpty &&
                                      _confirm_password == _password) {
                                    Response response = await ApiManager().Registry(
                                      full_name: _name,
                                      email: _email,
                                      password: _password,
                                    );

                                    if (response.message == check_email_registry) {
                                      Toast(context, "Tài khoản đã tồn tại");
                                    } else if (response.message == "") {
                                      Toast(context, "Đăng ký tài khoản thành công");

                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.pop(context);
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      divider_white,
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Image(
                            width: 50,
                            height: 50,
                            image: AssetImage("assets/images/btnClose.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Wrap(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Bằng việc chọn vào nút Đăng ký, bạn đã đồng ý với",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontFamily: "OpenSans SemiBold",
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Text(
                                  "Điều khoản sử dụng",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 10,
                                    color: yellow_color,
                                    fontFamily: "OpenSans SemiBold",
                                  ),
                                ),
                                onTap: () {
                                  Toast(context, "Điều khoản sử dụng");
                                },
                              ),
                              Text(
                                " và ",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontFamily: "OpenSans SemiBold",
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Toast(context, "Quy định bảo mật");
                                },
                                child: Text(
                                  "Quy định bảo mật",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 10,
                                    color: yellow_color,
                                    fontFamily: "OpenSans SemiBold",
                                  ),
                                ),
                              ),
                              Text(
                                " của Hfilm",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontFamily: "OpenSans SemiBold",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
