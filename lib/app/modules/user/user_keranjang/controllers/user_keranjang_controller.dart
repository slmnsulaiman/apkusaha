import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserKeranjangController extends GetxController {
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

  tambahStok(int index) {
    RxList<Map<String, dynamic>> carts =
        (box.read<List>('carts') ?? []).cast<Map<String, dynamic>>().obs;
    carts[index]['stok'] += 1;
  }

  kurangiStok(int index) {
    RxList<Map<String, dynamic>> carts =
        (box.read<List>('carts') ?? []).cast<Map<String, dynamic>>().obs;
    if (carts[index]['stok'] != 1) {
      carts[index]['stok'] -= 1;
    } else {
      Get.snackbar('Error', 'Stok Keranjang Minimal 1');
    }
  }
}
