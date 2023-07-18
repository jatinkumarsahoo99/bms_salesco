import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tape_i_d_campaign_controller.dart';

class TapeIDCampaignView extends GetView<TapeIDCampaignController> {
  const TapeIDCampaignView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TapeIDCampaignView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TapeIDCampaignView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
