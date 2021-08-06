import '../models/movie.dart';
import '../models/response.dart';
import 'repository.dart';

abstract class MovieRepository extends Repository<Movie> {
  Future<IResponse> getDetail(int id);
  Future<IResponse> addToFavorite(Movie movie);
  Future<IResponse> removeFromFavorite(Movie movie);
}
