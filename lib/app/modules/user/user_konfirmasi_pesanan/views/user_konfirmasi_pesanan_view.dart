import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeriko/app/modules/user/controllers/home_user_controller.dart';
import 'package:jeriko/app/modules/user/user_konfirmasi_pesanan/controllers/user_konfirmasi_pesanan_controller.dart';
import 'package:jeriko/app/services/idr.dart';

class UserKonfirmasiPesananView
    extends GetView<UserKonfirmasiPesananController> {
  const UserKonfirmasiPesananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserKonfirmasiPesananController controller =
        Get.put<UserKonfirmasiPesananController>(
            UserKonfirmasiPesananController());
    HomeUserController homeUserController =
        Get.put<HomeUserController>(HomeUserController());
    final box = GetStorage();
    double totalPesanan = box.read('total');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Pesanan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Alamat Penerima',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.alamat,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFECF0F1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    hintText: 'Alamat Penerima',
                    hintStyle: TextStyle(
                      color: Color(0xFFD0D0D0),
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.ambilLokasi();
                      },
                      icon: Icon(Icons.location_on),
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tekan ikon di kanan untuk mendapatkan alamat via GPS',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Nomor Handphone / WA',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.nomor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFECF0F1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    hintText: 'Nomor Handphone / WA',
                    hintStyle: TextStyle(
                      color: Color(0xFFD0D0D0),
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Metode Pembayaran',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'COD',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(height: 20),
                Text(
                  'Rincian Pembayaran',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Pesanan',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      '${formatter.format(totalPesanan)}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ongkos Kirim',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${formatter.format(controller.ongkos.value)}',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Pembayaran',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        formatter
                            .format(totalPesanan + controller.ongkos.value),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    await controller.simpanPesanan();
                    homeUserController.currentIndex.value = 2;
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    shadowColor: Colors.blueAccent,
                    elevation: 5.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Konfirmasi Pesanan',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
