import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeriko/app/data/models/Produk.dart';
import 'package:path/path.dart' as path;

class AdminTambahProdukController extends GetxController {
  TextEditingController nama = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController stok = TextEditingController();

  final storageRef = FirebaseStorage.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<String> kategories = [
    'sembako',
    'cemilan',
    'minuman',
    'siap saji',
    'lainnya',
  ];
  RxString kategoriTerpilih = ''.obs;
  String? previewGambar;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  simpanProduk(String nama, String deskripsi, String harga, String stok) async {
    if (kategoriTerpilih.value == '') {
      Get.snackbar('Error', 'Pilih Kategori Terlebih Dahulu');
    } else if (previewGambar == null) {
      Get.snackbar('Error', 'Tambahkan Gambar pada Produk Terlebih Dahulu');
    } else if (nama.isEmpty ||
        deskripsi.isEmpty ||
        harga.isEmpty ||
        stok.isEmpty) {
      Get.snackbar('Error', 'Isi Semua Formulir yang Diperlukan');
    } else {
      final extension = path.extension(previewGambar!).substring(1);
      final imageRef = storageRef.child('${nama}.${extension}');
      await imageRef.putFile(
        File(previewGambar!),
        SettableMetadata(
          contentType: "image/${extension}",
        ),
      );

      final produk = Produk(
        nama: nama.toLowerCase(),
        deskripsi: deskripsi,
        harga: double.parse(harga),
        stok: double.parse(stok),
        kategori: kategoriTerpilih.value.toLowerCase(),
        gambar: await imageRef.getDownloadURL(),
      );
      final docRef = db
          .collection("produks")
          .withConverter(
            fromFirestore: Produk.fromFirestore,
            toFirestore: (Produk produk, options) => produk.toFirestore(),
          )
          .doc();
      await docRef.set(produk);
      Get.back(result: true);
      Get.snackbar('Berhasil', 'Berhasil Menambah Produk');
    }
  }

  imagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    previewGambar = image!.path;
    update();
  }

  gantiKategoriTerpilih(kategori) {
    kategoriTerpilih.value = kategori;
    update();
  }
}
