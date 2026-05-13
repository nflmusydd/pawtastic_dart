import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pawtastic/services/user_provider.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 250),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 100,
                color: Color.fromRGBO(252, 147, 3, 1.0),
              ),
              const SizedBox(height: 30),
              const Text(
                "Connection Failed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "We couldn't reach the server. Please check your internet connection.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black54,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(252, 147, 3, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  onPressed: () {
                    context.read<UserProvider>().retry();
                  },
                  child: const Text(
                    "Try Again",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
