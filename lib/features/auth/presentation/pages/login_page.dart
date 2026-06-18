import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/shared/utils/snackbar_utils.dart';
import 'package:pawtastic/services/supabase/supabase_auth_service.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/core_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final SupabaseAuthService _authService = SupabaseAuthService();

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      SnackBarUtils.show(
        context,
        context.t.errors.common.please_fill_in_all_data_validly.ucfirst(),
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
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
      }
    } catch (e) {
      if (mounted) {
        final String userMessage = e is String
            ? e
            : context.t.auth.login.an_unexpected_error_occurred_please_try_again
                .ucfirst();
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
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),

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
                  CustomTextField(
                    controller: _emailController,
                    hintText:
                        context.t.auth.login.pawtastic_email.toTitleCase(),
                    prefixIcon: Icons.email_rounded,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return context.t.errors.common.required_field
                            .ucfirstChar();
                      }
                      final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(val.trim())) {
                        return context.t.errors.common.invalid_email_format
                            .ucfirstChar();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password input field
                  CustomTextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    hintText: context.t.common.password.toTitleCase(),
                    prefixIcon: Icons.lock,
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
                    validator: (val) => val == null || val.trim().isEmpty
                        ? context.t.errors.common.required_field.ucfirstChar()
                        : null,
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
                          color: const Color.fromRGBO(252, 147, 3, 1.0),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Login button
                  PrimaryButton(
                    label: context.t.auth.login.login.toTitleCase(),
                    isLoading: _isLoading,
                    onPressed: _login,
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
                              color: const Color.fromRGBO(252, 147, 3, 1.0),
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
