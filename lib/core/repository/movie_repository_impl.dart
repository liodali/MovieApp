import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/detail_movie.dart';
import '../../domain/models/movie.dart';
import '../../domain/models/response.dart';
import '../../domain/repository/movie_repository.dart';
import '../common/networkMixin.dart';

Future<IResponse> computeParserMoviesJson(Map<String, dynamic> input) async {
  return MoviesResponse(
    maxPages: input["pages"],
    movies: (input["data"] as List).map((e) => Movie.fromJson(e)).toList(),
  );
}


@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl with NetworkMixin implements MovieRepository {
  static const String prefixMovieURL = "/movie";

  @override
  Future<IResponse> getAll({String path = "", int page = 1}) async {
    final response = await get(
      endpoint: "$prefixMovieURL$path",
      query: {
        "page": page,
      },
    );
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
  Future<IResponse> getDetail(int id) async {
    final response = await get(
      endpoint: "$prefixMovieURL/$id",
    );
    if (response.statusCode != 200) {
      return ErrorResponse(error: "error to get detail movie");
    }
    final data = response.data as Map<String, dynamic>;
    return Response<DetailMovie>(data: DetailMovie.fromJson(data));
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
