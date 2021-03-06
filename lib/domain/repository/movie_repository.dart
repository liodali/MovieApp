import '../models/movie.dart';
import '../models/response.dart';
import 'repository.dart';

abstract class MovieRepository extends Repository<Movie> {
  Future<IResponse> getDetail(int id);

  Future<IResponse> listMovieFavorites();

  Future<IResponse> searchForMovie(
    String query,
    int page, {
    String? region,
    String? year,
  });

  Future<bool> isMovieFav(int id);

  Future<int> addToFavorite(Movie movie);

  Future<int> removeFromFavorite(int movieId);
}
