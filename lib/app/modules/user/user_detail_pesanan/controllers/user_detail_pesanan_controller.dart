import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jeriko/app/data/models/Pesanan.dart';
import 'package:jeriko/app/services/geo_service.dart';
import 'package:jeriko/app/modules/user/user_pesanan/controllers/user_pesanan_controller.dart';

class UserDetailPesananController extends GetxController {
  UserPesananController userPesananController =
      Get.put(UserPesananController());
  FirebaseFirestore db = FirebaseFirestore.instance;
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

  ambilLokasi(Pesanan pesanan) async {
    try {
      Position position = await getCoordinates();
      double latitude = position.latitude;
      double longitude = position.longitude;

      final docRef = db.collection("pesanans").doc(pesanan.id);
      docRef.update({
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      });
      userPesananController.status.value = '';
      Get.back();
      Get.snackbar(
          'Berhasil', 'Berhasil Melakukan Pengambilan Titik Koordinat');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  selesaikanPesanan(Pesanan pesanan) async {
    try {
      Get.defaultDialog(
        title: 'Proses',
        content: Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: true,
      );
      final collectionRef = db
          .collection("pesanans")
          .doc('${pesanan.uuid_user}-${pesanan.tanggal}');
      await collectionRef.update({'status': 'selesai'});
      Get.back();
      Get.snackbar('Berhasil', 'Berhasil Memperbarui Status');
    } catch (e) {
      Get.snackbar('Error', 'Gagal Memperbarui Status: ${e.toString()}');
      print("Error updating document: $e");
    }
  }
}
