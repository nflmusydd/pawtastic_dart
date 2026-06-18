import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:provider/provider.dart';

class SellerHomePage extends StatelessWidget {
  const SellerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final shopName = userProvider.shopName.isNotEmpty 
        ? userProvider.shopName 
        : "Paw Shop";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.orange),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.sellerSettings);
            },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.store, color: Colors.orange),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.sellerProfiles);
            },
          ),
        ],
        centerTitle: true,
        title: Text(
          shopName,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Add Product Button
              _buildMenuButton(
                context,
                icon: Icons.add,
                label: context.t.seller.home.add_product.toTitleCase(),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.addProduct);
                },
              ),
              const SizedBox(height: 16),

              // Manage Products Button
              _buildMenuButton(
                context,
                icon: Icons.inventory,
                label: context.t.seller.home.manage_products.toTitleCase(),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.manageProduct);
                },
              ),
              const SizedBox(height: 16),

              // Manage Orders Button
              _buildMenuButton(
                context,
                icon: Icons.shopping_bag,
                label: context.t.seller.home.manage_orders.toTitleCase(),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.manageOrder);
                },
              ),
              const SizedBox(height: 16),

              // CashierPage Button
              _buildMenuButton(
                context,
                icon: Icons.point_of_sale,
                label: context.t.seller.home.cashier.toTitleCase(),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.cashier);
                },
              ),
              const SizedBox(height: 80),

              // To Buyer Mode Button
              CustomTextButton(
                text: context.t.seller.home.to_buyer_mode.toTitleCase(),
                onPressed: () async {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
                },
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: const Color.fromRGBO(252, 147, 3, 1.0),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
