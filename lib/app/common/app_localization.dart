import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyAppLocalizations {
  MyAppLocalizations(this.locale);

  final Locale locale;

  static MyAppLocalizations? of(BuildContext context) {
    return Localizations.of<MyAppLocalizations>(context, MyAppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title_app': 'Movie TMDB',
      'loading_text': 'Loading ...',
      'error_loading_image': 'Error to Get Image',
      'more_movies': 'more movies ...',
      'search_hint': 'search',
      'votes': 'votes',
    },
    'fr': {
      'title_app': 'Movie TMDB',
      'loading_text': 'Chargement ...',
      'error_loading_image': 'Impossible de télécharger cet image',
      'more_movies': 'plus de films ...',
      'search_hint': 'recherche',
      'votes': 'votes',
    },
  };

  String get titleApp => _localizedValues[locale.languageCode]!['title_app']!;

  String get loadingText =>
      _localizedValues[locale.languageCode]!['loading_text']!;

  String get errorLoadImage =>
      _localizedValues[locale.languageCode]!['error_loading_image']!;

  String get moreMovies =>
      _localizedValues[locale.languageCode]!['more_movies']!;

  String get searchHint =>
      _localizedValues[locale.languageCode]!['search_hint']!;

  String get votes => _localizedValues[locale.languageCode]!['votes']!;
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<MyAppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<MyAppLocalizations> load(Locale locale) {
    return SynchronousFuture<MyAppLocalizations>(MyAppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
