import 'package:get/get.dart';
import 'package:jeriko/app/modules/user/user_produk/controllers/user_produk_controller.dart';

class UserProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProdukController>(
      () => UserProdukController(),
    );
  }
}
