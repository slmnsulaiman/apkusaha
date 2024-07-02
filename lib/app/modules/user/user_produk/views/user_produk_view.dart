import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jeriko/app/data/models/Produk.dart';
import 'package:jeriko/app/modules/user/user_detail_produk/views/user_detail_produk_view.dart';
import 'package:jeriko/app/modules/user/user_kategori_produk/views/user_kategori_produk_view.dart';
import 'package:jeriko/app/modules/user/user_produk/controllers/user_produk_controller.dart';
import 'package:jeriko/app/modules/user/user_produk/views/user_produk_pencarian.dart';
import 'package:jeriko/app/routes/app_pages.dart';

class UserProdukView extends GetView<UserProdukController> {
  const UserProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const UserProdukPencarian());
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    _buildCategoryItem(
                        'Sembako', 'assets/icons/sembako.png', 'sembako'),
                    SizedBox(width: 10),
                    _buildCategoryItem(
                        'Cemilan', 'assets/icons/cemilan.png', 'cemilan'),
                    SizedBox(width: 10),
                    _buildCategoryItem(
                        'Minuman', 'assets/icons/minuman.png', 'minuman'),
                    SizedBox(width: 10),
                    _buildCategoryItem(
                        'Siap Saji', 'assets/icons/makanan.png', 'siap saji'),
                    SizedBox(width: 10),
                    _buildCategoryItem(
                        'Lainnya', 'assets/icons/lainnya.png', 'lainnya'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('produks')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("Produk Kosong"));
                    }
                    List<Produk> produkList =
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Produk.fromMap(document.id, data);
                    }).toList();
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: produkList.length,
                      itemBuilder: (context, index) {
                        Produk produk = produkList[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Get.to(
                                          UserDetailProdukView(produk: produk));
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, String imagePath, String argument) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => const UserKategoriProdukView(), arguments: argument);
        },
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 80,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
