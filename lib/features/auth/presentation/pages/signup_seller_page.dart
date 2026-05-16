import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/shared/utils/snackbar_utils.dart';
import 'package:pawtastic/services/supabase_auth_service.dart';
import 'package:pawtastic/shared/widgets/custom_text_button.dart';
import 'package:pawtastic/shared/widgets/custom_text_field_decoration.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class SignUpSellerPage extends StatefulWidget {
  const SignUpSellerPage({super.key});

  @override
  State<SignUpSellerPage> createState() => _SignUpSellerPageState();
}

class _SignUpSellerPageState extends State<SignUpSellerPage> {
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final SupabaseAuthService _authService = SupabaseAuthService();

  String _generateSlug(String name) {
    return name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-');
  }

  Future<void> _submitData() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _shopNameController.text.isEmpty) {
      SnackBarUtils.show(context, context.t.auth.signup.please_fill_in_all_required_fields.ucfirst(), type: SnackBarType.error);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Sign up user
      await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        username: '', // Let trigger generate
        fullName: _shopNameController.text.trim(),
      );

      // 2. Create Shop
      final String slug = _generateSlug(_shopNameController.text.trim());
      
      await _authService.createShop(
        shopName: _shopNameController.text.trim(),
        description: _descriptionController.text.trim(),
        storeSlug: slug,
      );

      if (mounted) {
        SnackBarUtils.show(context, context.t.auth.seller.signup.shop_account_created_successfully.ucfirst(), type: SnackBarType.success);
        Navigator.pushReplacementNamed(context, AppRoutes.homeSeller);
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
                    context.t.auth.seller.signup.build_a_paw_shop_business.toTitleCase(),
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

                  // Email
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: CustomTextFieldDecoration(
                        hintText: context.t.auth.seller.login.shop_email.toTitleCase(),
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
                  const SizedBox(height: 20),

                  // Shop name
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _shopNameController,
                      decoration: CustomTextFieldDecoration(
                        hintText: context.t.auth.seller.signup.shop_name.toTitleCase(),
                        prefixIcon: Icons.store_rounded,
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
                      decoration: CustomTextFieldDecoration(
                        hintText: context.t.auth.seller.signup.shop_address.toTitleCase(),
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
                      decoration: CustomTextFieldDecoration(
                        hintText: context.t.auth.seller.signup.shop_description.toTitleCase(),
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
                      onPressed: _isLoading ? null : _submitData,
                      child: _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            context.t.auth.seller.signup.create_shop.toTitleCase(),
                            style: const TextStyle(color: Colors.white, fontSize: 20.0),
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
                          Text(
                            "${context.t.auth.seller.signup.i_already_have_paw_shop.ucfirst()} ",
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(87, 87, 87, 1.0),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          CustomTextButton(
                            text: context.t.auth.signup.login.toTitleCase(),
                            route: AppRoutes.loginSeller,
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
