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
  ScrollController _scrollController = ScrollController();
  int _per_page = 10;
  int _per_page_max = 31;
  List<Data> _movieAllList = List.empty();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    //todo
    // deleteAllFavourite();
    getFavouriteList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _per_page = 10;
    });
    return null;
  }

  Future<void> _getMoreData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _per_page = _per_page + 10;
    });
  }

  Future getFavouriteList() async {
    List<Favourite> favouriteList = await DatabaseHelper.instance.queryAll();
    print("${favouriteList.length}");
  }

  Future insertFavorite(int idMovie, int view, int like) async {
    Favourite favourite = Favourite(
      idMovie: idMovie,
      view: view,
      like: like,
    );
    List<Favourite> favouriteList = await DatabaseHelper.instance.queryAll();
    if (favouriteList.length < 1000) {
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
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Container(
            child: FutureBuilder<List<Data>>(
              future: ApiManager().getMovieList(_per_page),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //todo
                  _movieAllList = snapshot.data;
                  for (int i = 0; i < _movieAllList.length; i++) {
                    insertFavorite(
                        _movieAllList[i].id, _movieAllList[i].views, 0);
                  }
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _movieAllList.length,
                      itemBuilder: (context, index) {
                        Data _data = _movieAllList[index];
                        if (index == _movieAllList.length - 1 &&
                            _movieAllList.length < _per_page_max) {
                          return Theme(
                            data: ThemeData(
                                cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)),
                            child: CupertinoActivityIndicator(
                              radius: 20,
                            ),
                          );
                        }
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
      ),
    );
  }
}
