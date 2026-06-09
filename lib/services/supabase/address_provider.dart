import 'package:flutter/foundation.dart';
import 'package:pawtastic/models/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressProvider extends ChangeNotifier {
  final _supabase = Supabase.instance.client;
  List<AddressModel> _addresses = [];
  bool _isLoading = false;

  List<AddressModel> get addresses => _addresses;
  bool get isLoading => _isLoading;

  Future<void> fetchAddresses() async {
    _isLoading = true;
    notifyListeners();

    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final data = await _supabase
          .from('addresses')
          .select()
          .eq('profile_id', userId)
          .filter('deleted_at', 'is', null)
          .order('is_default_shipping', ascending: false)
          .order('created_at', ascending: false);

      _addresses = (data as List).map((json) => AddressModel.fromJson(json)).toList();
    } catch (e) {
      if (kDebugMode) debugPrint("Error fetching addresses: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addAddress(AddressModel address) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      await _supabase.from('addresses').insert({
        ...address.toJson(),
        'profile_id': userId,
      });

      await fetchAddresses();
      return true;
    } catch (e) {
      if (kDebugMode) debugPrint("Error adding address: $e");
      return false;
    }
  }

  Future<bool> updateAddress(String id, AddressModel address) async {
    try {
      await _supabase.from('addresses').update(address.toJson()).eq('id', id);
      await fetchAddresses();
      return true;
    } catch (e) {
      if (kDebugMode) debugPrint("Error updating address: $e");
      return false;
    }
  }

  Future<bool> deleteAddress(String id) async {
    try {
      // Soft delete
      await _supabase.from('addresses').update({
        'deleted_at': DateTime.now().toIso8601String(),
      }).eq('id', id);
      
      await fetchAddresses();
      return true;
    } catch (e) {
      if (kDebugMode) debugPrint("Error deleting address: $e");
      return false;
    }
  }

  Future<void> setDefaultAddress(String id) async {
    try {
      // Logic managed by database trigger trg_single_default_address
      await _supabase.from('addresses').update({
        'is_default_shipping': true,
      }).eq('id', id);
      
      await fetchAddresses();
    } catch (e) {
      if (kDebugMode) debugPrint("Error setting default address: $e");
    }
  }
}
