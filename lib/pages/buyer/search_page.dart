import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pawtastic/pages/buyer/product/product_details.dart';
import 'package:pawtastic/pages/buyer/bottom_bar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = ""; // Holds the search keyword

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90, top: 25),
            child: Column(
              children: [
                // Search Bar with Chatbot Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(248,247,247, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                _searchKeyword = value.toLowerCase(); // Update keyword dynamically
                              });
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search_rounded),
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(152, 152, 152, 1),
                                ),
                                // Add contentPadding to move the hint text lower
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // Adjust vertical padding
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Chatbot Button
                     Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(248,247,247, 1), // Background color
                          borderRadius: BorderRadius.circular(30.0), // Rounded corners
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/chatbot'); // Handle navigation
                          },
                          icon: Image.asset(
                            'images/gemini.png', // Replace with your image path
                            width: 30, // Set appropriate width
                            height: 30, // Set appropriate height
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('products').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No products available"));
                    }

                    // Map product data from Firestore
                    var products = snapshot.data!.docs.map((doc) {
                      return {
                        "productId": doc.id,
                        "productName": doc['product_name'],
                        "productImage": doc['image_url'],
                        "description": doc['description'],
                        "category": doc['categories'],
                        "price": doc['price'],
                        "stock": doc['stock'],
                        "productSold": doc['product_sold'],
                        "sellerId": doc['seller_id']
                      };
                    }).toList();

                    // Filter products based on search keyword
                    var filteredProducts = products.where((product) {
                      return product['productName']
                          .toLowerCase()
                          .contains(_searchKeyword); // Filter by name
                    }).toList();

                    if (filteredProducts.isEmpty) {
                      return const Center(child: Text("No products match your search"));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];

                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('seller')
                              .doc(product['sellerId'])
                              .get(),
                          builder: (context, sellerSnapshot) {
                            if (sellerSnapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            if (!sellerSnapshot.hasData || !sellerSnapshot.data!.exists) {
                              return const Text("Seller not found");
                            }

                            final seller = sellerSnapshot.data!.data() as Map<String, dynamic>;

                            // Check if the image URL is a local asset or network URL
                            bool isNetworkImage = Uri.tryParse(product["productImage"])?.hasScheme == 'http';

                            return GestureDetector(
                              onTap: () {
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
                                margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
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
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: isNetworkImage
                                          ? Image.network(
                                              product["productImage"],
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              product["productImage"],
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    const SizedBox(width: 12.0),
                                    Expanded(
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
                                          const SizedBox(height: 3.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class toSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Bottombar(initialIndex: 4);
  }
}

