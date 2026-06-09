class AddressModel {
  final String id;
  final String profileId;
  final String title;
  final String recipientName;
  final String phoneNumber;
  final String fullAddress;
  final int? provinceId;
  final String? provinceName;
  final int? cityId;
  final String? cityName;
  final int? districtId;
  final String? districtName;
  final int? subdistrictId;
  final String? subdistrictName;
  final String? zipCode;
  final String? api;
  final double? latitude;
  final double? longitude;
  final bool isDefaultShipping;
  final bool isShopPickup;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddressModel({
    required this.id,
    required this.profileId,
    required this.title,
    required this.recipientName,
    required this.phoneNumber,
    required this.fullAddress,
    this.provinceId,
    this.provinceName,
    this.cityId,
    this.cityName,
    this.districtId,
    this.districtName,
    this.subdistrictId,
    this.subdistrictName,
    this.zipCode,
    this.api,
    this.latitude,
    this.longitude,
    required this.isDefaultShipping,
    required this.isShopPickup,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    double? lat;
    double? lng;
    
    if (json['location'] != null && json['location'] is Map) {
      final coordinates = json['location']['coordinates'];
      if (coordinates != null && coordinates is List && coordinates.length >= 2) {
        lng = (coordinates[0] as num).toDouble();
        lat = (coordinates[1] as num).toDouble();
      }
    }

    return AddressModel(
      id: json['id'],
      profileId: json['profile_id'],
      title: json['title'],
      recipientName: json['recipient_name'],
      phoneNumber: json['phone_number'],
      fullAddress: json['full_address'],
      provinceId: json['province_id'],
      provinceName: json['province_name'],
      cityId: json['city_id'],
      cityName: json['city_name'],
      districtId: json['district_id'],
      districtName: json['district_name'],
      subdistrictId: json['subdistrict_id'],
      subdistrictName: json['subdistrict_name'],
      zipCode: json['zip_code'],
      api: json['api'],
      latitude: lat,
      longitude: lng,
      isDefaultShipping: json['is_default_shipping'] ?? false,
      isShopPickup: json['is_shop_pickup'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'recipient_name': recipientName,
      'phone_number': phoneNumber,
      'full_address': fullAddress,
      'province_id': provinceId,
      'province_name': provinceName,
      'city_id': cityId,
      'city_name': cityName,
      'district_id': districtId,
      'district_name': districtName,
      'subdistrict_id': subdistrictId,
      'subdistrict_name': subdistrictName,
      'zip_code': zipCode,
      'api': api,
      // Note: location is handled separately in Supabase via PostGIS
      'is_default_shipping': isDefaultShipping,
      'is_shop_pickup': isShopPickup,
    };
  }
}
