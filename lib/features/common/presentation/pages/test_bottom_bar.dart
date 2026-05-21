import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawtastic/features/home/presentation/pages/home_page.dart';
import 'package:pawtastic/features/cart/presentation/pages/cart_page.dart';
import 'package:pawtastic/features/my_orders/presentation/pages/my_orders_page.dart';
import 'package:pawtastic/features/search/presentation/pages/search_page.dart';
import 'package:pawtastic/shared/widgets/bottom_bar/bottom_nav_bar_painter.dart';
import 'package:pawtastic/services/bottom_bar_provider.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:provider/provider.dart';

class TestBottomBar extends StatefulWidget {
  const TestBottomBar({super.key});

  @override
  State<TestBottomBar> createState() => _TestBottomBarState();
}

class _TestBottomBarState extends State<TestBottomBar> {
  int currentIndex = 0;

  void setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
    context.read<BottomBarProvider>().setVisible(true);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bottomBarProvider = context.watch<BottomBarProvider>();
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final double hideOffset = 70 + bottomPadding + 20;
    final double currentBottom = bottomBarProvider.isVisible ? 0 : -hideOffset;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white.withAlpha(55),
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex,
            children: [
              const HomePage(),
              const CartPage(),
              const MyOrdersPage(),
              // Tab Account Khusus: Halaman Kosong dengan Tombol "Hapus Session"
              _buildAccountTestPage(context),
              const SearchPage(),
            ],
          ),
          
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            bottom: currentBottom, 
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 70 + bottomPadding,
              child: Stack(
                clipBehavior: Clip.none, 
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: SafeArea(
                      bottom: true,
                      child: CustomPaint(
                        size: Size(size.width, 70),
                        painter: BottomNavBarPainter(),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: SafeArea(
                      bottom: true,
                      child: SizedBox(
                        width: size.width,
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNavItem(0, Icons.home, "Home"),
                            _buildNavItem(1, Icons.shopping_cart, "Cart"),
                            Container(width: size.width * 0.20),
                            _buildNavItem(2, Icons.shopping_bag, "Orders"),
                            _buildNavItem(3, Icons.bug_report, "Clear Ses"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: bottomPadding + 20,
            left: (size.width / 2) - 28,
            child: FloatingActionButton(
              backgroundColor: currentIndex == 4 ? const Color.fromRGBO(252, 147, 3, 1.0) : Colors.white,
              elevation: 4.0,
              shape: const CircleBorder(
                side: BorderSide(
                  color: Color.fromRGBO(252, 147, 3, 1.0),
                  width: 2.0,
                ),
              ),
              onPressed: () => setBottomBarIndex(4),
              child: SvgPicture.asset(
                'assets/icon/search-svgrepo-bold-com.svg',
                height: 26.0, 
                width: 26.0,  
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountTestPage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning_amber_rounded, size: 80, color: Colors.red),
          const SizedBox(height: 20),
          const Text(
            "TEST MODE: HAPUS SESSION",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Text(
              "Menekan tombol di bawah akan menghapus session secara paksa tanpa pindah rute. Lihat reaksinya!",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              // Paksa logout via UserProvider
              context.read<UserProvider>().logout();
            },
            child: const Text("HAPUS SESSION SEKARANG"),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final color = currentIndex == index ? const Color.fromRGBO(252, 147, 3, 1.0) : Colors.black;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: color),
          onPressed: () => setBottomBarIndex(index),
        ),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 10),
        ),
      ],
    );
  }
}
