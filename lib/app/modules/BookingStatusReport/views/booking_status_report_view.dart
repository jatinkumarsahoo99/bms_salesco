import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/booking_status_report_controller.dart';

class BookingStatusReportView extends GetView<BookingStatusReportController> {
  const BookingStatusReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookingStatusReportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BookingStatusReportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
