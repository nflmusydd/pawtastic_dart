import 'package:flutter/material.dart';
import 'package:pawtastic/models/order_model.dart';
import 'package:pawtastic/features/my_orders/presentation/pages/order_details_page.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  Color _getStatusColor() {
    switch (order.status) {
      case 'delivered':
        return Colors.green[600]!;
      case 'processing':
        return Colors.orange[600]!;
      case 'cancelled':
        return Colors.red[600]!;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(BuildContext context) {
    if (order.status == 'delivered') {
      return context.t.my_orders.index.delivered_on(date: order.deliveredDate ?? "").ucfirst();
    }
    return order.detailStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${context.t.my_orders.index.order.toTitleCase()} №${order.orderId}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  order.orderDate,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              "${context.t.common.from.toTitleCase()}: ${order.shop}",
              style: const TextStyle(fontSize: 14.0),
            ),
            Text(
              "${context.t.common.shipping_address.toTitleCase()}: ${order.shippingAddress}",
              style: const TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "${context.t.common.total_amount.toTitleCase()}: ",
                        children: <TextSpan>[
                          TextSpan(
                            text: "Rp ${order.totalPrice}",
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      _getStatusText(context),
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsPage(order: order),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color.fromARGB(255, 108, 108, 108)),
                    ),
                    child: Text(context.t.common.details.toTitleCase()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
