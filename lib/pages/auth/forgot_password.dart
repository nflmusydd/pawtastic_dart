import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pawtastic/core/utils/snackbar_utils.dart';
import 'package:pawtastic/services/supabase_auth_service.dart';
import 'package:pawtastic/widget/text_field1.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
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
      SnackBarUtils.show(context, "Please enter your email address", type: SnackBarType.error);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.sendPasswordResetEmail(email);
      
      // Simpan cooldown ke storage
      await _saveCooldown();
      
      if (mounted) {
        SnackBarUtils.show(context, "Reset link has been sent to your email!", type: SnackBarType.success);
        
        // Langsung mulai timer lokal agar UI update sebelum navigasi
        setState(() => _secondsRemaining = 60);
        _startTimer();

        // Delay sedikit agar user sempat baca snackbar, lalu kembali ke login
        // Future.delayed(const Duration(seconds: 5), () {
        //   if (mounted) Navigator.pop(context);
        // });
      }
    } catch (e) {
      if (mounted) {
        final String userMessage = e is String ? e : "An unexpected error occurred. Please try again.";
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
      appBar: AppBar(
        elevation: 0, 
      ),
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
                  const Text(
                    "Forgot your Password?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
                      decoration: Textfield1(
                        hintText: 'Enter registered email address',
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
                        text: const TextSpan(
                          text: "*",  
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.red, 
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: " We will send you a message to set or reset your new password",
                              style: TextStyle(
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
                  
                  SizedBox(
                    width: 350,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _secondsRemaining > 0 
                            ? Colors.grey 
                            : const Color.fromRGBO(252, 147, 3, 1.0), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0), 
                        ), 
                      ),
                      onPressed: (_isLoading || _secondsRemaining > 0) ? null : _handleResetPassword,
                      child: _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            _secondsRemaining > 0 
                                ? "Wait ${_secondsRemaining}s" 
                                : "Submit",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                            )
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
