// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get options => 'Options';

  @override
  String get language => 'Language';

  @override
  String get profile => 'Profile';

  @override
  String get signOut => 'Sign Out';

  @override
  String get changeLanguage => 'Change Language?';

  @override
  String confirmChangeLanguage(String language) {
    return 'Are you sure you want to change the language to $language?';
  }

  @override
  String get yesChange => 'Yes, Change';

  @override
  String get cancel => 'Cancel';

  @override
  String successChangeLanguage(String language) {
    return 'Language changed to $language';
  }
}
