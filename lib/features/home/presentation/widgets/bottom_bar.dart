import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawtastic/features/cart/presentation/pages/cart_page.dart';
import 'package:pawtastic/features/home/presentation/pages/home_page.dart';
import 'package:pawtastic/features/my_orders/presentation/pages/my_orders_page.dart';
import 'package:pawtastic/features/search/presentation/pages/search_page.dart';
import 'package:pawtastic/features/account/presentation/pages/account_page.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

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
    currentIndex = widget.initialIndex;  // Set the initial index based on the passed parameter
  }

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,    // agar bottom bar tidak ke atas ketika keyboard muncul
      backgroundColor: Colors.white.withAlpha(55),
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex, // Change this based on the selected index
            children: [
              const HomePage(),       // index = 0
              const CartPage(),
              const MyOrdersPage(),
              const AccountPage(),
              const SearchPage(),     // index = 4
            ],
          ),
          
          // The bottom navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 70,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width, 70),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.8,
                    child: FloatingActionButton(
                      backgroundColor: currentIndex == 4 ? const Color.fromRGBO(252, 147, 3, 1.0) : Colors.white,
                      elevation: 0.1,
                      // shape: TopHalfCircleBorder(strokeWidth: 1.5, outlineColor: Color.fromRGBO(252, 147, 3, 1.0)), // Use custom ,
                      shape: const CircleBorder(
                        side: BorderSide(
                          color: Color.fromRGBO(252, 147, 3, 1.0), // Set the border color
                          width: 2.0, // Set the border width
                        ),
                      ),
                      onPressed: () {
                        setBottomBarIndex(4);
                      },
                      // child: Icon(Icons.search_rounded),
                      child: SvgPicture.asset(
                        'assets/icon/search-svgrepo-bold-com.svg',
                        height: 26.0, 
                        width: 26.0,  
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // HomePage icon with text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.home,
                                color: currentIndex == 0 ? const Color.fromRGBO(252, 147, 3, 1.0) : Colors.black,
                              ),
                              onPressed: () {
                                setBottomBarIndex(0);
                              },
                              splashColor: Colors.white,
                            ),
                            Text(
                              context.t.navigation.home.toTitleCase(),
                              style: TextStyle(
                                color: currentIndex == 0 ? const Color.fromRGBO(252, 147, 3, 1.0) : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        // Cart icon with text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: currentIndex == 1 ? const Color.fromRGBO(252, 147, 3, 1.0) : Colors.black,
                              ),
                              onPressed: () {
                                setBottomBarIndex(1);
                              },
                            ),
                            Text(
                              context.t.navigation.cart.toTitleCase(),
                              style: TextStyle(
                                color: currentIndex == 1 ? const Color.fromRGBO(252, 147, 3, 1.0) : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        // Empty space between icons
                        Container(
                          width: size.width * 0.20,
                        ),
                        // Bag icon with text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.shopping_bag_rounded,
                                color: currentIndex == 2 ? const Color.fromRGBO(252, 147, 3, 1.0) : Colors.black,
                              ),
                              onPressed: () {
                                setBottomBarIndex(2);
                              },
                            ),
                            Text(
                              context.t.navigation.my_orders.toTitleCase(),
                              style: TextStyle(
                                color: currentIndex == 2 ? const Color.fromRGBO(252, 147, 3, 1.0) : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        // Profile icon with text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.person,
                                color: currentIndex == 3 ? const Color.fromRGBO(252, 147, 3, 1.0) : Colors.black,
                              ),
                              onPressed: () {
                                setBottomBarIndex(3);
                              },
                            ),
                            Text(
                              context.t.navigation.account.toTitleCase(),
                              style: TextStyle(
                                color: currentIndex == 3 ? const Color.fromRGBO(252, 147, 3, 1.0) : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white // Fill color
      ..style = PaintingStyle.fill;

    Paint outlinePaint = Paint()
      ..color = const Color.fromRGBO(252, 147, 3, 1.0) // Outline color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5; // Outline width

    Path path = Path();
    path.moveTo(0.2, 0); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);

    // Draw the shadow
    canvas.drawShadow(path, Colors.black, 5, true);
    // Draw the filled path
    canvas.drawPath(path, paint);
    // Draw the outline
    canvas.drawPath(path, outlinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
