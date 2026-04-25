import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/widget/text_button.dart';
import 'package:pawtastic/widget/text_field1.dart';
import 'package:pawtastic/services/firebase/create_user.dart';

class SignuppageSeller extends StatefulWidget {
  const SignuppageSeller({super.key});

  @override
  State<SignuppageSeller> createState() => _SignuppageSellerState();
}

class _SignuppageSellerState extends State<SignuppageSeller> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CreateUser _createUser = CreateUser();

  Future<void> _submitData() async {
    // Attempt to create user through CreateUser service
    final String? result = await _createUser.createUser(
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      address: _addressController.text.trim(),
      password: _passwordController.text.trim(),
      // description: _descriptionController.text.trim(),
    );

    if (result != null) {
      // Show error message if user creation failed
      _showSnackBar(result, Colors.red);
    } else {
      // Show success message and navigate to home if successful
      _showSnackBar("Account created successfully!",
          const Color.fromRGBO(0, 128, 0, 1.0));
      Navigator.pushNamed(context, '/home');
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              backgroundColor == Colors.red
                  ? Icons.error_outline
                  : Icons.check_circle_outline,
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
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Build a\nPaw Shop Business",
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

                  // Email
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
                  const SizedBox(height: 20),

                  // Shop name
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: Textfield1(
                        hintText: 'Shop Name',
                        prefixIcon: Icons.person,
                      ).decoration,
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Address
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _addressController,
                      decoration: Textfield1(
                        hintText: 'Shop Address',
                        prefixIcon: Icons.house_rounded,
                      ).decoration,
                      keyboardType: TextInputType.streetAddress,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: Textfield1(
                        hintText: 'Shop Description',
                        prefixIcon: Icons.description_rounded,
                      ).decoration,
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
                          text:
                              "By clicking Create Account, I have\nagreed to our ",
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
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
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
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
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
                      onPressed: ()
                          //async
                          {
                        // await _submitData(); // Call the submit function
                        Navigator.pushNamed(context, '/home-seller');
                      },
                      child: const Text(
                        "Create Shop",
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
                            'I already have Paw Shop,',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(87, 87, 87, 1.0),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextbuttonNavigation(
                            text: 'Login',
                            route: '/login-seller',
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

