import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeriko/app/modules/user/user_keranjang/controllers/user_keranjang_controller.dart';
import 'package:jeriko/app/routes/app_pages.dart';
import 'package:jeriko/app/services/idr.dart';

class UserKeranjangView extends GetView<UserKeranjangController> {
  UserKeranjangView({super.key});

  RxList<Map<String, dynamic>> carts =
      (GetStorage().read<List>('carts') ?? []).cast<Map<String, dynamic>>().obs;

  deleteCarts(int index) {
    carts.removeAt(index);
    GetStorage().write('carts', carts.toList());
  }

  @override
  Widget build(BuildContext context) {
    UserKeranjangController controller =
        Get.put<UserKeranjangController>(UserKeranjangController());
    final box = GetStorage();
    double totalPembelanjaan() {
      double total = 0;
      for (int i = 0; i < carts.length; i++) {
        total += carts[i]['harga'] * carts[i]['stok'];
      }
      box.write('total', total);
      return total;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: carts.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> produk = carts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 16.0,
                      ),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                produk['gambar'],
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${produk['nama']}',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '${formatter.format(produk['harga'])}',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.kurangiStok(index);
                                          carts.refresh();
                                        },
                                        icon: Icon(Icons.remove),
                                      ),
                                      Text(
                                        '${produk['stok']}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.tambahStok(index);
                                          carts.refresh();
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.grey),
                              onPressed: () {
                                deleteCarts(index);
                                Get.snackbar('Berhasil',
                                    'Berhasil Menghapus Produk dalam Keranjang');
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (carts.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Obx(
                        () => Text(
                          'Total: ${formatter.format(totalPembelanjaan())}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.KONFIRMASI_PESANAN_USER);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(120, 50),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        shadowColor: Colors.blueAccent,
                        elevation: 5.0,
                        textStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      child: Text(
                        'Pesan',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
