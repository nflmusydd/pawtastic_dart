import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/core/utils/snackbar_utils.dart';
import 'package:pawtastic/services/supabase_auth_service.dart';
import 'package:pawtastic/widget/text_button.dart';
import 'package:pawtastic/widget/text_field1.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final SupabaseAuthService _authService = SupabaseAuthService();

  Future<void> _submitData() async {
    // Basic validation
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _fullNameController.text.isEmpty) {
      SnackBarUtils.show(context, "Please fill in all required fields");
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      SnackBarUtils.show(context, "Passwords do not match!");
      return;
    }

    if (_passwordController.text.length < 6) {
      SnackBarUtils.show(context, "Password must be at least 6 characters");
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        username: '',                               // di-generate TRIGGER kalo kosong
        fullName: _fullNameController.text.trim(),
      );

      if (mounted) {
        SnackBarUtils.show(context, "Account created successfully! Please check your email for verification.", isError: false);
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.show(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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

                  // Full Name
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _fullNameController,
                      decoration: Textfield1(
                        hintText: 'Full Name',
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
                        hintText: 'youremail@email.com',
                        prefixIcon: Icons.email_rounded,
                      ).decoration,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Address (sementara data belum ada proses)
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _addressController,
                      decoration: Textfield1(
                        hintText: 'Jl. Lorem no 1, Malang, Jawa Timur',
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
                      onPressed: _isLoading ? null : _submitData,
                      child: _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
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
