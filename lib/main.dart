import 'package:flutter/material.dart';
import 'package:untitled/firebase%20CRUD/addProduct.dart';
import 'package:untitled/pages/Cart_n_Checkoute/cart.dart';
import 'package:untitled/pages/Home/most_popular.dart';
import 'package:untitled/pages/HomeSeller/cashier.dart';
import 'package:untitled/pages/HomeSeller/home-seller.dart';
import 'package:untitled/pages/HomeSeller/manageorder.dart';
import 'package:untitled/pages/HomeSeller/manageproduct.dart';
import 'package:untitled/pages/aboutus.dart';
import 'package:untitled/pages/cart.dart';
import 'package:untitled/pages/Orders/myOrders.dart';
import 'package:untitled/pages/search.dart';
import 'package:untitled/pages/settings.dart';
import 'package:untitled/pages/starting/forgotPassword.dart';
import 'package:untitled/pages/Home/home.dart';
import 'package:untitled/pages/starting/loginPage.dart';
import 'package:untitled/pages/starting/loginPageSeller.dart';
import 'package:untitled/pages/starting/onboarding.dart';
import 'package:untitled/pages/starting/signupPage.dart';
import 'package:untitled/pages/starting-animation.dart';
import 'package:untitled/pages/starting-animation-shop.dart';
import 'package:untitled/pages/starting/signupPageSeller.dart';
import 'package:untitled/pages/test-page.dart';
import 'package:untitled/services/geminiService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
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
        '/': (context) => const StartingAnimation(),
        '/shop': (context) => const StartingAnimationShop(),
        '/welcome': (context) => const Onboarding(),
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
      initialRoute: '/',
      // initialRoute: '/home',   // jangan dihapus
    );
  }
}
