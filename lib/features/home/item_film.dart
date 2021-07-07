import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/Util/util.dart';
import 'package:movie/features/database/database_helper.dart';
import 'package:movie/features/fillm_detail/film_detail_page.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/favorite.dart';
import 'package:page_transition/page_transition.dart';

class ItemFilm extends StatefulWidget {
  Data _data;

  ItemFilm(this._data);

  @override
  State<ItemFilm> createState() => _ItemFilmState(_data);
}

class _ItemFilmState extends State<ItemFilm> {
  Data _data;
  int _isLike;
  int _viewLocal;

  var _title;
  String _imgLikeWhite = "assets/images/ic_like.png";
  String _imgLikeOrange = "assets/images/ic_like_orange.png";

  _ItemFilmState(this._data);

  Future insertFavorite(int idMovie, int view, int like) async {
    Favourite favourite = Favourite(
      idMovie: idMovie,
      view: view,
      like: like,
    );
    List<Favourite> favouriteList = await DatabaseHelper.instance.queryAll();
    if (favouriteList.length <= 10) {
      await DatabaseHelper.instance.insert(favourite);
    }
  }

  Future<int> setViews(int idMovie) async {
    List<Favourite> favouriteList = await DatabaseHelper.instance.queryAll();
    for (int i = 0; i < favouriteList.length; i++) {
      if (idMovie == favouriteList[i].idMovie) {
        return favouriteList[i].view;
      }
    }
  }

  Future<int> setLike(int idMovie) async {
    List<Favourite> favouriteList = await DatabaseHelper.instance.queryAll();
    for (int i = 0; i < favouriteList.length; i++) {
      if (idMovie == favouriteList[i].idMovie) {
        if (favouriteList[i].like == 1) {
          return 1;
        } else {
          return 0;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _title = _data.title.split(" / ");

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Image.network("${_data.image}"),
            ),
            Flexible(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_title[0]}",
                      style: TextStyle(
                        fontFamily: "OpenSans Bold",
                        fontSize: 13,
                        color: orange_color,
                      ),
                    ),
                    Text(
                      "${_title.length == 2 ? _title[1] : _title[0]}",
                      style: TextStyle(
                        fontFamily: "OpenSans Bold",
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                    //todo
                    FutureBuilder<int>(
                      future: setViews(_data.id),
                      builder: (context, snapshot) {
                        _viewLocal = snapshot.data;
                        return Text(
                          "Lượt xem: ${_viewLocal == null ? _data.views : _viewLocal}",
                          style: TextStyle(
                            fontFamily: "OpenSans Italic",
                            fontSize: 11,
                            color: view_color,
                            fontStyle: FontStyle.italic,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${_data.description}",
                      style: TextStyle(
                        fontFamily: "OpenSans Regular",
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: FutureBuilder<int>(
                              future: setLike(_data.id),
                              builder: (context, snapshot) {
                                _isLike = snapshot.data;
                                return Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          "${_isLike == 1 ? _imgLikeOrange : _imgLikeWhite}"),
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      "${_isLike == 1 ? "Đã thích" : "Thích"}",
                                      style: TextStyle(
                                        fontFamily: "OpenSans Regular",
                                        fontSize: 13,
                                        color: _isLike == 1
                                            ? orange_color
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            onTap: () async {
                              //todo
                              _isLike = _isLike == 1 ? 0 : 1;
                              Favourite favourite = Favourite(
                                idMovie: _data.id,
                                view: _viewLocal,
                                like: _isLike,
                              );
                              await DatabaseHelper.instance.update(favourite);

                              setState(() {});
                            },
                          ),
                        ),
                        RaisedButton(
                          color: orange_color,
                          child: Text(
                            "Xem phim",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "OpenSans Regular",
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                child: FilmDetailPage(
                                    _data,
                                    _isLike,
                                    _viewLocal == null
                                        ? _data.views
                                        : _viewLocal),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        divider_white,
      ],
    );
  }
}
