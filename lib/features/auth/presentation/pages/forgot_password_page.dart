import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pawtastic/shared/utils/snackbar_utils.dart';
import 'package:pawtastic/services/supabase_auth_service.dart';
import 'package:pawtastic/shared/widgets/custom_text_field_decoration.dart';
import 'package:pawtastic/shared/widgets/custom_app_bar.dart';
import 'package:pawtastic/shared/widgets/primary_button.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final SupabaseAuthService _authService = SupabaseAuthService();
  bool _isLoading = false;
  
  // Timer variables
  Timer? _timer;
  int _secondsRemaining = 0;
  static const String _cooldownKey = 'last_password_reset_timestamp';

  @override
  void initState() {
    super.initState();
    _loadCooldown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    super.dispose();
  }

  // Memuat status cooldown dari penyimpanan lokal
  Future<void> _loadCooldown() async {
    final prefs = await SharedPreferences.getInstance();
    final lastTimestamp = prefs.getInt(_cooldownKey) ?? 0;
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    
    final difference = (currentTimestamp - lastTimestamp) ~/ 1000;
    
    if (difference < 60) {
      setState(() {
        _secondsRemaining = 60 - difference;
      });
      _startTimer();
    }
  }

  // Menyimpan waktu pengiriman terakhir ke penyimpanan lokal
  Future<void> _saveCooldown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_cooldownKey, DateTime.now().millisecondsSinceEpoch);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 0) {
        timer.cancel();
        if (mounted) setState(() => _secondsRemaining = 0);
      } else {
        if (mounted) {
          setState(() {
            _secondsRemaining--;
          });
        }
      }
    });
  }

  Future<void> _handleResetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      SnackBarUtils.show(context, context.t.auth.forgot_password.please_enter_your_email_address.ucfirst(), type: SnackBarType.error);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.sendPasswordResetEmail(email);
      
      // Simpan cooldown ke storage
      await _saveCooldown();
      
      if (mounted) {
        SnackBarUtils.show(context, context.t.auth.forgot_password.reset_link_has_been_sent_to_your_email.ucfirst(), type: SnackBarType.success);
        
        // Langsung mulai timer lokal agar UI update sebelum navigasi
        setState(() => _secondsRemaining = 60);
        _startTimer();
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
      appBar: CustomAppBar.actionOnly(context),
      body: SafeArea(  
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, 
                mainAxisSize: MainAxisSize.min, 
                children: [
                  Text(
                    context.t.auth.forgot_password.forgot_your_password.toTitleCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 36.0,
                      fontWeight: FontWeight.w700,
                      height: 47 / 36,
                    ),
                  ),              
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: CustomTextFieldDecoration(
                        hintText: context.t.auth.forgot_password.enter_registered_email_address.toTitleCase(),
                        prefixIcon: Icons.mail_lock_rounded,
                      ).decoration,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: 340,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: "*",  
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.red, 
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: " ${context.t.auth.forgot_password.we_will_send_you_a_message_to_set_or_reset_your_new_password.ucfirst()}",
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color.fromRGBO(87, 87, 87, 1.0),  
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
                  
                  const SizedBox(height: 50),
                  
                  PrimaryButton(
                    label: _secondsRemaining > 0 
                        ? context.t.auth.forgot_password.wait(seconds: _secondsRemaining.toString()).toTitleCase()
                        : context.t.auth.forgot_password.submit.toTitleCase(),
                    isLoading: _isLoading,
                    backgroundColor: _secondsRemaining > 0 
                        ? Colors.grey 
                        : const Color.fromRGBO(252, 147, 3, 1.0),
                    onPressed: _secondsRemaining > 0 ? null : _handleResetPassword,
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
