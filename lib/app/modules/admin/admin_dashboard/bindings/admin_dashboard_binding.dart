import 'package:get/get.dart';
import 'package:jeriko/app/modules/admin/admin_dashboard/controllers/admin_dashboard_controller.dart';

class AdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDashboardController>(
      () => AdminDashboardController(),
    );
  }
}
