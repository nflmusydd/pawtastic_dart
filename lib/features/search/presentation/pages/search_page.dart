import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/features/product/presentation/pages/product_details_page.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/auth/auth_guard.dart';
import 'package:pawtastic/core/utils/core_utils.dart';

import 'package:pawtastic/services/bottom_bar_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = ""; // Holds the SearchPage keyword
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (context.read<BottomBarProvider>().isVisible) {
        context.read<BottomBarProvider>().setVisible(false);
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!context.read<BottomBarProvider>().isVisible) {
        context.read<BottomBarProvider>().setVisible(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthGuard(
      allowGuest: true,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 90, top: 25),
              child: Column(
                children: [
                  // SearchPage Bar with Chatbot Button
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
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: context.t.common.search.toTitleCase(),
                                  prefixIcon: const Icon(Icons.search_rounded),
                                  hintStyle: const TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(152, 152, 152, 1),
                                  ),
                                  // Add contentPadding to move the hint text lower
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // Adjust vertical padding
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
                              Navigator.pushNamed(context, AppRoutes.chatbot); // Handle navigation
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
                        return GlobalLoading.centered();
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text(context.t.search.no_products_available.ucfirst()));
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

                      // Filter products based on SearchPage keyword
                      var filteredProducts = products.where((product) {
                        return product['productName']
                            .toLowerCase()
                            .contains(_searchKeyword); // Filter by name
                      }).toList();

                      if (filteredProducts.isEmpty) {
                        return Center(child: Text(context.t.search.no_products_match_your_search.ucfirst()));
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
                                return GlobalLoading.centered();
                              }

                              if (!sellerSnapshot.hasData || !sellerSnapshot.data!.exists) {
                                return Text(context.t.search.seller_not_found.ucfirst());
                              }

                              final seller = sellerSnapshot.data!.data() as Map<String, dynamic>;

                              return GlobalProductCard(
                                productName: product["productName"],
                                productImage: product["productImage"],
                                price: product["price"].toDouble(),
                                shopName: seller["shop_name"],
                                isGrid: false,
                                margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                        product: product,
                                        seller: seller,
                                      ),
                                    ),
                                  );
                                },
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
      ),
    );
  }
}

class ToSearchPage extends StatelessWidget {
  const ToSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBar(initialIndex: 4);
  }
}
