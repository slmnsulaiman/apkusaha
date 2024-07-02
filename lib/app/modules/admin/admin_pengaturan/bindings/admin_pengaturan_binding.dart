import 'package:get/get.dart';
import 'package:jeriko/app/modules/admin/admin_pengaturan/controllers/admin_pengaturan_controller.dart';

class AdminPengaturanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPengaturanController>(
      () => AdminPengaturanController(),
    );
  }
}
