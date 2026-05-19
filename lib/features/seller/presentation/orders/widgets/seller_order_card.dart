import 'package:flutter/material.dart';
import 'package:pawtastic/models/order_model.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class SellerOrderCard extends StatelessWidget {
  final Order order;

  const SellerOrderCard({super.key, required this.order});

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
              "${context.t.seller.manage_orders.tracking_number.toTitleCase()}: ${order.shop}",
              style: const TextStyle(fontSize: 14.0),
            ),
            Text(
              "${context.t.seller.manage_orders.product_list.toTitleCase()}:\n${order.shippingAddress}",
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
                    if (order.status == 'processing')
                      Text(
                        order.detailStatus,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[600],
                        ),
                      ),
                    if (order.status == 'cancelled')
                      Text(
                        order.detailStatus,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[600],
                        ),
                      ),
                  ],
                ),
                if (order.status == 'delivered')
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color.fromARGB(255, 197, 31, 16)),
                          ),
                          child: Text(
                            context.t.common.cancel.toTitleCase(),
                            style: const TextStyle(color: Color.fromARGB(255, 197, 31, 16)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color.fromARGB(255, 33, 196, 12)),
                          ),
                          child: Text(
                            context.t.seller.manage_orders.confirm.toTitleCase(),
                            style: TextStyle(color: Colors.green[600]),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () {},
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
