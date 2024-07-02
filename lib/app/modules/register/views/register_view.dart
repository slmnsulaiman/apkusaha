import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF387ADF),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/logo.png',
                  width: 150,
                ),
                const SizedBox(height: 100),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.grey),
                          hintText: 'Nama Lengkap',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        controller: controller.nama,
                        style: TextStyle(color: Colors.black),
                      ),
                      const Divider(color: Colors.grey, height: 0),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          prefixIcon:
                              const Icon(Icons.phone, color: Colors.grey),
                          hintText: 'Nomor HP',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        controller: controller.nomor,
                        style: TextStyle(color: Colors.black),
                      ),
                      const Divider(color: Colors.grey, height: 0),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.grey),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        controller: controller.email,
                        style: TextStyle(color: Colors.black),
                      ),
                      const Divider(color: Colors.grey, height: 0),
                      Obx(
                        () => TextField(
                          obscureText: controller.obsecure.value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5),
                            prefixIcon:
                                const Icon(Icons.lock, color: Colors.grey),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.visibility,
                                  color: Colors.grey),
                              onPressed: () {
                                controller.togglePassword();
                              },
                            ),
                          ),
                          controller: controller.password,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const Divider(color: Colors.grey, height: 0),
                      Obx(
                        () => TextField(
                          obscureText: controller.obsecure.value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5),
                            prefixIcon:
                                const Icon(Icons.lock, color: Colors.grey),
                            hintText: 'Konfirmasi Password',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.visibility,
                                  color: Colors.grey),
                              onPressed: () {
                                controller.togglePassword();
                              },
                            ),
                          ),
                          controller: controller.konfirmasi_password,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF387ADF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      controller.register(
                        controller.nama.text,
                        controller.nomor.text,
                        controller.email.text,
                        controller.password.text,
                        controller.konfirmasi_password.text,
                      );
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
