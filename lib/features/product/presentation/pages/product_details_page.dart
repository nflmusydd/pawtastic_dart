import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawtastic/features/product/presentation/pages/seller_product_list_page.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final Map<String, dynamic> seller;

  const ProductDetailsPage({
    required this.product,
    required this.seller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure categories is a list (in case it's a single string)
    List<dynamic> categories = product["category"] is List
        ? product["category"]
        : [product["category"]];

    return Scaffold(
      appBar: CustomAppBar.actionOnly(
        context,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Handle SearchPage action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: Image.asset(
                  product["productImage"],
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),

              // Product Name
              Text(
                product["productName"],
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Price and Product Sold + Stock in a row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(product["price"]),
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: const Color.fromRGBO(252, 147, 3, 1.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${context.t.product.details.sold.toTitleCase()}: ${product["productSold"]}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Text(
                        '${context.t.product.details.stock.toTitleCase()}: ${product["stock"]}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // "For:" label and category box
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${context.t.product.details.kFor.toTitleCase()}: ",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: List.generate(
                      categories.length,
                      (index) => GestureDetector(
                        onTap: () {
                          // Handle category click if needed
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          child: Text(
                            categories[index],  // Display the category
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(252, 147, 3, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Description
              Text(
                context.t.product.details.description.toTitleCase(), 
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Text(
                product["description"],  // Content in normal font weight
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.0,
                ),
              ),

              // Grey Divider Line
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 8.0),

              // Seller Info
              Text(
                context.t.product.details.seller.toTitleCase(), 
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellerProductListPage(
                            seller: seller,
                            sellerId: product["sellerId"], 
                          )
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${seller["shop_name"]}",
                                  style: const TextStyle(
                                    color: const Color.fromRGBO(252, 147, 3, 1.0),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold, 
                                  ),
                                ),
                                SizedBox(
                                  width: 300.0,
                                  child: Text(
                                    "${seller["shop_address"]}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: const Color.fromRGBO(252, 147, 3, 1.0),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Divider(color: Colors.grey.shade300),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddToCartWithQuantity(
          product: product,
          seller: seller,
        ),
      ),
    );
  }
}

class AddToCartWithQuantity extends StatefulWidget {
  final Map<String, dynamic> product;
  final Map<String, dynamic> seller;

  const AddToCartWithQuantity({
    super.key,
    required this.product,
    required this.seller
  });

  @override
  _AddToCartWithQuantityState createState() => _AddToCartWithQuantityState();
}

class _AddToCartWithQuantityState extends State<AddToCartWithQuantity> {
  int quantity = 0;

  void increaseQuantity() {
    if (quantity < widget.product["stock"]) {
      setState(() {
        quantity++;
      });
    }
  }

  void decreaseQuantity() {
    setState(() {
      if (quantity > 0) {
        quantity--;
      }
    });
  }

  Future<void> addToCart() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.product.details.please_log_in_to_add_to_cart.ucfirst())),
      );
      return;
    }

    String userId = user.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference cartRef = firestore.collection('users').doc(userId).collection('cart');

    double price = (widget.product['price'] is int)
        ? (widget.product['price'] as int).toDouble()
        : widget.product['price'] as double;

    QuerySnapshot existingCart = await cartRef.where('productId', isEqualTo: widget.product['productId']).get();

    if (existingCart.docs.isEmpty) {
      await cartRef.add({
        'productId': widget.product['productId'],
        'productName': widget.product["productName"],
        'productImage': widget.product["productImage"],
        'price': price,
        'quantity': quantity,
        'sellerId': widget.product["sellerId"],
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.t.product.details.added_to_cart_successfully.ucfirst())),
        );
      }
    } else {
      String cartItemId = existingCart.docs.first.id;
      await cartRef.doc(cartItemId).update({
        'quantity': FieldValue.increment(quantity)
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.t.product.details.quantity_updated_in_cart.ucfirst())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: decreaseQuantity,
          color: Colors.orange,
        ),
        Text(
          '$quantity',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: increaseQuantity,
          color: Colors.orange,
        ),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromRGBO(252, 147, 3, 1.0),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              if (quantity > 0) {
                addToCart();
              }
            },
          ),
        ),
      ],
    );
  }
}
