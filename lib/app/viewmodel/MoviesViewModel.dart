import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:synchronized/synchronized.dart';

import '../../core/interactors/movies_use_case.dart';
import '../../domain/common/utilities.dart';
import '../../domain/models/movie.dart';
import '../../domain/models/response.dart';
import '../common/locator.dart';

class MoviesViewModel extends ChangeNotifier {
  String _typeMovieSelected = categoriesMovies.values.first;
  bool _isLoading = false;
  int maxPage = -1;
  int page = 1;
  IResponse? _moviesResponse;
  List<Movie> _moviesCache = [];
  final  _moviesPublisher = PublishSubject<List<Movie>>();

  late final  _streamMoviesPublisher = _moviesPublisher.stream;

  final _lock = Lock();

  String get typeMovieSelected => _typeMovieSelected;

  bool get isLoading => _isLoading;

  IResponse? get moviesResponse => _moviesResponse;

  Stream<List<Movie>>? get stream => _streamMoviesPublisher;

  MoviesViewModel();



  void setTypeMovieSelected(String newTypesSelected) {
    _typeMovieSelected = newTypesSelected;
    notifyListeners();
  }

  Future<void> initMovies() async {

    await _lock
        .synchronized(() async =>
    await _fetchMovies(_typeMovieSelected, 1, () {
      page++;
    }));
  }

  Future<void> getMovies({bool restart = false}) async {
    if (restart) {
      page = 1;
      maxPage = -1;
      _moviesCache.clear();
    }
    if ((page < maxPage && maxPage != -1) || !_isLoading) {
      _isLoading = true;
      notifyListeners();
      await _lock.synchronized(
              () async =>
          await _fetchMovies(_typeMovieSelected, page, () {
            page++;
          }));
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchMovies(String path, int page,
      Function? actionAfterGetMove) async {
    final result = await getIt<MoviesListUseCase>().invoke({
      "path": "/$path",
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
