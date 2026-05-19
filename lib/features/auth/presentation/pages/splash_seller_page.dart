import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:stroke_text/stroke_text.dart';

class SplashSellerPage extends StatefulWidget {
  const SplashSellerPage({super.key});

  @override
  State<SplashSellerPage> createState() => _SplashSellerPageState();
}

class _SplashSellerPageState extends State<SplashSellerPage> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcomeScreen();
  }

  // Navigate to the next screen (Welcome) after a delay
  Future<void> _navigateToWelcomeScreen() async {
    await Future.delayed(const Duration(seconds: 5)); 
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.signupSeller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 147, 3, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/logo_pawtastic-removebg-preview.png',
                width: 314, height: 385),

            StrokeText(
              text: "SHOP",
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontFamily: 'Poppins', // font custom, tidak menggunakan global
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.w800,
              ),
              strokeColor: Colors.black,
              strokeWidth: 20,
            ),

            const SizedBox(height: 20),

            Lottie.asset('assets/animation/loadingwhite.json',
                width: 200, height: 200),
          ],
        ),
      ),
    );
  }
}
