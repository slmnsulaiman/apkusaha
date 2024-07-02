import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserProfileController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final box = GetStorage();

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

  Stream<DocumentSnapshot> getProfile() {
    Map<String, dynamic> autentikasi = box.read('auth');
    return db.collection('users').doc(autentikasi['email']).snapshots();
  }
}
