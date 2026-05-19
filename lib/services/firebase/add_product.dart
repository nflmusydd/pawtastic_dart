import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawtastic/shared/widgets/custom_app_bar.dart';
import 'package:pawtastic/shared/widgets/primary_button.dart';
import 'package:pawtastic/shared/widgets/custom_text_field_decoration.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productSoldController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _selectedSellerId;
  List<Map<String, dynamic>> _sellers = [];
  List<String> _selectedCategories = []; // Stores selected animal categories

  // List of predefined animal categories
  final List<String> _animalCategories = ['Dogs', 'Cats', 'Birds', 'Fish', 'Hamster', 'Rabbits'];

  @override
  void initState() {
    super.initState();
    _fetchSellers();
  }

  /// Fetch sellers from the Firestore
  Future<void> _fetchSellers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('seller').get();
      setState(() {
        _sellers = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'shop_name': doc['shop_name'], // Assuming 'shop_name' exists in the seller document
          };
        }).toList();
      });
    } catch (e) {
      _showSnackBar("Error fetching sellers: $e", Colors.red);
    }
  }

  /// Submit the product to Firestore
  Future<void> _submitProduct() async {
    if (_selectedSellerId == null) {
      _showSnackBar("Please select a seller!", Colors.red);
      return;
    }

    if (_selectedCategories.isEmpty) {
      _showSnackBar("Please select at least one category!", Colors.red);
      return;
    }

    if (_descriptionController.text.isEmpty ||
        _imageUrlController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _productNameController.text.isEmpty ||
        _productSoldController.text.isEmpty ||
        _ratingController.text.isEmpty ||
        _stockController.text.isEmpty) {
      _showSnackBar("All fields are required!", Colors.red);
      return;
    }

    try {
      double price = double.parse(_priceController.text);
      int productSold = int.parse(_productSoldController.text);
      double rating = double.parse(_ratingController.text);
      int stock = int.parse(_stockController.text);

      await _firestore.collection('products').add({
        'categories': _selectedCategories, // Store categories as an array
        'description': _descriptionController.text.trim(),
        'image_url': _imageUrlController.text.trim(),
        'price': price,
        'product_name': _productNameController.text.trim(),
        'product_sold': productSold,
        'rating': rating,
        'stock': stock,
        'seller_id': _selectedSellerId, // Add seller_id to the product
        'created_at': FieldValue.serverTimestamp(),
      });

      _showSnackBar("Product added successfully!", Colors.green);
      _clearFields();
    } catch (e) {
      _showSnackBar("Error adding product: $e", Colors.red);
    }
  }

  /// Clear all input fields
  void _clearFields() {
    _descriptionController.clear();
    _imageUrlController.clear();
    _priceController.clear();
    _productNameController.clear();
    _productSoldController.clear();
    _ratingController.clear();
    _stockController.clear();
    setState(() {
      _selectedSellerId = null;
      _selectedCategories = [];
    });
  }

  /// Show a SnackBar with the given message and color
  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              backgroundColor == Colors.red ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.leftTitle(
        context,
        title: "Add Product",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedSellerId,
                  items: _sellers
                      .map((seller) => DropdownMenuItem<String>(
                            value: seller['id'],
                            child: Text(seller['shop_name']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSellerId = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Select Seller",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: _animalCategories.map((category) {
                    return FilterChip(
                      label: Text(category),
                      selected: _selectedCategories.contains(category),
                      onSelected: (isSelected) {
                        setState(() {
                          if (isSelected) {
                            _selectedCategories.add(category);
                          } else {
                            _selectedCategories.remove(category);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _productNameController,
                  decoration: CustomTextFieldDecoration(
                    hintText: 'Product Name',
                    prefixIcon: Icons.label,
                  ).decoration,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: CustomTextFieldDecoration(
                    hintText: 'Description',
                    prefixIcon: Icons.description,
                  ).decoration,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: CustomTextFieldDecoration(
                    hintText: 'Image URL',
                    prefixIcon: Icons.image,
                  ).decoration,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _priceController,
                  decoration: CustomTextFieldDecoration(
                    hintText: 'Price',
                    prefixIcon: Icons.attach_money,
                  ).decoration,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _productSoldController,
                  decoration: CustomTextFieldDecoration(
                    hintText: 'Product Sold',
                    prefixIcon: Icons.shopping_cart,
                  ).decoration,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _stockController,
                  decoration: CustomTextFieldDecoration(
                    hintText: 'Stock',
                    prefixIcon: Icons.inventory,
                  ).decoration,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _ratingController,
                  decoration: CustomTextFieldDecoration(
                    hintText: 'Rating',
                    prefixIcon: Icons.star_rate,
                  ).decoration,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  label: "Add Product",
                  onPressed: _submitProduct,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

