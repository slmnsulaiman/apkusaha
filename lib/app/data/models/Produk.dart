import 'package:cloud_firestore/cloud_firestore.dart';

class Produk {
  String? id, nama, deskripsi, kategori, gambar;
  double? harga, stok;

  Produk({
    this.id,
    this.nama,
    this.deskripsi,
    this.kategori,
    this.harga,
    this.stok,
    this.gambar,
  });

  factory Produk.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Produk(
      id: data?['id'],
      nama: data?['nama'],
      deskripsi: data?['detail'],
      kategori: data?['kategori'],
      harga: data?['harga'] != null ? (data?['harga'] as num).toDouble() : null,
      stok: data?['stok'] != null ? (data?['stok'] as num).toDouble() : null,
      gambar: data?['gambar'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nama != null) "nama": nama,
      if (deskripsi != null) "detail": deskripsi,
      if (kategori != null) "kategori": kategori,
      if (harga != null) "harga": harga,
      if (stok != null) "stok": stok,
      if (gambar != null) "gambar": gambar,
    };
  }

  factory Produk.fromMap(String id, Map<String, dynamic> data) {
    return Produk(
      id: id,
      nama: data['nama'],
      deskripsi: data['detail'],
      gambar: data['gambar'],
      harga: data['harga'] != null ? (data['harga'] as num).toDouble() : null,
      stok: data['stok'] != null ? (data['stok'] as num).toDouble() : null,
    );
  }
}
