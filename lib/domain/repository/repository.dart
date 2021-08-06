import '../models/response.dart';

abstract class Repository<T> {
  Future<IResponse> getAll({String path = ""});

  Future<IResponse> getAllByFilter(dynamic filter);
}
