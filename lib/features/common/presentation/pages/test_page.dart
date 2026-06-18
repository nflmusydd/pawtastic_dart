import 'package:flutter/material.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';

import 'package:pawtastic/features/common/presentation/pages/test_bottom_bar.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.centerTitle(context, blackTitle: "Security Test Page"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Halaman ini digunakan untuk mengetes apakah AuthGuard bekerja.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            
            // Tombol 1: Nembak rute Seller (Harusnya tertahan AuthGuard)
            PrimaryButton(
              label: "Tembak Dashboard Seller (Named Route)",
              onPressed: () {
                // Ini memanggil rute yang sudah dibungkus AuthGuard di main.dart
                Navigator.pushNamed(context, AppRoutes.sellerHome);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Tombol 2: Nembak Cart (Harusnya tertahan AuthGuard)
            PrimaryButton(
              label: "Tembak My Orders (Named Route)",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.myOrders);
              },
            ),

            const SizedBox(height: 16),

            // Tombol 3: Skenario Bottom Bar & Logout Paksa
            PrimaryButton(
              label: "Uji Skenario Bottom Bar (Reaktivitas)",
              onPressed: () {
                // Kita panggil langsung WIDGET-nya agar bisa ngetes tembus atau tidak
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TestBottomBar()),
                );
              },
            ),
            
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              "Info: Jika BELUM login, klik tombol di atas harusnya membawa ke halaman 'Login Required', bukan ke halaman tujuan.",
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
