import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/features/api/api_manager.dart';
import 'package:movie/features/database/database_helper.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/favorite.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';
import 'item_film.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{
  ScrollController _scrollController = ScrollController();
  int _per_page = 10;
  int _per_page_max = 31;
  List<Data> _movieAllList = List.empty();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialised,
      builder: (context, model, child) => Scaffold(
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
                    _movieAllList = snapshot.data;
                    for (int i = 0; i < _movieAllList.length; i++) {
                      model.insertFavorite(
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
                          return ItemFilm(model,_data);
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
      ),
    );
  }
}
