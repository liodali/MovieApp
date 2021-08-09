import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/common/use_cases.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

@Injectable()
class CheckMovieIsFavoriteUseCase extends FutureUseCase<int, bool> {
  final MovieRepository _repository;

  CheckMovieIsFavoriteUseCase(this._repository);

  @override
  Future<bool> invoke(int? parameter) async {
    return await this._repository.isMovieFav(parameter!);
  }
}
