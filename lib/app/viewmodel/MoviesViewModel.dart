import 'package:flutter/material.dart';
import 'package:movie_app/app/common/locator.dart';
import 'package:movie_app/core/interactors/movies_use_case.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:synchronized/synchronized.dart';

import '../../domain/models/response.dart';

class MoviesViewModel extends ChangeNotifier {
  bool _isLoading = false;
  int maxPage = -1;
  int page = 1;
  IResponse? _moviesResponse;
  List<Movie> _moviesCache = [];
  final _moviesPublisher = PublishSubject<List<Movie>>();
  final _lock = Lock();

  bool get isLoading => _isLoading;

  IResponse? get moviesResponse => _moviesResponse;

  Stream<List<Movie>>? get stream => _moviesPublisher.stream;

  MoviesViewModel();

  Future<void> initMovies(String types, {bool restart = false}) async {
    await _lock.synchronized(() async => await _fetchMovies(types, 1, () {
          page++;
        }));
  }

  Future<void> getMovies(String types, {bool restart = false}) async {
    if ((page < maxPage && maxPage != -1) || !_isLoading) {
      _isLoading = true;
      notifyListeners();
      await _lock.synchronized(() async => await _fetchMovies(types, page, () {
            page++;
          }));
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchMovies(
      String path, int page, Function? actionAfterGetMove) async {
    final result = await getIt<MoviesListUseCase>().invoke({
      "path": path,
      "page": page,
    });
    if (result is MoviesResponse) {
      if (maxPage == -1) {
        maxPage = result.maxPages;
      }
      _moviesCache.addAll(result.data);
      _moviesPublisher.sink.add(_moviesCache);
      if (actionAfterGetMove != null) {
        actionAfterGetMove();
      }
    } else {
      _moviesPublisher.sink.addError((result as ErrorResponse).error);
    }
  }

  @override
  void dispose() {
    _moviesPublisher.close();
    super.dispose();
  }
}
