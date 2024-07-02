import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jeriko/app/data/models/Pesanan.dart';
import 'package:jeriko/app/data/models/Produk.dart';

class UserPesananController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxString status = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List<Map<String, dynamic>>> itemPesanan(String status) async {
    Map<String, dynamic> user = GetStorage().read('auth');
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("pesanans")
          .where("status", isEqualTo: status.toLowerCase())
          .where("uuid_user", isEqualTo: user['uuid'])
          .get();

      List<Map<String, dynamic>> tempList = [];

      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> doc = docSnapshot.data() as Map<String, dynamic>;
        doc['id'] = docSnapshot.id;
        tempList.add(doc);
      }

      return tempList;
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }

  void statusTerpilih(value) {
    status.value = value;
    update();
  }
}
