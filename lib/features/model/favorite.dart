import 'package:movie/features/database/database_helper.dart';

class Favourite {
  int id;
  int idMovie;
  int view;
  int like;

  Favourite({this.id, this.idMovie, this.view, this.like});

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
    id: json[DatabaseHelper.columeId],
    idMovie: json[DatabaseHelper.columeIdMovie],
    view: json[DatabaseHelper.columeView],
    like: json[DatabaseHelper.columeLike],
  );

  Map<String, dynamic> toJson() => {
        DatabaseHelper.columeId: id,
        DatabaseHelper.columeIdMovie: idMovie,
        DatabaseHelper.columeView: view,
        DatabaseHelper.columeLike: like,
      };
}
