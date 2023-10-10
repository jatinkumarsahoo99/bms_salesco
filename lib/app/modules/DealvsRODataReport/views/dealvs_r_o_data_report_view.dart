import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dealvs_r_o_data_report_controller.dart';

class DealvsRODataReportView extends GetView<DealvsRODataReportController> {
  const DealvsRODataReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DealvsRODataReportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DealvsRODataReportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
