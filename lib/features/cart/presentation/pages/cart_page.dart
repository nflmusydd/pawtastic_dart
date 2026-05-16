import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawtastic/shared/utils/snackbar_utils.dart';
import 'package:pawtastic/features/cart/presentation/pages/cart_detail_page.dart';
// import 'package:pawtastic/features/my_orders/presentation/pages/checkout_page.dart';
import 'package:pawtastic/features/home/presentation/widgets/bottom_bar.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> deleteCartItem(String cartItemId) async {
    try {
      await firestore
          .collection('users')
          .doc(user?.uid)
          .collection('cart')
          .doc(cartItemId)
          .delete();
      if (mounted) {
        SnackBarUtils.show(context, context.t.cart.item_removed_from_cart.ucfirst(), type: SnackBarType.success);
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.show(context, context.t.cart.failed_to_remove_item_please_try_again.ucfirst(), type: SnackBarType.error);
      }
    }
  }

  // Handle individual item checkout
  void checkoutItem(Map<String, dynamic> cartItemData) {
    // Trigger your checkout logic here for the specific item
    // You could navigate to a Checkout Page with this data, for example:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CheckoutPage(cartItem: cartItemData),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.t.cart.cart.toTitleCase())), 
        body: Center(child: Text(context.t.cart.please_log_in_to_view_your_cart.ucfirst())),
      );
    }

    CollectionReference cartRef =
        firestore.collection('users').doc(user?.uid).collection('cart');

    return Scaffold(
      appBar: AppBar(
       automaticallyImplyLeading: false,
       backgroundColor: Colors.white,
       title: Padding(
          padding: const EdgeInsets.only(top: 10.0),  // Add margin for the title
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Ensure the column only takes as much space as needed
            children: [
              // Title Widget
              Center(
                child: Text(
                  context.t.cart.my_cart.toTitleCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,  
                  ),
                ),
              ),
              // Add a SizedBox after the title
              // const SizedBox(height: 20.0),  // Space between title and the TabBar
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: cartRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(context.t.cart.failed_to_load_cart_please_check_your_connection.ucfirst()));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text(context.t.cart.your_cart_empty.ucfirst()));
          }

          var cartItems = snapshot.data!.docs;

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              var cartItem = cartItems[index];
              var cartItemData = cartItem.data() as Map<String, dynamic>;
              String cartItemId = cartItem.id;
              int quantity = cartItemData['quantity'];
              double price = cartItemData['price'];

              return Card(
                color: Colors.white,
                elevation: 3.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Stack(
                  children: [
                    // The actual content of the card
                    ListTile(
                      leading: Image.asset(
                        cartItemData['productImage'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        cartItemData['productName'],
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('Quantity: $quantity'),
                          Text('${context.t.common.price.ucfirst()}:\n${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(price * quantity)}'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartDetailPage(cartItemData: cartItemData)
                          ),
                        );
                      },
                      trailing: SizedBox(
                        width: 150,  // Set a width constraint to avoid overflow
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => checkoutItem(cartItemData),
                              child: Text(context.t.common.checkout.toTitleCase()),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // The delete icon positioned at the top-right corner
                    Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: IconButton(
                        icon: const Icon(Icons.highlight_remove, color: Colors.red),
                        onPressed: () {
                          deleteCartItem(cartItemId); // Delete the item from cart
                        },
                      ),
                    ),
                  ],
                ),
              );

            },
          );
        },
      ),
    );
  }
}



class ToCartPage extends StatelessWidget {
  const ToCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBar(initialIndex: 1);
  }
}
