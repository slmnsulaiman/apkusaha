import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeriko/app/modules/user/controllers/home_user_controller.dart';
import 'package:jeriko/app/modules/user/user_keranjang/views/user_keranjang_view.dart';
import 'package:jeriko/app/modules/user/user_pesanan/views/user_pesanan_view.dart';
import 'package:jeriko/app/modules/user/user_produk/controllers/user_produk_controller.dart';
import 'package:jeriko/app/modules/user/user_produk/views/user_produk_view.dart';
import 'package:jeriko/app/modules/user/user_profile/views/user_profile_view.dart';

class HomeUserView extends GetView<HomeUserController> {
  HomeUserView({super.key});

  final TextStyle unselectedLabelStyle = const TextStyle(
      color: Colors.white54, fontWeight: FontWeight.w500, fontSize: 12);

  final TextStyle selectedLabelStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF387ADF),
  );

  buildBottomNavigationMenu(context, controller) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: controller.changePage,
          currentIndex: controller.currentIndex.value,
          backgroundColor: const Color(0xFFF2F2F2),
          unselectedItemColor: const Color(0xFFC4C4C4),
          selectedItemColor: const Color(0xFF387ADF),
          unselectedLabelStyle: unselectedLabelStyle,
          selectedLabelStyle: selectedLabelStyle,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory, color: const Color(0xFFC4C4C4)),
              label: 'Produk',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: const Color(0xFFC4C4C4)),
              label: 'Keranjang',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt, color: const Color(0xFFC4C4C4)),
              label: 'Pesanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: const Color(0xFFC4C4C4)),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationMenu(context, controller),
        body: Obx(
          () => IndexedStack(
            index: controller.currentIndex.value,
            children: [
              UserProdukView(),
              UserKeranjangView(),
              UserPesananView(),
              UserProfileView(),
            ],
          ),
        ),
      ),
    );
  }
}
