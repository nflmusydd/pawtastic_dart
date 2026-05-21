import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/services/supabase/supabase_auth_service.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:pawtastic/shared/utils/utils.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  final SupabaseAuthService _authService = SupabaseAuthService();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  Future<void> _handleChangePassword() async {
    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      SnackBarUtils.show(context, context.t.auth.reset_password.please_fill_in_all_fields.ucfirst(), type: SnackBarType.error);
      return;
    }

    if (newPassword != confirmPassword) {
      SnackBarUtils.show(context, context.t.auth.signup.passwords_do_not_match.ucfirst(), type: SnackBarType.error);
      return;
    }

    if (newPassword.length < 6) {
      SnackBarUtils.show(context, context.t.auth.signup.password_must_be_at_least_6_characters.ucfirst(), type: SnackBarType.error);
      return;
    }

    // Tampilkan konfirmasi Dialog
    DialogUtils.showConfirmationDialog(
      context: context,
      title: context.t.account.profile.change_password.toTitleCase(),
      message: "${context.t.account.change_password.are_you_sure_you_want_to_change_yout_password.ucfirst()} ${context.t.account.change_password.you_will_be_logged_out_and_required_to_login_again.ucfirst()}",
      confirmText: context.t.common.change.ucfirst(),
      onConfirm: () => _executePasswordChange(oldPassword, newPassword),
    );
  }

  Future<void> _executePasswordChange(String oldPassword, String newPassword) async {
    setState(() => _isLoading = true);

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final email = userProvider.user?.email;

      if (email == null) throw context.t.account.change_password.cannot_find_user_email.ucfirst();

      // Verifikasi password lama dgn re-login
      try {
        await _authService.signIn(email: email, password: oldPassword);
      } catch (e) {
        throw "${context.t.account.change_password.your_current_password_is_incorrect.ucfirst()}!";
      }

      await _authService.updatePassword(newPassword);

      if (mounted) {
        SnackBarUtils.show(context, context.t.account.change_password.password_changed_successfully.ucfirst(), type: SnackBarType.success);
        
        // pindah route dulu SEBELUM logout agar widget tidak dihancurkan oleh AuthGuard di tengah jalan
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
        await userProvider.logout();
      }
    } catch (e) {
      if (mounted) {
        final String userMessage = e is String 
            ? e 
            : context.t.auth.login.an_unexpected_error_occurred_please_try_again.ucfirst();
            
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
    return AuthGuard(
      child: Scaffold(
        appBar: CustomAppBar.leftTitle(
          context,
          title: context.t.account.profile.change_password.toTitleCase(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                const Icon(
                  Icons.lock_reset_rounded,
                  size: 80,
                  color: Color.fromRGBO(252, 147, 3, 1.0),
                ),
                const SizedBox(height: 20),
                Text(
                  context.t.account.change_password.secure_your_account.toTitleCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  context.t.account.change_password.please_enter_your_current_password_and_your_new_password_below.ucfirst(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 40),
                
                // Old Password
                TextFormField(
                  controller: _oldPasswordController,
                  obscureText: !_isPasswordVisible,
                  decoration: CustomTextFieldDecoration(
                    hintText: context.t.account.change_password.current_password.toTitleCase(),
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
                
                // New Password
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: !_isPasswordVisible,
                  decoration: CustomTextFieldDecoration(
                    hintText: context.t.auth.reset_password.new_password.toTitleCase(),
                    prefixIcon: Icons.lock_reset,
                  ).decoration,
                ),
                const SizedBox(height: 20),
                
                // Confirm New Password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isPasswordVisible,
                  decoration: CustomTextFieldDecoration(
                    hintText: context.t.auth.reset_password.confirm_new_password.toTitleCase(),
                    prefixIcon: Icons.check_circle_outline,
                  ).decoration,
                ),
                
                const SizedBox(height: 50),
                PrimaryButton(
                  label: context.t.account.profile.change_password.toTitleCase(),
                  isLoading: _isLoading,
                  onPressed: _handleChangePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
