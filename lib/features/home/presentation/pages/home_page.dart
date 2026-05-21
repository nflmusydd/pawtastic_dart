import 'package:pawtastic/core/config/app_routes.dart';
import 'package:pawtastic/services/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/features/product/presentation/pages/product_details_page.dart';
import 'package:pawtastic/features/account/presentation/pages/account_page.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/shared/widgets/widgets.dart';
import 'package:pawtastic/core/utils/core_utils.dart';

import 'package:pawtastic/services/bottom_bar_provider.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final List categories = [
    "images/cat.png",
    "images/dog.png",
    "images/hamster.png",
    "images/fish.png"
  ];

  final List categoryName = ["Cats", "Dogs", "Hamster", "Fish"];

  late Stream<QuerySnapshot> _productsStream;
  late Stream<QuerySnapshot> _popularProductsStream;
  late ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    
    // Inisialisasi Stream di initState agar tidak dibuat ulang setiap build
    _productsStream = FirebaseFirestore.instance.collection('products').snapshots();
    _popularProductsStream = FirebaseFirestore.instance
        .collection('products')
        .orderBy("product_sold", descending: true)
        .limit(6)
        .snapshots();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      // Scroll ke bawah -> Sembunyikan Bar
      if (context.read<BottomBarProvider>().isVisible) {
        context.read<BottomBarProvider>().setVisible(false);
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      // Scroll ke atas -> Tampilkan Bar
      if (!context.read<BottomBarProvider>().isVisible) {
        context.read<BottomBarProvider>().setVisible(true);
      }
    }
  }

  // Helper function to limit characters in name
  String _formatDisplayName(String fullName, {int maxChars = 23}) {
    if (fullName.trim().isEmpty) return context.t.common.guest.ucfirst();
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
    super.build(context); // Wajib dipanggil jika menggunakan AutomaticKeepAliveClientMixin

    return AuthGuard(
      allowGuest: true,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
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
                              MaterialPageRoute(builder: (context) => const ToAccountPage()),
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
                          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  
                  StreamBuilder<QuerySnapshot>(
                    stream: _productsStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return GlobalLoading.centered();
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text(context.t.home.index.no_products_available.ucfirst()));
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

                      return Container(
                        margin: const EdgeInsets.only(left: 14.0),
                        height: 120.0,
                        child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final nameCategory = categoryName[index];
                            final filteredProducts = products.where((product) {
                              return product['category'] != null &&
                                  product['category'].contains(nameCategory);
                            }).toList();

                            return CategoryTile(
                              image: categories[index],
                              name: nameCategory,
                              filteredProducts: filteredProducts,
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
                          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        CustomTextButton(
                          text: context.t.common.see_all.toTitleCase(),
                          route: AppRoutes.mostPopular,
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(252, 147, 3, 1.0),
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
                      stream: _popularProductsStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return GlobalLoading.centered();
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
                                  return GlobalLoading.centered(size: 80);
                                }

                                if (!sellerSnapshot.hasData || !sellerSnapshot.data!.exists) {
                                  return Center(child: Text(context.t.home.index.seller_not_found.ucfirst()));
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
                ],
              ),
            ),
          ),
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
