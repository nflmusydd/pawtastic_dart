import 'package:flutter/material.dart';
import 'package:pawtastic/models/order_model.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/shared/utils/dialog_utils.dart';

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

  void _handleConfirm(BuildContext context) {
    DialogUtils.showConfirmationDialog(
      context: context,
      title: isSeller 
        ? context.t.seller.manage_orders.confirm.toTitleCase()
        : context.t.my_orders.details.confirm_order.toTitleCase(),
      message: isSeller
        ? context.t.seller.manage_orders.confirm_order_message.ucfirst()
        : context.t.my_orders.details.confirm_receipt_message.ucfirst(),
      onConfirm: onConfirm ?? () {},
    );
  }

  void _handleCancel(BuildContext context) {
    DialogUtils.showConfirmationDialog(
      context: context,
      title: context.t.common.cancel.toTitleCase(),
      message: context.t.seller.manage_orders.cancel_order_message.ucfirst(),
      onConfirm: onCancel ?? () {},
    );
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
        padding: EdgeInsets.fromLTRB(16, 16, 16, _shouldShowActionButtons() ? 4 : 16,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Order ID and Date
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

            // Info Rows: Shop/Tracking and Address/Product List
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

            // Middle Row: Total Amount, Status, and Details Button
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
                // Details button always visible
                _buildOutlineButton(
                  context,
                  label: context.t.common.details.toTitleCase(),
                  color: const Color.fromARGB(255, 108, 108, 108),
                  onPressed: onTap,
                ),
              ],
            ),
            
            // Bottom Row: Action Buttons (Confirm/Cancel)
            if (_shouldShowActionButtons()) ...[
              const SizedBox(height: 12.0),
              const Divider(height: 1, thickness: 0.5),
              const SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isSeller) ...[
                    _buildOutlineButton(
                      context,
                      label: context.t.common.cancel.toTitleCase(),
                      color: const Color.fromARGB(255, 197, 31, 16),
                      onPressed: () => _handleCancel(context),
                    ),
                    const SizedBox(width: 12),
                  ],
                  _buildOutlineButton(
                    context,
                    label: isSeller 
                        ? context.t.seller.manage_orders.confirm.toTitleCase()
                        : context.t.my_orders.details.confirm_order.toTitleCase(),
                    color: const Color.fromARGB(255, 33, 196, 12),
                    onPressed: () => _handleConfirm(context),
                  ),
                ],
              ),
            ],
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

  bool _shouldShowActionButtons() {
    final status = order.status.toLowerCase();
    if (isSeller && status == 'processing') return true;
    if (!isSeller && status == 'delivered') return true;
    return false;
  }

  Widget _buildOutlineButton(BuildContext context, {
    required String label,
    required Color color,
    required VoidCallback? onPressed,
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
