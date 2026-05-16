import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(55),
      body: Stack(
        children: [
          // The main content of the body based on the currentIndex
          IndexedStack(
            index: currentIndex, // Change this based on the selected index
            children: [
              Center(child: Text("Home Page")),
              Center(child: Text("Cart Page")),
              Center(child: Text("Bag Page")),
              Center(child: Text("Settings Page")),
              // Add the Search Page here in the IndexedStack
              Center(child: Text("Search Page")), // This is the page for FAB
            ],
          ),
          
          // The bottom navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.8,
                    child: FloatingActionButton(
                      backgroundColor: currentIndex == 4 ? Colors.orange : Colors.white,
                      elevation: 0.1,
                      shape: CircleBorder(),
                      onPressed: () {
                        setBottomBarIndex(4); // Set the index for the Search page
                      }, // Change color based on currentIndex
                      child: Icon(Icons.search_rounded),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Home icon with text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.home,
                                color: currentIndex == 0 ? Colors.orange : Colors.grey.shade700,
                              ),
                              onPressed: () {
                                setBottomBarIndex(0);
                              },
                              splashColor: Colors.white,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: currentIndex == 0 ? Colors.orange : Colors.grey.shade700,
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
                                color: currentIndex == 1 ? Colors.orange : Colors.grey.shade700,
                              ),
                              onPressed: () {
                                setBottomBarIndex(1);
                              },
                            ),
                            Text(
                              'Cart',
                              style: TextStyle(
                                color: currentIndex == 1 ? Colors.orange : Colors.grey.shade700,
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
                                color: currentIndex == 2 ? Colors.orange : Colors.grey.shade700,
                              ),
                              onPressed: () {
                                setBottomBarIndex(2);
                              },
                            ),
                            Text(
                              'Bag',
                              style: TextStyle(
                                color: currentIndex == 2 ? Colors.orange : Colors.grey.shade700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        // Settings icon with text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.settings,
                                color: currentIndex == 3 ? Colors.orange : Colors.grey.shade700,
                              ),
                              onPressed: () {
                                setBottomBarIndex(3);
                              },
                            ),
                            Text(
                              'Settings',
                              style: TextStyle(
                                color: currentIndex == 3 ? Colors.orange : Colors.grey.shade700,
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
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 10); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 10);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

//  return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 255, 250, 250),
//         elevation: 0, // Removes shadow under the AppBar
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context); // Go back to the previous screen
//           },
//         ),
//       ),
//       body: SafeArea(     //Membuat agar tidak tabrakan dengan status/notification bar
//         child: Container(
//           margin: EdgeInsets.only(top: 30, left: 10.0),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "This UI avoids the status bar without an AppBar.",
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/welcome');
//                 },
//                 child: const Text("Back"),
//               ),
//             ],
//           ),
//         )
       
      
//       ),
//     );