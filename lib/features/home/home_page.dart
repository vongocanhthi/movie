import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/features/api/api_manager.dart';

import 'item_film.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("HFILM")),
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
            // future: ApiManager().getMovieList(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ItemFilm();
                  },
                );

              }else{
                return Text("${snapshot.error}");
              }

            },
          ),
        ),
      ),
    );
  }
}
