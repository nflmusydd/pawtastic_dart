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

  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  static bool get isProd => _environment == Environment.prod;
}
