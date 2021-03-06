import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/Util/util.dart';
import 'package:movie/features/api/api_manager.dart';
import 'package:movie/features/forgot_pasword/forgot_password_page.dart';
import 'package:movie/features/home/home_page.dart';
import 'package:movie/features/model/response.dart';
import 'package:movie/features/register/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FacebookLogin facebookSignIn = new FacebookLogin();

  String _message = 'Log in/out by pressing the buttons below.';

  String _email = "";
  String _password = "";


  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _loginGoogle(BuildContext context) async {
    try {
      await _googleSignIn.signIn().then((value) {
        print("value: $value");
        if(value != null){
          _loginSuccess(context);
        }
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Future<Null> _loginFb(BuildContext context) async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');

        _loginSuccess(context);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("cancelledByUser");
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print("error");

        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    _message = message;
    print(_message);
  }

  void _loginSuccess(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "????ng nh???p",
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
                        SizedBox(height: 10),
                        TextField(
                          onChanged: (value) {
                            _password = value;
                          },
                          decoration: InputDecoration(
                              hintText: "M???t kh???u",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.7)),
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
                              "????ng nh???p",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "OpenSans Regular",
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () async {
                              setState(() {});
                              if (_email.isNotEmpty && _password.isNotEmpty) {
                                Response response = await ApiManager().Login(
                                  email: _email,
                                  password: _password,
                                );

                                if (response.message == check_email_login) {
                                  Toast(context, "T??i kho???n kh??ng t???n t???i");
                                } else if (response.message == check_password) {
                                  Toast(context, "M???t kh???u kh??ng ch??nh x??c");
                                } else if (response.message == "") {
                                  Toast(context, "????ng nh???p th??nh c??ng");

                                  Future.delayed(Duration(seconds: 1), () {
                                    _loginSuccess(context);
                                  });
                                }
                              } else {
                                Toast(context,
                                    "Vui l??ng nh???p th??ng tin t??i kho???n");
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.white.withOpacity(0.2),
                            child: Text(
                              "Qu??n m???t kh???u?",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "OpenSans Regular",
                                fontSize: 13,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                ),
                              );
                            },
                          ),
                        ),
                        FacebookSignInButton(
                          onPressed: () {
                            _loginFb(context);
                          },
                        ),
                        GoogleSignInButton(
                          onPressed: () {
                            if (_googleSignIn != null) {
                              _handleSignOut();
                            }
                            _loginGoogle(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  divider_white,
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
                        "B???n ch??a c?? t??i kho???n? ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: "OpenSans SemiBold",
                        ),
                      ),
                      InkWell(
                        child: Text(
                          "????NG K??",
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
