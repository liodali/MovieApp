import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/common/use_cases.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

@Injectable()
class RemoveMovieFromFavoriteUseCase extends FutureUseCase<int, int> {
  final MovieRepository _repository;

  RemoveMovieFromFavoriteUseCase(this._repository);

  @override
  Future<int> invoke(int? parameter) async {
    return await this._repository.removeFromFavorite(parameter!);
  }
}
