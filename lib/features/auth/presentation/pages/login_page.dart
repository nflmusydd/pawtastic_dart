import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/shared/utils/snackbar_utils.dart';
import 'package:pawtastic/services/supabase_auth_service.dart';
import 'package:pawtastic/shared/widgets/custom_text_button.dart';
import 'package:pawtastic/shared/widgets/custom_text_field_decoration.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final SupabaseAuthService _authService = SupabaseAuthService();

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      SnackBarUtils.show(
        context, 
        context.t.auth.login.please_enter_email_and_password.ucfirst(), 
        type: SnackBarType.error
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        final String userMessage = e is String ? e : context.t.auth.login.an_unexpected_error_occurred_please_try_again.ucfirst();
        SnackBarUtils.show(context, userMessage, type: SnackBarType.error);
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
                  Text(
                    context.t.auth.login.welcome_back.toTitleCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                      decoration: CustomTextFieldDecoration(
                        hintText: context.t.auth.login.pawtastic_email.toTitleCase(),
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
                      decoration: CustomTextFieldDecoration(
                        hintText: context.t.common.password.toTitleCase(),
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
                  SizedBox(
                    width: 340,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        text: context.t.auth.login.forgot_your_password.ucfirst(),
                        route: AppRoutes.forgotPassword,
                        textStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color.fromRGBO(252, 147, 3, 1.0),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Login button
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
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            context.t.auth.login.login.toTitleCase(),
                            style: const TextStyle(
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
                            "${context.t.auth.login.or.ucfirst()}, ",
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(87, 87, 87, 1.0),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          CustomTextButton(
                            text: context.t.auth.login.create_an_account.toTitleCase(),
                            route: AppRoutes.signup,
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
