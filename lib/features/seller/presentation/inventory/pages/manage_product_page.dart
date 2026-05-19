import 'package:flutter/material.dart';
import 'package:pawtastic/shared/widgets/custom_app_bar.dart';
import 'package:pawtastic/i10n/strings.g.dart';
import 'package:pawtastic/core/utils/string_extension.dart';
import 'package:pawtastic/features/seller/presentation/inventory/pages/edit_product_page.dart';

class ManageProductPage extends StatelessWidget {
  const ManageProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data produk
    final List<Map<String, dynamic>> products = [
      {
        'image':
            'images/products/DIMILIN_Obat_Kutu_untuk_Ikan_Koi_Maskoki_dan_ikan_hias.jpg',
        'name': 'DIMILIN Obat Kutu untuk Ikan Koi, M...',
        'price': 'Rp 100.000',
        'stock': 20,
      },
      {
        'image':
            'images/products/KANDANG_HAMSTER_2_TINGKAT_LENGKAP_BERKUALITAS_RUMAH_HAMSTER.jpg',
        'name': 'KANDANG HAMSTER 2 TINGKAT LENG...',
        'price': 'Rp 350.000',
        'stock': 15,
      },
      {
        'image':
            'images/products/Primadex_Anti_Kembung_dan_Diare_Hamster_10ml.jpg',
        'name': 'Primadex Anti Kembung dan Diare ...',
        'price': 'Rp 58.000',
        'stock': 50,
      },
      {
        'image':
            'images/products/Makanan_Hamster_Jolly_Multivitamin_Hamster_Food_400gr.jpg',
        'name': 'Makanan Hamster Jolly Multivitami...',
        'price': 'Rp 220.000',
        'stock': 30,
      },
      {
        'image': 'images/products/Vitagel_multivitamin_anjing_kucing_hamster.jpg',
        'name': 'Vitagel obat suplemen vitamin mul...',
        'price': 'Rp 25.000',
        'stock': 100,
      },
    ];

    return Scaffold(
      appBar: CustomAppBar.leftTitle(
        context,
        title: context.t.seller_product.manage_product.product_list.toTitleCase(),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Gambar produk
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        product['image'],
                        height: 70.0,
                        width: 70.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12.0),

                    // Detail produk
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama produk
                          Text(
                            product['name'],
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4.0),

                          // Harga produk
                          Text(
                            product['price'],
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(252, 147, 3, 1.0),
                            ),
                          ),
                          const SizedBox(height: 4.0),

                          // Informasi stok
                          Text(
                            context.t.seller_product.manage_product.current_stock(stock: product['stock'].toString()).ucfirst(),
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),

                          // Tombol Edit
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                // Navigasi ke halaman edit
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProductPage(product: product),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(252, 147, 3, 1.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                              ),
                              child: Text(
                                context.t.common.edit.toTitleCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
