import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class Pesanan {
  String? id,
      nama,
      alamat,
      status,
      tanggal,
      uuid_user,
      longitude,
      latitude,
      alasan_pembatalan;
  int? nomor_wa;
  double? total_harga, ongkos_kirim;
  List<Map<String, dynamic>>? barang;

  final box = GetStorage();

  Pesanan({
    this.id,
    this.nama,
    this.nomor_wa,
    this.alamat,
    this.status,
    this.tanggal,
    this.barang,
    this.total_harga,
    this.ongkos_kirim,
    this.uuid_user,
    this.longitude,
    this.latitude,
    this.alasan_pembatalan,
  });

  factory Pesanan.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    List<Map<String, dynamic>> barang = [];

    if (data?['barang'] != null) {
      data?['barang'].forEach((barangData) {
        barang.add({
          'nama': barangData['nama'],
          'gambar': barangData['gambar'],
          'harga': barangData['harga'],
          'kuantitas': barangData['kuantitas'],
        });
      });
    }

    return Pesanan(
      id: data?['id'],
      nama: data?['nama'],
      nomor_wa: data?['nomor_wa'],
      alamat: data?['alamat'],
      status: data?['status'],
      tanggal: data?['tanggal'],
      total_harga: data?['total_harga'],
      ongkos_kirim: data?['ongkos_kirim'],
      uuid_user: data?['uuid_user'],
      latitude: data?['latitude'],
      longitude: data?['longitude'],
      alasan_pembatalan: data?['alasan_pembatalan'],
      barang: barang,
    );
  }

  factory Pesanan.fromMap(Map<String, dynamic> data) {
    List<Map<String, dynamic>> barang = [];

    if (data['barang'] != null) {
      data['barang'].forEach((barangData) {
        barang.add({
          'nama': barangData['nama'],
          'gambar': barangData['gambar'],
          'harga': barangData['harga'],
          'kuantitas': barangData['kuantitas'],
        });
      });
    }

    return Pesanan(
      id: data['id'],
      nama: data['nama'],
      nomor_wa: data['nomor_wa'],
      alamat: data['alamat'],
      status: data['status'],
      tanggal: data['tanggal'],
      total_harga: data['total_harga'],
      ongkos_kirim: data['ongkos_kirim'],
      uuid_user: data['uuid_user'],
      latitude: data?['latitude'],
      longitude: data?['longitude'],
      alasan_pembatalan: data?['alasan_pembatalan'],
      barang: barang,
    );
  }

  Map<String, dynamic> toFirestore() {
    List<Map<String, dynamic>> keranjang =
        (box.read<List>('carts') ?? []).cast<Map<String, dynamic>>();
    List<Map<String, dynamic>> barang = [];

    keranjang.forEach((item) {
      barang.add({
        'nama': item['nama'],
        'gambar': item['gambar'],
        'harga': item['harga'],
        'kuantitas': item['stok'],
      });
    });

    return {
      if (nama != null) "nama": nama,
      if (nomor_wa != null) "nomor_wa": nomor_wa,
      if (alamat != null) "alamat": alamat,
      if (status != null) "status": status,
      if (total_harga != null) "total_harga": total_harga,
      if (ongkos_kirim != null) "ongkos_kirim": ongkos_kirim,
      if (tanggal != null) "tanggal": tanggal,
      if (uuid_user != null) "uuid_user": uuid_user,
      if (latitude != null) "latitude": latitude,
      if (longitude != null) "longitude": longitude,
      if (alasan_pembatalan != null) "alasan_pembatalan": alasan_pembatalan,
      "barang": barang,
    };
  }
}
