import 'package:get/get.dart';
import 'package:jeriko/app/modules/admin/admin_dashboard/bindings/admin_dashboard_binding.dart';
import 'package:jeriko/app/modules/admin/admin_dashboard/views/admin_dashboard_view.dart';
import 'package:jeriko/app/modules/admin/admin_list_pelanggan/bindings/admin_list_pelanggan_binding.dart';
import 'package:jeriko/app/modules/admin/admin_list_pelanggan/views/admin_list_pelanggan_view.dart';
import 'package:jeriko/app/modules/admin/admin_list_pesanan/bindings/admin_list_pesanan_binding.dart';
import 'package:jeriko/app/modules/admin/admin_list_pesanan/views/admin_list_pesanan_view.dart';
import 'package:jeriko/app/modules/admin/admin_list_produk/bindings/admin_list_produk_binding.dart';
import 'package:jeriko/app/modules/admin/admin_list_produk/views/admin_list_produk_view.dart';
import 'package:jeriko/app/modules/admin/admin_pengaturan/bindings/admin_pengaturan_binding.dart';
import 'package:jeriko/app/modules/admin/admin_pengaturan/views/admin_pengaturan_view.dart';
import 'package:jeriko/app/modules/user/bindings/home_user_binding.dart';
import 'package:jeriko/app/modules/user/user_detail_produk/bindings/user_detail_produk_binding.dart';
import 'package:jeriko/app/modules/user/user_detail_produk/views/user_detail_produk_view.dart';
import 'package:jeriko/app/modules/user/user_konfirmasi_pesanan/bindings/user_konfirmasi_pesanan_binding.dart';
import 'package:jeriko/app/modules/user/user_konfirmasi_pesanan/views/user_konfirmasi_pesanan_view.dart';
import 'package:jeriko/app/modules/user/user_pesanan/bindings/user_pesanan_binding.dart';
import 'package:jeriko/app/modules/user/user_pesanan/views/user_pesanan_view.dart';
import 'package:jeriko/app/modules/user/user_produk/bindings/user_produk_binding.dart';
import 'package:jeriko/app/modules/user/user_produk/controllers/user_produk_controller.dart';
import 'package:jeriko/app/modules/user/user_produk/views/user_produk_view.dart';
import 'package:jeriko/app/modules/user/views/home_user_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.HOME_USER,
      page: () => HomeUserView(),
      binding: HomeUserBinding(),
    ),
    GetPage(
      name: _Paths.PRODUK_USER,
      page: () => const UserProdukView(),
      binding: UserProdukBinding(),
    ),
    GetPage(
      name: _Paths.KONFIRMASI_PESANAN_USER,
      page: () => const UserKonfirmasiPesananView(),
      binding: UserKonfirmasiPesananBinding(),
    ),
    GetPage(
      name: _Paths.PESANAN_USER,
      page: () => const UserPesananView(),
      binding: UserPesananBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_LIST_PELANGGAN,
      page: () => const AdminListPelangganView(),
      binding: AdminListPelangganBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_LIST_PESANAN,
      page: () => const AdminListPesananView(),
      binding: AdminListPesananBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_LIST_PRODUK,
      page: () => const AdminListProdukView(),
      binding: AdminListProdukBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PENGATURAN,
      page: () => const AdminPengaturanView(),
      binding: AdminPengaturanBinding(),
    ),
  ];
}
