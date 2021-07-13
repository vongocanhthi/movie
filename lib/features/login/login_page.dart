import 'dart:ui';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/Util/util.dart';
import 'package:movie/features/forgot_pasword/forgot_password_page.dart';
import 'package:movie/features/home/home_page.dart';
import 'package:movie/features/login/login_viewmodel.dart';
import 'package:movie/features/map/map_page.dart';
import 'package:movie/features/register/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FacebookLogin facebookSignIn = new FacebookLogin();
  SharedPreferences _prefs;

  String _message = 'Log in/out by pressing the buttons below.';

  String _email = "";
  String _password = "";
  bool _isRemember = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    init();

    // setState(() {
    //   getSharedPreferences();
    //   print("_email $_email");
    //   print("_password $_password");
    // });
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> getSharedPreferences() async {
    init();
    _email = _prefs.getString("email") == null ? "" : _prefs.getString("email");
    _password = _prefs.getString("password") ?? "";
    _isRemember = _prefs.getBool("remember") ?? false;
  }

  Future<void> setSharedPreferences() async {
    init();
    _prefs.setString("email", _email);
    _prefs.setString("password", _password);
    _prefs.setBool("remember", true);
    _prefs.commit();
  }

  Future<void> resetSharedPreferences() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("email", "");
    await _prefs.setString("password", "");
    await _prefs.setBool("remember", false);
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
        if (value != null) {
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
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => model.initialised,
      builder: (context, model, child) => Scaffold(
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
                        "Đăng nhập",
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
                                hintText: "Mật khẩu",
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.7)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.7)))),
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                          ),
                          // Row(
                          //   //todo
                          //   children: [
                          //     Checkbox(
                          //       value: _isRemember,
                          //       onChanged: (value) {
                          //         setState(() {
                          //           _isRemember = value;
                          //           // if (_isRemember) {
                          //           //   _isRemember = true;
                          //           // } else {
                          //           //   _isRemember = false;
                          //           // }
                          //         });
                          //       },
                          //     ),
                          //     Text(
                          //       "Nhớ mật khẩu",
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontFamily: "OpenSans Regular",
                          //         fontSize: 14,
                          //       ),
                          //     ),
                          //   ],
                          // ),
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
                                setState(() {

                                });
                                // if (_isRemember) {
                                setSharedPreferences();
                                // } else {
                                //   resetSharedPreferences();
                                // }
                                model.loginWithEmail(
                                    context, _email, _password);

                                print("a_email $_email");
                                print("a_password $_password");
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
                              if (Platform.isAndroid) {
                                _loginFb(context);
                              }
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
                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.white.withOpacity(0.2),
                              child: Text(
                                "Chức năng khác",
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
                                    builder: (context) => MapPage(),
                                  ),
                                );
                              },
                            ),
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
      ),
    );
  }
}
