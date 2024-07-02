import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jeriko/app/modules/user/user_profile/controllers/user_profile_controller.dart';
import 'package:jeriko/app/modules/user/user_profile/user_password/views/user_password_view.dart';
import 'package:jeriko/app/modules/user/user_profile/user_profile_informasi/views/user_profile_informasi_view.dart';
import 'package:jeriko/app/routes/app_pages.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfileController controller =
        Get.put<UserProfileController>(UserProfileController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.0),
                color: Colors.blueGrey[100],
                child: StreamBuilder<DocumentSnapshot>(
                  stream: controller.getProfile(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.data() == null) {
                      return Center(child: Text('No data available'));
                    }

                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return ListView(
                      children: [
                        ListTile(
                          title: Text(
                            '${data['nama']}',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text('${data['email']}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(data['nomor_hp'] != null
                              ? '${data['nomor_hp']}'
                              : 'Tambahkan Nomor HP'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      'Ubah Informasi Akun',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Get.to(() => const UserProfileInformasiView());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text(
                      'Ubah Password',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Get.to(() => const UserPasswordView());
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  GetStorage().erase();
                  Get.offAllNamed(Routes.WELCOME);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.blue,
                  shadowColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text("Keluar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
