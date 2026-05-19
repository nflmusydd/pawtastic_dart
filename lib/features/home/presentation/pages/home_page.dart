import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/features/product/presentation/pages/product_details_page.dart';
import 'package:pawtastic/shared/widgets/bottom_bar.dart';
import 'package:pawtastic/features/home/presentation/pages/product_category_page.dart';
import 'package:pawtastic/features/account/presentation/pages/account_page.dart';
import 'package:pawtastic/shared/widgets/custom_text_button.dart';
import 'package:pawtastic/shared/widgets/global_product_card.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List categories = [
    "images/cat.jpeg",
    "images/dog.png",
    "images/hamster.jpeg",
    "images/fish.jpeg"
  ];

  List categoryName = ["Cats", "Dogs", "Hamster", "Fish"];

  // Helper function to limit characters in name
  String _formatDisplayName(String fullName, {int maxChars = 23,}) {
    if (fullName.trim().isEmpty) return "User";
    final words = fullName.trim().split(RegExp(r'\s+'));
    if (words.first.length > maxChars) {
      return "${words.first.substring(0, maxChars - 3)}...";
    }
    String result = words.first;
    for (int i = 1; i < words.length; i++) {
      final next = "$result ${words[i]}";
      if (next.length > maxChars) {
        break;
      }
      result = next;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90, top: 25),
            child: Column(
              children: [
                // Header: User Profile and App Logo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ToAccountPage()),
                          );
                        },
                        child: const Icon(
                          Icons.person,
                          size: 48,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Consumer<UserProvider>(
                              builder: (context, userProvider, child) {
                                return Text.rich(
                                  TextSpan(
                                    text: "${context.t.common.hello.ucfirst()}\n",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: _formatDisplayName(userProvider.fullName),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      ClipRRect(
                        child: Image.asset(
                          "images/pawlogo.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),

                // SearchPage Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(235, 233, 233, 1),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: context.t.home.index.search_here.toTitleCase(),
                        hintStyle: const TextStyle(),
                        prefixIcon: const Icon(Icons.search_rounded),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),

                // Categories Section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.t.home.index.categories.toTitleCase(),
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                // Fetch categories and products from Firestore
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text(context.t.home.index.no_products_available.ucfirst()));
                    }

                    // Mapping product data from Firestore
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

                    return Container(
                      margin: const EdgeInsets.only(left: 14.0),
                      height: 120.0,
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final nameCategory = categoryName[index];

                          // Filter products by category name
                          final filteredProducts = products.where((product) {
                            return product['category'] != null &&
                                product['category'].contains(nameCategory);
                          }).toList();

                          return CategoryTile(
                            image: categories[index],
                            name: nameCategory,
                            filteredProducts:
                                filteredProducts, // Pass filtered products here
                          );
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30.0),

                // Popular Products Section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.t.home.index.most_popular.toTitleCase(),
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                      CustomTextButton(
                        text: context.t.common.see_all.toTitleCase(),
                        route: AppRoutes.mostPopular,
                        textStyle: const TextStyle(
                          color: const Color.fromRGBO(252, 147, 3, 1.0),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),

                // Product Grid
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .orderBy("product_sold", descending: true)
                        .limit(6)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text(context.t.home.index.no_popular_products.ucfirst()));
                      }

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

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length > 6 ? 6 : products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          final product = products[index];

                          // Fetch seller name using the sellerId
                          return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('seller')
                                .doc(product[
                                    'sellerId']) // Use sellerId to get seller data
                                .get(),
                            builder: (context, sellerSnapshot) {
                              if (sellerSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (!sellerSnapshot.hasData ||
                                  !sellerSnapshot.data!.exists) {
                                return Center(
                                    child: Text(context.t.home.index.seller_not_found.ucfirst()));
                              }

                              // Correct: Accessing seller data directly
                              var seller = sellerSnapshot.data!.data()
                                  as Map<String, dynamic>;

                              return GlobalProductCard(
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
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image, name;
  final List<Map<String, dynamic>> filteredProducts;

  const CategoryTile({
    super.key,
    required this.image,
    required this.name,
    required this.filteredProducts,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductCategoryPage(
              categoryName: name,
              products: filteredProducts,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15.0),
        height: 90.0,
        width: 90.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 90,
              width: 60,
              fit: BoxFit.cover,
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.orange)
          ],
        ),
      ),
    );
  }
}

class ToHomePage extends StatelessWidget {
  const ToHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBar(initialIndex: 0);
  }
}
