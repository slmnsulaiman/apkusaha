import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:jeriko/app/data/models/Pesanan.dart';
import 'package:jeriko/app/modules/admin/admin_detail_pesanan/controllers/admin_detail_pesanan_controller.dart';
import 'package:latlong2/latlong.dart';

class AdminDetailPesananNavigasi extends StatelessWidget {
  Pesanan pesanan;

  AdminDetailPesananNavigasi({super.key, required this.pesanan});

  @override
  Widget build(BuildContext context) {
    AdminDetailPesananController controller =
        Get.put<AdminDetailPesananController>(AdminDetailPesananController());
    controller.ambilLokasi(pesanan);
    controller.fetchRoute(pesanan);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.ambilLokasi(pesanan);
          controller.fetchRoute(pesanan);
        },
        child: Icon(Icons.gps_fixed),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialZoom: 17.0,
              initialCenter: LatLng(
                double.parse(pesanan.latitude as String),
                double.parse(pesanan.longitude as String),
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                      double.parse(pesanan.latitude as String),
                      double.parse(pesanan.longitude as String),
                    ),
                    width: 100,
                    height: 100,
                    child: Icon(Icons.location_on),
                  ),
                ],
              ),
              Obx(
                () => MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        controller.latitudeNavigasi.value,
                        controller.longitudeNavigasi.value,
                      ),
                      width: 100,
                      height: 100,
                      child: Icon(Icons.person),
                    ),
                  ],
                ),
              ),
              Obx(
                () => PolylineLayer(
                  polylines: [
                    Polyline(
                      points: controller.routePoints.value,
                      strokeWidth: 4,
                      color: Colors.blue,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
