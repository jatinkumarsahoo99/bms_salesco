import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/p_d_c_cheques_controller.dart';

class PDCChequesView extends GetView<PDCChequesController> {
  const PDCChequesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDCChequesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PDCChequesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
