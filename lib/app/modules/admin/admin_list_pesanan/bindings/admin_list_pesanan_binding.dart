import 'package:get/get.dart';
import 'package:jeriko/app/modules/admin/admin_list_pesanan/controllers/admin_list_pesanan_controller.dart';

class AdminListPesananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminListPesananController>(
      () => AdminListPesananController(),
    );
  }
}
