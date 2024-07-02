import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? uuid, nama, nomor_hp, email, password, role;

  User({
    this.uuid,
    this.nama,
    this.nomor_hp,
    this.email,
    this.password,
    this.role,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      uuid: data?['uuid'],
      nama: data?['nama'],
      nomor_hp: data?['nomor_hp'].toString(),
      email: data?['email'],
      password: data?['password'],
      role: data?['role'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uuid != null) "uuid": uuid,
      if (nama != null) "nama": nama,
      if (nomor_hp != null) "nomor_hp": nomor_hp,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (role != null) "role": role,
    };
  }
}
