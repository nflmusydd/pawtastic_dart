class ShopModel {
  final String id;
  final String ownerId;
  final String storeSlug;
  final String shopName;
  final String? description;
  final bool isVerified;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ShopModel({
    required this.id,
    required this.ownerId,
    required this.storeSlug,
    required this.shopName,
    this.description,
    required this.isVerified,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'],
      ownerId: json['owner_id'],
      storeSlug: json['store_slug'],
      shopName: json['shop_name'],
      description: json['description'],
      isVerified: json['is_verified'] ?? false,
      status: json['status'] ?? 'active',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shop_name': shopName,
      'store_slug': storeSlug,
      if (description != null) 'description': description,
    };
  }
}
