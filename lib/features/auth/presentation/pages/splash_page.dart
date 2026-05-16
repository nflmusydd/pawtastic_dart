import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    _navigateToWelcomeScreen();
  }

  // Navigate to the next screen (Welcome) after a delay
  Future<void> _navigateToWelcomeScreen() async {
    // Navigasi manual dimatikan karena AuthWrapper akan otomatis mendeteksi perubahan state
    // await Future.delayed(Duration(seconds: 3)); 
    // if (!mounted) return;
    // Navigator.pushReplacementNamed(context, '/welcome'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 147, 3, 1.0), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/logo_pawtastic-removebg-preview.png', width: 314, height: 385),

            SizedBox(height: 20),

            Lottie.asset('assets/animation/loadingwhite.json', width: 200, height: 200),
          ],
        ),
      ),
    );
  }
}