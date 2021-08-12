import 'package:flutter/material.dart';
import 'package:movie_app/app/common/locator.dart';
import 'package:movie_app/core/interactors/search_movies_use_case.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:movie_app/domain/models/response.dart';
import 'package:rxdart/rxdart.dart';

class SearchMovieViewModel extends ChangeNotifier {
  SearchMovieViewModel();

  bool _isLoading = false;
  bool _isChanged = false;

  bool get isLoading => _isLoading;

  String get query => _query;

  List<Movie> _moviesCache = [];
  int maxPage = -1;
  int page = 1;

  String _query = "";

  final _moviesPublisher = PublishSubject<List<Movie>>();

  Stream<List<Movie>> get stream => _moviesPublisher.stream;

  bool get isQueryEmpty => _query.isEmpty;

  @override
  void dispose() {
    _moviesPublisher.close();
    super.dispose();
  }

  void setQuery(query) {
    if (_query != query) {
      _query = query;
      _isChanged = true;
      //notifyListeners();
    }
  }

  void update() {
    // _query = query;
    if (_isChanged && _query.isNotEmpty) {
      _moviesCache.clear();
      page = 1;
      maxPage = -1;
      _isChanged = false;
      _isLoading = true;
      searchForMovie();
      _isLoading = false;
    } else if (_query.isNotEmpty) {
      Future.delayed(Duration.zero, () async {
        _moviesPublisher.sink.add(_moviesCache);
      });
    }
  }

  void searchForMovie() async {
    final queryEndPoint = {
      "query": _query,
      "page": page,
    };

    final response =
        await getIt<SearchForMoviesUseCase>().invoke(queryEndPoint);
    if (response is ErrorResponse) {
      _moviesPublisher.sink.addError((response).error);
    } else {
      _moviesCache.addAll((response as MoviesResponse).data);
      _moviesPublisher.sink.add(_moviesCache);
    }
  }

  void clear() {
    _moviesCache.clear();
    page = 1;
    maxPage = -1;
    _isChanged = false;
    _isLoading = false;
  }
}
