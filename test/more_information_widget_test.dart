// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/app/common/locator.dart';
import 'package:movie_app/app/common/utilities.dart';
import 'package:movie_app/app/ui/component/more_information_movie.dart';
import 'package:movie_app/app/viewmodel/DetailMovieViewModel.dart';
import 'package:movie_app/core/common/local_storage_mixin.dart';
import 'package:movie_app/core/interactors/detail_movies_use_case.dart';
import 'package:movie_app/domain/models/detail_movie.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:movie_app/domain/models/response.dart';
import 'package:provider/provider.dart';

void main() async {
  //TestWidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadValueForTesting({
    "API_URL": "https://api.themoviedb.org/3/",
    "API_KEY": "dc691803b1e7338ffeb819bf737c2dca"
  });
  final temp = await Directory.systemTemp.createTemp();
  Hive.init(temp.path);
  await HiveDB.init("FavoriteMovie");
  configureInjection();
  Movie movie = Movie.fromJson({
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

  DetailMovieViewModel vm = DetailMovieViewModel(movie);
  final detail = (await getIt<DetailMovieUseCase>().invoke(297761)
          as Response<DetailMovie>)
      .data;
  vm.setDetail(detail);
  testWidgets("check more information", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ChangeNotifierProvider.value(
          value: vm,
          child: MoreInformationMovie(),
        ),
      ),
    ));
    await tester.pump();
    final duration = calculateDurationMovie(123);
    expect(find.text(duration), findsOneWidget);
    expect(find.text("EN"), findsOneWidget);
    expect(find.text("Action,Adventure,Fantasy"), findsOneWidget);
  });
}
