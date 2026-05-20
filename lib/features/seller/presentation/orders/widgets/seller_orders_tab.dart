import 'package:flutter/material.dart';
import 'package:pawtastic/models/order_model.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';

class SellerOrdersTab extends StatelessWidget {
  final List<Order> orders;

  const SellerOrdersTab({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 70),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return GlobalOrderCard(
            order: orders[index],
            isSeller: true,
            onTap: () {
              // Handle tap
            },
            onConfirm: () {
              // Handle confirm
            },
            onCancel: () {
              // Handle cancel
            },
          );
        },
      ),
    );
  }
}
