import 'package:movie/features/database/database_helper.dart';
import 'package:movie/features/model/favorite.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  Future<void> updateMovie(Favourite favourite) async {
    await DatabaseHelper.instance.update(favourite);
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

}
