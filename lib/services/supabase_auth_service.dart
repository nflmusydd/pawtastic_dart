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
      
      // "Invalid login credentials" is safe as it's ambiguous
      if (e.message.toLowerCase().contains("invalid login credentials")) {
        throw "Email atau password salah.";
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
