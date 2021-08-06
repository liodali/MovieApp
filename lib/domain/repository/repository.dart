import '../models/response.dart';

abstract class Repository<T> {
  Future<IResponse> getAll();

  Future<IResponse> getAllByFilter(dynamic filter);

}
