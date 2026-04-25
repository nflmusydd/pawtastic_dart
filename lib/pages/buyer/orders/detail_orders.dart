import 'package:flutter/material.dart';
import 'package:pawtastic/pages/buyer/orders/my_orders.dart';

class Detailorders extends StatefulWidget {
  final Order order;  // menerima object Order

  // Modify the constructor to accept the orderId parameter
  const Detailorders({super.key, required this.order});

  @override
  State<Detailorders> createState() => _DetailordersState();
}

class _DetailordersState extends State<Detailorders> {
  late Order order;  // Declare the order variable here

  // Data list produk sementara (masih sama setiap order id)
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Makanan Hamster Jolly Multivitamin Hamster Food 400 gr',
      'price': 40000,
      'quantity': 2,
      'image': 'images/MakananHamsterJolly400gr.jpg'
    },
    {
      'name': 'Sisir Brush Pet Grooming Sisir Kucing Anjing Hewan Shift Brush',
      'price': 20000,
      'quantity': 3,
      'image': 'images/SisirBrushPetGroomingSisirKucingAnjing.jpg' 
    },
    {
      'name': 'Litter Box Kucing Besar Jumbo',
      'price': 25000,
      'quantity': 1,
      'image': 'images/LitterBoxKucingBesarJumboBaskom.png'  
    },
    
  ];


  @override
  void initState() {
    super.initState();
    // Initialize the order in initState to ensure it's available before build
    order = widget.order;
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
              mainAxisAlignment: MainAxisAlignment.center,  // Center vertically within AppBar
              children: [
                // Title Widget for "Details"
                const Text(
                  'Details',  // Display "Details" as the main title
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                // Display the order ID below the title
                Text(
                  'Order №${order.orderId}',  // Display the order ID
                  style: const TextStyle(
                    color: Color.fromRGBO(252, 147, 3, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      backgroundColor: const Color.fromARGB(255, 255, 250, 250),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Shop Section
          Card(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              // side: BorderSide(
                // color: Color.fromRGBO(252, 147, 3, 1.0),
                // width: 1.0, // Border width
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shop Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Shop: ${order.shop}'), 
                  const SizedBox(height: 10),
                  Text('Shop address:\nJalan Raya, Kota Malang'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Product Section with Images
          Card(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              // side: BorderSide(
              //   color: Color.fromRGBO(252, 147, 3, 1.0),
              //   width: 1.0, // Border width
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Products',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Column for vertically aligned products
                  Column(
                    children: products.map((product) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),  // Space between products
                        child: Row(
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                product['image'],  // Using local assets
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Product Name and Quantity
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'], 
                                    style: const TextStyle(fontSize: 14.0),
                                    overflow: TextOverflow.ellipsis,  // Limit text length and add "..."
                                    maxLines: 1,  // Limit to a single line
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Align text to both left and right
                                    children: [
                                      Text('Rp ${product['price']}\t x${product['quantity']}', style: const TextStyle(fontSize: 14.0)),
                                      Text(
                                        'Rp ${product['price'] * product['quantity']}',  // Calculate total price (price * quantity)
                                        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10), // Space between products list and total amount
                  // Total Amount Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Product subtotal:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Calculate the total amount
                      Text(
                        'Rp ${products.fold<int>(0, (total, product) {
                          // Force price and quantity to be treated as integers
                          final price = (product['price'] as num).toInt();
                          final quantity = (product['quantity'] as num).toInt();
                          return total + (price * quantity);
                        })}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange, // You can choose a color to highlight the total
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Order Details Section
          Card(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              // side: BorderSide(
              //   color: Color.fromRGBO(252, 147, 3, 1.0),
              //   width: 1.0, // Border width
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Using Row to align the label and value with consistent ':' alignment
                  Row(
                    children: [
                      const Expanded(
                        child: Text('Status:', style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Text(order.detailStatus),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Expanded(
                        child: Text('Order Date:', style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Text('${order.orderDate}, 00:00'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Conditionally render Delivered Date Row only if status is "Delivered"
                  if (order.status == "delivered") ...[
                    Row(
                      children: [
                        const Expanded(
                          child: Text('Delivered Date:', style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        Text(order.deliveredDate ?? "Not Delivered"),
                        
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                    
                  Row(
                    children: [
                      const Expanded(
                        child: Text('Payment Method:', style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Text(order.paymentMethod),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Expanded(
                        child: Text('Shipping Cost:', style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      const Text('Rp 10000'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Expanded(
                        child: Text('Discount:', style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      const Text('-Rp 0'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Expanded(
                        child: Text('Total Payment:', style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Text(
                        'Rp ${order.totalPrice}',
                        style: TextStyle(
                          color: Color.fromRGBO(252, 147, 3, 1.0),
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  Text(
                    'Shipping Address:\n${order.shippingAddress}',
                    style: TextStyle(fontWeight: FontWeight.w500)
                  ),

                  /*
                    Perlu ditambahkan status refund 
                    untuk yang cancelled??
                  */
                      
                ],
              ),
            ),
          ),            

        ],
      ),
    );
  }
}
