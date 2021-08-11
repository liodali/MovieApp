import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/common/use_cases.dart';
import 'package:movie_app/domain/models/response.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

@Injectable()
class SearchForMoviesUseCase extends FutureUseCase<Map<String, dynamic>, IResponse> {
  final MovieRepository _repository;

  SearchForMoviesUseCase(this._repository);

  @override
  Future<IResponse> invoke(Map<String, dynamic>? parameter) async {
    return await this._repository.searchForMovie(
          parameter!["query"],
          parameter["page"],
          region: parameter.containsKey("region") ? parameter["region"] : null,
          year: parameter.containsKey("year") ? parameter["year"] : null,
        );
  }
}
