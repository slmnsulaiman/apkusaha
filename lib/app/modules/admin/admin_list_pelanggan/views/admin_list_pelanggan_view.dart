import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jeriko/app/modules/admin/admin_list_pelanggan/controllers/admin_list_pelanggan_controller.dart';

class AdminListPelangganView extends GetView {
  const AdminListPelangganView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminListPelangganController controller =
        Get.put<AdminListPelangganController>(AdminListPelangganController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Pelanggan'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: FutureBuilder(
            future: controller.listPelanggan(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                );
              } else if (snapshot.hasError) {
                return const Text(
                  'Sepertinya ada yang salah',
                  style: TextStyle(color: Colors.red),
                );
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Text(
                  'Tidak Ada Pelanggan',
                  style: TextStyle(color: Colors.grey),
                );
              } else {
                List<QueryDocumentSnapshot> listPelanggan = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: listPelanggan.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot pelanggan = listPelanggan[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            pelanggan['nama'][0].toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          pelanggan['nama'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          pelanggan['nomor_hp'],
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
