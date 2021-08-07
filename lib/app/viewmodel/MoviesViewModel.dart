import 'package:flutter/material.dart';
import 'package:movie_app/app/common/locator.dart';
import 'package:movie_app/core/interactors/movies_use_case.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/models/response.dart';

class MoviesViewModel extends ChangeNotifier {
  bool _isLoading = false;
  int maxPage = -1;
  int page = 1;
  IResponse? _moviesResponse;
  final _moviesPublisher = PublishSubject<List<Movie>>();

  bool get isLoading => _isLoading;

  IResponse? get moviesResponse => _moviesResponse;

  Stream<List<Movie>>? get stream => _moviesPublisher.stream;

  MoviesViewModel();

  Future<void> initMovies(String types, {bool restart = false}) async {
    final result = await getIt<MoviesListUseCase>().invoke({
      "path": types,
      "page": 1,
    });
    if (result is MoviesResponse) {
      if (maxPage == -1) {
        maxPage = result.maxPages;
      }
      _moviesPublisher.sink.add(result.data);
      page++;
    } else {
      _moviesPublisher.sink.addError((result as ErrorResponse).error);
    }
  }

  Future<void> getMovies(String types, {bool restart = false}) async {
    if ((page < maxPage && maxPage != -1) || !_isLoading) {
      _isLoading = true;
      notifyListeners();
      final result = await getIt<MoviesListUseCase>().invoke({
        "path": types,
        "page": page,
      });
      if (result is MoviesResponse) {
        if (maxPage == -1) {
          maxPage = result.maxPages;
        }
        _moviesPublisher.sink.add(result.data);
        page++;
      } else {
        _moviesPublisher.sink.addError((result as ErrorResponse).error);
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _moviesPublisher.close();
    super.dispose();
  }
}
