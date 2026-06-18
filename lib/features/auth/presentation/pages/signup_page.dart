import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/services/supabase/supabase_auth_service.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/shared/utils/utils.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final SupabaseAuthService _authService = SupabaseAuthService();

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) {
      SnackBarUtils.show(context,
          context.t.errors.common.please_fill_in_all_data_validly.ucfirst(),
          type: SnackBarType.error);
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      SnackBarUtils.show(
          context, context.t.auth.signup.passwords_do_not_match.ucfirst(),
          type: SnackBarType.error);
      return;
    }

    if (_passwordController.text.length < 6) {
      SnackBarUtils.show(
          context,
          context.t.auth.signup.password_must_be_at_least_6_characters
              .ucfirst(),
          type: SnackBarType.error);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        username: '',                               // di-generate TRIGGER kalo kosong (sementara tidak bisa diinput dan diubah)
        fullName: _fullNameController.text.trim(),
      );

      if (mounted) {
        SnackBarUtils.show(
            context,
            context.t.auth.signup
                .account_created_successfully_please_check_your_email_for_verification
                .ucfirst(),
            type: SnackBarType.success);
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } catch (e) {
      if (mounted) {
        final String userMessage = e is String
            ? e
            : context
                .t.auth.signup.an_unexpected_error_occurred_please_try_again
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    context.t.auth.signup.create_account.toTitleCase(),
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

                  // Full Name
                  CustomTextField(
                    controller: _fullNameController,
                    hintText: context.t.auth.signup.full_name.toTitleCase(),
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.name,
                    validator: (val) => val == null || val.trim().isEmpty
                        ? context.t.errors.common.required_field.ucfirstChar()
                        : null,
                  ),
                  const SizedBox(height: 20),

                  // Email
                  CustomTextField(
                    controller: _emailController,
                    hintText: context.t.common.email.toTitleCase(),
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

                  // Password
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
                  const SizedBox(height: 20),

                  // Confirm Password
                  CustomTextField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    hintText: context.t.auth.signup.confirm_password.toTitleCase(),
                    prefixIcon: Icons.lock,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    validator: (val) => val == null || val.trim().isEmpty
                        ? context.t.errors.common.required_field.ucfirstChar()
                        : null,
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
                          text: "${context.t.auth.signup.by_clicking_create_account_i_have_agreed_to_our.ucfirst()} ",
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color.fromRGBO(87, 87, 87, 1.0),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: context.t.auth.signup.terms_and_conditions.toTitleCase(),
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: const Color.fromRGBO(252, 147, 3, 1.0),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                  // Handle Terms and Conditions tap
                                },
                            ),
                            TextSpan(
                              text: " ${context.t.auth.signup.and_have_read_our.ucfirst()} ",
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color.fromRGBO(87, 87, 87, 1.0),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: context.t.auth.signup.privacy_statement.toTitleCase(),
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: const Color.fromRGBO(252, 147, 3, 1.0),
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
                  PrimaryButton(
                    label: context.t.auth.signup.create_account_button.toTitleCase(),
                    isLoading: _isLoading,
                    onPressed: _submitData,
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
                          Text(
                            "${context.t.auth.signup.i_already_have_an_account.ucfirst()} ",
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(87, 87, 87, 1.0),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          CustomTextButton(
                            text: context.t.auth.signup.login.toTitleCase(),
                            route: AppRoutes.login,
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
