import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pawtastic/core/config/env_config.dart';
import 'package:pawtastic/features/account/presentation/pages/address_list_page.dart';
import 'package:pawtastic/features/seller/presentation/home/pages/seller_profile_shop_page.dart';
import 'package:pawtastic/services/supabase/address_provider.dart';
import 'package:pawtastic/services/supabase/shop_provider.dart';
import 'package:pawtastic/services/firebase/add_product.dart';
import 'package:pawtastic/features/cart/presentation/pages/cart_page.dart';
import 'package:pawtastic/features/home/presentation/pages/most_popular_page.dart';
import 'package:pawtastic/features/seller/presentation/cashier/pages/cashier_page.dart';
import 'package:pawtastic/features/seller/presentation/home/pages/seller_home_page.dart';
import 'package:pawtastic/features/seller/presentation/orders/pages/manage_order_page.dart';
import 'package:pawtastic/features/seller/presentation/inventory/pages/manage_product_page.dart';
import 'package:pawtastic/features/account/presentation/pages/about_us_page.dart';
import 'package:pawtastic/features/account/presentation/pages/profile_page.dart';
import 'package:pawtastic/features/seller/presentation/home/pages/create_shop_page.dart';
import 'package:pawtastic/features/seller/presentation/home/pages/seller_settings_page.dart';
import 'package:pawtastic/features/seller/presentation/home/pages/seller_profile_page.dart';
import 'package:pawtastic/features/account/presentation/pages/change_password_page.dart';
import 'package:pawtastic/features/my_orders/presentation/pages/my_orders_page.dart';
import 'package:pawtastic/features/search/presentation/pages/search_page.dart';
import 'package:pawtastic/features/account/presentation/pages/options_page.dart';
import 'package:pawtastic/features/account/presentation/pages/account_page.dart';
import 'package:pawtastic/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:pawtastic/features/home/presentation/pages/home_page.dart';
import 'package:pawtastic/features/auth/presentation/pages/login_page.dart';
import 'package:pawtastic/features/auth/presentation/pages/onboarding_page.dart';
import 'package:pawtastic/features/auth/presentation/pages/signup_page.dart';
import 'package:pawtastic/features/auth/presentation/pages/splash_page.dart';
import 'package:pawtastic/features/auth/presentation/pages/splash_seller_page.dart';
import 'package:pawtastic/features/common/presentation/pages/no_connection_page.dart';
import 'package:pawtastic/features/auth/presentation/pages/reset_password_page.dart';
// import 'package:pawtastic/features/common/presentation/pages/test_page.dart';
import 'package:pawtastic/services/gemini_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pawtastic/shared/widgets/layout/auth_guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:pawtastic/services/user_provider.dart';
import 'package:pawtastic/services/locale_provider.dart';
import 'package:pawtastic/services/bottom_bar_provider.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:pawtastic/core/config/app_routes.dart';

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
    TranslationProvider(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => AddressProvider()),
          ChangeNotifierProvider(create: (context) => ShopProvider()),
          ChangeNotifierProvider(create: (context) => LocaleProvider()),
          ChangeNotifierProvider(create: (context) => BottomBarProvider()),
        ],
        child: const MyApp(),
      ),
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
        _navigatorKey.currentState?.pushNamed(AppRoutes.resetPassword);
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
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          locale: TranslationProvider.of(context).flutterLocale, // Gunakan dari Slang
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: AppLocaleUtils.supportedLocales,
          navigatorKey: _navigatorKey, // navigasi dari luar widget tree
          title: 'Pawtastic',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(252, 147, 3, 1.0)),
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 250, 250),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: const Color.fromRGBO(252, 147, 3, 1.0),
              selectionColor: Color.fromRGBO(252, 147, 3, 0.3),
              selectionHandleColor: const Color.fromRGBO(252, 147, 3, 1.0),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: 16.0),
              displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            useMaterial3: true,
          ),
          routes: {
            // AppRoutes.test: (context)           => const TestPage(),
            AppRoutes.shop: (context)               => const AuthGuard(child: SplashSellerPage()),
            AppRoutes.login: (context)              => const LoginPage(),
            AppRoutes.signup: (context)             => const SignUpPage(),
            AppRoutes.forgotPassword: (context)     => const ForgotPasswordPage(),
            AppRoutes.resetPassword: (context)      => const ResetPasswordPage(),
            AppRoutes.home: (context)               => const AuthGuard(allowGuest: true, child: ToHomePage()),
            AppRoutes.cart: (context)               => const AuthGuard(child: ToCartPage()),
            AppRoutes.myOrders: (context)           => const AuthGuard(child: ToMyOrdersPage()),
            AppRoutes.account: (context)            => const AuthGuard(child: ToAccountPage()),
            AppRoutes.search: (context)             => const AuthGuard(child: ToSearchPage()),
            AppRoutes.sellerHome: (context)         => const AuthGuard(requiredRole: UserRole.seller, child: SellerHomePage()),
            AppRoutes.mostPopular: (context)        => const AuthGuard(child: MostPopularPage()),
            AppRoutes.options: (context)            => const AuthGuard(child: OptionsPage()),
            AppRoutes.addProduct: (context)         => const AuthGuard(requiredRole: UserRole.seller, child: AddProduct()),
            AppRoutes.manageOrder: (context)        => const AuthGuard(requiredRole: UserRole.seller, child: ManageOrdersPage()),
            AppRoutes.cashier: (context)            => const AuthGuard(requiredRole: UserRole.seller, child: CashierPage()),
            AppRoutes.sellerSettings: (context)     => const AuthGuard(requiredRole: UserRole.seller, child: SellerSettingsPage()),
            AppRoutes.sellerProfiles: (context)     => const AuthGuard(requiredRole: UserRole.seller, child: SellerProfilePage()),
            AppRoutes.sellerProfileShop: (context)  => const AuthGuard(requiredRole: UserRole.seller, child: SellerProfileShopPage()),
            AppRoutes.aboutUs: (context)            => AboutUsPage(),
            AppRoutes.profile: (context)            => const AuthGuard(child: ProfilePage()),
            AppRoutes.addressList: (context)        => const AuthGuard(child: AddressListPage()),
            AppRoutes.createShop: (context)         => const AuthGuard(child: CreateShopPage()),
            AppRoutes.changePassword: (context)     => const AuthGuard(child: ChangePasswordPage()),
            AppRoutes.manageProduct: (context)      => const AuthGuard(requiredRole: UserRole.seller, child: ManageProductPage()),
            AppRoutes.chatbot: (context)            => const AuthGuard(child: GeminiService()),
          },
          home: const AuthWrapper(),
          // home: const TestPage(),
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    if (kDebugMode) debugPrint("AUTH_DEBUG: Role=${userProvider.role}, User=${userProvider.user}, Loading=${userProvider.isLoading}, Error=${userProvider.hasConnectionError}");
    
    if (userProvider.hasConnectionError) {
      return const NoConnectionPage();
    }

    // Jika masih loading, tampilkan Splash
    if (userProvider.isLoading) {
      return const SplashPage();
    }

    // Jika belum login atau session tidak valid (ghost session)
    if (userProvider.user == null || userProvider.role == UserRole.none) {
      return const OnboardingPage();
    }

    // Jika Role Seller, ke HomePage Seller
    if (userProvider.role == UserRole.seller) {
      return const SellerHomePage();
    }

    // Default: Ke HomePage Buyer
    return const ToHomePage();
  }
}
