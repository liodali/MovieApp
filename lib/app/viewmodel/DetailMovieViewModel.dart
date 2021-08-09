import 'package:flutter/material.dart';
import 'package:movie_app/app/common/locator.dart';
import 'package:movie_app/core/interactors/add_movie_to_fav_use_case.dart';
import 'package:movie_app/core/interactors/check_movie_is_fav_use_case.dart';
import 'package:movie_app/core/interactors/detail_movies_use_case.dart';
import 'package:movie_app/domain/models/detail_movie.dart';
import 'package:movie_app/domain/models/response.dart';

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

  Future<int> addToFavorite(Movie movie) async {
    return await getIt<AddMovieToFavoriteUseCase>().invoke(movie);
  }
}
