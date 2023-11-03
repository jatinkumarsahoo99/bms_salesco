import 'dart:convert';

import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/modules/EdiRoBooking/bindings/edit_ro_init_data.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/DataGridShowOnly.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/rowfilter.dart';
import '../../../providers/ApiFactory.dart';

class EdiRoBookingController extends GetxController {
  //TODO: Implement EdiRoBookingController
  var bookingNo1TEC = TextEditingController(),
      bookingNo2TEC = TextEditingController(text: "0"),
      bookingNo3TEC = TextEditingController(),
      spotsAllTEC = TextEditingController(text: "0"),
      spotsBookedTEC = TextEditingController(text: "0"),
      spotsBalanceTEC = TextEditingController(text: "0"),
      durAllTEC = TextEditingController(text: "0"),
      durBookedTEC = TextEditingController(text: "0"),
      durBalanceTEC = TextEditingController(text: "0"),
      amtAllTEC = TextEditingController(text: "0"),
      amtBookedTEC = TextEditingController(text: "0"),
      amtBalanceTEC = TextEditingController(text: "0"),
      amtValAmmountTEC = TextEditingController(text: "0"),
      preVAmtTEC = TextEditingController(text: "0"),
      preBAmtTEC = TextEditingController(text: "0"),
      maxSpendTEC = TextEditingController(text: "0"),
      bookedAmountTEC = TextEditingController(text: "0"),
      valAmountTEC = TextEditingController(text: "0"),
      zoneTEC = TextEditingController(),
      payRouteTEC = TextEditingController(),
      payRouteCodeTEC = TextEditingController(),
      startDateTEC = TextEditingController(),
      endDateTEC = TextEditingController(),
      dealTypeTEC = TextEditingController(),
      payModeTEC = TextEditingController(),
      gstNoTEC = TextEditingController();

  final count = 0.obs;
  var infoTableList = [].obs;
  var drgabbleDialog = Rxn<Widget>();
  var programList = [].obs;
  var zoneCode = "".obs;
  var lstDgvDealEntriesList = [].obs;
  var lstDgvLinkedDealsList = [].obs;
  var lDButton = false.obs;
  var linkDealNO = "".obs;
  var linkDealName = "".obs;
  bool showGstPopUp = true;
  bool pdcDetailsPopUP = true;

  var isShowLink = false.obs;
  var lstXmlDtList = [].obs;
  var lstDgvSpotsList = [].obs;
  var fpcStartTabelList = [].obs;
  var tapIdTabelList = [].obs;
  var tempList = [].obs;
  var filtterValue = '';
  var selectedIndex = 0.obs;

  PlutoGridStateManager? dvgSpotGrid;

  PlutoGridStateManager? dgvDealEntriesGrid;
  PlutoGridStateManager? fpcStartTabelGrid;
  PlutoGridStateManager? tapeIdTabelGrid;

  EdiRoInitData? initData;
  var fileNames = RxList<DropDownValue>();
  var loactions = RxList<DropDownValue>();
  var positions = RxList<DropDownValue>();
  var executives = RxList<DropDownValue>();
  var strRoRefNo = RxList<DropDownValue>();
  var client = RxList<DropDownValue>();
  var agency = RxList<DropDownValue>();
  var brand = RxList<DropDownValue>();
  var channel = RxList<DropDownValue>();
  var dealNo = RxList<DropDownValue>();
  var gstPlant = RxList<DropDownValue>();

  // Selected DropDownValues
  DropDownValue? selectedFile;
  DropDownValue? selectedLoactions;
  DropDownValue? selectedPositions;
  DropDownValue? selectedExecutives;
  DropDownValue? selectedRoRefNo;
  DropDownValue? selectedClient;
  DropDownValue? selectedAgency;
  DropDownValue? selectedBrand;
  DropDownValue? selectedChannel;
  DropDownValue? selectedDealNo;
  DropDownValue? selectedGstPlant;

  TextEditingController effectiveDate = TextEditingController();

  PlutoGridStateManager? stateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1;
  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  RxBool isEnable = RxBool(true);

  @override
  void onInit() {
    super.onInit();
  }

  getInitData() {
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_INIT,
          fun: (map) {
            Get.back();
            // initData = EdiRoInitData.fromJson(map["onLoadInfo"]);
            //FileName
            fileNames.clear();
            map["onLoadInfo"]['softListMyFiles'].forEach((e) {
              fileNames
                  .add(DropDownValue(key: '', value: e['convertedFileName']));
            });
            //Loaction
            loactions.clear();
            map["onLoadInfo"]['lstLocation'].forEach((e) {
              loactions.add(DropDownValue(
                  key: e['locationCode'], value: e['locationName']));
            });
            // Position
            positions.clear();
            map["onLoadInfo"]['lstSpotPosType'].forEach((e) {
              positions.add(DropDownValue(
                  key: e['spotPositionTypeCode'],
                  value: e['spotPositionTypeName']));
            });
            selectedPositions = positions.firstWhereOrNull(
              (element) {
                var result = element.key == "ZAMID00002";
                return result;
              },
            );
            // Executives
            executives.clear();
            map["onLoadInfo"]['executives'].forEach((e) {
              executives.add(DropDownValue(
                  key: e['personnelCode'], value: e['personnelName']));
            });
            update(["initData"]);
          });
    } catch (e) {
      print(e.toString());
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  effectiveDateLeave() {
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_FILE_LEAVE(
              selectedFile?.value,
              DateFormat("yyyy-MM-dd")
                  .format(DateFormat("dd-MM-yyyy").parse(effectiveDate.text))),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoFileNameLeave'] != null &&
                map.containsKey('infoFileNameLeave')) {
              isEnable.value = false;
              //RO Ref No.
              strRoRefNo.clear();
              map["infoFileNameLeave"]['strRoRefNo'].forEach((e) {
                strRoRefNo.add(DropDownValue(key: '', value: e));
                selectedRoRefNo = DropDownValue(key: '', value: e);
              });
              //Location
              selectedLoactions = loactions.firstWhereOrNull((element) {
                var result = element.key ==
                    map['infoFileNameLeave']['headerData']['locationCode'];
                return result;
              });
              //Client
              client.clear();
              map["infoFileNameLeave"]['headerData']['lstClients'].forEach((e) {
                client.add(DropDownValue(
                    key: e['clientCode'], value: e['clientName']));
              });
              selectedClient = client.firstWhereOrNull(
                (element) {
                  var result = element.key ==
                      map['infoFileNameLeave']['headerData']['clientcode'];
                  return result;
                },
              );
              //Agency
              agency.clear();
              map["infoFileNameLeave"]['headerData']['lstAgencies']
                  .forEach((e) {
                agency.add(DropDownValue(
                    key: e['agencyCode'], value: e['agencyName']));
              });
              selectedAgency = agency.firstWhereOrNull(
                (element) {
                  var result = element.key ==
                      map['infoFileNameLeave']['headerData']['agencyCode'];
                  return result;
                },
              );
              //Brand
              brand.clear();
              map["infoFileNameLeave"]['headerData']['lstBrands'].forEach((e) {
                brand.add(
                    DropDownValue(key: e['brandcode'], value: e['brandname']));
              });
              //Executives
              executives.clear();
              map["infoFileNameLeave"]['headerData']['executivesSelectedValue']
                  .forEach((e) {
                executives.add(DropDownValue(
                    key: e['personnelCode'], value: e['personnelName']));
              });
              selectedExecutives = DropDownValue(
                  key: executives[0].key, value: executives[0].value);
              // Show Programs
              programList.clear();
              map["infoFileNameLeave"]['lstLoadXml']['lstShowPrograms']
                  .forEach((e) {
                programList.add(e);
              });
              // Channel
              channel.clear();
              map["infoFileNameLeave"]['headerData']['lstChannel'].forEach((e) {
                channel.add(DropDownValue(
                    key: e['channelCode'], value: e['channelName']));
              });
              selectedChannel = channel.firstWhereOrNull(
                (element) {
                  var result = element.key ==
                      map['infoFileNameLeave']['headerData']['channelCode'];
                  return result;
                },
              );
              //Deal No
              dealNo.clear();
              map["infoFileNameLeave"]['headerData']['lstDealNumbers']
                  .forEach((e) {
                dealNo.add(DropDownValue(key: e['code'], value: e['name']));
              });
              //Lst Xml Dt
              lstXmlDtList.value =
                  map["infoFileNameLeave"]['lstLoadXml']['lstXmlDt'];
              leaveFileNameClagdetails();
              update(["initData"]);
            } else {
              LoadingDialog.showErrorDialog('No data found.');
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  leaveFileNameClagdetails() {
    try {
      LoadingDialog.call();
      var effFromDate = DateFormat("dd-MM-yyyy").parse(effectiveDate.text);
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_LEAVE_FILE_NAME_CLAGDETAILS(
            selectedLoactions?.value ?? "",
            selectedChannel?.value ?? "",
            selectedClient?.value ?? "",
            selectedAgency?.value ?? "",
            DateFormat("yyyy-MM-dd").format(effFromDate),
          ),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoFileNameLeaveClagdetails'] != null &&
                map.containsKey('infoFileNameLeaveClagdetails') &&
                (map['infoFileNameLeaveClagdetails'] as List<dynamic>)
                    .isNotEmpty) {
              map["infoFileNameLeaveClagdetails"].forEach((e) {
                zoneTEC.text = e['zonename'];
                bookingNo3TEC.text = e["shortname"];
                payRouteTEC.text = e["payroutename"];
                payRouteCodeTEC.text = e["payRouteCode"];
                zoneCode.value = e["zonecode"];
              });

              update(["initData"]);
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  locationLeave(locationCode) {
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_LEAVE_LOCATION(locationCode ?? ""),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoChannelList'] != null &&
                map.containsKey('infoChannelList') &&
                (map['infoChannelList'] as List<dynamic>).isNotEmpty) {
              channel.clear();
              map["infoChannelList"].forEach((e) {
                channel.add(DropDownValue(
                    key: e['channelCode'], value: e['channelName']));
              });
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  dealLeave() {
    try {
      LoadingDialog.call();
      var effFromDate = DateFormat("dd-MM-yyyy").parse(effectiveDate.text);
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_LEAVE_DEAL_NO(
            DateFormat("yyyy-MM-dd").format(effFromDate),
            selectedLoactions?.key,
            selectedChannel?.key,
            selectedDealNo?.key,
            payRouteTEC.text,
            selectedAgency?.key,
            selectedClient?.key,
            'false',
          ),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoLeaveOnDealNumber'] != null &&
                map.containsKey('infoLeaveOnDealNumber')) {
              //Booking No.
              bookingNo1TEC.text =
                  map['infoLeaveOnDealNumber']['bookingMonth'] ?? "";
              //Start & End Date
              startDateTEC.text = DateFormat("dd-MM-yyyy").format(
                  DateFormat("MM/dd/yyyy hh:mm:ss").parse(
                      map['infoLeaveOnDealNumber']['displayDealDetails']
                              ['startDate'] ??
                          "10/01/2023 00:00:00"));
              endDateTEC.text = DateFormat("dd-MM-yyyy").format(
                  DateFormat("MM/dd/yyyy hh:mm:ss").parse(
                      map['infoLeaveOnDealNumber']['displayDealDetails']
                              ['endDate'] ??
                          "10/01/2023 00:00:00"));
              //Deal Type
              dealTypeTEC.text = map['infoLeaveOnDealNumber']
                      ['displayDealDetails']['dealType'] ??
                  "";
              //Max Spend
              maxSpendTEC.text = map['infoLeaveOnDealNumber']
                      ['displayDealDetails']['dealMaxSpent'] ??
                  "";
              //Pay Mode
              payModeTEC.text = map['infoLeaveOnDealNumber']
                      ['displayDealDetails']['payMode'] ??
                  "";
              //Pre V. Amt
              preVAmtTEC.text = map['infoLeaveOnDealNumber']
                      ['displayDealDetails']['previousValAmount'] ??
                  "";
              //Pre B. Amt
              preBAmtTEC.text = map['infoLeaveOnDealNumber']
                      ['displayDealDetails']['previousBookedAmount'] ??
                  "";
              //Deal Enter List
              List dealEntriesList = map['infoLeaveOnDealNumber']
                      ['displayDealDetails']['lstDgvDealEntries'] ??
                  "";
              lstDgvDealEntriesList.value = dealEntriesList.where((element) {
                var result = selectedLoactions?.value ==
                        element['locationname'].toString() &&
                    selectedChannel?.value ==
                        element['channelname'].toString() &&
                    selectedDealNo?.value == element['dealnumber'].toString();

                return result;
              }).toList();
              //Linked Deal List

              lstDgvLinkedDealsList.value = map['infoLeaveOnDealNumber']
                      ['displayDealDetails']['lstDgvLinkedDeals'] ??
                  "";

              //GST Plants
              gstNoTEC.text = map["infoLeaveOnDealNumber"]['gstRegNo'] ?? "";
              map["infoLeaveOnDealNumber"]['gstPlantList'].forEach((e) {
                gstPlant.add(DropDownValue(
                    key: e['plantid'].toString() ?? "",
                    value: e['column1'] ?? ""));
              });
              selectedGstPlant = gstPlant.firstWhereOrNull(
                (element) {
                  var result =
                      element.key == map['infoLeaveOnDealNumber']['gstPlantID'];
                  return result;
                },
              );

              isShowLink.value = true;
              //LD Button
              linkDealNO.value = map['infoLeaveOnDealNumber']['showLinkDeal']
                      ['linkDealNo'] ??
                  "";
              linkDealName.value = map['infoLeaveOnDealNumber']['showLinkDeal']
                      ['linkDealName'] ??
                  "";
              if (linkDealName.value == null) {
                lDButton.value = true;
              }
              //PDC
              if (map['infoLeaveOnDealNumber']['displayDealDetails']
                  ['grpPDC']) {
                if (pdcDetailsPopUP) {
                  pdcDetailsPopUP = false;
                  LoadingDialog.showErrorDialog(
                      map['infoLeaveOnDealNumber']['displayDealDetails']
                              ['message'] ??
                          "", callback: () {
                    gstDilogBox();
                  });
                }
              } else {
                gstDilogBox();
              }
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  gstDilogBox() {
    if (showGstPopUp) {
      showGstPopUp = false;
      Get.defaultDialog(
          radius: 05,
          title: "GST Plant",
          confirm: FormButtonWrapper(
            btnText: "Done",
            callback: () {
              Get.back();
            },
          ),
          content: SizedBox(
            height: Get.height / 6,
            width: Get.width / 4,
            child: Column(
              children: [
                DropDownField.formDropDown1WidthMap(
                  gstPlant.value,
                  (value) => {selectedGstPlant = value},
                  "GST Plant",
                  0.20,
                  selected: selectedGstPlant,
                  autoFocus: true,
                ),
                InputFields.formField1(
                  hintTxt: "GST Reg#",
                  controller: gstNoTEC,
                  width: 0.20,
                )
              ],
            ),
          ));
    }
  }

  showLink() {
    try {
      LoadingDialog.call();
      var payload = {
        "dealNo": selectedDealNo?.key,
        "locationCode": selectedLoactions?.key,
        "channelCode": selectedChannel?.key,
        "agencyCode": selectedAgency?.key,
        "roRefNo": selectedRoRefNo?.value,
        "lstDgvDealEntries": lstDgvLinkedDealsList.value.map((e) {
          if (e['programname'] == null) {
            e['programname'] = "";
          }
          if (e['programCategoryName'] == null) {
            e['programCategoryName'] = "";
          }
          return e;
        }).toList(),
        "lstXmlDt": lstXmlDtList.value,
        "duration": durAllTEC.text,
        "spots": spotsAllTEC.text,
        "amount": amtAllTEC.text
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EDI_RO_SHOW_LINK,
          json: payload,
          fun: (map) {
            Get.back();
            print(map);
            if (map != null &&
                map['infoShowLink'] != null &&
                map.containsKey('infoShowLink')) {
              lstDgvSpotsList.value = map['infoShowLink']['lstDgvSpots'];
              spotsAllTEC.text = map['infoShowLink']['allSpots'];
              durAllTEC.text = map['infoShowLink']['allDuration'];
              amtAllTEC.text = map['infoShowLink']['allAmount'];
              durBalanceTEC.text = map['infoShowLink']['balanceDuration'];
              spotsBalanceTEC.text = map['infoShowLink']['balanceSpots'];
              amtBalanceTEC.text = map['infoShowLink']['balanceAmount'];
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  spotFpcStart(locationCode, channelCode, telicastDate) {
    try {
      var date = DateFormat("MM-dd-yyyy")
          .format(DateFormat("dd-MM-yyyy").parse(telicastDate ?? "10-01-2023"));
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_SPOT_FPC_START(
              locationCode ?? "", channelCode ?? "", date ?? ""),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['spotFPCStart'] != null &&
                map.containsKey('spotFPCStart') &&
                (map['spotFPCStart'] as List<dynamic>).isNotEmpty) {
              fpcStartTabelList.clear();
              fpcStartTabelList.value = map['spotFPCStart'];
              fpcStartDilogBox();
              // map["infoChannelList"].forEach((e) {
              //   channel.add(DropDownValue(
              //       key: e['channelCode'], value: e['channelName']));
              // });
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  agencyLeave() {
    try {
      LoadingDialog.call();
      var effFromDate = DateFormat("dd-MM-yyyy").parse(effectiveDate.text);
      var payload = {
        "locationCode": selectedLoactions?.key,
        "locationName": selectedLoactions?.value,
        "channelCode": selectedChannel?.key,
        "channelName": selectedChannel?.value,
        "clientCode": selectedClient?.key,
        "clientName": selectedClient?.value,
        "agencyCode": selectedAgency?.key,
        "agencyName": selectedAgency?.value,
        "effectiveDate": DateFormat("yyyy-MM-dd").format(effFromDate),
        "effectiveFrom": DateFormat("yyyy-MM-dd").format(effFromDate)
      };

      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EDI_RO_AGENCY_LEAVE,
          json: payload,
          fun: (map) {
            Get.back();
            print(map);
            if (map != null &&
                map['infoChannelList'] != null &&
                map.containsKey('infoChannelList') &&
                (map['infoChannelList'] as List<dynamic>).isNotEmpty) {}
          });
    } catch (e) {
      print(e.toString());
    }
  }

  brandLeave(brandCode) {
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_LEAVE_BRAND(brandCode ?? ""),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoBrandList'] != null &&
                map.containsKey('infoBrandList')) {
              tapIdTabelList.clear();
              tapIdTabelList.value = map['infoBrandList'];
              tempList.addAll(tapIdTabelList.value);
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  onMarkAsDone() {
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_MARK_AS_DONE(selectedFile?.value),
          fun: (map) {
            Get.back();
            print(map);
            if (map != null &&
                map['infoChannelList'] != null &&
                map.containsKey('infoChannelList') &&
                (map['infoChannelList'] as List<dynamic>).isNotEmpty) {}
          });
    } catch (e) {
      print(e.toString());
    }
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single != null) {
      print(result.files[0]);
      // importfile(result.files[0]);
    } else {
      // User canceled the pic5ker
    }
  }

  showDilogBox() {
    showDialog(
      context: Get.context!,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: Get.width * 0.60,
            height: Get.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: lstDgvLinkedDealsList.isEmpty
                            ? BoxDecoration(
                                border: Border.all(color: Colors.grey))
                            : null,
                        child: lstDgvLinkedDealsList.value.isEmpty
                            ? null
                            : DataGridShowOnlyKeys(
                                mapData: lstDgvLinkedDealsList.value,
                                hideCode: false,
                                exportFileName: "EDI R.O. Booking",
                              ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8),
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: FormButton(
                  //       btnText: "Return",
                  //       callback: () {
                  //         programSummaryTableList.clear();
                  //         Get.back();
                  //       },
                  //       showIcon: false,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  fpcStartDilogBox() {
    drgabbleDialog.value = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: SizedBox(
        width: Get.width * 0.60,
        height: Get.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    drgabbleDialog.value = null;
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              Expanded(
                child: Obx(
                  () => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: fpcStartTabelList.isEmpty
                        ? BoxDecoration(border: Border.all(color: Colors.grey))
                        : null,
                    child: fpcStartTabelList.value.isEmpty
                        ? null
                        : DataGridShowOnlyKeys(
                            mapData: fpcStartTabelList.value,
                            hideCode: false,
                            exportFileName: "EDI R.O. Booking",
                            formatDate: false,
                            onload: (event) {
                              fpcStartTabelGrid = event.stateManager;
                            },
                            colorCallback: (colorEvent) {
                              return colorEvent.row.cells.containsValue(
                                      fpcStartTabelGrid?.currentCell)
                                  ? Colors.deepPurple.shade100
                                  : Colors.white;
                            },
                            onRowDoubleTap: (event) {
                              // print(event.cell.column.field);

                              if (event.cell.column.field.toString() ==
                                  'telecastTime') {
                                if (dvgSpotGrid?.currentRow?.sortIdx == null) {
                                  LoadingDialog.callInfoMessage(
                                      "Please select row.");
                                } else {
                                  lstDgvSpotsList.value[dvgSpotGrid!.currentRow!
                                      .sortIdx]['fpcstart'] = event.cell.value!;
                                  dvgSpotGrid!.changeCellValue(
                                    dvgSpotGrid!.currentRow!.cells['fpcstart']!,
                                    event.cell.value!,
                                    callOnChangedEvent: false,
                                    force: true,
                                  );
                                }
                                // print(
                                //     event.row.cells['telecastTime']?.value);
                              }
                            },
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  tapeIdDilogBox() {
    drgabbleDialog.value = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: SizedBox(
        width: Get.width * 0.60,
        height: Get.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputFields.formField1(
                    hintTxt: "Search Tape ID",
                    controller: TextEditingController(),
                    onFieldSubmitted: (value) {
                      tempList.clear();
                      if (value.isNotEmpty) {
                        for (var i = 0; i < tapIdTabelList.length; i++) {
                          if (value == tapIdTabelList[i]['exportTapeCode']) {
                            tempList.add(tapIdTabelList[i]);
                          }
                        }
                      } else {
                        tempList.addAll(tapIdTabelList.value);
                      }
                    },
                    width: 0.3,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        drgabbleDialog.value = null;
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Obx(
                  () => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: tempList.isEmpty
                        ? BoxDecoration(border: Border.all(color: Colors.grey))
                        : null,
                    child: tempList.value.isEmpty
                        ? null
                        : DataGridShowOnlyKeys(
                            mapData: tempList.value,
                            hideCode: false,
                            exportFileName: "EDI R.O. Booking",
                            formatDate: false,
                            onload: (event) {
                              tapeIdTabelGrid = event.stateManager;
                            },
                            colorCallback: (colorEvent) {
                              return colorEvent.row.cells.containsValue(
                                      tapeIdTabelGrid?.currentCell)
                                  ? Colors.deepPurple.shade100
                                  : Colors.white;
                            },
                            onRowDoubleTap: (event) {
                              if (event.cell.column.field.toString() ==
                                  'exportTapeCode') {
                                if (dvgSpotGrid?.currentRow?.sortIdx == null) {
                                  LoadingDialog.callInfoMessage(
                                      "Please select row.");
                                } else if (dvgSpotGrid!.currentRow!
                                        .cells['commercialduration']!.value
                                        .toString() !=
                                    event.row.cells['commercialDuration']?.value
                                        .toString()) {
                                  LoadingDialog.callErrorMessage1(
                                      msg: "Duration mismatch!");
                                } else {
                                  for (int i = 0;
                                      i < dvgSpotGrid!.refRows.length;
                                      i++) {
                                    if (dvgSpotGrid!.refRows[i]
                                            .cells['commercialduration']!.value
                                            .toString() ==
                                        event.row.cells['commercialDuration']
                                            ?.value
                                            .toString()) {
                                      //Tape Id
                                      lstDgvSpotsList.value[
                                              dvgSpotGrid!.refRows[i].sortIdx]
                                          ['tapE_ID'] = event.cell.value!;
                                      dvgSpotGrid!.changeCellValue(
                                        dvgSpotGrid!
                                            .refRows[i].cells['tapE_ID']!,
                                        event.cell.value!.toString(),
                                        callOnChangedEvent: false,
                                        force: true,
                                      );
                                      //Commercial Caption
                                      lstDgvSpotsList.value[dvgSpotGrid!
                                              .refRows[i]
                                              .sortIdx]['commercialcaption'] =
                                          event.row.cells['commercialCaption']
                                              ?.value
                                              .toString();
                                      dvgSpotGrid!.changeCellValue(
                                        dvgSpotGrid!.refRows[i]
                                            .cells['commercialcaption']!,
                                        event.row.cells['commercialCaption']
                                            ?.value
                                            .toString(),
                                        callOnChangedEvent: false,
                                        force: true,
                                      );
                                    }
                                  }
                                }
                              }
                            },
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> clearFirstDataTableFilter(
      PlutoGridStateManager stateManager) async {
    Get.find<MainController>().filters1[stateManager.hashCode.toString()] =
        RxList([]);
    var _filters =
        Get.find<MainController>().filters1[stateManager.hashCode.toString()] ??
            [];
    stateManager.setFilter((element) => true);
    List<PlutoRow> _filterRows = stateManager.rows;
    for (var filter in _filters) {
      if (filter.operator == "equal") {
        _filterRows = _filterRows
            .where(
                (element) => element.cells[filter.field]!.value == filter.value)
            .toList();
      } else {
        _filterRows = _filterRows
            .where(
                (element) => element.cells[filter.field]!.value != filter.value)
            .toList();
      }
    }
    stateManager.setFilter((element) => _filterRows.contains(element));
  }

  Future<void> doubleClickFilterGrid(gridController) async {
    print("Hashcode======================> ${gridController!.hashCode}");
    if (Get.find<MainController>()
        .filters1
        .containsKey(gridController!.hashCode.toString())) {
    } else {
      Get.find<MainController>().filters1[gridController!.hashCode.toString()] =
          RxList([]);
    }
    filtterValue = dvgSpotGrid!.currentCell!.value;
    if (gridController!.currentCell != null) {
      Get.find<MainController>()
          .filters1[gridController!.hashCode.toString()]!
          .add(RowFilter(
              field: gridController!.currentCell!.column.field,
              operator: "equal",
              value: gridController!.currentCell!.value));
    }

    var _filters = Get.find<MainController>()
            .filters1[gridController.hashCode.toString()] ??
        [];
    gridController!.setFilter((element) => true);
    List<PlutoRow> _filterRows = gridController!.rows;
    for (var filter in _filters) {
      if (filter.operator == "equal") {
        _filterRows = _filterRows
            .where(
                (element) => element.cells[filter.field]!.value == filter.value)
            .toList();
      } else {
        _filterRows = _filterRows
            .where(
                (element) => element.cells[filter.field]!.value != filter.value)
            .toList();
      }
    }
    gridController!.setFilter((element) => _filterRows.contains(element));
  }

  Future<void> doubleClickFilterGrid1(gridController, field, value) async {
    print("Hashcode======================> ${gridController!.hashCode}");
    if (Get.find<MainController>()
        .filters1
        .containsKey(gridController!.hashCode.toString())) {
    } else {
      Get.find<MainController>().filters1[gridController!.hashCode.toString()] =
          RxList([]);
    }

    if (gridController!.currentCell != null) {
      Get.find<MainController>()
          .filters1[gridController!.hashCode.toString()]!
          .add(RowFilter(
              // costPer10Sec
              field: field,
              operator: "equal",
              value: value));
    }

    var _filters = Get.find<MainController>()
            .filters1[gridController.hashCode.toString()] ??
        [];
    gridController!.setFilter((element) => true);
    List<PlutoRow> _filterRows = gridController!.rows;
    for (var filter in _filters) {
      if (filter.operator == "equal") {
        _filterRows = _filterRows.where((element) {
          return element.cells[filter.field]!.value == filter.value;
        }).toList();
      } else {
        _filterRows = _filterRows.where((element) {
          return element.cells[filter.field]!.value == filter.value;
        }).toList();
      }
    }
    gridController!.setFilter((element) => _filterRows.contains(element));
  }

  Color getColor(Map<String, dynamic> dr, int index) {
    if (dr.containsKey("noProgram") && dr["noProgram"].toString() == "1") {
      return const Color.fromRGBO(255, 230, 230, 1);
    } else if (dr.containsKey("auditedSpots") && dr['auditedSpots'] == 0) {
      return const Color.fromRGBO(255, 150, 150, 1);
    } else if (dr["bookingno"] == "Unaudited") {
      return const Color.fromRGBO(255, 230, 230, 1);
    } else if ((dr['auditedSpots'] ?? 0) < (dr["totalspots"] ?? 0)) {
      return const Color.fromRGBO(255, 150, 150, 1);
    }
    return Colors.white; // Return null if no color conditions are met.
  }

  @override
  void onReady() {
    super.onReady();
    getInitData();
    fetchUserSetting1();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
