import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/Util/constant.dart';
import 'package:movie/features/database/database_helper.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/favorite.dart';
import 'package:social_share/social_share.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FilmDetailPage extends StatefulWidget {
  Data data;
  int isLike;
  int views;

  FilmDetailPage(this.data, this.isLike, this.views);

  @override
  State<FilmDetailPage> createState() => _FilmDetailPageState();
}

class _FilmDetailPageState extends State<FilmDetailPage> {
  YoutubePlayerController _controller;
  String _imgLikeWhite = "assets/images/ic_like.png";
  String _imgLikeOrange = "assets/images/ic_like_orange.png";
  var _title;
  String _videoId;

  int _maxLineSeeMore = 5;
  bool _isSeeMore = false;
  int _viewUpdate = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  Future _updateViews() async {
    // List<Favourite> favouriteList = await DatabaseHelper.instance.queryAll();

    Favourite favourite = Favourite(
      idMovie: widget.data.id,
      view: _viewUpdate,
      like: widget.isLike,
    );
    await DatabaseHelper.instance.update(favourite);
  }

  @override
  Widget build(BuildContext context) {
    _title = widget.data.title.split(" / ");
    _videoId = YoutubePlayer.convertUrlToId(widget.data.link);
    _viewUpdate = widget.views + 1;

    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return WillPopScope(
      onWillPop: () {
        _updateViews();

        Navigator.pop(context, _viewUpdate);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "${_title[0]}",
              style: TextStyle(
                fontFamily: "OpenSans Bold",
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: orange_color,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.network("${widget.data.image}"),
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
                              "${_title.length == 2 ? _title[1] : _title[0]}",
                              style: TextStyle(
                                fontFamily: "OpenSans Bold",
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            //todo
                            Text(
                              "Lượt xem: $_viewUpdate",
                              style: TextStyle(
                                fontFamily: "OpenSans Italic",
                                fontSize: 11,
                                color: view_color,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Genres: ",
                                  style: TextStyle(
                                    fontFamily: "OpenSans Bold",
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1000,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    "${widget.data.category}",
                                    style: TextStyle(
                                      fontFamily: "OpenSans Regular",
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Actor: ",
                                  style: TextStyle(
                                    fontFamily: "OpenSans Bold",
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                  maxLines: 100,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    "${widget.data.actor}",
                                    style: TextStyle(
                                      fontFamily: "OpenSans Regular",
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Director: ",
                                  style: TextStyle(
                                    fontFamily: "OpenSans Bold",
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                  maxLines: 100,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    "${widget.data.director}",
                                    style: TextStyle(
                                      fontFamily: "OpenSans Regular",
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Manufacturer: ",
                                  style: TextStyle(
                                    fontFamily: "OpenSans Bold",
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                  maxLines: 100,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    "${widget.data.manufacturer}",
                                    style: TextStyle(
                                      fontFamily: "OpenSans Regular",
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Thời lượng phim: ",
                                  style: TextStyle(
                                    fontFamily: "OpenSans Bold",
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                  maxLines: 100,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    "${widget.data.duration} minute",
                                    style: TextStyle(
                                      fontFamily: "OpenSans Regular",
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
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
                                              "${widget.isLike == 1 ? _imgLikeOrange : _imgLikeWhite}"),
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          "${widget.isLike == 1 ? "Đã thích" : "Thích"}",
                                          style: TextStyle(
                                            fontFamily: "OpenSans Regular",
                                            fontSize: 13,
                                            color: widget.isLike == 1
                                                ? orange_color
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () async {
                                      List<Favourite> favouriteList =
                                          await DatabaseHelper.instance
                                              .queryAll();

                                      if (widget.isLike == 1) {
                                        widget.isLike = 0;
                                        Favourite favourite = Favourite(
                                          idMovie: widget.data.id,
                                          view:
                                              favouriteList[widget.data.id - 1]
                                                          .view ==
                                                      null
                                                  ? widget.data.views
                                                  : favouriteList[
                                                          widget.data.id - 1]
                                                      .view,
                                          like: widget.isLike,
                                        );
                                        await DatabaseHelper.instance
                                            .update(favourite);
                                      } else {
                                        widget.isLike = 1;
                                        Favourite favourite = Favourite(
                                          idMovie: widget.data.id,
                                          view:
                                              favouriteList[widget.data.id - 1]
                                                          .view ==
                                                      null
                                                  ? widget.data.views
                                                  : favouriteList[
                                                          widget.data.id - 1]
                                                      .view,
                                          like: widget.isLike,
                                        );
                                        await DatabaseHelper.instance
                                            .update(favourite);
                                      }

                                      setState(() {});
                                    },
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.share,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          "Chia sẻ",
                                          style: TextStyle(
                                            fontFamily: "OpenSans Regular",
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //todo
                                    onTap: () {
                                      SocialShare.shareOptions(
                                          "${widget.data.description}\n\n${widget.data.link}");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "${widget.data.description}",
                  style: TextStyle(
                    fontFamily: "OpenSans Regular",
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  maxLines: _maxLineSeeMore,
                  overflow: TextOverflow.ellipsis,
                ),
                InkWell(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${!_isSeeMore ? "Xem thêm" : "Rút gọn"}",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: "OpenSans Italic",
                        fontSize: 12,
                        color: view_color,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (!_isSeeMore) {
                        _maxLineSeeMore = 100;
                        _isSeeMore = true;
                      } else {
                        _maxLineSeeMore = 5;
                        _isSeeMore = false;
                      }
                    });
                  },
                ),
                SizedBox(height: 5),
                Divider(
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "XEM TRAILER",
                    style: TextStyle(
                      fontFamily: "OpenSans Bold",
                      fontSize: 13,
                      color: orange_color,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                YoutubePlayer(
                  controller: _controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
