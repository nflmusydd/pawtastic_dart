import 'package:flutter/material.dart';
import 'package:pawtastic/shared/widgets/custom_app_bar.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';
import 'package:pawtastic/shared/widgets/custom_tab_layout.dart';

class CashierPage extends StatelessWidget {
  const CashierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.leftTitle(
        context,
        title: context.t.seller.cashier.title.toTitleCase(),
        onBack: () {
          Navigator.pushNamed(context, AppRoutes.homeSeller);
        },
      ),
      body: CustomTabLayout(
        tabTitles: [
          context.t.seller.cashier.transaction_record.toTitleCase(),
          context.t.seller.cashier.add_offline_transaction.toTitleCase(),
        ],
        tabViews: [
          _buildTransactionRecord(context),
          _buildOfflineTransactionForm(context),
        ],
      ),
    );
  }

  Widget _buildTransactionRecord(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildOrderCard(
                context,
                orderId: '№1947034',
                items: ['Cat Food Whiskas x1', 'Hamsfood x1'],
                shippingCost: 'Rp 10.000',
                discount: 'Rp 10.000',
                totalAmount: 'Rp 40.000',
              ),
              _buildOrderCard(
                context,
                orderId: '№7519630',
                items: ['Cat Food Whiskas x3'],
                shippingCost: '-',
                discount: 'Rp 0',
                totalAmount: 'Rp 150.000',
              ),
              _buildOrderCard(
                context,
                orderId: '№3197318',
                items: ['Vitakraft x1', 'Cat Food Whiskas x2'],
                shippingCost: 'Rp 12.000',
                discount: 'Rp 7.000',
                totalAmount: 'Rp 155.000',
              ),
            ],
          ),
        ),
        _buildTotalIncome(context),
      ],
    );
  }

  Widget _buildTotalIncome(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.t.seller.cashier.total_income.toTitleCase(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Rp 453.000',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineTransactionForm(BuildContext context) {
    return Center(
      child: Text(
        context.t.seller.cashier.offline_form_placeholder.ucfirst(),
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required String orderId,
    required List<String> items,
    required String shippingCost,
    required String discount,
    required String totalAmount,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${context.t.my_orders.index.order.toTitleCase()} $orderId', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...items.map((item) => Text(item)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.t.seller.cashier.shipping_cost.toTitleCase()),
                Text(shippingCost),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.t.seller.cashier.discount.toTitleCase()),
                Text(discount),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${context.t.common.total_amount.toTitleCase()}:', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(totalAmount, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
