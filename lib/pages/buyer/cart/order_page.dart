import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;  // List of cart items
  final double totalPrice;  // Total price of cart items
  final String userAddress;  // User address for the order
  final String sellerName;

  const OrderPage({
    Key? key,
    required this.cartItems,
    required this.totalPrice,
    required this.userAddress,
    required this.sellerName,
  }) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  // Function to generate a unique order number (can be timestamp or custom format)
  String generateOrderNumber() {
    return 'Ord-№${DateTime.now().millisecondsSinceEpoch}';
  }

  // Function to handle checkout
  // void checkout() {
  //   // Handle your checkout logic here (e.g., save to Firestore)
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Proceeding with checkout...')),
  //   );
  // }

  // Function to handle checkout and save order details to Firestore
  void checkout() async {
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to place an order.')),
      );
      return;
    }

    try {
      // Generate a new order number
      String orderNumber = generateOrderNumber();

      // Prepare order data
      List<Map<String, dynamic>> orderItems = widget.cartItems.map((item) {
        return {
          'productId': item['productId'],
          'productName': item['productName'],
          'productImage': item['productImage'],
          'quantity': item['quantity'],
          'price': item['price'],
          'sellerId': item['sellerId'],
        };
      }).toList();

      // Store order details in the 'orders' subcollection of the user
      await firestore.collection('users').doc(user?.uid).collection('orders').add({
        'order_no': orderNumber,
        'items': orderItems,
        'totalPrice': widget.totalPrice,
        'createdAt': Timestamp.now(),
        'userAddress': widget.userAddress,
        'sellerName': widget.sellerName,
        'payment_method': "Cash on Delivery",
        'status': "Processing",
      });

      // Remove the ordered items from the cart
      for (var item in widget.cartItems) {
        await firestore
            .collection('users')
            .doc(user?.uid)
            .collection('cart')
            .doc(item['productId'])
            .delete();
      }

      // Update the product stock in the 'products' collection
      for (var item in widget.cartItems) {
        var productRef = firestore.collection('products').doc(item['productId']);
        var productSnapshot = await productRef.get();

        if (productSnapshot.exists) {
          var productData = productSnapshot.data();
          int currentStock = productData?['stock'] ?? 0;
          int purchasedQuantity = item['quantity'];

          // Decrease stock by the purchased quantity
          if (currentStock >= purchasedQuantity) {
            await productRef.update({
              'stock': currentStock - purchasedQuantity,
              'product_sold': currentStock + purchasedQuantity,
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Not enough stock available.')),
            );
            return;
          }
        }
      }

      // Show success message and navigate back to the home page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully!')),
      );

      // After successful order, redirect to the home page
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error placing order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Order Summary")),
        body: Center(child: const Text("Please log in to proceed.")),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 250),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Order Summary"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Order From: ${widget.sellerName}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ),
            
            // Order Card
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text('Order Number: ${generateOrderNumber()}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Price: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(widget.totalPrice)}'),
                    const SizedBox(height: 10),
                    Text('Shipping Address: ${widget.userAddress}'),
                  ],
                ),
              ),
            ),


            // Display Cart Items
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Cart Items:',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),

            // Cart Item List
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                var item = widget.cartItems[index];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    leading: Image.asset(
                      item['productImage'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['productName']),
                    subtitle: Text('Qty: ${item['quantity']} - Price: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(item['price'])}\n'),
                  ),
                );
              },
            ),

            // Total Price Display
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Total Price: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(widget.totalPrice)}',
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),

            // Proceed to Checkout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: ElevatedButton(
                onPressed: checkout,
                child: const Text('Buy Now'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
