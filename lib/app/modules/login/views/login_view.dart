import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jeriko/app/routes/app_pages.dart';
import 'package:jeriko/app/styles/text_style.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                const SizedBox(height: 30),
                Text(
                  'Selamat Datang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
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
                              const Icon(Icons.email, color: Colors.grey),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        controller: controller.emailTextField,
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
                          controller: controller.passwordTextField,
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
                      controller.login(
                        controller.emailTextField.text,
                        controller.passwordTextField.text,
                      );
                    },
                    child: Text(
                      'Masuk',
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
