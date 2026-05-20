import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawtastic/features/cart/presentation/pages/cart_page.dart';
import 'package:pawtastic/features/home/presentation/pages/home_page.dart';
import 'package:pawtastic/features/my_orders/presentation/pages/my_orders_page.dart';
import 'package:pawtastic/features/search/presentation/pages/search_page.dart';
import 'package:pawtastic/features/account/presentation/pages/account_page.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/shared/widgets/bottom_bar/bottom_nav_bar_painter.dart';

import 'package:pawtastic/services/bottom_bar_provider.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  final int initialIndex; 
  const BottomBar({super.key, this.initialIndex = 0});  // Default to Home page

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
    // Jika ganti tab, pastikan bar muncul
    context.read<BottomBarProvider>().setVisible(true);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bottomBarProvider = context.watch<BottomBarProvider>();
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    
    // Hitung jarak geser agar benar-benar hilang dari layar
    // 70 (tinggi bar) + bottomPadding (area navigasi android) + sedikit buffer
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
              const AccountPage(),
              const SearchPage(),
            ],
          ),
          
          // The bottom navigation bar with Animation
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            bottom: currentBottom, 
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 70 + bottomPadding, // Ukuran total termasuk area bawah
              child: Stack(
                clipBehavior: Clip.none, 
                children: [
                  // Background bar dengan SafeArea internal
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
                  
                  // Icons Row dengan SafeArea internal
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
                            _buildNavItem(0, Icons.home, context.t.navigation.home.toTitleCase()),
                            _buildNavItem(1, Icons.shopping_cart, context.t.navigation.cart.toTitleCase()),
                            Container(width: size.width * 0.20), // Space for FAB
                            _buildNavItem(2, Icons.shopping_bag_rounded, context.t.navigation.my_orders.toTitleCase()),
                            _buildNavItem(3, Icons.person, context.t.navigation.account.toTitleCase()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // FloatingActionButton (Search) - Diluar AnimatedPositioned Nav Bar 
          // agar posisinya bisa kita kontrol secara independen (Tetap muncul)
          Positioned(
            bottom: bottomPadding + 20, // Posisi ideal FAB agar pas di lengkungan
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
              onPressed: () {
                setBottomBarIndex(4);
              },
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
          style: TextStyle(color: color, fontSize: 12),
        ),
      ],
    );
  }
}