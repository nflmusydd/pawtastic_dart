import 'package:flutter/material.dart';
import 'package:pawtastic/widget/text_button.dart';
import 'package:pawtastic/widget/text_field1.dart';
import 'package:pawtastic/services/firebase/login_user.dart'; // Updated import to reflect the new name

class LoginpageSeller extends StatefulWidget {
  const LoginpageSeller({super.key});

  @override
  State<LoginpageSeller> createState() => _LoginpageSellerState();
}

class _LoginpageSellerState extends State<LoginpageSeller> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to handle login
  Future<void> _login() async {
    // String email = _emailController.text.trim();
    // String password = _passwordController.text.trim();

    // if (email.isEmpty || password.isEmpty) {
    //   _showSnackBar("Please enter both email and password.", Colors.red);
    //   return;
    // }

    // String? loginResult = await LoginUser().login(email, password);

    // if (loginResult == null) {
    Navigator.pushNamed(
        context, '/home-seller'); // Navigate to home page if successful
    // } else {
    //  _showSnackBar(
    //       loginResult, Colors.red); // Show error message if login failed
    // }
  }

  // Function to show SnackBar with custom message and color
  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 250),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: EdgeInsets.only(top: 50),
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Pawsitively\nProfitable",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 36.0,
                      fontWeight: FontWeight.w800,
                      height: 47 / 36,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Email input field
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: Textfield1(
                        hintText: 'Shop Email',
                        prefixIcon: Icons.email_rounded,
                      ).decoration,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password input field
                  SizedBox(
                    width: 350,
                    height: 55,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: Textfield1(
                        hintText: 'Password',
                        prefixIcon: Icons.lock,
                      ).decoration.copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Forgot password link
                  // SizedBox(
                  //   width: 340,
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: TextbuttonNavigation(
                  //       text: 'Forgot your password?',
                  //       route: '/forgot-password',
                  //       textStyle: TextStyle(
                  //         fontFamily: 'Montserrat',
                  //         color: Color.fromRGBO(252, 147, 3, 1.0),
                  //         fontSize: 14.0,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(height: 50),

                  // Login button
                  SizedBox(
                    width: 350,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(252, 147, 3, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      onPressed: _login, // Call the login function
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Navigate to Sign Up page
                  SizedBox(
                    height: 50.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Have not registered Paw Shop yet? ',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(87, 87, 87, 1.0),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextbuttonNavigation(
                            text: 'Register!',
                            route: '/signup',
                            textStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(252, 147, 3, 1.0),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

