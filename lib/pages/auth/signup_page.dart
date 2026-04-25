import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/widget/text_button.dart';
import 'package:pawtastic/widget/text_field1.dart';
import 'package:pawtastic/services/firebase/create_user.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final CreateUser _createUser = CreateUser();

  Future<void> _submitData() async {
    // Validate password and confirm password
    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar("Passwords do not match!",  Colors.red);
      return;
    }

    // Attempt to create user through CreateUser service
    final String? result = await _createUser.createUser(
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      address: _addressController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (result != null) {
      // Show error message if user creation failed
      _showSnackBar(result,  Colors.red);
    } else {
      // Show success message and navigate to home if successful
      _showSnackBar("Account created successfully!", const Color.fromRGBO(0, 128, 0, 1.0));
      Navigator.pushNamed(context, '/home');
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              backgroundColor == Colors.red ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
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
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Create\nAccount!",
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
                  
                  // Username
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: Textfield1(
                        hintText: 'John Doe',
                        prefixIcon: Icons.person,
                      ).decoration,
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: Textfield1(
                        hintText: 'johndoe@gmail.com',
                        prefixIcon: Icons.email_rounded,
                      ).decoration,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Address
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _addressController,
                      decoration: Textfield1(
                        hintText: 'Jl. Lorem no 1, Malang, Jawa Timur, Indonesia, 65146',
                        prefixIcon: Icons.house_rounded,
                      ).decoration,
                      keyboardType: TextInputType.streetAddress,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: Textfield1(
                        hintText: 'Password',
                        prefixIcon: Icons.lock,
                      ).decoration.copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
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
                  const SizedBox(height: 20),

                  // Confirm Password
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: Textfield1(
                        hintText: 'Confirm Password',
                        prefixIcon: Icons.lock,
                      ).decoration.copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Terms and Privacy
                  SizedBox(
                    width: 340,
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "By clicking Create Account, I have\nagreed to our ",
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color.fromRGBO(87, 87, 87, 1.0),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Terms and Conditions",
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color.fromRGBO(252, 147, 3, 1.0),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                // Handle Terms and Conditions tap
                              },
                            ),
                            const TextSpan(
                              text: " and\nhave read our ",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color.fromRGBO(87, 87, 87, 1.0),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "Privacy Statement",
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color.fromRGBO(252, 147, 3, 1.0),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                // Handle Privacy Statement tap
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Create Account Button
                  SizedBox(
                    width: 350,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(252, 147, 3, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      onPressed: () async {
                        await _submitData(); // Call the submit function
                      },
                      child: const Text(
                        "Create Account",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Already have an account
                  SizedBox(
                    height: 50.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'I already have an account,',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(87, 87, 87, 1.0),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextbuttonNavigation(
                            text: 'Login',
                            route: '/login',
                            textStyle: const TextStyle(
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

