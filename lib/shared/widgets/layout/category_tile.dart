import 'package:flutter/material.dart';
import 'package:pawtastic/features/home/presentation/pages/product_category_page.dart';

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
