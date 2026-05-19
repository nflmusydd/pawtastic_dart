import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/shared/widgets/custom_app_bar.dart';
import 'package:pawtastic/shared/widgets/primary_button.dart';
import 'package:pawtastic/shared/widgets/global_order_card.dart';
import 'package:pawtastic/models/order_model.dart' as model;
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;  // List of cart items
  final double totalPrice;  // Total price of cart items
  final String userAddress;  // User address for the order
  final String sellerName;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    required this.totalPrice,
    required this.userAddress,
    required this.sellerName,
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  // Function to generate a unique order number (can be timestamp or custom format)
  String generateOrderNumber() {
    return 'Ord-№${DateTime.now().millisecondsSinceEpoch}';
  }

  // Function to handle checkout and save order details to Firestore
  void checkout() async {
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.my_orders.checkout.please_log_in_to_place_an_order.ucfirst())),
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
              SnackBar(content: Text(context.t.my_orders.checkout.not_enough_stock_available.ucfirst())),
            );
            return;
          }
        }
      }

      // Show success message and navigate back to the HomePage page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.my_orders.checkout.order_placed_successfully.ucfirst())),
      );

      // After successful order, redirect to the HomePage page
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.my_orders.checkout.error_placing_order(error: e.toString()).ucfirst())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: CustomAppBar.leftTitle(
          context,
          title: context.t.my_orders.checkout.order_summary.toTitleCase(),
        ),
        body: Center(child: Text(context.t.my_orders.checkout.please_log_in_to_proceed.ucfirst())),
      );
    }

    return Scaffold(
      appBar: CustomAppBar.leftTitle(
        context,
        title: context.t.my_orders.checkout.order_summary.toTitleCase(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlobalOrderCard(
                order: model.Order(
                  orderId: 'TBA',
                  shop: widget.sellerName,
                  shippingAddress: widget.userAddress,
                  totalPrice: widget.totalPrice.toInt(),
                  orderDate: DateFormat('dd MMM yyyy').format(DateTime.now()),
                  paymentMethod: "Cash on Delivery",
                  status: 'processing',
                  detailStatus: context.t.my_orders.checkout.order_summary.toTitleCase(),
                ),
              ),
            ),


            // Display Cart Items
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${context.t.my_orders.checkout.cart_items.toTitleCase()}:',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
                    subtitle: Text('${context.t.my_orders.checkout.qty.toTitleCase()}: ${item['quantity']} - ${context.t.common.price.toTitleCase()}: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(item['price'])}\n'),
                  ),
                );
              },
            ),

            // Total Price Display
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                '${context.t.my_orders.checkout.total_price.toTitleCase()}: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(widget.totalPrice)}',
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),

            // Proceed to Checkout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: PrimaryButton(
                label: context.t.common.buy_now.toTitleCase(),
                onPressed: checkout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
