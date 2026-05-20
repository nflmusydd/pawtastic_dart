import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/features/product/presentation/pages/product_details_page.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';

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
      appBar: CustomAppBar.centerTitle(
        context,
        blackTitle: context.t.home.product_category.product_category.toTitleCase(),
        orangeTitle: categoryName,
      ),
      body: products.isNotEmpty
          ? GridView.builder(
              padding: const EdgeInsets.all(14.0),
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
                      .doc(product['sellerId']) // Use sellerId to get seller data
                      .get(),
                  builder: (context, sellerSnapshot) {
                    if (sellerSnapshot.connectionState == ConnectionState.waiting) {
                      return GlobalLoading.centered();
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
                      child: GlobalProductCard(
                        productName: product["productName"],
                        productImage: product["productImage"],
                        price: (product["price"] as num).toDouble(),
                        shopName: seller["shop_name"],
                        onTap: () {
                          // Navigate to details page, passing product data
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
