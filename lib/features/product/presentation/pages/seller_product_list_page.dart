import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawtastic/features/product/presentation/pages/product_details_page.dart';
import 'package:pawtastic/shared/widgets/custom_app_bar.dart';

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
  late List<Map<String, dynamic>> sellerProducts = [];
  bool isLoading = true;

  // Fetch products for the given sellerId
  Future<void> fetchProducts() async {
    try {
      // Query Firestore for products that belong to this sellerId
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('seller_id', isEqualTo: widget.sellerId)
          .get();

      // Extract product data
      setState(() {
        sellerProducts = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) debugPrint("Error fetching products: $e");
      print("Error fetching products");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();  // Fetch products when the page is initialized
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
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sellerProducts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (context, index) {
                      final product = sellerProducts[index];

                      // Handle null values by providing default values
                      String productName = product["product_name"] ?? "Unnamed Product";
                      String productImage = product["image_url"] ?? "assets/default_image.png";
                      // double price = product["price"]?.toDouble() ?? 0.0;

                      return GestureDetector(
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
                                    productImage,
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
                                      productName,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
      )
    );
  }
}
