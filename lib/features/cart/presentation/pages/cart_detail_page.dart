import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawtastic/features/my_orders/presentation/pages/checkout_page.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class CartDetailPage extends StatefulWidget {
  final Map<String, dynamic> cartItemData;  // Add cartItemData as a parameter

  const CartDetailPage({Key? key, required this.cartItemData}) : super(key: key);

  @override
  _CartDetailPageState createState() => _CartDetailPageState();
}

class _CartDetailPageState extends State<CartDetailPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Function to delete a cart item
  Future<void> deleteCartItem(String cartItemId) async {
    try {
      await firestore
          .collection('users')
          .doc(user?.uid)
          .collection('cart')
          .doc(cartItemId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.cart.item_removed_from_cart.ucfirst())),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.cart.error_deleting_item(error: e.toString()).ucfirst())),
      );
    }
  }

  // Function to proceed with checkout for the selected cart item
  void checkout() {
    // Handle your checkout logic here (e.g., navigate to a checkout page)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.t.cart.proceeding_with_checkout.ucfirst())),
    );
  }

  // Function to retrieve the user's address from the 'addresses' subcollection
  Future<String> getUserAddress() async {
    try {
      // Retrieve the first address from the 'addresses' subcollection
      var addressSnapshot = await firestore
          .collection('users')
          .doc(user?.uid)
          .collection('addresses')
          .limit(1) // Assuming we want to get the first address
          .get();

      if (addressSnapshot.docs.isNotEmpty) {
        return addressSnapshot.docs.first['address']; // Assuming 'address' field exists
      } else {
        return context.t.cart.address_not_found.ucfirst();  // Default if no address is found
      }
    } catch (e) {
      return context.t.cart.error_retrieving_address.ucfirst();
    }
  }

  // Function to retrieve the seller's name from the 'seller' collection
  Future<String> getSellerName(String sellerId) async {
    try {
      var sellerDoc = await firestore.collection('seller').doc(sellerId).get();
      if (sellerDoc.exists) {
        return sellerDoc['shop_name'];  // Assuming 'shop_name' is a field in the 'seller' document
      } else {
        return context.t.cart.seller_not_found.ucfirst();
      }
    } catch (e) {
      return context.t.cart.error_retrieving_seller_name.ucfirst();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.t.cart.my_cart.toTitleCase())),
        body: Center(child: Text(context.t.cart.please_log_in_to_view_your_cart.ucfirst())),
      );
    }

    var cartItemData = widget.cartItemData;  // Get the passed cart item data
    String cartItemId = cartItemData['productId']; // Assuming 'productId' is unique
    int quantity = cartItemData['quantity'];
    double price = cartItemData['price'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(context.t.cart.cart_details.toTitleCase()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                leading: Image.asset(
                  cartItemData['productImage'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(cartItemData['productName']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Order date: ${DateFormat('dd-MM-yyyy').format(cartItemData['timestamp'].toDate())}'),
                    Text('${context.t.common.price.ucfirst()}: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(price)}'),
                    Text('${context.t.common.quantity.ucfirst()}: $quantity'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.highlight_remove, color: Colors.red),
                  onPressed: () {
                    deleteCartItem(cartItemId); // Delete the item
                  },
                ),
              ),
            ),

            // Total Price for this selected item
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                '${context.t.cart.total_price.toTitleCase()}: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(price * quantity)}',
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),

            // Inside CartPage
            ElevatedButton(
              onPressed: () async {
                String userAddress = await getUserAddress(); // Fetch user address
                String sellerName = await getSellerName(cartItemData['sellerId']); // Fetch seller name

                // Navigate to CheckoutPage with cart items and total price
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(
                      totalPrice: price * quantity,  // Total price from cart
                      cartItems: [
                        {
                          'productId': cartItemData['productId'],
                          'productName': cartItemData['productName'],
                          'productImage': cartItemData['productImage'],
                          'quantity': cartItemData['quantity'],
                          'price': cartItemData['price'],
                          'sellerId': cartItemData['sellerId'],
                        }
                      ],  // Only passing the current cart item here
                      userAddress: userAddress,  // Pass the retrieved user address here
                      sellerName: sellerName,
                    ),
                  ),
                );
              },
              child: Text(context.t.cart.proceed_to_checkout.toTitleCase()),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
