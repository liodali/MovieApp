import 'package:flutter/material.dart';
import 'package:movie_app/app/common/locator.dart';
import 'package:movie_app/core/interactors/detail_movies_use_case.dart';
import 'package:movie_app/domain/models/detail_movie.dart';
import 'package:movie_app/domain/models/response.dart';

import '../../domain/models/movie.dart';

class DetailMovieViewModel extends ChangeNotifier {
  final Movie _movie;
  DetailMovie? _detailMovie;

  Movie get movie => _movie;

  DetailMovie? get detailMovie => _detailMovie;

  DetailMovieViewModel(this._movie);

  Future<void> getDetailMovie() async {
    final response = await getIt<DetailMovieUseCase>().invoke(_movie.id);
    if(response is Response<DetailMovie>){
      _detailMovie = response.data;
      notifyListeners();
    }
  }
}
