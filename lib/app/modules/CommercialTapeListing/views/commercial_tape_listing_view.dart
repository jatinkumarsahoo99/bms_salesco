import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/commercial_tape_listing_controller.dart';

class CommercialTapeListingView
    extends GetView<CommercialTapeListingController> {
  const CommercialTapeListingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CommercialTapeListingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CommercialTapeListingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
