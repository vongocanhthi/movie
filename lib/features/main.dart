import 'package:flutter/material.dart';
import 'package:movie/features/home/home_page.dart';
import 'package:movie/features/register/register_page.dart';
import 'package:flutter/services.dart';

import 'login/login_page.dart';

void main() {
  // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
