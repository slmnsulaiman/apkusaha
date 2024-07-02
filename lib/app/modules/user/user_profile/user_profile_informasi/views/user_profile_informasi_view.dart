import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeriko/app/modules/user/user_profile/user_profile_informasi/controllers/user_profile_informasi_controller.dart';

class UserProfileInformasiView extends GetView {
  const UserProfileInformasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfileInformasiController controller =
        Get.put<UserProfileInformasiController>(
            UserProfileInformasiController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Informasi Akun"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 74,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: controller.nama,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0XFFECF0F1),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  hintText: '   Nama Kamu',
                  hintStyle: const TextStyle(
                      color: Color(0xffd0d0d0),
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: controller.nomor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0XFFECF0F1),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  hintText: '   No. Handphone / WA',
                  hintStyle: const TextStyle(
                      color: Color(0xffd0d0d0),
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.updateUser(
                    controller.nama.text,
                    controller.nomor.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(240, 50),
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
                  'Perbarui Profile',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
