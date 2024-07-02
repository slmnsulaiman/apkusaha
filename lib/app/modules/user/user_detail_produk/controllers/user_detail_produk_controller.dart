import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jeriko/app/data/models/Produk.dart';

class UserDetailProdukController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  tambahCart(Produk produkModel) {
    if (box.hasData('carts')) {
      List<Map<String, dynamic>> carts =
          (box.read<List>('carts') ?? []).cast<Map<String, dynamic>>();
      bool productExist = false;
      for (var item in carts) {
        if (item['nama'] == produkModel.nama) {
          item['stok'] = (item['stok'] ?? 1) + 1;
          productExist = true;
          Get.snackbar('Berhasil', 'Berhasil Menambahkan ke Keranjang');
          break;
        }
      }
      if (!productExist) {
        carts.add({
          'nama': produkModel.nama,
          'stok': 1,
          'harga': produkModel.harga,
          'gambar': produkModel.gambar,
        });
      }
      box.write('carts', carts);
      Get.snackbar('Berhasil', 'Berhasil Menambahkan ke Keranjang');
    } else {
      box.write(
        'carts',
        [
          {
            'nama': produkModel.nama,
            'stok': 1,
            'harga': produkModel.harga,
            'gambar': produkModel.gambar,
          }
        ],
      );
      Get.snackbar('Berhasil', 'Berhasil Menambahkan ke Keranjang');
    }
  }
}
