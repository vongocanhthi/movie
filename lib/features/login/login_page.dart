import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/Util/util.dart';
import 'package:movie/features/home/home_page.dart';
import 'package:movie/features/register/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _password = "";

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
                      "Đăng nhập",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: "UVN BaiSau"),
                    ),
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: orange_color,
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "OpenSans Regular",
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.white.withOpacity(0.2),
                      child: Text(
                        "Quên mật khẩu?",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "OpenSans Regular",
                          fontSize: 13,
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
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bạn chưa có tài khoản? ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: "OpenSans SemiBold",
                        ),
                      ),
                      InkWell(
                        child: Text(
                          "ĐĂNG KÝ",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                            color: yellow_color,
                            fontFamily: "OpenSans SemiBold",
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
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
