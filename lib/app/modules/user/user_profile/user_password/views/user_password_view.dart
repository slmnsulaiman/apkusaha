import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeriko/app/modules/user/user_profile/user_password/controllers/user_password_controller.dart';

class UserPasswordView extends GetView {
  const UserPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserPasswordController controller =
        Get.put<UserPasswordController>(UserPasswordController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 74),
              SizedBox(
                height: 50,
                child: Obx(
                  () => TextFormField(
                    obscureText: controller.obsecure.value,
                    controller: controller.passwordLama,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0XFFECF0F1),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.lock),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 24.0, bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.tombolLihatPassword();
                          },
                          child: Icon(Icons.visibility),
                        ),
                      ),
                      hintText: 'Password Lama',
                      hintStyle: TextStyle(
                        color: Color(0xffd0d0d0),
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 47),
              SizedBox(
                height: 50,
                child: Obx(
                  () => TextFormField(
                    obscureText: controller.obsecure.value,
                    controller: controller.passwordBaru,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0XFFECF0F1),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.lock),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 24.0, bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.tombolLihatPassword();
                          },
                          child: Icon(Icons.visibility),
                        ),
                      ),
                      hintText: 'Password Baru',
                      hintStyle: TextStyle(
                        color: Color(0xffd0d0d0),
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                height: 50,
                child: Obx(
                  () => TextFormField(
                    controller: controller.konfirmasiPasswordBaru,
                    obscureText: controller.obsecure.value,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0XFFECF0F1),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.lock),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 24.0, bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.tombolLihatPassword();
                          },
                          child: Icon(Icons.visibility),
                        ),
                      ),
                      hintText: 'Confirmasi Password Baru',
                      hintStyle: TextStyle(
                        color: Color(0xffd0d0d0),
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.updatePassword(
                      controller.passwordLama.text,
                      controller.passwordBaru.text,
                      controller.konfirmasiPasswordBaru.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(240, 50),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.blue,
                    shadowColor: Colors.blueAccent,
                    elevation: 5.0,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Ubah',
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
