import 'package:flutter/material.dart';

class HomeSeller extends StatelessWidget {
  const HomeSeller({Key? key}) : super(key: key);

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
                  label: "Add Product",
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/addproduct'); // Navigate to Add Product Page
                  },
                ),
                const SizedBox(height: 16),

                // Manage Products Button
                _buildMenuButton(
                  context,
                  icon: Icons.inventory,
                  label: "Manage Products",
                  onTap: () {
                    Navigator.pushNamed(context,
                        '/manageproduct'); // Navigate to Manage Products Page
                  },
                ),
                const SizedBox(height: 16),

                // Manage Orders Button
                _buildMenuButton(
                  context,
                  icon: Icons.shopping_bag,
                  label: "Manage Orders",
                  onTap: () {
                    Navigator.pushNamed(context,
                        '/manageorder'); // Navigate to Manage Orders Page
                  },
                ),
                const SizedBox(height: 16),

                // Cashier Button
                _buildMenuButton(
                  context,
                  icon: Icons.point_of_sale,
                  label: "Cashier",
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/cashier'); // Navigate to Cashier Page
                  },
                ),
                const SizedBox(
                    height: 80), // Beri jarak sebelum tulisan Sign Out

                // Sign Out Button
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/home'); // Sign out action
                  },
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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
