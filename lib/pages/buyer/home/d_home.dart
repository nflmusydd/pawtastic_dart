import 'package:flutter/material.dart';
import 'package:pawtastic/pages/buyer/product/product_details.dart';
import 'package:pawtastic/pages/buyer/bottom_bar.dart';
import 'package:pawtastic/pages/buyer/home/product_category.dart';
import 'package:pawtastic/widget/text_button.dart';

class DHome extends StatefulWidget {
  const DHome({super.key});

  @override
  State<DHome> createState() => _DHomeState();
}

class _DHomeState extends State<DHome> {
  List categories = [
    "images/cat.jpeg",
    "images/dog.png",
    "images/hamster.jpeg",
    "images/fish.jpeg"
  ];

  List categoryName = [
    "Cat",
    "Dog",
    "Hamster",
    "Fish"
  ];

  // Dummy product list
  final List<Map<String, dynamic>> products = [
    {
      "productName": "Jolly Makanan Hamster 400 gram",
      "productImage": "images/MakananHamsterJolly400gr.jpg",
      "description": "Hamster food",
      "category": "Hamster",
      "price": 30000,
      "stock": 10,
      "productSold": 15,
      "sellerName": "Pet Shop A",
      "sellerAddress": "123 Main St"
    },
    {
      "productName": "Sisir Brush Pet Grooming, Sisir Kucing Anjing",
      "productImage": "images/SisirBrushPetGroomingSisirKucingAnjing.jpg",
      "description": "Sisir untuk mempercantik bulu kucing",
      "category": "Cat",
      "price": 10000,
      "stock": 20,
      "productSold": 10,
      "sellerName": "Pet Shop B",
      "sellerAddress": "456 Market Rd"
    },
    {
      "productName": "Litter Box Kucing Besar",
      "productImage": "images/LitterBoxKucingBesarJumboBaskom.png",
      "description": "Tempat buang kotoran kucing ukuran jumbo",
      "category": "Cat",
      "price": 23000,
      "stock": 5,
      "productSold": 18,
      "sellerName": "Pet Shop C",
      "sellerAddress": "789 Pet Lane"
    },
    {
      "productName": "Pasir Kucing Wangi",
      "productImage": "images/PasirWangiTayo3LtrGumpal.jpg",
      "description": "Pasir kotoran kucing anti bau",
      "category": "Cat",
      "price": 24000,
      "stock": 5,
      "productSold": 25,
      "sellerName": "Pet Shop C",
      "sellerAddress": "789 Pet Lane"
    },
    {
      "productName": "Meja Aquarium",
      "productImage": "images/meja_aquarium_jati_belanda.jpg",
      "description": "Meja jati kokoh untuk aquarium",
      "category": "Fish",
      "price": 150000,
      "stock": 5,
      "productSold": 13,
      "sellerName": "Pet Shop C",
      "sellerAddress": "789 Pet Lane"
    },
    {
      "productName": "Botol susu anak anjing dan kucing",
      "productImage": "images/BotolSusuAnjingKucingHewanNursingDotKittenDotAnjingPuppy.jpg",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "category": ["Dog", "Cat"],
      "price": 50000,
      "stock": 5,
      "productSold": 13,
      "sellerName": "Pet Shop C",
      "sellerAddress": "789 Pet Lane"
    },
    {
      "productName": "C-One Conditioning SHAMPOO",
      "productImage": "images/C-One_CONDITIONING_SHAMPOO_for_Pet_100ml.jpg",
      "description": "Shampoo mandi untuk hewan peliharaan kesayanganmu",
      "category": ["Dog", "Cat"],
      "price": 30000,
      "stock": 5,
      "productSold": 13,
      "sellerName": "Pet Shop A",
      "sellerAddress": "789 Pet Lane"
    },
  ];

  @override
  void initState() {
    super.initState();
    // Sort the products by 'productSold' when the widget is first created
    _sortProductsByProductSold();
  }

  // Function to sort products
  void _sortProductsByProductSold() {
    setState(() {
      // Sorting products in descending order by 'productSold'
      products.sort((a, b) => b["productSold"].compareTo(a["productSold"]));
    });
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();

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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "images/photoprofile.jpg",
                              height: 48,
                              width: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "Hello\n",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Daniel Guntoro!",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        height: 1.3,
                                      ),
                                    )
                                  ],
                                ),
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
                  Container(
                    margin: EdgeInsets.only(left: 14.0),
                    height: 120.0,
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final nameCategory = categoryName[index];
                        final filteredProducts = products
                            .where((product) => product['category'].contains(nameCategory))    // Check if the category array contains the current category
                            .toList(); // Filter products by category name
                        return CategoryTile(
                          image: categories[index],
                          name: nameCategory,
                          products: filteredProducts
                        );
                      },
                    ),
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
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,   //hanya menampilkan 6 di home
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.74,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to details page, passing product data
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ProductDetails(
                            //       product: product, 
                            //       allProducts: products
                            //     ),
                            //   ),
                            // );
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
                                        'Rp ${product["price"]}',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 3.0),
                                      Text(
                                        product["sellerName"],
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Montserrat",
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
  final List<Map<String, dynamic>> products;
  const CategoryTile({super.key, required this.image, required this.name, required this.products});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ProductCategory(categoryName: name, products: products)),
        // );
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
  const toHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Bottombar(initialIndex: 0);
  }
}

