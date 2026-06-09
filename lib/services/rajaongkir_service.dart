import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RajaOngkirService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getProvinces() async {
    try {
      final response = await _supabase.functions.invoke(
        'rajaongkir-proxy',
        body: {'action': 'get_provinces'},
      );

      if (response.status == 200) {
        final data = response.data;
        if (data != null && data['rajaongkir'] != null) {
          return List<Map<String, dynamic>>.from(data['rajaongkir']['results']);
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint("RajaOngkir Error (Provinces): $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getCities(int provinceId) async {
    try {
      final response = await _supabase.functions.invoke(
        'rajaongkir-proxy',
        body: {
          'action': 'get_cities',
          'province_id': provinceId,
        },
      );

      if (response.status == 200) {
        final data = response.data;
        if (data != null && data['rajaongkir'] != null) {
          return List<Map<String, dynamic>>.from(data['rajaongkir']['results']);
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint("RajaOngkir Error (Cities): $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getDistricts(int cityId) async {
    try {
      final response = await _supabase.functions.invoke(
        'rajaongkir-proxy',
        body: {
          'action': 'get_districts',
          'city_id': cityId,
        },
      );

      if (response.status == 200) {
        final data = response.data;
        if (data != null && data['rajaongkir'] != null) {
          return List<Map<String, dynamic>>.from(data['rajaongkir']['results']);
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint("RajaOngkir Error (Districts): $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getSubdistricts(int districtId) async {
    try {
      final response = await _supabase.functions.invoke(
        'rajaongkir-proxy',
        body: {
          'action': 'get_subdistricts',
          'district_id': districtId,
        },
      );

      if (response.status == 200) {
        final data = response.data;
        if (data != null && data['rajaongkir'] != null) {
          return List<Map<String, dynamic>>.from(data['rajaongkir']['results']);
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint("RajaOngkir Error (Subdistricts): $e");
    }
    return [];
  }

  // Persiapan untuk fitur Cek Ongkir nanti
  Future<List<dynamic>> getCost({
    required String origin,
    required String destination,
    required int weight,
    required String courier,
  }) async {
    try {
      final response = await _supabase.functions.invoke(
        'rajaongkir-proxy',
        body: {
          'action': 'get_cost',
          'origin': origin,
          'destination': destination,
          'weight': weight,
          'courier': courier,
        },
      );

      if (response.status == 200) {
        final data = response.data;
        return data['rajaongkir']['results'][0]['costs'];
      }
    } catch (e) {
      if (kDebugMode) debugPrint("RajaOngkir Error (Cost): $e");
    }
    return [];
  }
}
