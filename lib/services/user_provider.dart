import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum UserRole { buyer, seller, none }

class UserProvider extends ChangeNotifier {
  UserRole _role = UserRole.none;
  bool _isLoading = true;
  User? _user;

  UserRole get role => _role;
  bool get isLoading => _isLoading;
  User? get user => _user;

  final _supabase = Supabase.instance.client;

  UserProvider() {
    _init();
  }

  void _init() {
    // Listen to Auth state changes
    _supabase.auth.onAuthStateChange.listen((data) async {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      _user = session?.user;

      if (_user != null) {
        await _fetchUserRole(_user!.id);
      } else {
        _role = UserRole.none;
        _isLoading = false;
        notifyListeners();
      }
    });

    // Check current session on startup
    final session = _supabase.auth.currentSession;
    _user = session?.user;
    if (_user != null) {
      _fetchUserRole(_user!.id);
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchUserRole(String uid) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Check if user has a shop (is a seller)
      final shopData = await _supabase
          .from('shops')
          .select('id')
          .eq('owner_id', uid)
          .maybeSingle();

      if (shopData != null) {
        _role = UserRole.seller;
      } else {
        // If profile exists but no shop, they are a buyer
        final profileData = await _supabase
            .from('profiles')
            .select('id')
            .eq('id', uid)
            .maybeSingle();
        
        if (profileData != null) {
          _role = UserRole.buyer;
        } else {
          _role = UserRole.none;
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint("Error fetching role: $e");
      _role = UserRole.none;
    }

    _isLoading = false;
    notifyListeners();
  }

  void setRole(UserRole newRole) {
    _role = newRole;
    notifyListeners();
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
    _role = UserRole.none;
    _user = null;
    notifyListeners();
  }
}

