import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/core_utils.dart';

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
        throw t.errors.auth.this_email_is_already_registered_please_use_another_email.ucfirst();
      }
      if (e.message.contains("Network")) {
        throw t.errors.auth.connection_problem_check_your_internet.ucfirst();
      }
      
      // Fallback to a safe general message for production
      throw t.errors.auth.failed_to_register_make_sure_the_data_is_correct_or_try_again_later.ucfirst();
    } catch (e) {
      if (kDebugMode) debugPrint("UNEXPECTED_ERROR [SignUp]: $e");
      throw t.errors.auth.system_error_occurred_please_try_again_in_a_few_moments.ucfirst();
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
        throw t.errors.auth.incorrect_email_or_password.ucfirst();
      }
      if (message.contains("email not confirmed")) {
        throw t.errors.auth.your_email_has_not_been_confirmed_please_check_your_email_inbox.ucfirst();
      }
      throw t.errors.auth.failed_to_login_please_try_again.ucfirst();
    } catch (e) {
      if (kDebugMode) debugPrint("UNEXPECTED_ERROR [SignIn]: $e");
      throw t.errors.auth.system_error.ucfirst();
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

      final msg = e.message.toLowerCase();
      if (msg.contains("user not found")) {
        throw t.errors.auth.email_not_registered_please_check_again.ucfirst();
      }
      if (msg.contains("rate limit")) {
        throw t.errors.auth.too_many_requests_please_wait_a_few_moments.ucfirst();
      }
      throw t.errors.auth.failed_to_send_reset_email_make_sure_your_email_is_correct.ucfirst();
    } catch (e) {
      if (kDebugMode) debugPrint("UNEXPECTED_ERROR [ResetPassword]: $e");
      throw t.errors.auth.connection_problem_please_try_again.ucfirst();
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
        throw t.errors.auth.new_password_cannot_be_the_same_as_the_old_password.ucfirst();
      }
      throw t.errors.auth.failed_to_update_password_please_try_again.ucfirst();
    } catch (e) {
      if (kDebugMode) debugPrint("UNEXPECTED_ERROR [UpdatePassword]: $e");
      throw t.errors.auth.system_error.ucfirst();
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

      if (e.message.contains("store_slug")) {
        throw t.errors.shop.shop_name_already_used_or_contains_unauthorized_characters.ucfirst();
      }
      throw t.errors.shop.failed_to_create_shop_please_try_again.ucfirst();
    } catch (e) {
      if (kDebugMode) debugPrint("UNEXPECTED_ERROR [CreateShop]: $e");
      throw t.errors.shop.failed_to_create_shop_account.ucfirst();
    }
  }
}
