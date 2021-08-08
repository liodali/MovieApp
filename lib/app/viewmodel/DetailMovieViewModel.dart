import 'package:flutter/material.dart';

import '../../domain/models/movie.dart';

class DetailMovieViewModel extends ChangeNotifier {
  final Movie _movie;

  Movie get movie => _movie;

  DetailMovieViewModel(this._movie);
}
