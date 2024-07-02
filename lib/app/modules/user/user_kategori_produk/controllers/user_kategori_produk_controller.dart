import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jeriko/app/data/models/Produk.dart';

class UserKategoriProdukController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final String kategori = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    getProduk(kategori);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<QuerySnapshot> getProduk(kategori) async {
    final collectionReference =
        db.collection('produks').where('kategori', isEqualTo: kategori);
    return await collectionReference.get();
  }
}
