import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/amagi_spots_replacement_controller.dart';

class AmagiSpotsReplacementView
    extends GetView<AmagiSpotsReplacementController> {
   AmagiSpotsReplacementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AmagiSpotsReplacementView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AmagiSpotsReplacementView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
