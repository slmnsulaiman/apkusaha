import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserProdukController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final box = GetStorage();
  RxString query = ''.obs;

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

  void pencarianQuery(String pencarian) {
    query.value = pencarian;
    hasilPencarian();
    update();
  }

  Future<QuerySnapshot> hasilPencarian() async {
    Query queryFB = db
        .collection("produks")
        .where("nama", isEqualTo: '${query.value.toLowerCase()}');
    QuerySnapshot dataQuery = await queryFB.get();
    return dataQuery;
  }

  Stream<QuerySnapshot<Object?>>? produkStream() {
    return db.collection('produks').snapshots();
  }
}
