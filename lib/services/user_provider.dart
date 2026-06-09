import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum UserRole { buyer, seller, none }

class UserProvider extends ChangeNotifier {
  UserRole _role = UserRole.none;
  bool _isLoading = true;
  bool _hasConnectionError = false;
  User? _user;
  String? _fullName;

  UserRole get role => _role;
  bool get isLoading => _isLoading;
  bool get hasConnectionError => _hasConnectionError;
  User? get user => _user;
  String get fullName => _fullName ?? "";

  final _supabase = Supabase.instance.client;

  UserProvider() {
    _init();
  }

  void _init() {
    // Listen to Auth state changes
    _supabase.auth.onAuthStateChange.listen((data) async {
      // final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      _user = session?.user;

      if (_user != null) {
        await _fetchUserRole(_user!.id);
      } else {
        _role = UserRole.none;
        _isLoading = false;
        notifyListeners();
      }
    }, onError: (error) {
      if (kDebugMode) {
        debugPrint("AUTH_ERROR: $error");
      }
      if (error.toString().contains("SocketException") || error.toString().contains("Connection refused")) {
        _hasConnectionError = true;
        _isLoading = false;
        notifyListeners();
      }
    });

    // Check current session on startup
    _checkInitialSession();
  }

  Future<void> _checkInitialSession() async {
    _isLoading = true;
    _hasConnectionError = false;
    notifyListeners();

    try {
      final session = _supabase.auth.currentSession;
      _user = session?.user;
      if (_user != null) {
        await _fetchUserRole(_user!.id);
      } else {
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) debugPrint("INITIAL_SESSION_ERROR: $e");
      
      if (e.toString().contains("SocketException") || e.toString().contains("Connection refused")) {
        _hasConnectionError = true;
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> retry() async {
    await _checkInitialSession();
  }

  Future<void> refreshRole() async {
    if (_user != null) {
      await _fetchUserRole(_user!.id);
    }
  }

  Future<void> _fetchUserRole(String uid) async {
    // Hanya tampilkan loading screen jika ini adalah login pertama kali
    // (role belum ada). Ini mencegah layar kedap-kedip ke Splash saat token refresh atau re-login.
    final bool isFirstLoad = _role == UserRole.none;

    if (isFirstLoad) {
      _isLoading = true;
      _hasConnectionError = false;
      notifyListeners();
    }

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
            .select('id, full_name')
            .eq('id', uid)
            .maybeSingle();
        
        if (profileData != null) {
          _role = UserRole.buyer;
          _fullName = profileData['full_name'];
        } else {
          _role = UserRole.none;
        }
      }
      
      // If it's a seller, we might still want their full_name from profiles
      if (_role == UserRole.seller) {
        final profileData = await _supabase
            .from('profiles')
            .select('full_name')
            .eq('id', uid)
            .maybeSingle();
        if (profileData != null) {
          _fullName = profileData['full_name'];
        }
      }
      _hasConnectionError = false;
    } catch (e) {
      if (kDebugMode) debugPrint("Error fetching role: $e");
      
      if (e.toString().contains("SocketException") || e.toString().contains("Connection refused")) {
        _hasConnectionError = true;
      } else {
        _role = UserRole.none;
      }
    }

    if (isFirstLoad) {
      _isLoading = false;
    }
    notifyListeners();
  }

  void setRole(UserRole newRole) {
    _role = newRole;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      if (kDebugMode) debugPrint("Logout error: $e");
    }
    _role = UserRole.none;
    _user = null;
    _fullName = null;
    notifyListeners();
  }
}

