import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/controller/MainController.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../providers/ApiFactory.dart';

class NewShortContentFormController extends GetxController {
  var locations = RxList<DropDownValue>([]);
  var channels = RxList<DropDownValue>([]);
  var types = RxList<DropDownValue>([]);
  var categeroies = RxList<DropDownValue>([]);
  var tapes = RxList<DropDownValue>([]);
  var orgRepeats = RxList<DropDownValue>([]);

  FocusNode houseFocusNode = FocusNode();

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
  DropDownValue? selectedType;
  DropDownValue? selectedCategory;
  DropDownValue? selectedProgram;
  DropDownValue? selectedTape;
  DropDownValue? selectedOrgRep;

  TextEditingController caption = TextEditingController(),
      txCaption = TextEditingController(),
      houseId = TextEditingController(),
      som = TextEditingController(),
      eom = TextEditingController(),
      duration = TextEditingController(),
      startData = TextEditingController(),
      endDate = TextEditingController(),
      segment = TextEditingController(),
      remark = TextEditingController();
  var toBeBilled = RxBool(false);
  getInitData() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.NEW_SHORT_CONTENT_INIT,
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onLoadShortCode")) {
            Map data = rawdata["onLoadShortCode"];

            locations.value = [];
            for (var location in data["lstLocation"]) {
              locations.add(DropDownValue(key: location["locationCode"], value: location["locationName"]));
            }
            types.value = [];
            for (var revenue in data["lstFormType"]) {
              types.add(DropDownValue(key: revenue["formCode"], value: revenue["formName"]));
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
              channels.add(DropDownValue(key: channel["channelCode"], value: channel["channelName"]));
            }
          }
        });
  }

  typeleave(formCode) {
    if (formCode == "ZASTI00001") {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.NEW_SHORT_CONTENT_GetStillTypeMaster,
          fun: (rawdata) {
            if (rawdata is Map && rawdata.containsKey("infoStillType")) {
              tapes.value = [];
              for (var category in rawdata["infoStillType"]) {
                tapes.add(DropDownValue(key: category["tapetypecode"], value: category["tapeTypeName"]));
              }
            }
          });
    }
    if (formCode == "ZASLI00045") {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.NEW_SHORT_CONTENT_GetSlideTypeMaster,
          fun: (rawdata) {
            if (rawdata is Map && rawdata.containsKey("infoSlideTypes")) {
              tapes.value = [];
              for (var category in rawdata["infoSlideTypes"]) {
                tapes.add(DropDownValue(key: category["tapetypecode"], value: category["tapeTypeName"]));
              }
            }
          });
    }
    if (formCode == "ZADAT00117") {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.NEW_SHORT_CONTENT_GetVignetee,
          fun: (rawdata) {
            if (rawdata is Map && rawdata.containsKey("infoVignetteType")) {
              orgRepeats.value = [];
              for (var category in rawdata["infoVignetteType"]) {
                orgRepeats.add(DropDownValue(key: category["originalRepeatCode"], value: category["originalRepeatName"]));
              }
            }
          });
    }

    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.NEW_SHORT_CONTENT_Type_LEAVE(formCode),
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onLeaveTypeCategory")) {
            categeroies.value = [];
            for (var category in rawdata["onLeaveTypeCategory"]) {
              categeroies.add(DropDownValue(key: category["typeId"], value: category["typeName"]));
            }
          }
        });
  }

  houseleave() {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.NEW_SHORT_CONTENT_HOUSEID_LEAVE(houseId.text, txCaption.text, caption.text),
        fun: (rawdata) {
          if (rawdata is Map && rawdata.containsKey("onLeaveTypeCategory")) {
            categeroies.value = [];
            for (var category in rawdata["onLeaveTypeCategory"]) {
              categeroies.add(DropDownValue(key: category["typeName"], value: category["typeName"]));
            }
          }
        });
  }

  save() {
    var body = {};
    // formCode: "ZASTI00001"formName: "Still Master"
    if (selectedType?.key == "ZASTI00001") {
      body = {
        "stillCode": "",
        "stillCaption": caption.text,
        "programCode": selectedProgram?.key, // Common in (still/Vignette)
        "exportTapeCaption": houseId.text, // Common in (still/Slide)
        "exportTapeCode": txCaption.text, // Common in (still/Slide)
        "segmentNumber": int.tryParse(segment.text),
        "stillDuration": duration.text,
        "houseId": houseId.text, // Common in (still/Slide/vignetee)
        "som": som.text, // Common in (still/Slide/vignetee)
        "tapeTypeCode": selectedTape?.key, // Common in (still/Slide)
        "dated": DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(startData.text)), // Common in (still/Slide)
        "killDate": DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(endDate.text)), // Common in (still/Slide/vignetee)
        "modifiedBy": Get.find<MainController>().user?.logincode, // Common in (still/Slide)
        "locationcode": selectedLocation?.key, // Common in (still/Slide/Vignette)
        "channelcode": selectedChannel?.key, // Common in (still/Slide/vignetteCaption)
        "eom": eom.text, // Common in (still/Slide/vignetee)
        "stillType": selectedCategory?.key,
      };
    }
    //  "formCode": "ZASLI00045", "formName": "Slide Master"
    if (selectedType?.key == "ZASLI00045") {
      body = {
        "slideCode": "",
        "slideCaption": caption.text,
        "segmentNumber_SL": segment.text,
        "slideType": selectedCategory?.key,
        "exportTapeDuration": duration.text, //Common in (Slide/Vignette)
        "houseId": houseId.text, // Common in (still/Slide/vignetee)
        "som": som, // Common in (still/Slide/vignetee)
        "tapeTypeCode": selectedTape?.key, // Common in (still/Slide)
        "dated": DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(startData.text)), // Common in (still/Slide)
        "killDate": DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(endDate.text)), // Common in (still/Slide/vignetee)
        "modifiedBy": Get.find<MainController>().user?.logincode, // Common in (still/Slide)
        "locationcode": selectedLocation?.key, // Common in (still/Slide/Vignette)
        "channelcode": selectedChannel?.key, // Common in (still/Slide/vignetteCaption)
        "eom": eom.text, // Common in (still/Slide/vignetee)
        "exportTapeCaption": txCaption.text, // Common in (still/Slide)
        "exportTapeCode": houseId.text,
      };
    }
    // "formCode": "ZADAT00117", "formName": "Vignette Master"
    if (selectedType?.key == "ZADAT00117") {
      body = {
        "vignetteCode": "",
        "vignetteCaption": caption.text,
        "vignetteDuration": duration.text,
        "exportTapeCode_VG": txCaption.text,
        "originalRepeatCode": selectedOrgRep?.key,
        "segmentNumber_VG": segment.text,
        "startDate": DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(startData.text)),
        "remarks": remark.text,
        "billflag": toBeBilled.value,
        "companycode": "",
        "exportTapeDuration": duration.text, //Common in (Slide/Vignette)
        "locationcode": selectedLocation?.key, // Common in (still/Slide/Vignette)
        "channelcode": selectedChannel?.key, // Common in (still/Slide/vignetteCaption)
        "eom": eom.text, // Common in (still/Slide/vignetee)
        "killDate": DateFormat("yyyy-MM-dd").format(DateFormat("dd-MM-yyyy").parse(endDate.text)), // Common in (still/Slide/vignetee)
        "houseId": houseId.text, // Common in (still/Slide/vignetee)
        "som": som, // Common in (still/Slide/vignetee)
        "programCode": selectedProgram?.key,
      };
    }

    Get.find<ConnectorControl>().POSTMETHOD(api: ApiFactory.NEW_SHORT_CONTENT_SAVE, json: body, fun: (rawdata) {});
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
