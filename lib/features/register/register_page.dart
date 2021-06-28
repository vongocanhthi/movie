import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/Util/util.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    String _name = "1";
    String _email = "";
    String _password = "";
    String _confirm_password = "";

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 10),
                  Visibility(
                    child: Text(
                      "Bạn chưa điền họ tên",
                      style: TextStyle(
                          color: yellow_color,
                          fontSize: 12,
                          fontFamily: "OpenSans Regular"),
                    ),
                    visible: false,
                  ),
                  // Text(_name + "123"),
                  TextField(
                    // controller: TextEditingController(),
                    onChanged: (value) {
                      this.setState(() {
                        _name = value;
                      });
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
                    visible: false,
                  ),
                  TextField(
                    // onChanged: (value) {
                    //   setState(() {
                    //     _email = value;
                    //   });
                    // },
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
                    visible: false,
                  ),
                  TextField(
                    // onChanged: (value) {
                    //   setState(() {
                    //     _password = value;
                    //   });
                    // },
                    decoration: InputDecoration(
                        hintText: "Mật khẩu",
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
                      "Bạn chưa xác nhận mật khẩu",
                      style: TextStyle(
                          color: yellow_color,
                          fontSize: 12,
                          fontFamily: "OpenSans Regular"),
                    ),
                    visible: false,
                  ),
                  TextField(
                    // onChanged: (value) {
                    //   setState(() {
                    //     _confirm_password = value;
                    //   });
                    // },
                    decoration: InputDecoration(
                        hintText: "Xác nhận mật khẩu",
                        hintStyle:
                        TextStyle(color: Colors.white.withOpacity(0.7)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7)))),
                    style: TextStyle(color: Colors.white),
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
                      onPressed: () {
                        //todo
                        // if(_name.isEmpty){
                        //   Toast(context, "empty");
                        // }else{
                        //   Toast(context, _name + "abc");
                        // }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
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
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
