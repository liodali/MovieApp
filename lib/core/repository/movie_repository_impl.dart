import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/common/local_storage_mixin.dart';

import '../../domain/models/detail_movie.dart';
import '../../domain/models/movie.dart';
import '../../domain/models/response.dart';
import '../../domain/repository/movie_repository.dart';
import '../common/network_mixin.dart';

Future<IResponse> computeParserMoviesJson(Map<String, dynamic> input) async {
  return MoviesResponse(
    maxPages: input["pages"],
    movies: (input["data"] as List).map((e) => Movie.fromJson(e)).toList(),
  );
}

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl
    with NetworkMixin, LocalStorageMixin
    implements MovieRepository {
  static const String prefixMovieURL = "movie";

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
  Future<int> addToFavorite(Movie movie) async {
    try {
      await addFavorite(movie);
      return 200;
    } catch (e) {
      return 400;
    }
  }

  @override
  Future<int> removeFromFavorite(Movie movie) {
    // TODO: implement removeFromFavorite
    throw UnimplementedError();
  }

  @override
  Future<IResponse> listMovieFavorites() async {
    try {
      var list = await getFavorites();
      return MoviesResponse(maxPages: 1, movies: list);
    } catch (e) {
      return ErrorResponse(error: {"code": 404, "message": e.toString()});
    }
  }

  @override
  Future<bool> isMovieFav(int id) async{
     return await isMovieFavorite(id);
  }
}
