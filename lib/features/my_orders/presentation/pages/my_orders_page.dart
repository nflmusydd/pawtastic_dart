import 'package:flutter/material.dart';
import 'package:pawtastic/models/order_model.dart';
import 'package:pawtastic/features/my_orders/presentation/widgets/delivered_orders_tab.dart';
import 'package:pawtastic/features/my_orders/presentation/widgets/processing_orders_tab.dart';
import 'package:pawtastic/features/my_orders/presentation/widgets/cancelled_orders_tab.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/auth/auth_guard.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/services/bottom_bar_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  // Data dummy (nanti akan diganti dengan fetch dari database)
  final List<Order> orders = [
    Order(
      orderId: '1947034',
      shop: 'Vidibi Pet Shop',
      shippingAddress: 'Blimbing, Kota Malang',
      totalPrice: 40000,
      orderDate: '05-11-2024',
      paymentMethod: 'Credit Card',
      deliveredDate: '06-11-2024, 15:01',
      status: 'delivered',
      detailStatus: 'Delivered',
    ),
    Order(
      orderId: '1947035',
      shop: 'Rumah hewan',
      shippingAddress: 'Jalan Raya, Kota Malang',
      totalPrice: 50000,
      orderDate: '06-11-2024',
      paymentMethod: 'Debit Card',
      deliveredDate: '07-11-2024, 12:00',
      status: 'delivered',
      detailStatus: 'Delivered',
    ),
    Order(
      orderId: '1947036',
      shop: 'Pakan hewan Malang',
      shippingAddress: 'Jalan Merdeka, Kota Malang',
      totalPrice: 30000,
      orderDate: '07-11-2024',
      paymentMethod: 'PayPal',
      deliveredDate: '08-11-2024, 16:00',
      status: 'delivered',
      detailStatus: 'Delivered',
    ),
    Order(
      orderId: '1947037',
      shop: 'Vidibi Pet Shop',
      shippingAddress: 'Jalan Candi, Kota Malang',
      totalPrice: 25000,
      orderDate: '08-11-2024',
      paymentMethod: 'Cash on Delivery',
      deliveredDate: null, 
      status: 'processing',
      detailStatus: 'Waiting for packaging',
    ),
    Order(
      orderId: '1947038',
      shop: 'Koneko Pet Shop',
      shippingAddress: 'Jalan Batu, Kota Malang',
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
    Order(
      orderId: '1947040',
      shop: 'Patzy Pet Shop',
      shippingAddress: 'Jalan Merdeka, Kota Malang',
      totalPrice: 30000,
      orderDate: '07-11-2024',
      paymentMethod: 'PayPal',
      deliveredDate: '07-11-2024, 16:00',
      status: 'delivered',
      detailStatus: 'Delivered',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AuthGuard(
        child: Scaffold(
          appBar: CustomAppBar.centerTitle(
            context,
            blackTitle: context.t.my_orders.index.my_orders.toTitleCase(),
            titleOnly: true,
          ),
          body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.reverse) {
              if (context.read<BottomBarProvider>().isVisible) {
                context.read<BottomBarProvider>().setVisible(false);
              }
            } else if (notification.direction == ScrollDirection.forward) {
              if (!context.read<BottomBarProvider>().isVisible) {
                context.read<BottomBarProvider>().setVisible(true);
              }
            }
            return true;
          },
          child: CustomTabLayout(
            tabTitles: [
              context.t.my_orders.index.delivered.toTitleCase(),
              context.t.my_orders.index.processing.toTitleCase(),
              context.t.my_orders.index.cancelled.toTitleCase(),
            ],
            tabViews: [
              DeliveredOrdersTab(orders: orders.where((o) => o.status == 'delivered').toList()),
              ProcessingOrdersTab(orders: orders.where((o) => o.status == 'processing').toList()),
              CancelledOrdersTab(orders: orders.where((o) => o.status == 'cancelled').toList()),
            ],
          ),
        ),
      ),
    );
  }
}

class ToMyOrdersPage extends StatelessWidget {
  const ToMyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBar(initialIndex: 2);
  }
}
