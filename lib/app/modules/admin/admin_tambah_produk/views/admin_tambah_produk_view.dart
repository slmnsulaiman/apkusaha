import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeriko/app/modules/admin/admin_tambah_produk/controllers/admin_tambah_produk_controller.dart';

class AdminTambahProdukView extends GetView {
  const AdminTambahProdukView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminTambahProdukController controller =
        Get.put<AdminTambahProdukController>(AdminTambahProdukController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<AdminTambahProdukController>(builder: (controller) {
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
                GetBuilder<AdminTambahProdukController>(
                  builder: (controller) {
                    return Center(
                      child: controller.previewGambar == null
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
                                    child: Image.file(
                                      File(controller.previewGambar!),
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
                      'Simpan Produk',
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
