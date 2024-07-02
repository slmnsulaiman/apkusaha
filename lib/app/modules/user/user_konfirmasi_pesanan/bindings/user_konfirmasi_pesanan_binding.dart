import 'package:get/get.dart';
import 'package:jeriko/app/modules/user/user_konfirmasi_pesanan/controllers/user_konfirmasi_pesanan_controller.dart';

class UserKonfirmasiPesananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserKonfirmasiPesananController>(
      () => UserKonfirmasiPesananController(),
    );
  }
}
