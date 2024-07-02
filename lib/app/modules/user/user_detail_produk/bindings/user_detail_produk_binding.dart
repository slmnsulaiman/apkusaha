import 'package:get/get.dart';
import 'package:jeriko/app/modules/user/user_detail_produk/controllers/user_detail_produk_controller.dart';

class UserDetailProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailProdukController>(
      () => UserDetailProdukController(),
    );
  }
}
