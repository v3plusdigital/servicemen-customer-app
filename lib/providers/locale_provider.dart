import 'package:flutter/material.dart';
import 'package:servicemen_customer_app/services/local_data/shared_pref.dart';
import 'package:servicemen_customer_app/services/local_data/shared_pref_keys.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  final SharedPrefService _sharedPrefService = SharedPrefService();

  Locale get locale => _locale;

  // Initialize locale from shared preferences
  Future<void> initializeLocale() async {
    final savedLanguageCode = await _sharedPrefService.getStringValue(SharedPrefKey.languageCode);
    if (savedLanguageCode != null) {
      _locale = Locale(savedLanguageCode);
      notifyListeners();
    }
  }

  // Change locale and save to shared preferences
  Future<void> changeLocale(String languageCode) async {
    _locale = Locale(languageCode);
    await _sharedPrefService.setStringValue(SharedPrefKey.languageCode, languageCode);
    notifyListeners();
  }

  // Get language name based on language code
  String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'हिंदी';
      case 'gu':
        return 'ગુજરાતી';
      default:
        return 'English';
    }
  }
}