import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { buyer, seller, none }

class UserProvider extends ChangeNotifier {
  UserRole _role = UserRole.none;
  bool _isLoading = true;
  User? _user;

  UserRole get role => _role;
  bool get isLoading => _isLoading;
  User? get user => _user;

  UserProvider() {
    _init();
  }

  void _init() {
    // --- MODE SIMULASI (ubah _role)---
    _role = UserRole.none; 
    _user = null; 
    _isLoading = false;
    notifyListeners();
  }

  void setRole(UserRole newRole) {
    _role = newRole;
    notifyListeners();
  }

  Future<void> _fetchUserRole(String uid) async {
    _isLoading = true;
    notifyListeners();

    try {
      var buyerDoc = await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (buyerDoc.exists) {
        _role = UserRole.buyer;
      } else {
        var sellerDoc = await FirebaseFirestore.instance.collection('Sellers').doc(uid).get();
        if (sellerDoc.exists) {
          _role = UserRole.seller;
        } else {
          _role = UserRole.none;
        }
      }
    } catch (e) {
      debugPrint("Error fetching role: $e");
      _role = UserRole.none;
    }

    _isLoading = false;
    notifyListeners();
  }

  void logout() async {
    _role = UserRole.none;
    _user = null;
    notifyListeners();
    await FirebaseAuth.instance.signOut();
  }
}
