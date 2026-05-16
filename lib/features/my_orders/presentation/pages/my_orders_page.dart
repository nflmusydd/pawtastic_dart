import 'package:flutter/material.dart';
import 'package:pawtastic/features/my_orders/presentation/pages/order_details_page.dart';
import 'package:pawtastic/features/home/presentation/widgets/bottom_bar.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';

// MyOrdersPage Page with TabBar (Nested Navigation)
class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

// Order Model
class Order {
  final String orderId;
  final String shop;
  final String shippingAddress;
  final int totalPrice;
  final String orderDate;
  final String paymentMethod;
  final String? deliveredDate; // Can be null
  final String status; // 'delivered', 'processing', or 'cancelled'
  final String detailStatus;

  Order({
    required this.orderId,
    required this.shop,
    required this.shippingAddress,
    required this.totalPrice,
    required this.orderDate,
    required this.paymentMethod,
    this.deliveredDate,
    required this.status,
    required this.detailStatus,
  });
}

class _MyOrdersPageState extends State<MyOrdersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // data dummy (tidak dipakai setelah connect ke db)
  final List<Order> orders = [
    Order(
      orderId: '1947034',
      shop: 'Vidibi Pet Shop',
      shippingAddress: 'Blimbing, Kota Malang',
      totalPrice: 40000,
      orderDate: '05-11-2024',
      paymentMethod: 'Credit Card',
      deliveredDate: '06-11-2024, 15:01',
      status: 'delivered',
      detailStatus: 'Delivered',
    ),
    Order(
      orderId: '1947035',
      shop: 'Rumah hewan',
      shippingAddress: 'Jalan Raya, Kota Malang',
      totalPrice: 50000,
      orderDate: '06-11-2024',
      paymentMethod: 'Debit Card',
      deliveredDate: '07-11-2024, 12:00',
      status: 'delivered',
      detailStatus: 'Delivered',
    ),
    Order(
      orderId: '1947036',
      shop: 'Pakan hewan Malang',
      shippingAddress: 'Jalan Merdeka, Kota Malang',
      totalPrice: 30000,
      orderDate: '07-11-2024',
      paymentMethod: 'PayPal',
      deliveredDate: '08-11-2024, 16:00',
      status: 'delivered',
      detailStatus: 'Delivered',
    ),
    Order(
      orderId: '1947037',
      shop: 'Vidibi Pet Shop',
      shippingAddress: 'Jalan Candi, Kota Malang',
      totalPrice: 25000,
      orderDate: '08-11-2024',
      paymentMethod: 'Cash on Delivery',
      deliveredDate: null, // Not delivered
      status: 'processing',
      detailStatus: 'Waiting for packaging',
    ),
    Order(
      orderId: '1947038',
      shop: 'Koneko Pet Shop',
      shippingAddress: 'Jalan Batu, Kota Malang',
      totalPrice: 45000,
      orderDate: '09-11-2024',
      paymentMethod: 'Credit Card',
      deliveredDate: null, // Not delivered
      status: 'processing',
      detailStatus: 'In delivery',
    ),
    Order(
      orderId: '1947039',
      shop: 'Perlengkapan Hewan Singosari',
      shippingAddress: 'Jalan Indah, Kota Malang',
      totalPrice: 35000,
      orderDate: '10-11-2024',
      paymentMethod: 'Bank Transfer',
      deliveredDate: null, // Not delivered
      status: 'cancelled',
      detailStatus: 'Empty stock',
    ),
    Order(
      orderId: '1947040',
      shop: 'Patzy Pet Shop',
      shippingAddress: 'Jalan Merdeka, Kota Malang',
      totalPrice: 30000,
      orderDate: '07-11-2024',
      paymentMethod: 'PayPal',
      deliveredDate: '07-11-2024, 16:00',
      status: 'delivered',
      detailStatus: 'Delivered',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);  // 3 tabs for processing, completed, and cancelled
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        automaticallyImplyLeading: false,  // Remove back button
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),  // Add margin for the title
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Ensure the column only takes as much space as needed
            children: [
              // Title Widget
              Center(
                child: Text(
                  context.t.my_orders.index.my_orders.toTitleCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,  
                  ),
                ),
              ),
            ],
          ),
        ),
        
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.label,  // This ensures indicator takes up the full width of the tab
                // indicatorWeight: 4.0,
                indicator: BoxDecoration(
                  color: const Color.fromRGBO(252, 147, 3, 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
               labelStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                tabs: [
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),  // Add padding to create space around text
                      child: Text(context.t.my_orders.index.delivered.toTitleCase()),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),  // Add padding to create space around text
                      child: Text(context.t.my_orders.index.processing.toTitleCase()),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),  // Add padding to create space around text
                      child: Text(context.t.my_orders.index.cancelled.toTitleCase()),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height:5.0),
          ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // panggil masing-masing page dan lakukan passing data dummy
          CompletedOrders(orders: orders.where((order) => order.status == 'delivered').toList()),  
          ProcessingOrders(orders: orders.where((order) => order.status == 'processing').toList()),
          CancelledOrders(orders: orders.where((order) => order.status == 'cancelled').toList()),
        ],
      ),
    );
  }
}

class CompletedOrders extends StatelessWidget {
  final List<Order> orders;

  const CompletedOrders({super.key, required this.orders});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(     
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 70),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true, // Allows ListView to take only as much space as required
                physics: const NeverScrollableScrollPhysics(), // Prevent ListView from scrolling independently
                padding: const EdgeInsets.all(16.0),
                itemCount: orders.length, 
                itemBuilder: (context, index) {
                  // buat orderId sementara
                  final order = orders[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Id
                              Text(
                                "${context.t.my_orders.index.order.toTitleCase()} №${order.orderId}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              // tanggal order
                              Text(
                                order.orderDate,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                         // nama toko
                          Text(
                            "${context.t.common.from.toTitleCase()}: ${order.shop}",  // sementara belum dinamis
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          // alamat
                          Text(
                            "${context.t.common.shipping_address.toTitleCase()}: ${order.shippingAddress}",
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column( 
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // total belanja
                                  Text.rich(
                                    TextSpan(
                                      text: "${context.t.common.total_amount.toTitleCase()}: ",
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Rp ${order.totalPrice}",
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // detailed status 
                                  Text(
                                    context.t.my_orders.index.delivered_on(date: order.deliveredDate ?? "").ucfirst(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[600],
                                    ),
                                  ),
                                ]
                              ),
                              
                              Align(
                                alignment: Alignment.centerRight,
                                child: OutlinedButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, '/detail-orders');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderDetailsPage(order: order),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color.fromARGB(255, 108, 108, 108)),
                                  ),
                                  child: Text(context.t.common.details.toTitleCase()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
       
      ),
    );
  }
}

// Sub-page Widgets
class ProcessingOrders extends StatelessWidget {
  final List<Order> orders;

  const ProcessingOrders({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(     
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 70),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true, // Allows ListView to take only as much space as required
                physics: const NeverScrollableScrollPhysics(), // Prevent ListView from scrolling independently
                padding: const EdgeInsets.all(16.0),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${context.t.my_orders.index.order.toTitleCase()} №19470${order.orderId}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                order.orderDate,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "${context.t.common.from.toTitleCase()}: ${order.shop}",
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          Text(
                            "${context.t.common.shipping_address.toTitleCase()}: ${order.shippingAddress}",
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column( 
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "${context.t.common.total_amount.toTitleCase()}: ",
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Rp ${order.totalPrice}",
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    // "Seller packages the goods",
                                    // "In delivery",
                                    order.detailStatus,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[600],
                                    ),
                                  ),
                                ]
                              ),
                              
                              Align(
                                alignment: Alignment.centerRight,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderDetailsPage(order: order),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color.fromARGB(255, 108, 108, 108)),
                                  ),
                                  child: Text(context.t.common.details.toTitleCase()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
       
      ),
    );
  }
}

class CancelledOrders extends StatelessWidget {
  final List<Order> orders;

  const CancelledOrders({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(     
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 70),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true, // Allows ListView to take only as much space as required
                physics: const NeverScrollableScrollPhysics(), // Prevent ListView from scrolling independently
                padding: const EdgeInsets.all(16.0),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${context.t.my_orders.index.order.toTitleCase()} №${order.orderId}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                order.orderDate,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          // nama toko
                          Text(
                            "${context.t.common.from.toTitleCase()}: ${order.shop}",  // sementara belum dinamis
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          Text(
                            "${context.t.common.shipping_address.toTitleCase()}: ${order.shippingAddress}",
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column( 
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "${context.t.common.total_amount.toTitleCase()}: ",
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Rp ${order.totalPrice}",
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    order.detailStatus,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[600],
                                    ),
                                  ),
                                ]
                              ),
                              
                              Align(
                                alignment: Alignment.centerRight,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderDetailsPage(order: order),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color.fromARGB(255, 108, 108, 108)),
                                  ),
                                  child: Text(context.t.common.details.toTitleCase()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
       
      ),
    );
  }
}

class ToMyOrdersPage extends StatelessWidget {
  const ToMyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBar(initialIndex: 2);
  }
}
