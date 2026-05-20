import 'package:flutter/material.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';

class EditProductPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const EditProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.leftTitle(
        context,
        title: context.t.seller_product.manage_product.edit_product.toTitleCase(),
      ),
      body: Center(
        child: Text(
          context.t.seller_product.manage_product.edit_details_for(name: product['name']).ucfirst(),
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
