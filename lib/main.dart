import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/app/viewmodel/MoviesViewModel.dart';
import 'package:provider/provider.dart';

import 'app/common/app_localization.dart';
import 'app/common/locator.dart';
import 'app/common/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  configureInjection();
  await FlutterConfig.loadEnvVariables();

  final _rootRouter = RootRouter();

  runApp(MultiProvider(
    providers: [
      ListenableProvider(create: (ctx) => MoviesViewModel()),
    ],
    child: MyApp(
      router: _rootRouter,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final RootRouter router;

  const MyApp({
    Key? key,
    required this.router,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
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
