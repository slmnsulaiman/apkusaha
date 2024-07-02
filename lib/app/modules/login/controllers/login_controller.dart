import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jeriko/app/data/models/User.dart';
import 'package:jeriko/app/routes/app_pages.dart';

class LoginController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final box = GetStorage();

  TextEditingController emailTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();
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

  login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Harap Isi Semua Informasi yang Diperlukan');
    } else if (!email.isEmail) {
      Get.snackbar('Error', 'Penulisan Email tidak Valid');
    } else {
      final docRef = db.collection('users').doc(email);
      final userDoc = await docRef.get();
      if (userDoc.data() == null) {
        Get.snackbar('Error', 'Akun Tidak Terdaftar');
      }
      User user = User.fromFirestore(userDoc, null);
      if (password != user.password) {
        Get.snackbar('Error', 'Password Salah');
      } else {
        box.write('auth', {
          'uuid': user.uuid,
          'nama': user.nama,
          'email': user.email,
          'password': user.password,
          'nomor_hp': user.nomor_hp,
          'role': user.role,
        });
        if (user.role == 'pembeli') {
          Get.offAllNamed(Routes.HOME_USER);
        } else {
          Get.offAllNamed(Routes.ADMIN_DASHBOARD);
        }
      }
    }
  }

  togglePassword() {
    obsecure.value = !obsecure.value;
  }
}
