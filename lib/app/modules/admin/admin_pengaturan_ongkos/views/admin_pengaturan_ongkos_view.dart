import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeriko/app/modules/admin/admin_pengaturan_ongkos/controllers/admin_pengaturan_ongkos_controller.dart';
import 'package:jeriko/app/services/idr.dart';

class AdminPengaturanOngkosView extends StatelessWidget {
  const AdminPengaturanOngkosView({super.key});

  @override
  Widget build(BuildContext context) {
    AdminPengaturanOngkosController controller =
        Get.put<AdminPengaturanOngkosController>(
            AdminPengaturanOngkosController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ongkos Kirim'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(
                  () => Text(
                    'Ongkos Kirim saat: ${formatter.format(controller.ongkos.value)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: controller.ongkos_kirim,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Ongkos Kirim',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.local_shipping, color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    double ongkosKirim =
                        double.parse(controller.ongkos_kirim.text);
                    controller.simpan(ongkosKirim);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
