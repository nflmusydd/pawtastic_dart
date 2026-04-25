import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stroke_text/stroke_text.dart';

class StartingAnimationShop extends StatefulWidget {
  const StartingAnimationShop({super.key});

  @override
  State<StartingAnimationShop> createState() => _StartingAnimationShopState();
}

class _StartingAnimationShopState extends State<StartingAnimationShop> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcomeScreen();
  }

  // Navigate to the next screen (Welcome) after a delay
  Future<void> _navigateToWelcomeScreen() async {
    await Future.delayed(Duration(seconds: 5)); // Show splash for 3 seconds
    Navigator.pushReplacementNamed(
        context, '/signup-seller'); // Use route to navigate
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
            // Display your image
            Image.asset('images/logo_pawtastic-removebg-preview.png',
                width: 314, height: 385),

            StrokeText(
              text: "SHOP",
              textAlign: TextAlign.center, // menengahkan teks bergantung widget
              textStyle: const TextStyle(
                fontFamily: 'Poppins', // font custom, tidak menggunakan global
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.w800,
              ),
              strokeColor: Colors.black,
              strokeWidth: 20,
            ),

            // Add some space between the image and animation
            SizedBox(height: 20),

            // Display the Lottie animation
            Lottie.asset('assets/animation/loadingwhite.json',
                width: 200, height: 200),
          ],
        ),
      ),
    );
  }
}
