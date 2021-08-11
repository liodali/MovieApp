import 'package:flutter/material.dart';
import 'package:movie_app/app/common/locator.dart';
import 'package:movie_app/core/interactors/search_movies_use_case.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:movie_app/domain/models/response.dart';
import 'package:rxdart/rxdart.dart';

class TextSearchVM extends ChangeNotifier {
  String _query = "";
  String get query => _query;
  void setQuery(query){
    _query = query;
    //notifyListeners();
  }
}

class SearchMovieViewModel extends ChangeNotifier {
  SearchMovieViewModel(this._query);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

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

  void update(String query) {
    _query = query;
    notifyListeners();
    _moviesCache.clear();
    page = 1;
    maxPage = -1;
    _isLoading = true;
    searchForMovie();
    _isLoading = false;
    notifyListeners();
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
}
