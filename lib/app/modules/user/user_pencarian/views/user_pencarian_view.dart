import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UserPencarianView extends GetView {
  const UserPencarianView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserPencarianView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserPencarianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
