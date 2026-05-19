import 'package:flutter/material.dart';
import 'package:pawtastic/shared/widgets/custom_app_bar.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/services/supabase_auth_service.dart';
import 'package:pawtastic/shared/utils/snackbar_utils.dart';
import 'package:pawtastic/shared/widgets/custom_text_field_decoration.dart';
import 'package:pawtastic/shared/widgets/primary_button.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final SupabaseAuthService _authService = SupabaseAuthService();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  Future<void> _handleUpdatePassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      SnackBarUtils.show(context, context.t.auth.reset_password.please_fill_in_all_fields.ucfirst(), type: SnackBarType.error);
      return;
    }

    if (password != confirmPassword) {
      SnackBarUtils.show(context, context.t.auth.signup.passwords_do_not_match.ucfirst(), type: SnackBarType.error);
      return;
    }

    if (password.length < 6) {
      SnackBarUtils.show(context, context.t.auth.signup.password_must_be_at_least_6_characters.ucfirst(), type: SnackBarType.error);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.updatePassword(password);
      if (mounted) {
        SnackBarUtils.show(context, context.t.auth.reset_password.password_updated_successfully.ucfirst(), type: SnackBarType.success);
        // Navigate to login or HomePage
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
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
      appBar: CustomAppBar.leftTitle(
        context,
        title: context.t.auth.reset_password.reset_password.toTitleCase(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Text(
                context.t.auth.reset_password.set_new_password.toTitleCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                context.t.auth.reset_password.please_enter_your_new_password_below.ucfirst(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: CustomTextFieldDecoration(
                  hintText: context.t.auth.reset_password.new_password.toTitleCase(),
                  prefixIcon: Icons.lock_outline,
                ).decoration.copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_isPasswordVisible,
                decoration: CustomTextFieldDecoration(
                  hintText: context.t.auth.reset_password.confirm_new_password.toTitleCase(),
                  prefixIcon: Icons.lock_reset,
                ).decoration,
              ),
              const SizedBox(height: 50),
              PrimaryButton(
                label: context.t.auth.reset_password.update_password.toTitleCase(),
                isLoading: _isLoading,
                onPressed: _handleUpdatePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
