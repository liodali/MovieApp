import 'package:flutter/material.dart';
import 'package:movie_app/app/common/locator.dart';
import 'package:movie_app/core/interactors/get_movies_from_fav_use_case.dart';
import 'package:movie_app/domain/models/response.dart';


class FavoriteMoviesViewModel extends ChangeNotifier {
 late  Future<IResponse> _moviesFav;

  Future<IResponse> get moviesFav => _moviesFav;


  void getMovieFavoriteList(){
    _moviesFav =  getIt<GetMoviesFromFavoriteUseCase>().invoke();
  }

}
