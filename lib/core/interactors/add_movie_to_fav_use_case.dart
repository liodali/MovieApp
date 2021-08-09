import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/common/use_cases.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

@Injectable()
class AddMovieToFavoriteUseCase extends FutureUseCase<Movie, int> {
  final MovieRepository _repository;

  AddMovieToFavoriteUseCase(this._repository);

  @override
  Future<int> invoke(Movie? parameter) async {
    return await this._repository.addToFavorite(parameter!);
  }
}
