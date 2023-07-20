import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/CommercialLanguageSpecificationController.dart';

class CommercialLanguageSpecificationView
    extends GetView<CommercialLanguageSpecificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CommercialLanguageSpecificationView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CommercialLanguageSpecificationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
