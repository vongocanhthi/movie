import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/Util/util.dart';
import 'package:movie/features/api/api_manager.dart';
import 'package:movie/features/model/response.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String _email = "";

  @override
  Widget build(BuildContext context) {
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
          // padding: EdgeInsets.only(left: 40, right: 40),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Quên mật khẩu",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: "UVN BaiSau"),
                    ),
                  ),
                  SizedBox(height: 20),
                  divider_white,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Text(
                          "Hãy nhập email bạn đã dùng để tạo tài khoản",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "OpenSans Regular"),
                        ),
                        TextField(
                          onChanged: (value) {
                            _email = value;
                          },
                          decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.7)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.7)))),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: orange_color,
                            child: Text(
                              "Gửi mật khẩu?",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "OpenSans Regular",
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () async {
                              //todo
                              if (_email.isEmpty) {
                                Toast(context, "Vui lòng nhập email");
                              } else {
                                var response = await ApiManager()
                                    .getForgotPassword(_email);
                                Toast(context, "${response}");
                                // if (response.message == check_forgot_password) {
                                //   Toast(context, check_forgot_password);
                                // } else if (response.message.isEmpty) {
                                //   Toast(context, "Vui lòng kiểm tra email");
                                // }
                              }
                            },
                          ),
                        )
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
            ],
          ),
        ),
      ),
    );
  }
}
