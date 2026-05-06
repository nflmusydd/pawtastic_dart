import 'package:flutter/material.dart';
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
import 'package:pawtastic/pages/test_page.dart';
import 'package:pawtastic/services/gemini_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:pawtastic/services/user_provider.dart';
import 'package:provider/provider.dart';

const String environment = 'local';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    String envFile = environment == 'prod' ? '.env.prod' : '.env';
    await dotenv.load(fileName: envFile);
  } catch (e) {
    debugPrint("Dotenv load failed: $e");
  }
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }

  try {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  } catch (e) {
    debugPrint("Supabase initialization failed: $e");
  }
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawtastic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', // membuat font Poppins untuk keseluruhan file
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 93, 0, 255)),
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
    
    debugPrint("AUTH_DEBUG: Role=${userProvider.role}, User=${userProvider.user}, Loading=${userProvider.isLoading}");

    // 1. Jika masih loading, tampilkan Splash
    if (userProvider.isLoading) {
      return const StartingAnimation();
    }

    // 2. Jika belum login (dan tidak sedang simulasi), tampilkan Onboarding
    if (userProvider.user == null && userProvider.role == UserRole.none) {
      return const Onboarding();
    }

    // 3. Jika Role Seller, ke Home Seller
    if (userProvider.role == UserRole.seller) {
      return HomeSeller();
    }

    // 4. Default: Ke Home Buyer
    return toHomePage();
  }
}
