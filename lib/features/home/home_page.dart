import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/features/api/service.dart';
import 'package:movie/features/bottom_bar/bottom_bar.dart';
import 'package:movie/features/database/database_helper.dart';
import 'package:movie/features/map/map_page.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/favorite.dart';
import 'package:movie/features/notification/notification_page.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';
import 'item_film.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  ScrollController _scrollController = ScrollController();
  int _per_page = 10;
  int _per_page_max = 31;
  List<Data> _movieAllList = List.empty();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
        key: _scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 80,
                color: orange_color,
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.map),
                title: Text("Map"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.border_all_rounded),
                title: Text("Bottombar + Bottom Sheet"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomBarPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text("Notification"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          title: Text("HFILM"),
          centerTitle: true,
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
                future: Service().getMovieList(_per_page),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _movieAllList = snapshot.data;
                    NotificationPage.movieList = _movieAllList;
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
                                  cupertinoOverrideTheme: CupertinoThemeData(
                                      brightness: Brightness.dark)),
                              child: CupertinoActivityIndicator(
                                radius: 20,
                              ),
                            );
                          }
                          return ItemFilm(model, _data);
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
