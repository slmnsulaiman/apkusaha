import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminListPelangganController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

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

  Future<QuerySnapshot> listPelanggan() async {
    CollectionReference collectionReference = db.collection('users');
    QuerySnapshot querySnapshot = await collectionReference.get();
    return querySnapshot;
  }
}
