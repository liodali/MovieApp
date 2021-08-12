import 'package:flutter/material.dart';
import '../common/locator.dart';
import '../../core/interactors/add_movie_to_fav_use_case.dart';
import '../../core/interactors/check_movie_is_fav_use_case.dart';
import '../../core/interactors/detail_movies_use_case.dart';
import '../../core/interactors/remove_movie_from_fav_use_case.dart';
import '../../domain/models/detail_movie.dart';
import '../../domain/models/response.dart';

import '../../domain/models/movie.dart';

class DetailMovieViewModel extends ChangeNotifier {
  final Movie _movie;
  DetailMovie? _detailMovie;

  bool _isFav = false;

  Movie get movie => _movie;

  bool get isFav => _isFav;

  DetailMovie? get detailMovie => _detailMovie;

  DetailMovieViewModel(this._movie);

  void setIsFav(bool fav) {
    _isFav = fav;
    notifyListeners();
  }
  @visibleForTesting
  void setDetail(DetailMovie detailMovie){
    _detailMovie = detailMovie;
  }

  Future<void> getDetailMovie() async {
    final response = await getIt<DetailMovieUseCase>().invoke(_movie.id);
    if (response is Response<DetailMovie>) {
      _detailMovie = response.data;
      notifyListeners();
    }
  }

  Future<void> checkIsFav() async {
    _isFav = await getIt<CheckMovieIsFavoriteUseCase>().invoke(movie.id);
    notifyListeners();
  }

  Future<int> addToFavorite() async {
    return await getIt<AddMovieToFavoriteUseCase>().invoke(movie);
  }

  Future<int> removeFromFavorite() async {
    return await getIt<RemoveMovieFromFavoriteUseCase>().invoke(movie.id);
  }
}
