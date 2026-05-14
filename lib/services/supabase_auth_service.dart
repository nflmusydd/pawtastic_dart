import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class SupabaseAuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Sign up a new user with email, password, and additional metadata.
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? username,
    required String fullName,
  }) async {
    try {
      final Map<String, dynamic> userMetadata = {
        'full_name': fullName,
      };
      
      if (username != null && username.isNotEmpty) {
        userMetadata['username'] = username;
      }

      return await _supabase.auth.signUp(
        email: email,
        password: password,
        data: userMetadata,
      );
    } on AuthException catch (e) {
      if (kDebugMode) debugPrint("SUPABASE_AUTH_ERROR [SignUp]: ${e.message}");
      
      // Map common technical errors to safe, friendly messages
      if (e.message.contains("already registered")) {
        throw "Email ini sudah terdaftar. Silakan gunakan email lain.";
      }
      if (e.message.contains("Network")) {
        throw "Koneksi bermasalah. Periksa internet kamu.";
      }
      
      // Fallback to a safe general message for production
      throw "Gagal mendaftar. Pastikan data benar atau coba lagi nanti.";
    } catch (e) {
      if (kDebugMode) debugPrint("UNEXPECTED_ERROR [SignUp]: $e");
      throw 'Terjadi kesalahan sistem. Silakan coba beberapa saat lagi.';
    }
  }

  /// Sign in with email and password.
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      if (kDebugMode) debugPrint("SUPABASE_AUTH_ERROR [SignIn]: ${e.message}");
      
      final message = e.message.toLowerCase();
      if (message.contains("invalid login credentials")) {
        throw "Email atau password salah.";
      }
      if (message.contains("email not confirmed")) {
        throw "Email kamu belum dikonfirmasi. Silakan cek inbox email kamu.";
      }
      throw "Gagal login. Silakan coba lagi.";
    } catch (e) {
      if (kDebugMode) debugPrint("UNEXPECTED_ERROR [SignIn]: $e");
      throw 'Terjadi kesalahan sistem.';
    }
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      if (kDebugMode) debugPrint("UNEXPECTED_ERROR [SignOut]: $e");
    }
  }

  /// Get the currently logged in user.
  User? get currentUser => _supabase.auth.currentUser;

  /// Stream of auth state changes.
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// Send a password reset email to the user.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: kIsWeb ? null : 'io.supabase.pawtastic://reset-password',
      );
    } on AuthException catch (e) {
      if (kDebugMode) debugPrint("SUPABASE_AUTH_ERROR [ResetPassword]: ${e.message}");

      // Saring pesan error Supabase agar tidak terlalu teknis
      final msg = e.message.toLowerCase();
      if (msg.contains("user not found")) {
        throw "Email tidak terdaftar. Silakan cek kembali.";
      }
      if (msg.contains("rate limit")) {
        throw "Terlalu banyak permintaan. Silakan tunggu beberapa saat.";
      }
      throw "Gagal mengirim email reset. Pastikan email Anda benar.";
    } catch (e) {
      if (kDebugMode) debugPrint("UNEXPECTED_ERROR [ResetPassword]: $e");
      throw 'Terjadi masalah koneksi. Silakan coba lagi.';
    }
  }

  /// Update the current user's password.
  Future<void> updatePassword(String newPassword) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } on AuthException catch (e) {
      if (kDebugMode) debugPrint("SUPABASE_AUTH_ERROR [UpdatePassword]: ${e.message}");

      if (e.message.contains("same as old password")) {
        throw "Password baru tidak boleh sama dengan password lama.";
      }
      throw "Gagal memperbarui password. Silakan coba lagi.";
    } catch (e) {
      if (kDebugMode) debugPrint("UNEXPECTED_ERROR [UpdatePassword]: $e");
      throw 'Terjadi kesalahan sistem.';
    }
  
  }

  /// Create a shop for the current user.
  Future<void> createShop({
    required String shopName,
    required String description,
    required String storeSlug,
  }) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw 'User not logged in';

      await _supabase.from('shops').insert({
        'owner_id': user.id,
        'shop_name': shopName,
        'description': description,
        'store_slug': storeSlug,
      });
    } on PostgrestException catch (e) {
      if (kDebugMode) debugPrint("SUPABASE_DB_ERROR [CreateShop]: ${e.message} (Code: ${e.code})");

      // Very important: don't expose database column/constraint names
      if (e.message.contains("store_slug")) {
        throw "Nama toko sudah digunakan atau mengandung karakter yang tidak diizinkan.";
      }
      throw 'Gagal membuat toko. Silakan coba lagi.';
    } catch (e) {
      if (kDebugMode) debugPrint("UNEXPECTED_ERROR [CreateShop]: $e");
      throw 'Gagal membuat akun toko.';
    }
  }
}
