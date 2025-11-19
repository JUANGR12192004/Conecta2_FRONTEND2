import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryOption {
  final String code;
  final String name;
  final String emoji;
  final Locale locale;
  final String currencyCode;

  const CountryOption({
    required this.code,
    required this.name,
    required this.emoji,
    required this.locale,
    required this.currencyCode,
  });

  String get localeTag =>
      locale.countryCode == null ? locale.languageCode : '${locale.languageCode}_${locale.countryCode}';

  static const colombia = CountryOption(
    code: 'CO',
    name: 'Colombia',
    emoji: '🇨🇴',
    locale: Locale('es', 'CO'),
    currencyCode: 'COP',
  );
  static const brazil = CountryOption(
    code: 'BR',
    name: 'Brasil',
    emoji: '🇧🇷',
    locale: Locale('pt', 'BR'),
    currencyCode: 'BRL',
  );
  static const unitedStates = CountryOption(
    code: 'US',
    name: 'Estados Unidos',
    emoji: '🇺🇸',
    locale: Locale('en', 'US'),
    currencyCode: 'USD',
  );
  static const france = CountryOption(
    code: 'FR',
    name: 'Francia',
    emoji: '🇫🇷',
    locale: Locale('fr', 'FR'),
    currencyCode: 'EUR',
  );
  static const germany = CountryOption(
    code: 'DE',
    name: 'Alemania',
    emoji: '🇩🇪',
    locale: Locale('de', 'DE'),
    currencyCode: 'EUR',
  );

  static const List<CountryOption> values = [
    colombia,
    brazil,
    unitedStates,
    france,
    germany,
  ];

  static CountryOption fromCode(String? code) {
    return values.firstWhere(
      (country) => country.code == code,
      orElse: () => colombia,
    );
  }
}

class LocaleProvider extends ChangeNotifier {
  static const _storageKey = 'selected_country';
  final SharedPreferences _prefs;
  late CountryOption _selectedCountry;

  LocaleProvider(this._prefs) {
    final saved = _prefs.getString(_storageKey);
    _selectedCountry = CountryOption.fromCode(saved);
    Intl.defaultLocale = _selectedCountry.localeTag;
  }

  CountryOption get selectedCountry => _selectedCountry;

  List<CountryOption> get countries => CountryOption.values;

  List<Locale> get supportedLocales =>
      countries.map((country) => country.locale).toList();

  Locale get locale => _selectedCountry.locale;

  Future<void> updateCountry(CountryOption country) async {
    if (_selectedCountry.code == country.code) return;
    _selectedCountry = country;
    Intl.defaultLocale = country.localeTag;
    await _prefs.setString(_storageKey, country.code);
    notifyListeners();
  }

  String formatCurrency(double value) =>
      NumberFormat.currency(locale: _selectedCountry.localeTag, name: _selectedCountry.currencyCode)
          .format(value);

  String formatDate(DateTime date) =>
      DateFormat.yMMMMEEEEd(_selectedCountry.localeTag).format(date);
}
