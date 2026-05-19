import 'package:flutter/material.dart';
import 'package:pawtastic/models/order_model.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class GlobalOrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;
  final bool isSeller;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const GlobalOrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.isSeller = false,
    this.onConfirm,
    this.onCancel,
  });

  Color _getStatusColor() {
    switch (order.status.toLowerCase()) {
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
    if (order.status.toLowerCase() == 'delivered' && !isSeller) {
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
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  order.orderDate,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            _buildInfoRow(
              context,
              label: isSeller 
                ? context.t.seller.manage_orders.tracking_number.toTitleCase()
                : context.t.common.from.toTitleCase(),
              value: order.shop,
            ),
            const SizedBox(height: 4.0),
            _buildInfoRow(
              context,
              label: isSeller
                ? context.t.seller.manage_orders.product_list.toTitleCase()
                : context.t.common.shipping_address.toTitleCase(),
              value: order.shippingAddress,
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "${context.t.common.total_amount.toTitleCase()}: ",
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Montserrat',
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Rp ${order.totalPrice}",
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      _getStatusText(context),
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(),
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
                _buildActionButtons(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, {required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            fontSize: 13.0,
            color: Colors.grey,
            fontFamily: 'Montserrat',
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    if (isSeller && order.status.toLowerCase() == 'delivered') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOutlineButton(
            context,
            label: context.t.common.cancel.toTitleCase(),
            color: const Color.fromARGB(255, 197, 31, 16),
            onPressed: onCancel,
          ),
          const SizedBox(width: 8),
          _buildOutlineButton(
            context,
            label: context.t.seller.manage_orders.confirm.toTitleCase(),
            color: const Color.fromARGB(255, 33, 196, 12),
            onPressed: onConfirm,
          ),
        ],
      );
    }

    return _buildOutlineButton(
      context,
      label: context.t.common.details.toTitleCase(),
      color: const Color.fromARGB(255, 108, 108, 108),
      onPressed: onTap,
    );
  }

  Widget _buildOutlineButton(BuildContext context, {
    required String label,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        minimumSize: const Size(0, 32),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
