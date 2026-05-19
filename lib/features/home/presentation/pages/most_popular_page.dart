import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/features/product/presentation/pages/product_details_page.dart';
import 'package:pawtastic/shared/widgets/global_product_card.dart';
import 'package:pawtastic/shared/widgets/custom_app_bar.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class MostPopularPage extends StatefulWidget {
  const MostPopularPage({super.key});

  @override
  State<MostPopularPage> createState() => _MostPopularPageState();
}

class _MostPopularPageState extends State<MostPopularPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.centerTitle(
        context,
        orangeTitle: context.t.home.most_popular.most_popular.toTitleCase(),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .orderBy('product_sold', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Text(context.t.home.index.no_products_available.ucfirst()));
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
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
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
                      return Center(
                          child: Text(context.t.home.index.seller_not_found.ucfirst()));
                    }

                    var seller = sellerSnapshot.data!.data() as Map<String, dynamic>;

                    return GlobalProductCard(
                      productName: product["productName"],
                      productImage: product["productImage"],
                      price: (product["price"] as num).toDouble(),
                      shopName: seller["shop_name"],
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
      ),
    );
  }
}
