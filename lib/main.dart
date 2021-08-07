import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/app/ui/pages/home.dart';
import 'package:movie_app/app/viewmodel/MoviesViewModel.dart';
import 'package:provider/provider.dart';

import 'app/common/app_localization.dart';
import 'app/common/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  configureInjection();
  await FlutterConfig.loadEnvVariables();
  runApp(MultiProvider(
    providers: [
      ListenableProvider(create: (ctx) => MoviesViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlexColorScheme.dark(
        scheme:  FlexScheme.shark,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ).toTheme,
      themeMode: ThemeMode.light,
      home: Home(),
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
