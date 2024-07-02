import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jeriko/app/data/models/Pesanan.dart';

class AdminDashboardController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxDouble total_penjualan = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    totalPenjualan();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  totalPenjualan() async {
    db.collection("pesanans").where("status", isEqualTo: "selesai").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Pesanan pesanan = Pesanan.fromMap(docSnapshot.data());
          total_penjualan.value += pesanan.total_harga!;
        }
      },
    );
  }

  Stream<QuerySnapshot> pesananStream() {
    return FirebaseFirestore.instance.collection('pesanans').snapshots();
  }
}
