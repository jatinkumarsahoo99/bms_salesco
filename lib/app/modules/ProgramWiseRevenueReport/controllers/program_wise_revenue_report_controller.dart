import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/CheckBox/multi_check_box.dart';
import '../../../../widgets/DataGridShowOnly.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/ApiFactory.dart';
import '../../../providers/Utils.dart';
import '../../../routes/app_pages.dart';

class ProgramWiseRevenueReportController extends GetxController {
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  List<String> bookingTypes = [
    "Detail",
    "Summary",
  ];
  List<PermissionModel>? formPermissions;
  var locations = RxList<MultiCheckBoxModel>();
  var channels = RxList<MultiCheckBoxModel>();
  var program = RxList<MultiCheckBoxModel>();
  var programType = RxList<MultiCheckBoxModel>();
  var zone = RxList<MultiCheckBoxModel>();
  var revnue = RxList<MultiCheckBoxModel>();
  var attribute = RxList<MultiCheckBoxModel>();
  var timeFormat = DateFormat('dd-MM-yyyy hh:mm a');

  List<DropDownValue> selectLocation = [];
  List<DropDownValue> selectChannel = [];
  List<DropDownValue> selectProgram = [];
  List<DropDownValue> selectProgramType = [];
  List<DropDownValue> selectZone = [];
  List<DropDownValue> selectRevnue = [];
  List<DropDownValue> selectAttribute = [];

  RxnString bookingType = RxnString();
  var dataTableList = [].obs;
  var clientTableList = [].obs;

  var isDetails = true.obs;
  bool val = true;

  Future<void> getRadioStatus(String name) async {
    print(name);
    switch (name) {
      case "Detail":
        isDetails.value = true;
        val = true;
        break;
      case "Summary":
        isDetails.value = false;
        val = false;
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    formPermissions = Utils.fetchPermissions1(
        Routes.BOOKING_STATUS_REPORT.replaceAll("/", ""));
  }

  @override
  void onReady() {
    super.onReady();
    getLoadData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getLoadData() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PROGRAM_WISE_REPORT_INITIAL,
        fun: (Map map) {
          Get.back();
          locations.clear();
          channels.clear();
          program.clear();
          programType.clear();
          zone.clear();
          revnue.clear();
          attribute.clear();
          int i = 0;
          map["getInitialData"]["locationList"].forEach((e) {
            locations
                .add(MultiCheckBoxModel(DropDownValue.fromJson1(e), false, i));
            i++;
          });
          i = 0;
          map["getInitialData"]["channelList"].forEach((e) {
            channels.add(MultiCheckBoxModel(
                DropDownValue(key: e["channelcode"], value: e["channelname"]),
                false,
                i));
            i++;
          });
          i = 0;
          map["getInitialData"]["programTypeMasterList"].forEach((e) {
            programType.add(MultiCheckBoxModel(
                DropDownValue(
                    key: e["programtypecode"], value: e["programtypename"]),
                false,
                i));
            i++;
          });
          i = 0;
          map["getInitialData"]["programMasterList"].forEach((e) {
            program.add(MultiCheckBoxModel(
                DropDownValue(
                    key: e["programcode"].toString(), value: e["programname"]),
                false,
                i));
            i++;
          });
          i = 0;
          map["getInitialData"]["zoneList"].forEach((e) {
            zone.add(MultiCheckBoxModel(
                DropDownValue(key: e["zonecode"], value: e["zonename"]),
                false,
                i));
            i++;
          });
          i = 0;
          map["getInitialData"]["salesBookList"].forEach((e) {
            revnue.add(MultiCheckBoxModel(
                DropDownValue(key: e["accountcode"], value: e["accountname"]),
                false,
                i));
            i++;
          });
          i = 0;
          map["getInitialData"]["attribute2MasterList"].forEach((e) {
            attribute.add(MultiCheckBoxModel(
                DropDownValue(key: e["a2code"], value: e["a2desc"]), false, i));
            i++;
          });
        });
  }

  genrate() {
    selectLocation.clear();
    selectChannel.clear();
    selectProgramType.clear();
    selectProgram.clear();
    selectZone.clear();
    selectRevnue.clear();
    selectAttribute.clear();
    for (var element in locations) {
      if (element.isSelected ?? false) {
        selectLocation.add(element.val!);
      }
    }
    for (var element in channels) {
      if (element.isSelected ?? false) {
        selectChannel.add(element.val!);
      }
    }
    for (var element in programType) {
      if (element.isSelected ?? false) {
        selectProgramType.add(element.val!);
      }
    }
    for (var element in program) {
      if (element.isSelected ?? false) {
        selectProgram.add(element.val!);
      }
    }
    for (var element in zone) {
      if (element.isSelected ?? false) {
        selectZone.add(element.val!);
      }
    }
    for (var element in revnue) {
      if (element.isSelected ?? false) {
        selectRevnue.add(element.val!);
      }
    }
    for (var element in attribute) {
      if (element.isSelected ?? false) {
        selectAttribute.add(element.val!);
      }
    }
    getReport();
  }

  getReport() {
    LoadingDialog.call();
    var startDate = DateFormat("dd-MM-yyyy").parse(fromDate.text);
    var endDate = DateFormat("dd-MM-yyyy").parse(toDate.text);
    var payload = {
      "LocationList": selectLocation
          .map(
            (e) => {"locationCode": e.key, "locationName": e.value},
          )
          .toList(),
      "ChannelList": selectChannel
          .map((e) => {"channelcode": e.key, "channelname": e.value})
          .toList(),
      "ZoneList": selectZone
          .map((e) => {"zonecode": e.key, "zonename": e.value})
          .toList(),
      "SalesBookList": selectRevnue
          .map((e) => {"accountcode": e.key, "accountname": e.value})
          .toList(),
      "ProgramTypeMasterList": selectProgramType
          .map((e) => {"programtypecode": e.key, "programtypename": e.value})
          .toList(),
      "ProgramMasterList": selectProgram
          .map(
              (e) => {"programcode": int.parse(e.key!), "programname": e.value})
          .toList(),
      "attribute2MasterList": selectAttribute
          .map((e) => {"a2code": e.key, "a2desc": e.value})
          .toList(),
      "fromDate": DateFormat("yyyy-MM-ddT00:00:00").format(startDate),
      "toDate": DateFormat("yyyy-MM-ddT00:00:00").format(endDate),
      "Isdetail": isDetails.value
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.PROGRAM_WISE_REPORT_GENERATE_REPORT,
        json: payload,
        fun: (map) {
          Get.back();
          if (map != null &&
              map['generateReport']['result'] != null &&
              map.containsKey('generateReport') &&
              (map['generateReport']['result'] as List<dynamic>).isNotEmpty) {
            dataTableList.clear();
            dataTableList.value.addAll((map['generateReport']['result']));
          } else {
            LoadingDialog.showErrorDialog('No data found.');
          }
        });
  }

  getClientList() {
    LoadingDialog.call();
    var startDate = DateFormat("dd-MM-yyyy").parse(fromDate.text);
    var endDate = DateFormat("dd-MM-yyyy").parse(toDate.text);
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PROGRAM_WISE_REPORT_CLIENTLIST(
            DateFormat("yyyy-MM-dd").format(startDate),
            DateFormat("yyyy-MM-dd").format(endDate)),
        fun: (Map map) {
          Get.back();
          clientTableList.clear();
          clientTableList.value.addAll(map['summaryReport']['result']);
        });
  }

  showDilogBox() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      getClientList();
      return null;
    });
    showDialog(
      context: Get.context!,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: Get.width * 60,
            height: Get.height * 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: clientTableList.isEmpty
                            ? BoxDecoration(
                                border: Border.all(color: Colors.grey))
                            : null,
                        child: clientTableList.value.isEmpty
                            ? null
                            : DataGridShowOnlyKeys(
                                mapData: clientTableList.value,
                                hideCode: false,
                                exportFileName: "ProgramWise Revenue Report",
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FormButton(
                        btnText: "Return",
                        callback: () {
                          Get.back();
                        },
                        showIcon: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
