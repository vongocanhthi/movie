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

class ItemFilm extends StatefulWidget {
  Data _data;

  ItemFilm(this._data);

  @override
  State<ItemFilm> createState() => _ItemFilmState(_data);
}

class _ItemFilmState extends State<ItemFilm> {
  Data _data;

  var _title;
  bool _isLike = false;
  String _imgLikeWhite = "assets/images/ic_like.png";
  String _imgLikeOrange = "assets/images/ic_like_orange.png";

  _ItemFilmState(this._data);

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
                    Text(
                      "Lượt xem: ${_data.views}",
                      style: TextStyle(
                        fontFamily: "OpenSans Italic",
                        fontSize: 11,
                        color: view_color,
                        fontStyle: FontStyle.italic,
                      ),
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
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(
                                      "${_isLike
                                          ? _imgLikeOrange
                                          : _imgLikeWhite}"),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  "${_isLike ? "Đã thích" : "Thích"}",
                                  style: TextStyle(
                                    fontFamily: "OpenSans Regular",
                                    fontSize: 13,
                                    color:
                                    _isLike ? orange_color : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () async {
                              //todo
                              setState(() {
                                if (_isLike) {
                                  _isLike = false;
                                } else {
                                  _isLike = true;
                                }
                              });

                              final favourite = Favourite(
                                idMovie: _data.id,
                                view: _data.views,
                                like: true,
                              );
                              int i = await DatabaseHelper.instance.insert(favourite);
                              print("i: $i");
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FilmDetailPage(_data),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(
                                      "${_isLike
                                          ? _imgLikeOrange
                                          : _imgLikeWhite}"),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  "${_isLike ? "Đã thích" : "Thích"}",
                                  style: TextStyle(
                                    fontFamily: "OpenSans Regular",
                                    fontSize: 13,
                                    color:
                                    _isLike ? orange_color : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () async {
                              //todo
                              // List<Map<String, dynamic>> aaa =
                              //     await DatabaseHelper.instance.queryAll();
                              // print("a ${aaa}");
                              // print("a ${aaa.length}");
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FilmDetailPage(_data),
                              ),
                            );
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
