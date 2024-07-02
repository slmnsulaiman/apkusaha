import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AdminListPesananController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> listStatusPesanan = [
    'Dikemas',
    'Dikirim',
    'Selesai',
    'Dibatalkan'
  ];
  RxString statusPesanan = 'Dikemas'.obs;

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

  Future<QuerySnapshot> ambilListPesanan(status) async {
    status = status.toLowerCase();
    final collection =
        db.collection('pesanans').where('status', isEqualTo: status);
    QuerySnapshot getCollection = await collection.get();
    return getCollection;
  }

  gantiStatusPesanan(status) {
    statusPesanan.value = status;
    update();
  }
}
