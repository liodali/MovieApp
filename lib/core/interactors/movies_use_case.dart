import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/common/use_cases.dart';
import 'package:movie_app/domain/models/response.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

@Injectable()
class MoviesListUseCase extends FutureUseCase<Map<String, dynamic>, IResponse> {
  final MovieRepository _repository;

  MoviesListUseCase(this._repository);

  @override
  Future<IResponse> invoke(Map<String, dynamic>? parameter) async {
    return await this._repository.getAll(
          path: parameter!["path"],
          page: parameter["page"],
        );
  }
}
