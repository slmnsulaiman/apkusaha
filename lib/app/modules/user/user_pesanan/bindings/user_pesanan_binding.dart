import 'package:get/get.dart';
import 'package:jeriko/app/modules/user/user_pesanan/controllers/user_pesanan_controller.dart';

class UserPesananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPesananController>(
      () => UserPesananController(),
    );
  }
}
