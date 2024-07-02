import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserProfileInformasiController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final box = GetStorage();
  TextEditingController nama = TextEditingController();
  TextEditingController nomor = TextEditingController();
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

  updateUser(String nama, String nomor) {
    if (nama.isEmpty || nomor.isEmpty) {
      Get.snackbar('Error', 'Isi Semua Informasi yang Ada');
    } else if (!nomor.isNum) {
      Get.snackbar('Error', 'Pengisian Nomor Harus Berupa Angka');
    } else {
      Map<String, dynamic> autentikasi = box.read('auth');
      Get.defaultDialog(
          title: 'Proses',
          content: const Center(
            child: CircularProgressIndicator(),
          ));
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      return users.doc(autentikasi['email']).update({
        'nama': nama,
        'nomor_hp': nomor,
      }).then(
        (value) {
          autentikasi['nama'] = nama;
          autentikasi['nomor_hp'] = nomor;
          Get.back();
          Get.snackbar('Berhasil', 'Berhasil Memperbarui Profile');
        },
      ).catchError(
        (error) => print("Failed to update user: $error"),
      );
    }
  }
}
