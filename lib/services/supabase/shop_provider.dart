import 'package:flutter/foundation.dart';
import 'package:pawtastic/models/shop_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShopProvider extends ChangeNotifier {
  final _supabase = Supabase.instance.client;
  ShopModel? _shop;

  ShopModel? get shop => _shop;

  Future<void> fetchShop() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    final data = await _supabase
        .from('shops')
        .select()
        .eq('owner_id', userId)
        .maybeSingle();

    if (data != null) {
      _shop = ShopModel.fromJson(data);
      notifyListeners();
    }
  }

  Future<bool> updateShop(String id, ShopModel updatedShop) async {
    try {
      await _supabase.from('shops').update(updatedShop.toJson()).eq('id', id);
      _shop = updatedShop;
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) debugPrint("Error updating shop: $e");
      return false;
    }
  }
}
