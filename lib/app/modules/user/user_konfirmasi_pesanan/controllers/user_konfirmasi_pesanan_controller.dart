import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jeriko/app/data/models/Pesanan.dart';
import 'package:jeriko/app/data/models/Produk.dart';
import 'package:jeriko/app/routes/app_pages.dart';
import 'package:jeriko/app/services/geo_service.dart';
import 'package:uuid/uuid.dart';

class UserKonfirmasiPesananController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final box = GetStorage();
  var uuid = Uuid();
  String? latitude;
  String? longitude;
  TextEditingController nomor = TextEditingController();
  TextEditingController alamat = TextEditingController();
  RxDouble ongkos = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    setDefaults();
    ambilOngkos();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  simpanPesanan() async {
    try {
      Get.defaultDialog(
        title: 'Proses',
        content: Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      if (nomor.text.isEmpty) {
        Get.snackbar('Error', 'Tambahkan Nomor WA');
      }
      Map<String, dynamic> user = box.read('auth');
      List<Map<String, dynamic>> keranjang =
          (box.read<List>('carts') ?? []).cast<Map<String, dynamic>>();
      double totalPesanan = box.read('total');

      keranjang.forEach((item) async {
        final docRef =
            db.collection("produks").where('nama', isEqualTo: item['nama']);
        QuerySnapshot snapshot = await docRef.get();
        for (var snapshotData in snapshot.docs) {
          Map<String, dynamic> dataSnapshot =
              snapshotData.data() as Map<String, dynamic>;
          final produkRef = db.collection("produks").doc(snapshotData.id);
          produkRef.update({
            'stok': dataSnapshot['stok'] - item['stok'],
          });
        }
      });

      final pesanan = Pesanan(
        uuid_user: user['uuid'],
        nama: user['nama'],
        alamat: '${alamat.text}',
        nomor_wa: int.parse(nomor.text),
        tanggal: '${DateTime.now().toString()}',
        status: 'dikemas',
        barang: keranjang,
        total_harga: totalPesanan + ongkos.value,
        latitude: latitude == null ? null : latitude,
        longitude: longitude == null ? null : longitude,
        ongkos_kirim: ongkos.value,
      );
      final docRef = db
          .collection('pesanans')
          .withConverter(
            fromFirestore: Pesanan.fromFirestore,
            toFirestore: (Pesanan pesanan, options) => pesanan.toFirestore(),
          )
          .doc('${pesanan.uuid_user}-${pesanan.tanggal}');
      await docRef.set(pesanan);
      await box.remove('carts');
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString(), duration: const Duration(minutes: 1));
    }
  }

  ambilLokasi() async {
    try {
      Position position = await getCoordinates();
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      Placemark placemark = await getAddressFromLatLang(position);
      alamat.text = '${placemark.street}';
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void setDefaults() {
    Map<String, dynamic> user = box.read('auth');
    if (user['nomor_hp'] != null) {
      nomor.text = user['nomor_hp'].toString();
    }
  }

  ambilOngkos() {
    db.collection("pengaturan").doc("ongkos").get().then((value) {
      Map<String, dynamic>? hasil = value.data();
      ongkos.value = hasil!['harga'];
    });
  }
}
