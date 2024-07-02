import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jeriko/app/data/models/Produk.dart';
import 'package:jeriko/app/modules/user/user_detail_produk/views/user_detail_produk_view.dart';
import 'package:jeriko/app/modules/user/user_kategori_produk/controllers/user_kategori_produk_controller.dart';

class UserKategoriProdukView extends GetView<UserKategoriProdukController> {
  const UserKategoriProdukView({super.key});
  @override
  Widget build(BuildContext context) {
    UserKategoriProdukController controller =
        Get.put<UserKategoriProdukController>(UserKategoriProdukController());
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.kategori}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
              future: controller.getProduk(controller.kategori),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("Produk Kosong"));
                }
                print(snapshot.data!.docs.runtimeType);
                List<QueryDocumentSnapshot> listProduk = snapshot.data!.docs;
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: listProduk.length,
                  itemBuilder: (context, index) {
                    Produk produk = Produk.fromFirestore(
                        (listProduk[index]
                            as DocumentSnapshot<Map<String, dynamic>>),
                        null);
                    return InkWell(
                      onTap: () {
                        Get.to(UserDetailProdukView(produk: produk));
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                produk.gambar!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    produk.nama!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Get.to(UserDetailProdukView(produk: produk));
                                },
                                splashColor: Colors.yellow.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
