import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserPasswordController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final box = GetStorage();
  TextEditingController passwordLama = TextEditingController();
  TextEditingController passwordBaru = TextEditingController();
  TextEditingController konfirmasiPasswordBaru = TextEditingController();
  RxBool obsecure = true.obs;

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

  Future<void> updatePassword(String passwordLama, String passwordBaru,
      String konfirmasiPasswordBaru) async {
    Map<String, dynamic> autentikasi = box.read('auth');

    if (passwordLama != autentikasi['password']) {
      Get.snackbar('Error', 'Password Lama Tidak Sama dengan Sebelumnya');
      return;
    }

    if (passwordBaru != konfirmasiPasswordBaru) {
      Get.snackbar(
          'Error', 'Password Baru tidak sama dengan Password Konfirmasi');
      return;
    }

    Get.defaultDialog(
      title: 'Proses',
      content: const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(autentikasi['email']).update({
        'password': passwordBaru,
      });

      Get.back();
      Get.snackbar('Berhasil', 'Berhasil Memperbarui Password');
    } catch (error) {
      Get.back();
      Get.snackbar('Error', 'Gagal Memperbarui Password');
      print("Failed to update user: $error");
    }
  }

  void tombolLihatPassword() {
    obsecure.value = !obsecure.value;
  }
}
