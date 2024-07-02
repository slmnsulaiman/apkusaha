import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeriko/app/data/models/Produk.dart';
import 'package:jeriko/app/data/models/User.dart';
import 'package:jeriko/app/modules/user/user_detail_produk/views/user_detail_produk_view.dart';
import 'package:jeriko/app/modules/user/user_produk/controllers/user_produk_controller.dart';
import 'package:jeriko/app/services/idr.dart';

class UserProdukPencarian extends StatelessWidget {
  const UserProdukPencarian({super.key});

  @override
  Widget build(BuildContext context) {
    UserProdukController controller =
        Get.put<UserProdukController>(UserProdukController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Pencarian Produk"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                controller.pencarianQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'Ketikkan Nama Produk...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: GetBuilder<UserProdukController>(
          builder: (controller) {
            return FutureBuilder<QuerySnapshot>(
              future: controller.hasilPencarian(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak Ada Pencarian yang Cocok dengan Kata Kunci "${controller.query.value}"',
                    ),
                  );
                } else {
                  List<QueryDocumentSnapshot> listProduk = snapshot.data!.docs;
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: listProduk.length,
                    itemBuilder: (context, index) {
                      Produk produk = Produk.fromFirestore(
                        listProduk[index]
                            as DocumentSnapshot<Map<String, dynamic>>,
                        null,
                      );
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          onTap: () {
                            Get.to(UserDetailProdukView(produk: produk));
                          },
                          contentPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: Colors.white,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              produk.gambar!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            produk.nama!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${formatter.format(produk.harga)}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
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
    );
  }
}
