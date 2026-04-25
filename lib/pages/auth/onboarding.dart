import 'package:flutter/material.dart';
import 'package:pawtastic/widget/text_button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFFFC9303), // untuk warna tema Pawtastic
      backgroundColor: const Color.fromARGB(255, 255, 250, 250), // Warna background putih
      body: Center( // Menengahkan semua isi layar
        child: Column(
          mainAxisSize: MainAxisSize.min, // Shrinks the Column to fit its children
          children: [
            // Image Section
            Image.asset(
              "images/starting_page.png", // nama file tidak boleh ada spasi
              // width: double.infinity, // jika lebar gambar dibuat (horizontal) memenuhi layar
              width: 300.0,
              height: 200.0,
              fit: BoxFit.cover, // Adjust how the image fits within the size
            ),
            const SizedBox(height: 20), // Add space between image and text
            // Main Heading
            Text(
              "RUFF!\nWelcome to Pawtastic!",
              textAlign: TextAlign.center, // menengahkan teks bergantung widget
              style: const TextStyle(
                fontFamily: 'Montserrat', // font custom, tidak menggunakan global
                color: Colors.black,
                fontSize: 26.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 30),
            // Subtitle
            Text(
              "One app for all of your\npet equipment!",
              textAlign: TextAlign.center, // menengahkan teks bergantung widget
              style: const TextStyle(
                fontFamily: 'Montserrat', // font custom, tidak menggunakan global
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                height: 24 / 16, // line height di figma dibagi font size
              ),
            ),
            const SizedBox(height: 100),
            // Get Started Button
            TextbuttonNavigation(
              text: 'Get Started',
              route: '/signup',
              // route: '/',   //tes startingp page
              textStyle: TextStyle(
                color: Colors.orange,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10.0),
            // Login Button
            TextbuttonNavigation(
              text: 'Login',
              route: '/login',
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

