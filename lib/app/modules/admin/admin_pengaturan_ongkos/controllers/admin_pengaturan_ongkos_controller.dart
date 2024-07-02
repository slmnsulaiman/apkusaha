import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPengaturanOngkosController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController ongkos_kirim = TextEditingController();
  RxDouble ongkos = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    ambil();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ambil() {
    db.collection("pengaturan").doc("ongkos").get().then((value) {
      Map<String, dynamic>? hasil = value.data();
      ongkos.value = hasil!['harga'];
    });
  }

  simpan(double Ongkos) {
    db.collection("pengaturan").doc("ongkos").set({"harga": Ongkos});
    Get.snackbar('Berhasil', 'Berhasil Memperbarui Ongkos Kirim');
    ambil();
  }
}
