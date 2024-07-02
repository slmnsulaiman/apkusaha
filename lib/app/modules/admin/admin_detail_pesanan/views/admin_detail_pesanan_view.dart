import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jeriko/app/data/models/Pesanan.dart';
import 'package:jeriko/app/modules/admin/admin_detail_pesanan/controllers/admin_detail_pesanan_controller.dart';
import 'package:jeriko/app/modules/admin/admin_detail_pesanan/views/admin_detail_pesanan_navigasi.dart';
import 'package:jeriko/app/modules/admin/admin_list_pesanan/controllers/admin_list_pesanan_controller.dart';

class AdminDetailPesananView extends GetView {
  Pesanan pesanan;

  AdminDetailPesananView({super.key, required this.pesanan});

  @override
  Widget build(BuildContext context) {
    AdminDetailPesananController controller =
        Get.put<AdminDetailPesananController>(AdminDetailPesananController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: GetBuilder<AdminDetailPesananController>(
            builder: (controller) {
              return Column(
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
                        '${pesanan.nama} belum memberikan lokasi koordinat',
                        style: TextStyle(
                          color: Colors.red.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
                  if (pesanan.latitude != null && pesanan.longitude != null)
                    Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: Colors.blue,
                            width: 1.0,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => AdminDetailPesananNavigasi(
                                  pesanan: pesanan,
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Navigasi',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.navigation,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )),
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
                                              '${barang['harga'] * barang['kuantitas']}',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      '${pesanan.ongkos_kirim}',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      '${pesanan.total_harga}',
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
                  ElevatedButton(
                    onPressed: () async {
                      if (pesanan.status == 'dikemas') {
                        await controller.kirimPesanan(pesanan);
                        Get.back();
                      } else if (pesanan.status == 'dikirim') {
                        await controller.batalkanPesanan(pesanan);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: () {
                      if (pesanan.status == 'dikemas') {
                        return Text('Kirim');
                      } else if (pesanan.status == 'dikirim') {
                        return Text('Batalkan');
                      } else {
                        return Text(
                            'Alasan Pembatalan: ${pesanan.alasan_pembatalan}');
                      }
                    }(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
