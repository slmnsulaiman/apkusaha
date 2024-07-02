import 'package:get/get.dart';
import 'package:jeriko/app/modules/admin/admin_list_produk/controllers/admin_list_produk_controller.dart';

class AdminListProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminListProdukController>(
      () => AdminListProdukController(),
    );
  }
}
