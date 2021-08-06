import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyAppLocalizations {
  MyAppLocalizations(this.locale);

  final Locale locale;

  static MyAppLocalizations? of(BuildContext context) {
    return Localizations.of<MyAppLocalizations>(
        context, MyAppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title_app': 'Movie TMDB',
      'loading_text': 'Loading ...',

    },
    'fr': {
      'title_app': 'Movie TMDB',
      'loading_text': 'Changement ...',

    },
  };

  String get titleApp => _localizedValues[locale.languageCode]!['title_app']!;
  String get loadingText => _localizedValues[locale.languageCode]!['loading_text']!;
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<MyAppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<MyAppLocalizations> load(Locale locale) {
    return SynchronousFuture<MyAppLocalizations>(
        MyAppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}