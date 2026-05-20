import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/services/supabase/supabase_auth_service.dart';
import 'package:pawtastic/shared/utils/snackbar_utils.dart';
import 'package:pawtastic/i10n/strings.g.dart';
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

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final SupabaseAuthService _authService = SupabaseAuthService();

  Future<void> _submitData() async {
    // Basic validation
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _fullNameController.text.isEmpty) {
      SnackBarUtils.show(context, context.t.auth.signup.please_fill_in_all_required_fields.ucfirst(), type: SnackBarType.error);
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      SnackBarUtils.show(context, context.t.auth.signup.passwords_do_not_match.ucfirst(), type: SnackBarType.error);
      return;
    }

    if (_passwordController.text.length < 6) {
      SnackBarUtils.show(context, context.t.auth.signup.password_must_be_at_least_6_characters.ucfirst(), type: SnackBarType.error);
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
        SnackBarUtils.show(context, context.t.auth.signup.account_created_successfully_please_check_your_email_for_verification.ucfirst(), type: SnackBarType.success);
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } catch (e) {
      if (mounted) {
        final String userMessage = e is String ? e : context.t.auth.signup.an_unexpected_error_occurred_please_try_again.ucfirst();
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
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _fullNameController,
                      decoration: CustomTextFieldDecoration(
                        hintText: context.t.auth.signup.full_name.toTitleCase(),
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
                      decoration: CustomTextFieldDecoration(
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
                      decoration: CustomTextFieldDecoration(
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
                      decoration: CustomTextFieldDecoration(
                        hintText: context.t.common.password.toTitleCase(),
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
                      decoration: CustomTextFieldDecoration(
                        hintText: context.t.auth.signup.confirm_password.toTitleCase(),
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
