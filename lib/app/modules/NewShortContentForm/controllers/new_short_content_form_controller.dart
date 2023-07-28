import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../providers/ApiFactory.dart';

class NewShortContentFormController extends GetxController {
  var locations = RxList<DropDownValue>([]);
  var channels = RxList<DropDownValue>([]);
  var types = RxList<DropDownValue>([]);
  var categeroies = RxList<DropDownValue>([]);
  FocusNode houseFocusNode = FocusNode();

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
  DropDownValue? selectedType;
  DropDownValue? selectedCategory;
  DropDownValue? selectedProgram;
  TextEditingController caption = TextEditingController(),
      txCaption = TextEditingController(),
      houseId = TextEditingController();
  getInitData() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.NEW_SHORT_CONTENT_INIT,
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onLoadShortCode")) {
            Map data = rawdata["onLoadShortCode"];

            locations.value = [];
            for (var location in data["lstLocation"]) {
              locations.add(DropDownValue(
                  key: location["locationCode"],
                  value: location["locationName"]));
            }
            types.value = [];
            for (var revenue in data["lstFormType"]) {
              types.add(DropDownValue(
                  key: revenue["formCode"], value: revenue["formName"]));
            }
          }
        });
  }

  getChannel(locationCode) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.NEW_SHORT_CONTENT_LOCATION_LEAVE(locationCode),
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onLeaveLocation")) {
            channels.value = [];
            for (var channel in rawdata["onLeaveLocation"]) {
              channels.add(DropDownValue(
                  key: channel["channelCode"], value: channel["channelName"]));
            }
          }
        });
  }

  typeleave(formCode) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.NEW_SHORT_CONTENT_Type_LEAVE(formCode),
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onLeaveTypeCategory")) {
            categeroies.value = [];
            for (var category in rawdata["onLeaveTypeCategory"]) {
              categeroies.add(DropDownValue(
                  key: category["typeName"], value: category["typeName"]));
            }
          }
        });
  }

  houseleave() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.NEW_SHORT_CONTENT_HOUSEID_LEAVE(
            houseId.text, txCaption.text, caption.text),
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onLeaveTypeCategory")) {
            categeroies.value = [];
            for (var category in rawdata["onLeaveTypeCategory"]) {
              categeroies.add(DropDownValue(
                  key: category["typeName"], value: category["typeName"]));
            }
          }
        });
  }

  @override
  void onInit() {
    getInitData();
    houseFocusNode.addListener(() {
      if (!houseFocusNode.hasFocus && houseId.text.isNotEmpty) {
        houseleave();
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
