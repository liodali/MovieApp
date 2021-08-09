import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/core/common/local_storage_mixin.dart';
import 'package:movie_app/domain/models/movie.dart';

class TestHiveDB with LocalStorageMixin {}

void main() {
  group("group", (){
    late TestHiveDB testDB;

    setUp(() async {
      final temp = await Directory.systemTemp.createTemp();
      Hive.init(temp.path);
      await HiveDB.init("FavoriteMovie");
      testDB = TestHiveDB();
    });

    test("add favorite", () async {
      final movie = Movie.fromJson({
        "poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
        "adult": false,
        "overview":
        "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
        "release_date": "2016-08-03",
        "id": 297761,
        "original_title": "Suicide Squad",
        "original_language": "en",
        "title": "Suicide Squad",
        "backdrop_path": "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
        "popularity": 48.261451,
        "vote_count": 1466,
        "vote_average": 5.91
      });

      await testDB.addFavorite(movie);

      final movieFromHiveDB = await testDB.getFavoriteById(297761);
      expect(movieFromHiveDB!.title, "Suicide Squad");

      final movies = await testDB.getFavorites();
      expect(movies.length, 1);
      expect(movies.first.id, 297761);
    });
    tearDown(() async {
      await testDB.clearAll();
    });
  });
}
