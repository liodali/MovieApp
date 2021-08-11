import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/app/ui/pages/favorite_movie_list.dart';
import 'package:movie_app/app/viewmodel/movies_view_model.dart';
import 'package:provider/provider.dart';

import 'app/common/app_localization.dart';
import 'app/common/locator.dart';
import 'app/common/routes.dart';
import 'app/ui/pages/home.dart';
import 'app/viewmodel/search_movie_view_model.dart';
import 'core/common/local_storage_mixin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig

  configureInjection();
  await FlutterConfig.loadEnvVariables();
  await Hive.initFlutter();
  await HiveDB.init("FavoriteMovie");

  runApp(MultiProvider(
    providers: [
      ListenableProvider<MoviesViewModel>(
        create: (ctx) => MoviesViewModel(),
        dispose: (ctx, moviesViewModel) => moviesViewModel.dispose(),
      ),
      ListenableProvider<TextSearchVM>(
        create: (ctx) => TextSearchVM(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AppRouter.homePage: (ctx) => Home(),
        AppRouter.favoriteMoviesNamePage: (ctx) => FavoriteMovieList(),
      },
      initialRoute: AppRouter.homePage,
      onGenerateRoute: AppRouter.routes,
      theme: FlexColorScheme.dark(
        scheme: FlexScheme.shark,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ).toTheme,
      themeMode: ThemeMode.light,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('fr', ''), // English, no country code
      ],
    );
  }
}
