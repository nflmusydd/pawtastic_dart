import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';
import 'package:pawtastic/shared/widgets/custom_text_button.dart';

class HomeSellerPage extends StatelessWidget {
  const HomeSellerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.store, color: Colors.orange),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.orange),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        title: const Text(
          "Meow Pet Shop",
          style: TextStyle(
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

              // Sign Out Button
              CustomTextButton(
                text: context.t.seller.home.sign_out.toTitleCase(),
                onPressed: () async {
                  // await userProvider.logout();
                  // if (context.mounted) {
                  //   Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                  // }
                  Navigator.pushNamed(context, AppRoutes.home);
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 248, 248),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(2, 2),
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
      ),
    );
  }
}
