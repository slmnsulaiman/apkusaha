import 'package:get/get.dart';
import 'package:jeriko/app/modules/admin/admin_list_pelanggan/controllers/admin_list_pelanggan_controller.dart';

class AdminListPelangganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminListPelangganController>(
      () => AdminListPelangganController(),
    );
  }
}
