import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:intl/intl.dart';
import 'package:pawtastic/pages/buyer/product/product_details.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({super.key});

  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        toolbarHeight: 75, // AppBar height
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        titleSpacing: 0,
        flexibleSpace: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Most Popular',
                  style: TextStyle(
                    color: Color.fromRGBO(252, 147, 3, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "Product",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 250, 250),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 14.0, right: 14.0, bottom: 20.0, top: 10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('products').orderBy('product_sold', descending: true).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No products available"));
                      }

                var products = snapshot.data!.docs.map((doc) {
                  return {
                    "productName": doc['product_name'],
                    "productImage": doc['image_url'],
                    "description": doc['description'],
                    "category": doc['categories'],
                    "price": doc['price'],
                    "stock": doc['stock'],
                    "productSold": doc['product_sold'],
                    "sellerId": doc['seller_id'],
                  };
                }).toList();

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.74,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('seller')
                          .doc(product['sellerId']) // Use sellerId to get seller data
                          .get(),
                      builder: (context, sellerSnapshot) {
                        if (sellerSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!sellerSnapshot.hasData || !sellerSnapshot.data!.exists) {
                          return Center(child: Text("Seller not found"));
                        }

                    // Seller data
                    var seller = sellerSnapshot.data!.data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        // Navigate to details page, passing product data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              product: product,
                              seller: seller,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  product["productImage"],
                                  // "images/C-One_CONDITIONING_SHAMPOO_for_Pet_100ml.jpg",
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product["productName"],
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(product["price"])}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 3.0),
                                  Text(
                                    seller["shop_name"],
                                    style: const TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Montserrat",
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
