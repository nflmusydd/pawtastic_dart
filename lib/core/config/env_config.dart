import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { local, prod }

class EnvConfig {
  static Environment _environment = Environment.local;

  static void initialize(String env) {
    if (env == 'prod') {
      _environment = Environment.prod;
    } else {
      _environment = Environment.local;
    }
  }

  static String get envFile => _environment == Environment.prod ? '.env.prod' : '.env';

  static String get supabaseUrl {
    String url = dotenv.env['SUPABASE_URL'] ?? '';

    // Alur Local Development untuk Android
    if (!isProd && !kIsWeb && Platform.isAndroid && url.contains('127.0.0.1')) {
      // Emulator check (atau bisa pakai package device_info_plus)
      bool isEmulator = Platform.environment.containsKey('ANDROID_EMULATOR_LAUNCHER') || 
                        Platform.operatingSystemVersion.toLowerCase().contains('sdk');

      // tanpa adb reverse di emulator, replace ke IP 10.0.2.2
      if (isEmulator) {
        return url.replaceAll('127.0.0.1', '10.0.2.2');
      }

      // pakai adb reverse di HP Fisik (USB Debugging), tidak perlu replace IP.
    }
    return url;
  }


  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  static bool get isProd => _environment == Environment.prod;
}
