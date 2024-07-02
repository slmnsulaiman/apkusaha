import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jeriko/app/data/models/Pesanan.dart';
import 'package:jeriko/app/modules/user/user_detail_pesanan/controllers/user_detail_pesanan_controller.dart';
import 'package:jeriko/app/services/idr.dart';

class UserDetailPesananView extends GetView {
  Pesanan pesanan;

  UserDetailPesananView({super.key, required this.pesanan});

  @override
  Widget build(BuildContext context) {
    UserDetailPesananController controller =
        Get.put<UserDetailPesananController>(UserDetailPesananController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (pesanan.latitude == null && pesanan.longitude == null)
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    'Anda belum memberikan lokasi koordinat',
                    style: TextStyle(
                      color: Colors.red.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              SizedBox(height: 20),
              Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      constraints: BoxConstraints(
                        maxWidth: 600,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text(
                                  '${pesanan.status!.toUpperCase()}',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tanggal',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${DateFormat('d MMMM y').format(DateTime.parse(pesanan.tanggal!))} - ${DateFormat('HH:mm').format(DateTime.parse(pesanan.tanggal!))}',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nama Pelanggan',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${pesanan.nama}',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Alamat',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${pesanan.alamat}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'No. Handphone',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${pesanan.nomor_wa}',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Titik Koordinat',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      pesanan.latitude == null &&
                                              pesanan.longitude == null
                                          ? 'Tidak Ada'
                                          : '${pesanan.longitude}\n${pesanan.latitude}',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (pesanan.latitude == null &&
                                    pesanan.longitude == null)
                                  ElevatedButton(
                                    onPressed: () async {
                                      controller.ambilLokasi(pesanan);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      backgroundColor: Colors.blue,
                                      shadowColor: Colors.blueAccent,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Text("Ambil Titik Koordinat"),
                                  ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rincian Barang',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: pesanan.barang!.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> barang =
                                        pesanan.barang![index];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            '${barang['nama']}',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${barang['kuantitas']}',
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${formatter.format(barang['harga'] * barang['kuantitas'])}',
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ongkos Kirim',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(0XFFEB4F45),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${formatter.format(pesanan.ongkos_kirim)}',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(0XFFEB4F45),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Pembayaran',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${formatter.format(pesanan.total_harga)}',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (pesanan.status == 'dikirim')
                ElevatedButton(
                  onPressed: () {
                    controller.selesaikanPesanan(pesanan);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.blue,
                    shadowColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Selesai'),
                ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
