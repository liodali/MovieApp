import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/core/common/local_storage_mixin.dart';
import 'package:movie_app/core/repository/movie_repository_impl.dart';
import 'package:movie_app/domain/models/response.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadValueForTesting({
    "API_URL": "https://api.themoviedb.org/3/",
    "API_KEY": "dc691803b1e7338ffeb819bf737c2dca"
  });
  final temp = await Directory.systemTemp.createTemp();
  Hive.init(temp.path);
  await HiveDB.init("FavoriteMovie");
  final movieRepo = MovieRepositoryImpl();

  test("test movie popular", () async {
    MoviesResponse moviesResponse =
        await movieRepo.getAll(path: "/popular") as MoviesResponse;
    expect(moviesResponse.maxPages, 500);
  });
}
