import 'package:get/get.dart';
import 'package:jeriko/app/modules/user/controllers/home_user_controller.dart';

class HomeUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeUserController>(
      () => HomeUserController(),
    );
  }
}
