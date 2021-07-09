import 'package:movie/features/database/database_helper.dart';
import 'package:movie/features/model/data.dart';
import 'package:movie/features/model/favorite.dart';
import 'package:social_share/social_share.dart';
import 'package:stacked/stacked.dart';

class FilmDetalViewModel extends BaseViewModel {
  Future<void> clickLike(int isLike, Data data) async {
    List<Favourite> favouriteList = await DatabaseHelper.instance.queryAll();

    if (isLike == 1) {
      isLike = 0;
      Favourite favourite = Favourite(
        idMovie: data.id,
        view: favouriteList[data.id - 1].view == null
            ? data.views
            : favouriteList[data.id - 1].view,
        like: isLike,
      );
      await DatabaseHelper.instance.update(favourite);
    } else {
      isLike = 1;
      Favourite favourite = Favourite(
        idMovie: data.id,
        view: favouriteList[data.id - 1].view == null
            ? data.views
            : favouriteList[data.id - 1].view,
        like: isLike,
      );
      await DatabaseHelper.instance.update(favourite);
    }
  }

  void shareOptions(String description, String link) {
    SocialShare.shareOptions("${description}\n\n${link}");
  }
}
