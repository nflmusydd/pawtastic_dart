import 'package:flutter/material.dart';
import 'package:pawtastic/models/order_model.dart';
import 'package:pawtastic/features/seller/presentation/orders/widgets/seller_orders_tab.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';

class ManageOrdersPage extends StatefulWidget {
  const ManageOrdersPage({super.key});

  @override
  State<ManageOrdersPage> createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<ManageOrdersPage> {
  final List<Order> orders = [
    Order(
      orderId: '1947034',
      shop: 'IW3475453455',
      shippingAddress: 'Cat Food Whiskas x1\nHamsfood x1',
      totalPrice: 40000,
      orderDate: '05-11-2024',
      paymentMethod: 'Credit Card',
      deliveredDate: '06-11-2024, 15:01',
      status: 'delivered',
      detailStatus: 'Delivered',
    ),
    Order(
      orderId: '1947035',
      shop: 'IW3475453456',
      shippingAddress: 'Dog Food Pedigree x1\nHamsfood x1',
      totalPrice: 50000,
      orderDate: '06-11-2024',
      paymentMethod: 'Debit Card',
      deliveredDate: '07-11-2024, 12:00',
      status: 'delivered',
      detailStatus: 'Delivered',
    ),
    Order(
      orderId: '1947036',
      shop: 'IW3475453457',
      shippingAddress: 'Suplemen Kucing x1',
      totalPrice: 30000,
      orderDate: '07-11-2024',
      paymentMethod: 'PayPal',
      deliveredDate: '08-11-2024, 16:00',
      status: 'delivered',
      detailStatus: 'Delivered',
    ),
    Order(
      orderId: '1947037',
      shop: 'IW3475453460',
      shippingAddress: 'Suplemen Hamster x1',
      totalPrice: 25000,
      orderDate: '08-11-2024',
      paymentMethod: 'Cash on Delivery',
      deliveredDate: null, 
      status: 'processing',
      detailStatus: 'Waiting for packaging',
    ),
    Order(
      orderId: '1947038',
      shop: 'IW3475453465',
      shippingAddress: 'Obat Diare Anjing x1',
      totalPrice: 45000,
      orderDate: '09-11-2024',
      paymentMethod: 'Credit Card',
      deliveredDate: null, 
      status: 'processing',
      detailStatus: 'In delivery',
    ),
    Order(
      orderId: '1947039',
      shop: 'Perlengkapan Hewan Singosari',
      shippingAddress: 'Jalan Indah, Kota Malang',
      totalPrice: 35000,
      orderDate: '10-11-2024',
      paymentMethod: 'Bank Transfer',
      deliveredDate: null, 
      status: 'cancelled',
      detailStatus: 'Empty stock',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.leftTitle(
        context,
        title: context.t.seller.manage_orders.title.toTitleCase(),
      ),
      body: CustomTabLayout(
        tabTitles: [
          context.t.seller.manage_orders.pending.toTitleCase(),
          context.t.seller.manage_orders.delivered.toTitleCase(),
          context.t.seller.manage_orders.cancelled.toTitleCase(),
        ],
        tabViews: [
          SellerOrdersTab(orders: orders.where((o) => o.status == 'processing').toList()),
          SellerOrdersTab(orders: orders.where((o) => o.status == 'delivered').toList()),
          SellerOrdersTab(orders: orders.where((o) => o.status == 'cancelled').toList()),
        ],
      ),
    );
  }
}
