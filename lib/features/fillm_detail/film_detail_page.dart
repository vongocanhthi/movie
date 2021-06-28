import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/features/api/api_manager.dart';
import 'package:movie/features/model/data.dart';

class FilmDetailPage extends StatefulWidget {
  @override
  State<FilmDetailPage> createState() => _FilmDetailPageState();
}

class _FilmDetailPageState extends State<FilmDetailPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text("aaaa"),
        ),
        backgroundColor: orange_color,
        systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(

        ),
      ),
    );
  }
}
