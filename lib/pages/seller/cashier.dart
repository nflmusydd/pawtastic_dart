import 'package:flutter/material.dart';

class Cashier extends StatefulWidget {
  @override
  _CashierState createState() => _CashierState();
}

class _CashierState extends State<Cashier> {
  bool showTransactionRecord = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cashier', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color.fromRGBO(252, 147, 3, 1.0),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home-seller');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AnimatedAlign(
                  alignment: showTransactionRecord
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: Container(
                    width: 180,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showTransactionRecord = true;
                        });
                      },
                      child: Container(
                        width: 180,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          'Transaction Record',
                          style: TextStyle(
                              color: showTransactionRecord
                                  ? Colors.white
                                  : const Color.fromARGB(255, 71, 71, 71),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showTransactionRecord = false;
                        });
                      },
                      child: Container(
                        width: 180,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          'Add Offline Transaction',
                          style: TextStyle(
                              color: showTransactionRecord
                                  ? const Color.fromARGB(255, 71, 71, 71)
                                  : Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: showTransactionRecord
                  ? _buildTransactionRecord()
                  : _buildOfflineTransactionForm(),
            ),
            if (showTransactionRecord) ...[
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Income',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp 453.000',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionRecord() {
    return ListView(
      children: [
        _buildOrderCard(
          orderId: '№1947034',
          items: [
            'Cat Food Whiskas x1',
            'Hamsfood x1',
          ],
          shippingCost: 'Rp 10.000',
          discount: 'Rp 10.000',
          totalAmount: 'Rp 40.000',
        ),
        _buildOrderCard(
          orderId: '№7519630',
          items: [
            'Cat Food Whiskas x3',
          ],
          shippingCost: '-',
          discount: 'Rp 0',
          totalAmount: 'Rp 150.000',
        ),
        _buildOrderCard(
          orderId: '№3197318',
          items: [
            'Vitakraft x1',
            'Cat Food Whiskas x2',
          ],
          shippingCost: 'Rp 12.000',
          discount: 'Rp 7.000',
          totalAmount: 'Rp 155.000',
        ),
        _buildOrderCard(
          orderId: '№7533914',
          items: [
            'Vitakraft x2',
          ],
          shippingCost: 'Rp 8.000',
          discount: 'Rp 0',
          totalAmount: 'Rp 108.000',
        ),
      ],
    );
  }

  Widget _buildOfflineTransactionForm() {
    return Center(
      child: Text(
        'Offline Transaction Form Placeholder',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required List<String> items,
    required String shippingCost,
    required String discount,
    required String totalAmount,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order $orderId',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ...items.map((item) => Text(item)).toList(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping Cost'),
                Text(shippingCost),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount'),
                Text(discount),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  totalAmount,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(String name, int price, int stock, bool isAddable,
      {int quantity = 0, int totalPrice = 0}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              color: Colors.grey[300], // Placeholder for product image
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text('Rp ${price.toString()}',
                      style: TextStyle(color: Colors.grey)),
                  Text('Current Stock: $stock',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            isAddable
                ? ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.orange),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Add item',
                        style: TextStyle(color: Colors.orange)),
                  )
                : Column(
                    children: [
                      Text('Total\nRp $totalPrice',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14)),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.remove_circle_outline,
                                color: Colors.orange),
                          ),
                          Text('$quantity', style: TextStyle(fontSize: 16)),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add_circle_outline,
                                color: Colors.orange),
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
