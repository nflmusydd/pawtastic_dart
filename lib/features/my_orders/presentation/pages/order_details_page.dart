import 'package:flutter/material.dart';
import 'package:pawtastic/shared/widgets/custom_app_bar.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';
import 'package:pawtastic/models/order_model.dart';

class OrderDetailsPage extends StatefulWidget {
  final Order order;  // menerima object Order

  // Modify the constructor to accept the orderId parameter
  const OrderDetailsPage({super.key, required this.order});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
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
      appBar: CustomAppBar.centerTitle(
        context,
        blackTitle: context.t.my_orders.details.details.toTitleCase(),
        orangeTitle: '${context.t.my_orders.details.order.toTitleCase()} №${order.orderId}',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Shop Section
          Card(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.t.my_orders.details.shop_information.toTitleCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('${context.t.my_orders.details.shop.toTitleCase()}: ${order.shop}'), 
                  const SizedBox(height: 10),
                  Text('${context.t.my_orders.details.shop_address.toTitleCase()}:\nJalan Raya, Kota Malang'),
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
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.t.my_orders.details.products.toTitleCase(),
                    style: const TextStyle(
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
                      Text(
                        context.t.my_orders.details.product_subtotal.toTitleCase(),
                        style: const TextStyle(
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
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.t.my_orders.details.order_details.toTitleCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Using Row to align the label and value with consistent ':' alignment
                  Row(
                    children: [
                      Expanded(
                        child: Text('${context.t.my_orders.details.status.toTitleCase()}:', style: const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Text(order.detailStatus),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Text('${context.t.my_orders.details.order_date.toTitleCase()}:', style: const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Text('${order.orderDate}, 00:00'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Conditionally render Delivered Date Row only if status is "Delivered"
                  if (order.status == "delivered") ...[
                    Row(
                      children: [
                        Expanded(
                          child: Text('${context.t.my_orders.details.delivered_date.toTitleCase()}:', style: const TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        Text(order.deliveredDate ?? context.t.my_orders.details.not_delivered.ucfirst()),
                        
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                    
                  Row(
                    children: [
                      Expanded(
                        child: Text('${context.t.my_orders.details.payment_method.toTitleCase()}:', style: const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Text(order.paymentMethod),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Text('${context.t.my_orders.details.shipping_cost.toTitleCase()}:', style: const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      const Text('Rp 10000'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Text('${context.t.my_orders.details.discount.toTitleCase()}:', style: const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      const Text('-Rp 0'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Text('${context.t.my_orders.details.total_payment.toTitleCase()}:', style: const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Text(
                        'Rp ${order.totalPrice}',
                        style: const TextStyle(
                          color: const Color.fromRGBO(252, 147, 3, 1.0),
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  Text(
                    '${context.t.my_orders.details.shipping_address.toTitleCase()}:\n${order.shippingAddress}',
                    style: const TextStyle(fontWeight: FontWeight.w500)
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
