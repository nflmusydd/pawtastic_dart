class Order {
  final String orderId;
  final String shop;
  final String shippingAddress;
  final int totalPrice;
  final String orderDate;
  final String paymentMethod;
  final String? deliveredDate; // Can be null
  final String status; // 'delivered', 'processing', or 'cancelled'
  final String detailStatus;

  Order({
    required this.orderId,
    required this.shop,
    required this.shippingAddress,
    required this.totalPrice,
    required this.orderDate,
    required this.paymentMethod,
    this.deliveredDate,
    required this.status,
    required this.detailStatus,
  });
}
