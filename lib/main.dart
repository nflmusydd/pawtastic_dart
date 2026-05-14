import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pawtastic/core/config/env_config.dart';
import 'package:pawtastic/services/firebase/add_product.dart';
import 'package:pawtastic/pages/buyer/cart/cart.dart';
import 'package:pawtastic/pages/buyer/home/most_popular.dart';
import 'package:pawtastic/pages/seller/cashier.dart';
import 'package:pawtastic/pages/seller/home_seller.dart';
import 'package:pawtastic/pages/seller/manage_order.dart';
import 'package:pawtastic/pages/seller/manage_product.dart';
import 'package:pawtastic/pages/common/about_us_page.dart';
import 'package:pawtastic/pages/buyer/orders/my_orders.dart';
import 'package:pawtastic/pages/buyer/search_page.dart';
import 'package:pawtastic/pages/common/settings_page.dart';
import 'package:pawtastic/pages/auth/forgot_password.dart';
import 'package:pawtastic/pages/buyer/home/home.dart';
import 'package:pawtastic/pages/auth/login_page.dart';
import 'package:pawtastic/pages/auth/login_page_seller.dart';
import 'package:pawtastic/pages/auth/onboarding.dart';
import 'package:pawtastic/pages/auth/signup_page.dart';
import 'package:pawtastic/pages/auth/splash_screen.dart';
import 'package:pawtastic/pages/auth/splash_screen_shop.dart';
import 'package:pawtastic/pages/auth/signup_page_seller.dart';
import 'package:pawtastic/pages/common/no_connection_page.dart';
import 'package:pawtastic/pages/auth/reset_password.dart';
import 'package:pawtastic/pages/test_page.dart';
import 'package:pawtastic/services/gemini_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:pawtastic/services/user_provider.dart';
import 'package:provider/provider.dart';

// Use --dart-define=ENVIRONMENT=prod during build/run
const String env = String.fromEnvironment('ENVIRONMENT', defaultValue: 'local');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EnvConfig.initialize(env);

  try {
    await dotenv.load(fileName: EnvConfig.envFile);
  } catch (e) {
    if (kDebugMode) debugPrint("Dotenv load failed: $e");
  }
  
  // belum di migrate semua
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (kDebugMode) debugPrint("Firebase initialization failed: $e");
  }

  try {
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );
  } catch (e) {
    if (kDebugMode) debugPrint("Supabase initialization failed: $e");
  }
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<AuthState>? _authSubscription;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // Listener Global untuk menangani Deep Link (seperti Reset Password)
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.passwordRecovery) {
        // Jika user datang dari link reset password di email, 
        // arahkan otomatis ke halaman Reset Password.
        _navigatorKey.currentState?.pushNamed('/reset-password');
      }
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey, // Penting agar bisa navigasi dari luar widget tree
      title: 'Pawtastic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(252, 147, 3, 1.0)),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 250, 250),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(252, 147, 3, 1.0),
          selectionColor: Color.fromRGBO(252, 147, 3, 0.3),
          selectionHandleColor: Color.fromRGBO(252, 147, 3, 1.0),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16.0),
          displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        useMaterial3: true,
      ),
      routes: {
        '/test': (context) => TestPage(),
        '/shop': (context) => const StartingAnimationShop(),
        '/login': (context) => const Loginpage(),
        '/login-seller': (context) => const LoginpageSeller(),
        '/signup': (context) => const Signuppage(),
        '/signup-seller': (context) => const SignuppageSeller(),
        '/forgot-password': (context) => const Forgotpassword(),
        '/reset-password': (context) => const ResetPasswordPage(),
        '/home': (context) => toHomePage(),
        '/home-seller': (context) => HomeSeller(),
        // '/home': (context) => Bottombar(initialIndex: 0),    // jangan dihapus
        '/most-popular': (context) => MostPopular(),
        '/cart': (context) => toCartPage(),
        '/my-orders': (context) => toMyOrdersPage(),
        // '/detail-orders': (context) => Detailorders(),
        '/settings': (context) => toSettingsPage(),
        '/search': (context) => toSearchPage(),
        '/addproduct': (context) => AddProduct(),
        '/manageorder': (context) => ManageOrders(),
        '/cashier': (context) => Cashier(),
        '/aboutus': (context) => AboutUs(),
        '/manageproduct': (context) => ManageProduct(),
        '/chatbot': (context) => GeminiService(),

      },
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    if (kDebugMode) {
      debugPrint("AUTH_DEBUG: Role=${userProvider.role}, User=${userProvider.user}, Loading=${userProvider.isLoading}, Error=${userProvider.hasConnectionError}");
    }
    if (userProvider.hasConnectionError) {
      return const NoConnectionPage();
    }

    // Jika masih loading, tampilkan Splash
    if (userProvider.isLoading) {
      return const StartingAnimation();
    }

    // Jika belum login (dan tidak sedang simulasi), tampilkan Onboarding
    if (userProvider.user == null && userProvider.role == UserRole.none) {
      return const Onboarding();
    }

    // Jika Role Seller, ke Home Seller
    if (userProvider.role == UserRole.seller) {
      return HomeSeller();
    }

    // Default: Ke Home Buyer
    return toHomePage();
  }
}
