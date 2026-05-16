import 'package:flutter/material.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  void setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    
    // Sinkronisasi dengan Slang agar reaktif
    LocaleSettings.setLocaleRaw(locale.languageCode);
    
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    _locale = Locale(languageCode);
    
    // Sinkronisasi dengan Slang saat load pertama
    LocaleSettings.setLocaleRaw(languageCode);
    
    notifyListeners();
  }
}
