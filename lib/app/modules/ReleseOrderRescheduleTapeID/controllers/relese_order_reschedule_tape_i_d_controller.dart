import 'package:bms_salesco/app/controller/ConnectorControl.dart';
import 'package:bms_salesco/app/controller/HomeController.dart';
import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/providers/ApiFactory.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../CommonDocs/controllers/common_docs_controller.dart';
import '../../CommonDocs/views/common_docs_view.dart';
import '../model/ro_reschedule_tape_id_model.dart';

class ReleseOrderRescheduleTapeIDController extends GetxController {
  RORescheduleOnLoadModel? onloadData;
  List<LsttapeDetails>? lsttapeDetails;
  PlutoGridStateManager? stateManager;

  var lstBookingDetails = <LstBookingDetails>[].obs;
  var locationList = <DropDownValue>[].obs,
      channelList = <DropDownValue>[].obs,
      clientList = <DropDownValue>[].obs,
      agencyList = <DropDownValue>[].obs,
      brandList = <DropDownValue>[].obs,
      tapeList = <DropDownValue>[].obs,
      tapeListRight = <DropDownValue>[].obs;
  var isAllCheck = false.obs;
  int? lastSelectedRow;

  DropDownValue? selectedLocation,
      selectedChannel,
      selectedClient,
      selectedAgency,
      selectedBrand,
      selectedTape,
      selectedTapeRight;
  var tapeCodeDura = "".obs,
      tapeCodeDuraRight = "".obs,
      tapeCodeCaptionRight = "".obs;

  var fromDateTC = TextEditingController(), toDateTC = TextEditingController();

  FocusNode locationFN = FocusNode();

  @override
  void onReady() {
    super.onReady();
    getOnLoadData();
  }

  getOnLoadData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
      api: ApiFactory.RO_RESCHEDULE_TAPE_ID_ON_LOAD,
      fun: (resp) {
        Get.back();
        if (resp != null) {
          onloadData = RORescheduleOnLoadModel.fromJson(resp);
          locationList.value.addAll(onloadData?.loadData?.lstLocation ?? []);
        } else {
          LoadingDialog.showErrorDialog(resp.toString());
        }
      },
      failed: (resp) {
        Get.back();
        LoadingDialog.showErrorDialog(resp.toString());
      },
    );
  }

  getChannel(
    DropDownValue? location,
  ) {
    if (location?.key == null) {
      LoadingDialog.callInfoMessage("Please select Location.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RESCHEDULE_TAPE_ID_GET_CHANNELS(location!.key!),
        fun: (resp) {
          Get.back();
          if (resp != null && resp["lstChannel"] != null) {
            channelList.value = [];
            channelList.value.addAll((resp['lstChannel'] as List<dynamic>)
                .map((e) => DropDownValue(
                      key: e['channelCode'],
                      value: e['channelName'],
                    ))
                .toList());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        },
      );
    }
  }

  getClient(
    DropDownValue? location,
    DropDownValue? channel,
  ) {
    if (location?.key == null) {
      LoadingDialog.callInfoMessage("Please select Location.");
    } else if (channel?.key == null) {
      LoadingDialog.callInfoMessage("Please select Channel.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RESCHEDULE_TAPE_ID_GET_CLIENT(
          location!.key!,
          channel!.key!,
        ),
        fun: (resp) {
          Get.back();
          if (resp != null && resp["lstclient"] != null) {
            clientList.value = [];
            clientList.value.addAll((resp['lstclient'] as List<dynamic>)
                .map((e) => DropDownValue(
                      key: e['clientCode'],
                      value: e['clientName'],
                    ))
                .toList());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        },
      );
    }
  }

  getAgency(
    DropDownValue? location,
    DropDownValue? channel,
    DropDownValue? client,
  ) {
    if (location?.key == null) {
      LoadingDialog.callInfoMessage("Please select Location.");
    } else if (channel?.key == null) {
      LoadingDialog.callInfoMessage("Please select Channel.");
    } else if (client?.key == null) {
      LoadingDialog.callInfoMessage("Please select Client.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RESCHEDULE_TAPE_ID_GET_AGENCY(
          location!.key!,
          channel!.key!,
          client!.key!,
        ),
        fun: (resp) {
          Get.back();
          if (resp != null && resp["lstAgency"] != null) {
            agencyList.value = [];
            agencyList.value.addAll((resp['lstAgency'] as List<dynamic>)
                .map((e) => DropDownValue(
                      key: e['agencyCode'],
                      value: e['agencyName'],
                    ))
                .toList());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        },
      );
    }
  }

  getBrand(
    DropDownValue? location,
    DropDownValue? channel,
    DropDownValue? client,
    DropDownValue? agency,
  ) {
    if (location?.key == null) {
      LoadingDialog.callInfoMessage("Please select Location.");
    } else if (channel?.key == null) {
      LoadingDialog.callInfoMessage("Please select Channel.");
    } else if (client?.key == null) {
      LoadingDialog.callInfoMessage("Please select Client.");
    } else if (agency?.key == null) {
      LoadingDialog.callInfoMessage("Please select Agency.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RESCHEDULE_TAPE_ID_GET_BRAND(
          location!.key!,
          channel!.key!,
          client!.key!,
          agency!.key!,
        ),
        fun: (resp) {
          Get.back();
          if (resp != null && resp["lstBrand"] != null) {
            brandList.value = [];
            brandList.value.addAll((resp['lstBrand'] as List<dynamic>)
                .map((e) => DropDownValue(
                      key: e['brandCode'],
                      value: e['brandName'],
                    ))
                .toList());
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        },
      );
    }
  }

  getTapeDetails(
    DropDownValue? location,
    DropDownValue? channel,
    DropDownValue? client,
    DropDownValue? agency,
    DropDownValue? brand,
    String fromDate,
    String toDate,
  ) {
    if (location?.key == null) {
      LoadingDialog.callInfoMessage("Please select Location.");
    } else if (channel?.key == null) {
      LoadingDialog.callInfoMessage("Please select Channel.");
    } else if (client?.key == null) {
      LoadingDialog.callInfoMessage("Please select Client.");
    } else if (agency?.key == null) {
      LoadingDialog.callInfoMessage("Please select Agency.");
    } else if (brand?.key == null) {
      LoadingDialog.callInfoMessage("Please select Brand.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RESCHEDULE_TAPE_ID_GET_TAPE_DETAILS(
          location!.key!,
          channel!.key!,
          client!.key!,
          agency!.key!,
          brand!.key!,
          fromDate,
          toDate,
        ),
        fun: (resp) {
          Get.back();
          if (resp != null && resp["lsttapeDetails"] != null) {
            lsttapeDetails = [];
            for (var element in resp['lsttapeDetails']) {
              lsttapeDetails!.add(LsttapeDetails.fromJson(element));
            }
            tapeList.value = [];
            tapeList.value.addAll(lsttapeDetails
                    ?.map((e) => DropDownValue(
                          key: (e.duration ?? "").toString(),
                          value: e.exportTapeCode,
                        ))
                    .toList() ??
                []);
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        },
      );
    }
  }

  getBookingDetails(
    DropDownValue? location,
    DropDownValue? channel,
    DropDownValue? client,
    DropDownValue? agency,
    DropDownValue? brand,
    String fromDate,
    String toDate,
    DropDownValue? tapeCode,
  ) {
    if (location?.key == null) {
      LoadingDialog.callInfoMessage("Please select Location.");
    } else if (channel?.key == null) {
      LoadingDialog.callInfoMessage("Please select Channel.");
    } else if (client?.key == null) {
      LoadingDialog.callInfoMessage("Please select Client.");
    } else if (agency?.key == null) {
      LoadingDialog.callInfoMessage("Please select Agency.");
    } else if (brand?.key == null) {
      LoadingDialog.callInfoMessage("Please select Brand.");
    } else if (tapeCode?.key == null) {
      LoadingDialog.callInfoMessage("Please select Tape Code.");
    } else {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.RO_RESCHEDULE_TAPE_ID_GET_TAPE_BOOKING_DETAILS(
          location!.key!,
          channel!.key!,
          client!.key!,
          agency!.key!,
          brand!.key!,
          fromDate,
          toDate,
          tapeCode!.value!,
        ),
        fun: (resp) {
          Get.back();
          if (resp != null && resp["lstBookingDetails"] != null) {
            lstBookingDetails.value = [];
            lstBookingDetails.addAll(
                (resp['lstBookingDetails'] as List<dynamic>)
                    .map((e) => LstBookingDetails.fromJson(e))
                    .toList());
            tapeListRight.value = [];
            if (tapeCodeDura.value == "") {
              tapeCodeDura.value = "0";
            }

            isAllCheck.value = false;
            lastSelectedRow = null;

            for (var i = 0; i < tapeList.length; i++) {
              if (tapeList[i].value != selectedTape!.value &&
                  tapeList[i].key == tapeCodeDura.value) {
                tapeListRight.add(tapeList[i]);
              }
            }
            if (tapeListRight.isEmpty || lstBookingDetails.isEmpty) {
              LoadingDialog.callInfoMessage(
                  "No optional TapeID found for replacing existing TapeID.");
            }
          } else {
            LoadingDialog.showErrorDialog(resp.toString());
          }
        },
        failed: (resp) {
          Get.back();
          LoadingDialog.showErrorDialog(resp.toString());
        },
      );
    }
  }

  saveData(
    String modifiedBy,
    DropDownValue? location,
    DropDownValue? channel,
    DropDownValue? client,
    DropDownValue? agency,
    DropDownValue? brand,
    String fromDate,
    String toDate,
    DropDownValue? tapeCode,
  ) {
    if (location?.key == null) {
      LoadingDialog.callInfoMessage("Please select Location.");
    } else if (channel?.key == null) {
      LoadingDialog.callInfoMessage("Please select Channel.");
    } else if (client?.key == null) {
      LoadingDialog.callInfoMessage("Please select Client.");
    } else if (agency?.key == null) {
      LoadingDialog.callInfoMessage("Please select Agency.");
    } else if (brand?.key == null) {
      LoadingDialog.callInfoMessage("Please select Brand.");
    } else if (tapeCode?.value == null) {
      LoadingDialog.callInfoMessage("Please select Tape Code.");
    } else if (lstBookingDetails.isEmpty) {
      LoadingDialog.callInfoMessage("No data to save.");
    } else {
      LoadingDialog.call();
      var payload = {
        "modifiedBy": modifiedBy,
        "locationCode": location?.key,
        "channelCode": channel?.key,
        "clientcode": client?.key,
        "agencycode": agency?.key,
        "brandCode": brand?.key,
        "exportTapeCode": tapeCode?.value,
        "effectiveFromDT": fromDate,
        "effectiveToDT": toDate,
        "lstRoDetails": lstBookingDetails
            .map((element) => element.toJson(fromSave: true))
            .toList(),
      };
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.RO_RESCHEDULE_TAPE_ID_SAVE_DATA,
        json: payload,
        fun: (resp) {
          Get.back();
          if (resp != null &&
              resp is Map<String, dynamic> &&
              resp['message'] != null &&
              resp['message'].toString().contains("successfully")) {
            LoadingDialog.callDataSaved(
                msg: resp['message'],
                callback: () {
                  Get.find<HomeController>().clearPage1();
                });
          } else {
            if (resp != null &&
                resp is Map<String, dynamic> &&
                resp['message'] != null) {
              LoadingDialog.showErrorDialog(resp['message'].toString());
            } else {
              LoadingDialog.showErrorDialog(resp.toString());
            }
          }
        },
      );
    }
  }

  docs(
    DropDownValue? location,
    DropDownValue? channel,
    DropDownValue? client,
    DropDownValue? agency,
    DropDownValue? brand,
    DropDownValue? tapeCode,
  ) async {
    String documentKey = "";
    if (location?.key == null ||
        channel?.key == null ||
        client?.key == null ||
        agency?.key == null ||
        brand?.key == null ||
        tapeCode?.value == null) {
      documentKey = "";
    } else {
      documentKey =
          "ROReschedule_ByTapeID ${location?.value}${channel?.value}${client?.key}${agency?.key}${brand?.key}${selectedTapeRight?.key ?? ''}${tapeCode?.key}";
    }

    Get.defaultDialog(
      title: "Documents",
      content: CommonDocsView(documentKey: documentKey),
    ).then((value) {
      Get.delete<CommonDocsController>(tag: "commonDocs");
    });
  }

  changeExportTapeCode() {
    if (selectedTapeRight == null) {
      LoadingDialog.callInfoMessage("Please replaceble Tapecode.");
    } else {
      for (var i = 0; i < lstBookingDetails.length; i++) {
        if (lstBookingDetails[i].action ?? false) {
          lstBookingDetails[i].newTapeID = selectedTapeRight!.value!;
        }
      }
      lstBookingDetails.refresh();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
