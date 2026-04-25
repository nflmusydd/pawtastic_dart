import 'package:flutter/material.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({super.key});

  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        toolbarHeight: 75,    //tinggi appBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        titleSpacing: 0,  // Remove any default padding for the title
        flexibleSpace: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(imagePath),  // Display the category image
                const Text(
                  'Most Popular',  
                  style: TextStyle(
                    color: Color.fromRGBO(252, 147, 3, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "Product",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0, 
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      backgroundColor: const Color.fromARGB(255, 255, 250, 250),
      body: SingleChildScrollView(
        child: SafeArea(
           child: Container(
            padding: EdgeInsets.only(left: 14.0, right: 14.0, bottom: 20.0, top: 10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
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
                    //       product: product),
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
                
        )
      )
    );
  }
}