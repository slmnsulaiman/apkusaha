import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jeriko/app/data/models/User.dart';
import 'package:jeriko/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';

class RegisterController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final uuid = Uuid();
  final box = GetStorage();

  TextEditingController nama = TextEditingController();
  TextEditingController nomor = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController konfirmasi_password = TextEditingController();

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

  register(
    String nama,
    String nomor,
    String email,
    String password,
    String konfirmasi_password,
  ) async {
    if (nama.isEmpty ||
        nomor.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        konfirmasi_password.isEmpty) {
      Get.snackbar('Error', 'Harap Isi Semua Informasi yang Diperlukan');
    } else if (!email.isEmail) {
      Get.snackbar('Error', 'Harap Masukkan Email yang Valid');
    } else if (!nomor.isNum) {
      Get.snackbar('Error', 'Harap Masukkan Nomor yang Valid');
    } else if (password != konfirmasi_password) {
      Get.snackbar('Error', 'Password Tidak Sama');
    } else {
      try {
        if (await cekUser(email)) {
          final user = User(
            uuid: uuid.v4(),
            nama: nama,
            nomor_hp: nomor,
            email: email,
            password: password,
            role: 'pembeli',
          );
          final docRef = db
              .collection("users")
              .withConverter(
                fromFirestore: User.fromFirestore,
                toFirestore: (User user, options) => user.toFirestore(),
              )
              .doc(email);
          await docRef.set(user);
          box.write('auth', {
            'uuid': user.uuid,
            'nama': user.nama,
            'email': user.email,
            'password': user.password,
            'nomor_hp': user.nomor_hp,
            'role': user.role,
          });
          Get.offAllNamed(Routes.HOME_USER);
        } else {
          Get.back();
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  togglePassword() {
    obsecure.value = !obsecure.value;
  }

  cekUser(String email) async {
    DocumentReference docRef = db.collection("users").doc(email);
    DocumentSnapshot userDoc = await docRef.get();
    if (userDoc.data() != null) {
      Get.snackbar('Error', 'Akun Sudah Terdaftar');
      return false;
    } else {
      return true;
    }
  }
}
