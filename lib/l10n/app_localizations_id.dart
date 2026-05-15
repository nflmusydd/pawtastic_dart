// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get settings => 'Pengaturan';

  @override
  String get options => 'Opsi';

  @override
  String get language => 'Bahasa';

  @override
  String get profile => 'Profil';

  @override
  String get signOut => 'Keluar';

  @override
  String get changeLanguage => 'Ganti Bahasa?';

  @override
  String confirmChangeLanguage(String language) {
    return 'Apakah Anda yakin ingin mengganti bahasa ke $language?';
  }

  @override
  String get yesChange => 'Ya, Ganti';

  @override
  String get cancel => 'Batal';

  @override
  String successChangeLanguage(String language) {
    return 'Bahasa berhasil diubah ke $language';
  }
}
