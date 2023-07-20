import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/CommercialCreationAutoController.dart';

class CommercialCreationAutoView
    extends GetView<CommercialCreationAutoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CommercialCreationAutoView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CommercialCreationAutoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
