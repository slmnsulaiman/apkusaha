import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jeriko/app/data/models/Produk.dart';
import 'package:jeriko/app/modules/admin/admin_list_produk/controllers/admin_list_produk_controller.dart';
import 'package:jeriko/app/modules/admin/admin_list_produk/views/admin_list_produk_edit.dart';
import 'package:jeriko/app/modules/admin/admin_tambah_produk/views/admin_tambah_produk_view.dart';

class AdminListProdukView extends GetView {
  const AdminListProdukView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminListProdukController controller =
        Get.put<AdminListProdukController>(AdminListProdukController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.to(() => const AdminTambahProdukView());
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: SafeArea(
          child: FutureBuilder(
            future: controller.ambilListProduk(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('Tidak Ada Produk'),
                );
              } else {
                List<DocumentSnapshot> listProduk = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: listProduk.length,
                  itemBuilder: (context, index) {
                    Produk produk = Produk.fromFirestore(
                      listProduk[index]
                          as DocumentSnapshot<Map<String, dynamic>>,
                      null,
                    );
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: InkWell(
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: produk.gambar != null
                                        ? Image.network(
                                            produk.gambar!,
                                            fit: BoxFit.cover,
                                          )
                                        : Placeholder(),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        produk.nama ?? 'Nama Produk Kosong',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Kategori: ${produk.kategori ?? 'Tidak ada'}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Harga: ${produk.harga ?? 'Tidak ada'}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Stok: ${produk.stok ?? 'Tidak ada'}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Get.to(() => AdminListProdukEdit(
                                          produk: produk,
                                          id: listProduk[index].id,
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
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
