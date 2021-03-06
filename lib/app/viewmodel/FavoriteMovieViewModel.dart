import 'package:flutter/material.dart';
import 'package:movie_app/app/common/locator.dart';
import 'package:movie_app/core/interactors/check_movie_is_fav_use_case.dart';
import 'package:movie_app/core/interactors/get_movies_from_fav_use_case.dart';
import 'package:movie_app/core/interactors/remove_movie_from_fav_use_case.dart';
import 'package:movie_app/domain/models/response.dart';

class FavoriteMoviesViewModel extends ChangeNotifier {
  late Future<IResponse> _moviesFav;

  Future<IResponse> get moviesFav => _moviesFav;

  void getMovieFavoriteList() {
    _moviesFav = getIt<GetMoviesFromFavoriteUseCase>().invoke();
  }

  Future<int> removeMovieFromFavoriteList(int movieId) async {
    return await getIt<RemoveMovieFromFavoriteUseCase>().invoke(movieId);
  }
  Future<bool> checkMovieInFavorite(int movieId) async {
    return await getIt<CheckMovieIsFavoriteUseCase>().invoke(movieId);
  }
}
