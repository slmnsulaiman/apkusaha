import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jeriko/app/modules/admin/admin_pengaturan_ongkos/views/admin_pengaturan_ongkos_view.dart';

class AdminPengaturanView extends GetView {
  const AdminPengaturanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  onTap: () {
                    Get.to(() => const AdminPengaturanOngkosView());
                  },
                  title: Text(
                    'Ongkos Kirim',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Ubah Ongkos Kirim',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.black),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.local_shipping, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
