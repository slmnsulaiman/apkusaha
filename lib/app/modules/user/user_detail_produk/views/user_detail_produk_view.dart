import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeriko/app/data/models/Produk.dart';
import 'package:jeriko/app/modules/user/user_detail_produk/controllers/user_detail_produk_controller.dart';
import 'package:jeriko/app/services/idr.dart';

class UserDetailProdukView extends GetView<UserDetailProdukController> {
  final Produk produk;
  UserDetailProdukView({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    UserDetailProdukController controller =
        Get.put<UserDetailProdukController>(UserDetailProdukController());

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  produk.gambar!,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.6,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                produk.nama!,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${formatter.format(produk.harga)}',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Stok: ${produk.stok}',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Detail Produk',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${produk.deskripsi}',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.tambahCart(produk);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
                  child: Text('Tambah ke Keranjang'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
