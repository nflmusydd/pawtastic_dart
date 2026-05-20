import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/features/product/presentation/pages/product_details_page.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';

class SellerProductListPage extends StatefulWidget {
  final Map<String, dynamic> seller;
  final String sellerId;

  const SellerProductListPage({
    Key? key,
    required this.seller,
    required this.sellerId,
  }) : super(key: key);

  @override
  _SellerProductListPageState createState() => _SellerProductListPageState();
}

class _SellerProductListPageState extends State<SellerProductListPage> {
  List<Map<String, dynamic>> sellerProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Fetch products when the page is initialized
  }

  // Function to fetch products from Firestore based on sellerId
  void fetchProducts() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('seller_id', isEqualTo: widget.sellerId)
          .get();

      setState(() {
        sellerProducts = snapshot.docs.map((doc) {
          return {
            "product_name": doc['product_name'],
            "image_url": doc['image_url'],
            "description": doc['description'],
            "categories": doc['categories'],
            "price": doc['price'],
            "stock": doc['stock'],
            "product_sold": doc['product_sold'],
            "seller_id": doc['seller_id'],
          };
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching products: $e");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.centerTitle(
        context,
        blackTitle: 'Products by',
        orangeTitle: "${widget.seller["shop_name"]}",
      ),
      body: SafeArea(
        child: isLoading
            ? GlobalLoading.centered()
            : GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                itemCount: sellerProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = sellerProducts[index];

                  return GlobalProductCard(
                    productName: product["product_name"] ?? "Unnamed Product",
                    productImage: product["image_url"] ?? "assets/default_image.png",
                    price: (product["price"] as num).toDouble(),
                    shopName: widget.seller["shop_name"],
                    onTap: () {
                      // Navigate to the product details page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            product: product,
                            seller: widget.seller,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
