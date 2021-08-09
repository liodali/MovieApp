import '../models/movie.dart';
import '../models/response.dart';
import 'repository.dart';

abstract class MovieRepository extends Repository<Movie> {
  Future<IResponse> getDetail(int id);

  Future<IResponse> listMovieFavorites();

  Future<int> addToFavorite(Movie movie);

  Future<int> removeFromFavorite(Movie movie);
}
