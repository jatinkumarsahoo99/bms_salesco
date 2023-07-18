import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_r_o_number_controller.dart';

class ChangeRONumberView extends GetView<ChangeRONumberController> {
  const ChangeRONumberView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeRONumberView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChangeRONumberView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
