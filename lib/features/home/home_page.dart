import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/features/api/api_manager.dart';
import 'package:movie/features/model/data.dart';

import 'item_film.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          child: Text("HFILM"),
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
          child: FutureBuilder(
            future: ApiManager().getMovieList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Data> _movieList = snapshot.data;
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: _movieList.length,
                    itemBuilder: (context, index) {
                      Data _data = _movieList[index];
                      return ItemFilm(_data);
                    },
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
