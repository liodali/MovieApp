import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/common/use_cases.dart';
import 'package:movie_app/domain/models/response.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

@Injectable()
class DetailMovieUseCase extends FutureUseCase<int, IResponse> {
  final MovieRepository _repository;

  DetailMovieUseCase(this._repository);

  @override
  Future<IResponse> invoke(int? parameter) async {
    return await this._repository.getDetail(parameter!);
  }
}
