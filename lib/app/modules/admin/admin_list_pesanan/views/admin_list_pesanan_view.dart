import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jeriko/app/data/models/Pesanan.dart';
import 'package:jeriko/app/modules/admin/admin_detail_pesanan/views/admin_detail_pesanan_view.dart';
import 'package:jeriko/app/modules/admin/admin_list_pesanan/controllers/admin_list_pesanan_controller.dart';

class AdminListPesananView extends GetView {
  const AdminListPesananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminListPesananController controller =
        Get.put<AdminListPesananController>(AdminListPesananController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Pesanan'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            GetBuilder<AdminListPesananController>(
              builder: (controller) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.listStatusPesanan.map((status) {
                      return InkWell(
                        onTap: () {
                          controller.gantiStatusPesanan(status);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: controller.statusPesanan.value == status
                                ? Colors.blue
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: controller.statusPesanan.value == status
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            GetBuilder<AdminListPesananController>(
              builder: (controller) {
                return FutureBuilder(
                  future: controller
                      .ambilListPesanan(controller.statusPesanan.value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text('Tidak Ada Pesanan'),
                      );
                    } else {
                      List<DocumentSnapshot> listPesanan = snapshot.data!.docs;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: listPesanan.length,
                          itemBuilder: (context, index) {
                            Pesanan pesanan = Pesanan.fromFirestore(
                              (listPesanan[index]
                                  as DocumentSnapshot<Map<String, dynamic>>),
                              null,
                            );
                            return InkWell(
                              onTap: () {
                                Get.to(() =>
                                    AdminDetailPesananView(pesanan: pesanan));
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                elevation: 4.0,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  title: Text(
                                    '${pesanan.nama}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${pesanan.alamat} - ${pesanan.nomor_wa}'),
                                      SizedBox(height: 4.0),
                                      Text(
                                        'Harga: ${pesanan.total_harga}',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(Icons.arrow_forward),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
