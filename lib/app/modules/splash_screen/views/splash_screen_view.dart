import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jeriko/app/routes/app_pages.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Future.delayed(const Duration(seconds: 3), () {
      if (box.hasData('auth')) {
        Map<String, dynamic> data = box.read('auth');
        if (data['role'] == 'pembeli') {
          Get.offNamed(Routes.HOME_USER);
        } else {
          Get.offNamed(Routes.ADMIN_DASHBOARD);
        }
      } else {
        Get.offNamed(Routes.WELCOME);
      }
    });
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/logo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
