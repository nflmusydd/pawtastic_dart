import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawtastic/features/product/presentation/pages/product_details_page.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class ProductCategoryPage extends StatelessWidget {
  final String categoryName;
  final List<Map<String, dynamic>> products;

  const ProductCategoryPage({
    super.key,
    required this.categoryName,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        toolbarHeight: 75,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.t.home.product_category.product_category.toTitleCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0,
                  ),
                ),
                Text(
                  categoryName,
                  style: const TextStyle(
                    color: Color.fromRGBO(252, 147, 3, 1.0),
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: products.isNotEmpty
          ? GridView.builder(
              padding: const EdgeInsets.all(14.0),
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
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!sellerSnapshot.hasData || !sellerSnapshot.data!.exists) {
                      return Center(child: Text(context.t.home.index.seller_not_found.ucfirst()));
                    }

                    // Seller data
                    var seller = sellerSnapshot.data!.data() as Map<String, dynamic>;

                    return GestureDetector(
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
                      child: ProductCard(
                        product: product,
                        seller: seller,
                      ),
                    );
                  },
                );
              },
            )
          : Center(
              child: Text(context.t.home.product_category.no_products_found_for_this_category.ucfirst()),
            ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final Map<String, dynamic> seller;

  const ProductCard({
    super.key, 
    required this.product,
    required this.seller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(product["price"]),
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
    );
  }
}
