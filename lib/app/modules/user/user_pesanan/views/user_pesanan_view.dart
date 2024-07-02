import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jeriko/app/data/models/Pesanan.dart';
import 'package:jeriko/app/data/models/Produk.dart';
import 'package:jeriko/app/modules/user/user_detail_pesanan/views/user_detail_pesanan_view.dart';
import 'package:jeriko/app/modules/user/user_pesanan/controllers/user_pesanan_controller.dart';
import 'package:jeriko/app/services/idr.dart';

class UserPesananView extends GetView<UserPesananController> {
  const UserPesananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserPesananController controller =
        Get.put<UserPesananController>(UserPesananController());
    List<String> statusPesanan = [
      'Dikemas',
      'Dikirim',
      'Selesai',
      'Dibatalkan',
    ];
    DateFormat format = new DateFormat("MMMM dd, yyyy");
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Center(
                  child: GetBuilder<UserPesananController>(
                    builder: (controller) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: statusPesanan.map((status) {
                            return InkWell(
                              onTap: () async {
                                controller.statusTerpilih(status);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                margin: EdgeInsets.only(
                                  top: 30,
                                  left: 10,
                                  bottom: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      controller.status.value == status
                                          ? Colors.blueAccent.withOpacity(0.8)
                                          : Colors.white,
                                      Colors.blueAccent.withOpacity(0.3),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: controller.status.value == status
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: GetBuilder<UserPesananController>(
                  builder: (controller) {
                    return FutureBuilder(
                      future: controller.itemPesanan(controller.status.value),
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              'Tidak Ada Pesanan dengan Status ${controller.status.value}',
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        } else {
                          List<Pesanan> listPesanan = snapshot.data!
                              .map((e) => Pesanan.fromMap(e))
                              .toList();
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Pesanan pesanan = listPesanan[index];
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 20),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.white, Colors.blue.shade50],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () => Get.to(
                                    () => UserDetailPesananView(
                                      pesanan: pesanan,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${DateFormat('d MMMM y').format(DateTime.parse(pesanan.tanggal!))} - ${DateFormat('HH:mm').format(DateTime.parse(pesanan.tanggal!))}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total Pembayaran',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            '${formatter.format(pesanan.total_harga)}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
