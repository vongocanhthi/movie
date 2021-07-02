import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/features/api/api_manager.dart';
import 'package:movie/features/database/database_helper.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/favorite.dart';

import 'item_film.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isInsertLocal = false;

  Future getFavouriteList() async {
    List<Favourite> favouriteList = await DatabaseHelper.instance.queryAll();
    // for (int i = 0; i < favouriteList.length; i++) {
    //   print("like $i: ${favouriteList[i].like}");
    // }
    print("${favouriteList.length}");
  }

  Future insertFavorite(int idMovie, int view, int like) async {
    Favourite favourite = Favourite(
      idMovie: idMovie,
      view: view,
      like: like,
    );
    List<Favourite> favouriteList = await DatabaseHelper.instance.queryAll();
    if(favouriteList.length < 10){
      await DatabaseHelper.instance.insert(favourite);
    }
  }

  Future deleteAllFavourite() async {
    List<Favourite> favouriteList = await DatabaseHelper.instance.queryAll();
    print("${favouriteList.length}");
    for (int i = 0; i < favouriteList.length; i++) {
      await DatabaseHelper.instance.delete(favouriteList[i].idMovie);
    }

    print("delete: ${favouriteList.length}");
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    //todo
    // deleteAllFavourite();
    getFavouriteList();
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
                //todo
                if(!_isInsertLocal){
                  for(int i = 0; i<_movieList.length;i++){
                    insertFavorite(_movieList[i].id, _movieList[i].views, 0);
                  }
                  _isInsertLocal = true;
                }

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
