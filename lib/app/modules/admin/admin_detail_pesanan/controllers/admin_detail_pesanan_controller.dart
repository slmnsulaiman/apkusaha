import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jeriko/app/data/models/Pesanan.dart';
import 'package:jeriko/app/services/geo_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class AdminDetailPesananController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController alasan_pembatalan = TextEditingController();

  RxDouble latitudeNavigasi = 0.0.obs;
  RxDouble longitudeNavigasi = 0.0.obs;
  final RxList<LatLng> routePoints = <LatLng>[].obs;

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
    Position position = await getCoordinates();
    latitudeNavigasi.value = position.latitude;
    longitudeNavigasi.value = position.longitude;
    fetchRoute(pesanan);
  }

  Future<void> fetchRoute(Pesanan pesanan) async {
    final url =
        'https://router.project-osrm.org/route/v1/bike/${longitudeNavigasi.value},${latitudeNavigasi.value};${pesanan.longitude},${pesanan.latitude}?overview=full&geometries=geojson';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 'Ok') {
          final List<dynamic> coordinates =
              data['routes'][0]['geometry']['coordinates'];
          routePoints.clear();
          coordinates.forEach((coord) {
            routePoints.add(LatLng(coord[1], coord[0]));
          });
        } else {
          print('No route found: ${data['message']}');
        }
      } else {
        print('Failed to fetch route: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching route: $e');
    }
  }

  kirimPesanan(Pesanan pesanan) async {
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
      await collectionRef.update({'status': 'dikirim'});
      Get.back();
      Get.snackbar('Berhasil', 'Berhasil Memperbarui Status');
    } catch (e) {
      Get.snackbar('Error', 'Gagal Memperbarui Status: ${e.toString()}');
      print("Error updating document: $e");
    }
  }

  batalkanPesanan(Pesanan pesanan) async {
    try {
      Get.defaultDialog(
        title: 'Pembatalan Pesanan',
        titleStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.redAccent,
        ),
        content: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: alasan_pembatalan,
                  decoration: InputDecoration(
                    labelText: 'Alasan Pembatalan',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                  maxLines: 3,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (alasan_pembatalan.text.isEmpty) {
                    Get.snackbar('Error', 'Masukkan Alasan Pembatalan');
                  } else {
                    final collectionRef = db
                        .collection("pesanans")
                        .doc('${pesanan.uuid_user}-${pesanan.tanggal}');
                    await collectionRef.update({
                      'status': 'dibatalkan',
                      'alasan_pembatalan': alasan_pembatalan.text
                    });
                    Get.back();
                    Get.snackbar('Berhasil', 'Berhasil Membatalkan Pesanan');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  'Batalkan',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      Get.snackbar('Error', 'Gagal Memperbarui Status: ${e.toString()}');
      print("Error updating document: $e");
    }
  }
}
