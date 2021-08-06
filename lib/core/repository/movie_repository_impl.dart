import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:movie_app/domain/models/response.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

import '../common/networkMixin.dart';

Future<IResponse> computeParserMoviesJson(Map<String, dynamic> input) async {
  return MoviesResponse(
    maxPages: input["pages"],
    movies: (input["data"] as List).map((e) => Movie.fromJson(e)).toList(),
  );
}

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl with NetworkMixin implements MovieRepository {
  @override
  Future<IResponse> getAll({String path = ""}) async {
    final response = (await get(endpoint: path));
    if (response.statusCode != 200) {
      return ErrorResponse(error: "error to get movie");
    }
    final data = response.data as Map<String, dynamic>;
    return compute(
      computeParserMoviesJson,
      {
        "pages": data["total_pages"],
        "data": data["results"] as List<dynamic>,
      },
    );
  }

  @override
  Future<IResponse> getAllByFilter(filter) {
    // TODO: implement getAllByFilter
    throw UnimplementedError();
  }

  @override
  Future<IResponse> getDetail(int id) {
    // TODO: implement getDetail
    throw UnimplementedError();
  }

  @override
  Future<IResponse> addToFavorite(Movie movie) {
    // TODO: implement addToFavorite
    throw UnimplementedError();
  }

  @override
  Future<IResponse> removeFromFavorite(Movie movie) {
    // TODO: implement removeFromFavorite
    throw UnimplementedError();
  }
}
