import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/datewise_error_spots_controller.dart';

class DatewiseErrorSpotsView extends GetView<DatewiseErrorSpotsController> {
  const DatewiseErrorSpotsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DatewiseErrorSpotsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DatewiseErrorSpotsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
