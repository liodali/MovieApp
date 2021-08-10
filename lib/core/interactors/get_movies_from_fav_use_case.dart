import 'package:injectable/injectable.dart';
import '../../domain/common/use_cases.dart';
import '../../domain/models/response.dart';
import '../../domain/repository/movie_repository.dart';

@Injectable()
class GetMoviesFromFavoriteUseCase extends FutureUseCase0<IResponse> {
  final MovieRepository _repository;

  GetMoviesFromFavoriteUseCase(this._repository);

  @override
  Future<IResponse> invoke() async{
   return _repository.listMovieFavorites();
  }


}
