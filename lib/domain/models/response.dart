import 'movie.dart';

abstract class IResponse {}

class ErrorResponse extends IResponse {
  dynamic error;

  ErrorResponse({
    required this.error,
  });
}

class Response<T> extends IResponse {
  T data;

  Response({
    required this.data,
  });
}

class MovieResponse extends Response<Movie> {
  MovieResponse({
    required Movie movie,
  }) : super(data: movie);
}

class MoviesResponse extends Response<List<Movie>> {
  MoviesResponse({
    required List<Movie> movies,
  }) : super(data: movies);
}