import 'package:flutter/material.dart';
import 'package:pawtastic/models/order_model.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/features/my_orders/presentation/pages/order_details_page.dart';

class CancelledOrdersTab extends StatelessWidget {
  final List<Order> orders;

  const CancelledOrdersTab({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true, 
            physics: const NeverScrollableScrollPhysics(), 
            padding: const EdgeInsets.all(16.0),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return GlobalOrderCard(
                order: orders[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsPage(order: orders[index]),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
