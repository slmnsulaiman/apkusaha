import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jeriko/app/data/models/Pesanan.dart';
import 'package:jeriko/app/modules/admin/admin_dashboard/controllers/admin_dashboard_controller.dart';
import 'package:jeriko/app/modules/admin/admin_detail_pesanan/views/admin_detail_pesanan_view.dart';
import 'package:jeriko/app/modules/admin/admin_list_pelanggan/views/admin_list_pelanggan_view.dart';
import 'package:jeriko/app/routes/app_pages.dart';
import 'package:jeriko/app/services/idr.dart';

class AdminDashboardView extends GetView {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminDashboardController controller =
        Get.put<AdminDashboardController>(AdminDashboardController());
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Hello'),
            SizedBox(width: 10),
            Text(
              'Admin',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                GetStorage().remove('auth');
                Get.offAllNamed(Routes.WELCOME);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double containerHeight = constraints.maxHeight * 0.15;
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: containerHeight,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.lightBlueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Penjualan",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Obx(
                              () => Text(
                                "${formatter.format(controller.total_penjualan.value)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/icons/total_sales.png',
                        width: containerHeight * 0.5,
                        height: containerHeight * 0.5,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio:
                            constraints.maxWidth < 600 ? 3 / 2 : 2 / 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      children: [
                        buildMenuButton(context, Icons.people, "List Pelanggan",
                            Routes.ADMIN_LIST_PELANGGAN),
                        buildMenuButton(context, Icons.receipt, "List Pesanan",
                            Routes.ADMIN_LIST_PESANAN),
                        buildMenuButton(context, Icons.shopping_bag,
                            "List Produk", Routes.ADMIN_LIST_PRODUK),
                        buildMenuButton(context, Icons.settings, "Pengaturan",
                            Routes.ADMIN_PENGATURAN),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Pesanan Baru',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: controller.pesananStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    return SizedBox(
                      height: 150,
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                              Pesanan pesanan = Pesanan.fromMap(
                                  (document.data()! as Map<String, dynamic>));
                              if (pesanan.status == 'dikemas') {
                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 0,
                                  ),
                                  tileColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                  ),
                                  title: Text(
                                    '${pesanan.nama}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${pesanan.alamat}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            })
                            .toList()
                            .cast(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildMenuButton(
      BuildContext context, IconData icon, String title, String routename) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () {
        Get.toNamed(routename);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
