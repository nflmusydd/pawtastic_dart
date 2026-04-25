import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pawtastic/pages/buyer/product/product_details.dart';
import 'package:pawtastic/pages/buyer/bottom_bar.dart';
import 'package:pawtastic/pages/buyer/home/product_category.dart';
import 'package:pawtastic/pages/common/settings_page.dart';
import 'package:pawtastic/widget/text_button.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "images/cat.jpeg",
    "images/dog.png",
    "images/hamster.jpeg",
    "images/fish.jpeg"
  ];

  List categoryName = ["Cats", "Dogs", "Hamster", "Fish"];

  // Fetch user name from Firestore
  Future<String> getUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        String username =
            userDoc['username']; // Assuming the username field is "username"
        return username;
      }
    }
    return "User"; // Default value if the username is not found
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 250),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 90, top: 25),
            child: Container(
              child: Column(
                children: [
                  // Header: User Profile and App Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),

                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(50),
                          //   child: Image.asset(
                          //     "images/photoprofile.jpg",
                          //     height: 48,
                          //     width: 48,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => toSettingsPage()),
                              );
                            },
                            child: Icon(
                              Icons.person,
                              size: 48,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FutureBuilder<String>(
                                future: getUserName(), // Fetch the user's name
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text("Hello...");
                                  }
                                  if (snapshot.hasError) {
                                    return Text("Error loading name");
                                  }

                                  return Text.rich(
                                    TextSpan(
                                      text: "Hello\n",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: snapshot.data ?? "User",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
                  SizedBox(height: 30.0),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(235, 233, 233, 1),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search here",
                          hintStyle: TextStyle(),
                          prefixIcon: Icon(Icons.search_rounded),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),

                  // Categories Section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  // Fetch categories and products from Firestore
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No products available"));
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
                        margin: EdgeInsets.only(left: 14.0),
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

                  SizedBox(height: 30.0),

                  // Popular Products Section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Most Popular",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        TextbuttonNavigation(
                          text: "see all",
                          route: '/most-popular',
                          textStyle: TextStyle(
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
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .orderBy("product_sold", descending: true)
                          .limit(6)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text("No popular products"));
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
                          itemCount: 6, // Display 6 products only on home page
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.74,
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
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (!sellerSnapshot.hasData ||
                                    !sellerSnapshot.data!.exists) {
                                  return Center(
                                      child: Text("Seller not found"));
                                }

                                // Correct: Accessing seller data directly
                                var seller = sellerSnapshot.data!.data()
                                    as Map<String, dynamic>;

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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              product["productImage"],
                                              height: 180,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                '${seller["shop_name"]}', // Display the seller name here
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
                ],
              ),
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

  CategoryTile({
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
            builder: (context) => ProductCategory(
              categoryName: name,
              products: filteredProducts,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
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
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.orange)
          ],
        ),
      ),
    );
  }
}

class toHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Bottombar(initialIndex: 0);
  }
}

