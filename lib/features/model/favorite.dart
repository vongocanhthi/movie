import 'package:movie/features/database/database_helper.dart';

class Favourite {
  int id;
  int idMovie;
  int view;
  bool like;

  Favourite({this.id, this.idMovie, this.view, this.like});

  Map<String, dynamic> toJson() => {
        DatabaseHelper.columeId: id,
        DatabaseHelper.columeIdMovie: idMovie,
        DatabaseHelper.columeView: view,
        DatabaseHelper.columeLike: like,
      };
}
