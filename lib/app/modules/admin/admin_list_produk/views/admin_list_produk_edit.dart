import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeriko/app/data/models/Produk.dart';
import 'package:jeriko/app/modules/admin/admin_list_produk/controllers/admin_list_produk_controller.dart';
import 'package:jeriko/app/modules/admin/admin_tambah_produk/controllers/admin_tambah_produk_controller.dart';

class AdminListProdukEdit extends StatelessWidget {
  Produk produk;
  String id;

  AdminListProdukEdit({super.key, required this.produk, required this.id});

  @override
  Widget build(BuildContext context) {
    AdminListProdukController controller =
        Get.put<AdminListProdukController>(AdminListProdukController());
    controller.kategoriTerpilih.value = produk.kategori!;
    controller.nama.text = produk.nama!;
    controller.deskripsi.text = produk.deskripsi!;
    controller.harga.text = produk.harga!.toString();
    controller.stok.text = produk.stok!.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('${produk.nama}'),
        actions: [
          IconButton(
            onPressed: () {
              controller.delete(id);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<AdminListProdukController>(builder: (controller) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.kategories.map((kategori) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: InkWell(
                            onTap: () {
                              controller.gantiKategoriTerpilih(kategori);
                            },
                            child: Chip(
                              label: Text(
                                kategori,
                                style: TextStyle(
                                  color: controller.kategoriTerpilih.value ==
                                          kategori
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              backgroundColor:
                                  controller.kategoriTerpilih.value == kategori
                                      ? Colors.blue
                                      : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 4.0,
                              shadowColor: Colors.grey[60],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                GetBuilder<AdminListProdukController>(
                  builder: (controller) {
                    return Center(
                      child: produk.gambar == null
                          ? ElevatedButton.icon(
                              onPressed: () {
                                controller.imagePicker();
                              },
                              icon: const Icon(Icons.add_a_photo),
                              label: const Text('Tambahkan Gambar'),
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(240, 50),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.blue,
                                shadowColor: Colors.blueAccent,
                                elevation: 5.0,
                                foregroundColor: Colors.white,
                              ),
                            )
                          : Column(
                              children: [
                                Card(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      produk.gambar!,
                                      width: 100,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    controller.imagePicker();
                                  },
                                  icon: const Icon(Icons.image),
                                  label: const Text('Ganti Gambar'),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(150, 20),
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor: Colors.blue,
                                    shadowColor: Colors.blueAccent,
                                    elevation: 5.0,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.nama,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0XFFECF0F1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintText: 'Nama Produk',
                    hintStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.deskripsi,
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0XFFECF0F1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintText: 'Deskripsi Produk',
                    hintStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.harga,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0XFFECF0F1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintText: 'Harga Produk',
                    hintStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.stok,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0XFFECF0F1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintText: 'Stok Produk',
                    hintStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.simpanProduk(
                        id,
                        produk,
                        controller.nama.text,
                        controller.deskripsi.text,
                        controller.harga.text,
                        controller.stok.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(20, 20),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.blueAccent,
                      elevation: 5.0,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Perbarui Produk',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
