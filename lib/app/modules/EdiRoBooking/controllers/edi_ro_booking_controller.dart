import 'dart:convert';
import 'dart:math';

import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/app/modules/CommonDocs/views/common_docs_view.dart';
import 'package:bms_salesco/app/modules/EdiRoBooking/bindings/edi_ro_booking_check_all_deal_utility.dart';
import 'package:bms_salesco/app/modules/EdiRoBooking/bindings/edi_ro_booking_model.dart';
import 'package:bms_salesco/app/modules/EdiRoBooking/bindings/edit_ro_init_data.dart';
import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:bms_salesco/widgets/PlutoGrid/pluto_grid.dart';

import '../../../../widgets/DataGridShowOnly.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/rowfilter.dart';
import '../../../providers/ApiFactory.dart';
import '../../CommonDocs/controllers/common_docs_controller.dart';
import '../bindings/edi_ro_booking_deal_leave_model.dart';

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
      gstNoTEC = TextEditingController(),
      pdcChqAmtTEC = TextEditingController(text: '0.00'),
      mgStartDateTEC = TextEditingController(),
      mgEndDateTEC = TextEditingController(),
      pdcLoactionTEC = TextEditingController(),
      pdcChannelTEC = TextEditingController(),
      pdcAgencyTEC = TextEditingController(),
      pdcClientTEC = TextEditingController(),
      pdcActivityPeriodTEC = TextEditingController(),
      pdcChequeNoTEC = TextEditingController(),
      pdcChqDtTEC = TextEditingController(),
      pdcBankTEC = TextEditingController(),
      pdcChequeRecordByTEC = TextEditingController(),
      pdcRecordOnTEC = TextEditingController(),
      pdcRemarksTEC = TextEditingController(),
      effectiveDate = TextEditingController(),
      bkDate = TextEditingController();

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
  bool isCheckAll = true;

  var extraButtons = ['Info', 'Check All', 'MG Spots', 'Tape Id'];

  var isShowLink = false.obs;
  var lstXmlDtList = [].obs;
  var lstDgvSpotsList = [].obs;
  var fpcStartTabelList = [].obs;
  var tapIdTabelList = [].obs;
  var tempList = [].obs;
  var filtterValue = '';
  var selectedIndex = 9999.obs;
  var blnDurationMismatch = true.obs;
  var intMonth = 0.obs;
  var intYear = 0.obs;
  int lastSelectedIdx = 0;
  var lastSelectedOffect = 0.0;
  var isEnterNewPDC = false.obs;
  int chequeID = 0;
  var fillPDCList = [].obs;
  var controllsEnable = false.obs;
  var isSelectingChange = true.obs;
  var roMsg = "".obs;
  var lstDgvDealEntries = <LstDealEntries>[].obs;
  var lstDgvSpots = <LstSpots>[].obs;
  var makeGoodReportList = [].obs;
  int mgLastSelectedIdx = 0;

  PlutoGridStateManager? dvgSpotGrid;

  PlutoGridStateManager? dgvDealEntriesGrid;
  PlutoGridStateManager? fpcStartTabelGrid;
  PlutoGridStateManager? tapeIdTabelGrid;
  PlutoGridStateManager? fillPDCTabelGrid;
  PlutoGridStateManager? mgSpotTabelGrid;

  PlutoRowColorContext? coloerEvents;

  EdiRoInitData? initData;
  RoBookingLeaveFileName? roBookingLeaveFileName;
  RoBookingDealLeave? roBookingDealLeave;
  RoBookingCheckAllDealUtility? roBookingCheckAllDealUtility;

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
  var newPdcList = RxList<DropDownValue>();

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
  DropDownValue? selectedPdc;

  ValueKey? valueKey;

  PlutoGridStateManager? stateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1;
  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  RxBool isEnable = RxBool(true);
  RxBool isBrandEnable = RxBool(true);
  var fileNameFN = FocusNode(), brandFN = FocusNode(), effDateFN = FocusNode();

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
            if (map is Map && map.containsKey("onLoadInfo")) {
              Get.back();
              initData = EdiRoInitData.fromJson(map["onLoadInfo"]);
              //FileName
              fileNames.clear();
              initData!.softListMyFiles!.forEach((e) {
                fileNames
                    .add(DropDownValue(key: '', value: e.convertedFileName));
              });
              //Loaction
              loactions.clear();
              initData!.lstLocation!.forEach((e) {
                loactions.add(
                    DropDownValue(key: e.locationCode, value: e.locationName));
              });
              // Position
              positions.clear();
              initData!.lstSpotPosType!.forEach((e) {
                positions.add(DropDownValue(
                    key: e.spotPositionTypeCode,
                    value: e.spotPositionTypeName));
              });
              selectedPositions = positions.firstWhereOrNull(
                (element) {
                  var result = element.key == "ZAMID00002";
                  return result;
                },
              );
              // Executives
              executives.clear();
              initData!.executives!.forEach((e) {
                executives.add(DropDownValue(
                    key: e.personnelCode, value: e.personnelName));
              });
              // executives.clear();
              // map["onLoadInfo"]['executives'].forEach((e) {
              //   executives.add(DropDownValue(
              //       key: e['personnelCode'], value: e['personnelName']));
              // });
              update(["initData"]);
            } else if (map is String) {
              LoadingDialog.callErrorMessage1(msg: map);
            }
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
              roBookingLeaveFileName = RoBookingLeaveFileName.fromJson(map);

              isEnable.value = false;
              //RO Ref No.
              strRoRefNo.clear();
              roBookingLeaveFileName!.infoFileNameLeave!.strRoRefNo!
                  .forEach((e) {
                strRoRefNo.add(DropDownValue(key: '', value: e));
                selectedRoRefNo = DropDownValue(key: '', value: e);
              });

              //Location
              selectedLoactions = loactions.firstWhereOrNull((element) {
                var result = element.key ==
                    roBookingLeaveFileName!
                        .infoFileNameLeave!.headerData!.locationCode;
                return result;
              });
              pdcLoactionTEC.text = selectedLoactions!.value.toString();

              // Channel
              channel.clear();
              roBookingLeaveFileName!.infoFileNameLeave!.headerData!.lstChannel!
                  .forEach((e) {
                channel.add(
                    DropDownValue(key: e.channelCode, value: e.channelName));
              });
              selectedChannel = channel.firstWhereOrNull(
                (element) {
                  var result = element.key ==
                      roBookingLeaveFileName!
                          .infoFileNameLeave!.headerData!.channelCode;

                  return result;
                },
              );
              pdcChannelTEC.text = selectedChannel!.value.toString();
              //Client
              client.clear();
              roBookingLeaveFileName!.infoFileNameLeave!.headerData!.lstClients!
                  .forEach((e) {
                client
                    .add(DropDownValue(key: e.clientCode, value: e.clientName));
              });

              selectedClient = client.firstWhereOrNull(
                (element) {
                  var result = element.key ==
                      roBookingLeaveFileName!
                          .infoFileNameLeave!.headerData!.clientcode;
                  return result;
                },
              );
              pdcClientTEC.text = selectedClient!.value.toString();
              //Agency
              agency.clear();
              roBookingLeaveFileName!
                  .infoFileNameLeave!.headerData!.lstAgencies!
                  .forEach((e) {
                agency
                    .add(DropDownValue(key: e.agencyCode, value: e.agencyName));
              });
              selectedAgency = agency.firstWhereOrNull(
                (element) {
                  var result = element.key ==
                      roBookingLeaveFileName!
                          .infoFileNameLeave!.headerData!.agencyCode;
                  return result;
                },
              );

              pdcAgencyTEC.text = selectedAgency!.value.toString();
              //Brand
              brand.clear();
              roBookingLeaveFileName!.infoFileNameLeave!.headerData!.lstBrands!
                  .forEach((e) {
                brand.add(DropDownValue(key: e.brandcode, value: e.brandname));
              });
              //Executives
              executives.clear();
              roBookingLeaveFileName!
                  .infoFileNameLeave!.headerData!.executivesSelectedValue!
                  .forEach((e) {
                executives.add(DropDownValue(
                    key: e.personnelCode, value: e.personnelName));
              });

              selectedExecutives = DropDownValue(
                  key: executives[0].key, value: executives[0].value);
              // Show Programs
              programList.clear();
              roBookingLeaveFileName!
                  .infoFileNameLeave!.lstLoadXml!.lstShowPrograms!
                  .forEach((e) {
                programList.add(e);
              });
              //Deal No
              dealNo.clear();
              roBookingLeaveFileName!
                  .infoFileNameLeave!.headerData!.lstDealNumbers!
                  .forEach((e) {
                dealNo.add(DropDownValue(key: e.code, value: e.name));
              });
              //Lst Xml Dt
              lstXmlDtList.value = roBookingLeaveFileName!
                  .infoFileNameLeave!.lstLoadXml!.lstXmlDt!;
              roMsg.value = roBookingLeaveFileName!
                      .infoFileNameLeave!.headerData!.message ??
                  "";
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
              if (roMsg != "") {
                LoadingDialog.callInfoMessage(roMsg.toString());
              }
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
            selectedLoactions?.key ?? "",
            selectedChannel?.key ?? "",
            selectedDealNo?.key ?? "",
            payRouteTEC.text ?? "",
            selectedAgency?.key ?? "",
            selectedClient?.key ?? "",
            'false',
          ),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoLeaveOnDealNumber'] != null &&
                map.containsKey('infoLeaveOnDealNumber')) {
              roBookingDealLeave = RoBookingDealLeave.fromJson(map);
              //Booking No.
              bookingNo1TEC.text =
                  roBookingDealLeave!.infoLeaveOnDealNumber!.bookingMonth! ??
                      "";

              pdcActivityPeriodTEC.text =
                  roBookingDealLeave!.infoLeaveOnDealNumber!.bookingMonth! ??
                      "";

              //Start & End Date
              startDateTEC.text = DateFormat("dd-MM-yyyy").format(
                  DateFormat("MM/dd/yyyy hh:mm:ss").parse(roBookingDealLeave!
                          .infoLeaveOnDealNumber!
                          .displayDealDetails!
                          .startDate! ??
                      "10/01/2023 00:00:00"));
              endDateTEC.text = DateFormat("dd-MM-yyyy").format(
                  DateFormat("MM/dd/yyyy hh:mm:ss").parse(roBookingDealLeave!
                          .infoLeaveOnDealNumber!
                          .displayDealDetails!
                          .endDate! ??
                      "10/01/2023 00:00:00"));
              //Deal Type
              dealTypeTEC.text = roBookingDealLeave!
                      .infoLeaveOnDealNumber!.displayDealDetails!.dealType! ??
                  "";
              //Max Spend
              maxSpendTEC.text = roBookingDealLeave!.infoLeaveOnDealNumber!
                      .displayDealDetails!.dealMaxSpent! ??
                  "";

              //Pay Mode
              payModeTEC.text = roBookingDealLeave!
                      .infoLeaveOnDealNumber!.displayDealDetails!.payMode! ??
                  "";

              //Pre V. Amt
              preVAmtTEC.text = roBookingDealLeave!.infoLeaveOnDealNumber!
                      .displayDealDetails!.previousValAmount! ??
                  "";
              //Pre B. Amt
              preBAmtTEC.text = roBookingDealLeave!.infoLeaveOnDealNumber!
                      .displayDealDetails!.previousBookedAmount! ??
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
                  [];

              //GST Plants
              gstNoTEC.text =
                  roBookingDealLeave?.infoLeaveOnDealNumber?.gstRegNo ?? "";
              if (roBookingDealLeave?.infoLeaveOnDealNumber?.gstPlantList !=
                  null) {
                roBookingDealLeave!.infoLeaveOnDealNumber!.gstPlantList!
                    .forEach((e) {
                  gstPlant.add(DropDownValue(
                      key: e.plantid.toString() ?? "", value: e.column1 ?? ""));
                });
                selectedGstPlant = gstPlant.firstWhereOrNull(
                  (element) {
                    var result = element.key ==
                        roBookingDealLeave!.infoLeaveOnDealNumber!.gstPlantId!;
                    return result;
                  },
                );
              }

              isShowLink.value = true;
              //LD Button
              linkDealNO.value = roBookingDealLeave!
                      .infoLeaveOnDealNumber!.showLinkDeal!.linkDealNo! ??
                  "";
              linkDealName.value = roBookingDealLeave!
                      .infoLeaveOnDealNumber!.showLinkDeal!.linkDealName! ??
                  "";
              print(roBookingDealLeave!
                  .infoLeaveOnDealNumber!.showLinkDeal!.linkDealNo!
                  .toString());
              if (roBookingDealLeave!
                      .infoLeaveOnDealNumber!.showLinkDeal!.linkDealNo!
                      .toString() !=
                  "0") {
                lDButton.value = true;
              }
              //PDC
              if (roBookingDealLeave!
                  .infoLeaveOnDealNumber!.displayDealDetails!.grpPdc!) {
                if (pdcDetailsPopUP) {
                  pdcDetailsPopUP = false;
                  LoadingDialog.showErrorDialog(
                      roBookingDealLeave!.infoLeaveOnDealNumber!
                              .displayDealDetails!.message ??
                          "", callback: () {
                    isEnterNewPDC.value = true;
                    gstDilogBox();
                    getFillPDC();
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
          // barrierDismissible: false,
          radius: 05,
          title: "GST Plant",
          confirm: FormButtonWrapper(
            btnText: "Done",
            callback: () {
              if (selectedGstPlant == null) {
                LoadingDialog.showErrorDialog('Please select GST Plant');
              } else {
                brandFN.requestFocus();
                Get.back();
              }
            },
          ),
          content: Focus(
            autofocus: true,
            onKey: (node, event) {
              print("object111");
              if (event.logicalKey == LogicalKeyboardKey.escape) {
                print("object");
                Get.back();
              }
              return KeyEventResult.ignored;
            },
            child: SizedBox(
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
              if (map['infoShowLink']['message'] != null) {
                LoadingDialog.recordExists(
                    map['infoShowLink']['message'].toString(), () {
                  Get.back();
                  showDefaultLink();
                }, cancel: () {
                  Get.back();
                });
              } else {
                showDefaultLink();
              }
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  showDefaultLink() {
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
          api: ApiFactory.EDI_RO_SHOW_YES_DEFAULT_LINK,
          json: payload,
          fun: (map) {
            Get.back();
            print(map);
            if (map != null &&
                map['infoShowLink'] != null &&
                map.containsKey('infoShowLink')) {
              if (map['infoShowLink']['message'] != null) {
                LoadingDialog.recordExists(
                    map['infoShowLink']['message'].toString(), () {
                  showDefaultLink();
                  Get.back();
                }, cancel: () {
                  Get.back();
                });
              } else {
                lstDgvSpotsList.value = map['infoShowLink']['lstDgvSpots'];
                spotsAllTEC.text = map['infoShowLink']['allSpots'];
                durAllTEC.text = map['infoShowLink']['allDuration'];
                amtAllTEC.text = map['infoShowLink']['allAmount'];
                durBalanceTEC.text = map['infoShowLink']['balanceDuration'];
                spotsBalanceTEC.text = map['infoShowLink']['balanceSpots'];
                amtBalanceTEC.text = map['infoShowLink']['balanceAmount'];
              }
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  spotFpcStart(locationCode, channelCode, telicastDate) {
    try {
      var date = telicastDate.contains('/')
          ? DateFormat("MM-dd-yyyy").format(
              DateFormat("dd/MM/yyyy").parse(telicastDate ?? "10/01/2023"))
          : DateFormat("MM-dd-yyyy").format(
              DateFormat("dd-MM-yyyy").parse(telicastDate ?? "10-01-2023"));
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_SPOT_FPC_START(
              locationCode ?? "", channelCode ?? "", date),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['spotFPCStart'] != null &&
                map.containsKey('spotFPCStart') &&
                (map['spotFPCStart'] as List<dynamic>).isNotEmpty) {
              fpcStartTabelList.clear();
              fpcStartTabelList.value = map['spotFPCStart'];
              fpcStartDilogBox();
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
              tempList.clear();
              tapIdTabelList.value = map['infoBrandList'];
              tempList.addAll(tapIdTabelList.value);
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  onMarkAsDone() {
    if (selectedFile == null) {
      LoadingDialog.showErrorDialog("Nothing to update");
    } else {
      LoadingDialog.modify(
        "Do you want to mark this RO as entered!\nIf yes then it will not appear in your screen to enter again!",
        () {
          //yes
          try {
            LoadingDialog.call();
            Get.find<ConnectorControl>().GETMETHODCALL(
              api: ApiFactory.EDI_RO_MARK_AS_DONE(selectedFile?.value),
              fun: (map) {
                Get.back();
                print(map);
                if (map != null &&
                    map['infoAgencyLeave'] != null &&
                    map.containsKey('infoAgencyLeave')) {
                  Get.delete<EdiRoBookingController>();
                  Get.find<HomeController>().clearPage1();
                }
              },
            );
          } catch (e) {
            print(e.toString());
          }
        },
        () {
          //No
          Get.back();
        },
        deleteTitle: "Yes",
        cancelTitle: "No",
      );
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  fpcStartDilogBox() {
    drgabbleDialog.value = Focus(
      autofocus: true,
      onKey: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          drgabbleDialog.value = null;
        }

        return KeyEventResult.ignored;
      },
      child: Card(
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
                          ? BoxDecoration(
                              border: Border.all(color: Colors.grey))
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

                                fpcStartTabelGrid?.setCurrentCell(
                                    event.cell, event.rowIdx);

                                // if (event.cell.column.field.toString() ==
                                //     'telecastTime') {
                                if (dvgSpotGrid?.currentRow?.sortIdx == null) {
                                  LoadingDialog.callInfoMessage(
                                      "Please select row.");
                                } else {
                                  // Telecast Time
                                  lstDgvSpotsList.value[dvgSpotGrid!
                                          .currentRow!.sortIdx]['fpcstart'] =
                                      event.row.cells['telecastTime']?.value;
                                  dvgSpotGrid!.changeCellValue(
                                    dvgSpotGrid!.currentRow!.cells['fpcstart']!,
                                    event.row.cells['telecastTime']?.value,
                                    callOnChangedEvent: false,
                                    force: true,
                                  );
                                  // Program Name
                                  lstDgvSpotsList.value[dvgSpotGrid!
                                          .currentRow!.sortIdx]['fpcprogram'] =
                                      event.row.cells['programName']?.value;
                                  dvgSpotGrid!.changeCellValue(
                                    dvgSpotGrid!
                                        .currentRow!.cells['fpcprogram']!,
                                    event.row.cells['programName']?.value,
                                    callOnChangedEvent: false,
                                    force: true,
                                  );
                                  // Program Code
                                  lstDgvSpotsList.value[dvgSpotGrid!
                                          .currentRow!.sortIdx]['programCode'] =
                                      event.row.cells['programCode']?.value;
                                  dvgSpotGrid!.changeCellValue(
                                    dvgSpotGrid!
                                        .currentRow!.cells['programCode']!,
                                    event.row.cells['programCode']?.value,
                                    callOnChangedEvent: false,
                                    force: true,
                                  );

                                  // Group Code
                                  lstDgvSpotsList.value[dvgSpotGrid!
                                          .currentRow!.sortIdx]['groupcode'] =
                                      event.row.cells['groupCode']?.value;
                                  dvgSpotGrid!.changeCellValue(
                                    dvgSpotGrid!
                                        .currentRow!.cells['groupcode']!,
                                    event.row.cells['groupCode']?.value,
                                    callOnChangedEvent: false,
                                    force: true,
                                  );
                                }
                                // print(
                                //     event.row.cells['telecastTime']?.value);
                                // }
                              },
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  tapeIdDilogBox() {
    drgabbleDialog.value = Focus(
      autofocus: true,
      onKey: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          drgabbleDialog.value = null;
        }

        return KeyEventResult.ignored;
      },
      child: Card(
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
                      onchanged: (value) async {
                        if (Get.find<MainController>()
                            .filters1
                            .containsKey(tapeIdTabelGrid.hashCode.toString())) {
                          await clearFirstDataTableFilter(tapeIdTabelGrid!);
                        }
                      },
                      onFieldSubmitted: (value) async {
                        // tempList.clear();
                        // if (value.isNotEmpty) {
                        //   for (var i = 0; i < tapIdTabelList.length; i++) {
                        //     if (value == tapIdTabelList[i]['exportTapeCode']) {
                        //       tempList.add(tapIdTabelList[i]);
                        //     }
                        //   }
                        // } else {
                        //   tempList.addAll(tapIdTabelList.value);
                        // }
                        print(value.toString());
                        if (Get.find<MainController>()
                            .filters1
                            .containsKey(tapeIdTabelGrid.hashCode.toString())) {
                          await clearFirstDataTableFilter(tapeIdTabelGrid!);
                        }
                        for (var element in tapeIdTabelGrid!.rows) {
                          if (element.cells['exportTapeCode']?.value ==
                              value.toString()) {
                            tapeIdTabelGrid?.setCurrentCell(
                                element.cells['exportTapeCode'],
                                element.sortIdx);
                            break;
                          }
                        }
                        doubleClickFilterGrid1(tapeIdTabelGrid,
                            'exportTapeCode', value.toString());
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
                      decoration: tapIdTabelList.isEmpty
                          ? BoxDecoration(
                              border: Border.all(color: Colors.grey))
                          : null,
                      child: tapIdTabelList.value.isEmpty
                          ? null
                          : DataGridShowOnlyKeys(
                              mapData: tapIdTabelList.value,
                              hideCode: false,
                              exportFileName: "EDI R.O. Booking",
                              formatDate: false,
                              onload: (event) {
                                tapeIdTabelGrid = event.stateManager;
                                tapeIdTabelGrid?.setCurrentCell(
                                    tapeIdTabelGrid
                                        ?.getRowByIdx(
                                            tapeIdTabelGrid?.currentRowIdx ?? 0)
                                        ?.cells['exportTapeCode'],
                                    tapeIdTabelGrid?.currentRowIdx ?? 0);
                              },
                              colorCallback: (colorEvent) {
                                return colorEvent.row.cells.containsValue(
                                        tapeIdTabelGrid?.currentCell)
                                    ? Colors.deepPurple.shade100
                                    : Colors.white;
                              },
                              onRowDoubleTap: (event) {
                                tapeIdTabelGrid?.setCurrentCell(
                                    event.cell, event.rowIdx);
                                if (event.cell.column.field.toString() ==
                                    'exportTapeCode') {
                                  if (dvgSpotGrid?.currentRow?.sortIdx ==
                                      null) {
                                    LoadingDialog.callInfoMessage(
                                        "Please select row.");
                                  } else if (dvgSpotGrid!.currentRow!
                                          .cells['commercialduration']!.value
                                          .toString() !=
                                      event.row.cells['commercialDuration']
                                          ?.value
                                          .toString()) {
                                    LoadingDialog.callErrorMessage1(
                                        msg: "Duration mismatch!");
                                  } else {
                                    for (int i = 0;
                                        i < dvgSpotGrid!.refRows.length;
                                        i++) {
                                      if (dvgSpotGrid!
                                              .refRows[i]
                                              .cells['commercialduration']!
                                              .value
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
      ),
    );
  }

  tapId() {
    // if (selectedLoactions?.key == null) {
    //   LoadingDialog.showErrorDialog('Please select location.');
    // } else if (selectedChannel?.key == null) {
    //   LoadingDialog.showErrorDialog('Please select channel.');
    // } else if (selectedBrand?.key == null) {
    //   LoadingDialog.showErrorDialog('Please select brand.');
    // } else {
    try {
      LoadingDialog.call();
      var payload = {
        "locationCode": selectedLoactions?.key ?? "",
        "channelCode": selectedChannel?.key ?? "",
        "brandCode": selectedBrand?.key ?? "",
        "lstSpots": lstDgvSpotsList.map((e) {
          if (e['backColor'] == null) {
            e['backColor'] = "";
          }
          if (e['programcategoryname'] == null) {
            e['programcategoryname'] = "";
          }
          if (e['groupcode'] == null) {
            e['groupcode'] = "";
          }
          if (e['pEndTime'] == null) {
            e['pEndTime'] = "";
          }
          return e;
        }).toList(),
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EDI_RO_COMP_TATE_ID,
          json: payload,
          fun: (map) {
            Get.back();
            if (map != null &&
                map['strCompTape'] != null &&
                map.containsKey('strCompTape')) {
              if (map['strCompTape'].isNotEmpty) {
                LoadingDialog.showErrorDialog(map['strCompTape']);
              }
              // update(["initData"]);
            }
          });
    } catch (e) {
      print(e.toString());
    }
    // }
  }

  showMakeGood() {
    if (selectedLoactions?.key == null) {
      LoadingDialog.showErrorDialog('Please select location.');
    } else if (selectedChannel?.key == null) {
      LoadingDialog.showErrorDialog('Please select channel.');
    } else if (selectedBrand?.key == null) {
      LoadingDialog.showErrorDialog('Please select brand.');
    } else {
      try {
        var fromDate = DateFormat("MM-dd-yyyy").format(DateFormat("dd-MM-yyyy")
            .parse(mgStartDateTEC.text ?? "10-01-2023"));
        var toDate = DateFormat("MM-dd-yyyy").format(
            DateFormat("dd-MM-yyyy").parse(mgEndDateTEC.text ?? "10-01-2023"));
        LoadingDialog.call();
        Get.find<ConnectorControl>().GETMETHODCALL(
            api: ApiFactory.EDI_RO_SHOW_MAKE_GOOD(
              selectedLoactions?.value ?? "",
              selectedChannel?.value ?? "",
              selectedBrand?.value ?? "",
              selectedClient?.value ?? "",
              selectedAgency?.value ?? "",
              fromDate,
              toDate,
              selectedDealNo?.value ?? "",
            ),
            fun: (map) {
              Get.back();
              if (map != null &&
                  map['infoShowMakeGood'] != null &&
                  map.containsKey('infoShowMakeGood')) {
                makeGoodReportList.value =
                    map['infoShowMakeGood']['lstMakeGood'];
                if (map['infoShowMakeGood']['message'] != null) {
                  LoadingDialog.callInfoMessage(
                      map['infoShowMakeGood']['message']);
                }
              }
            });
      } catch (e) {
        print(e.toString());
      }
    }
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
    // filtterValue = dvgSpotGrid!.currentCell!.value;
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

    if (gridController!.hashCode != null) {
      Get.find<MainController>()
          .filters1[gridController!.hashCode.toString()]!
          .add(RowFilter(
              // costPer10Sec
              field: field,
              operator: "equal",
              value: value));
    } else {
      print(gridController!.currentCell);
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
      return Colors.red;
    } else if (dr.containsKey("dur") &&
        dr.containsKey("commercialduration") &&
        dr["dur"].toString() != dr["commercialduration"].toString()) {
      // if (blnDurationMismatch.value) {
      //   blnDurationMismatch.value = false;
      //   LoadingDialog.callErrorMessage(
      //       "Duration mismatch!\nRequested duration is not equal to tape duration!");
      // }
      return const Color.fromRGBO(255, 230, 230, 1);
    }

    //Month
    if (intMonth.value != 0) {
      var months =
          DateFormat('MM').format(DateFormat('dd-MM-yyyy').parse(dr['acT_DT']));
      if (dr.containsKey("acT_DT") && int.parse(months) != intMonth.value) {
        // LoadingDialog.callErrorMessage(
        //     "Month / Year mismatch!\nMultiple Month / Year not allowed!");

        return const Color.fromRGBO(255, 230, 230, 1);
      }
    } else {
      var months =
          DateFormat('MM').format(DateFormat('dd-MM-yyyy').parse(dr['acT_DT']));
      intMonth.value = int.parse(months);
    }

    //Year
    if (intYear.value != 0) {
      var year = DateFormat('yyyy')
          .format(DateFormat('dd-MM-yyyy').parse(dr['acT_DT']));
      if (dr.containsKey("acT_DT") && int.parse(year) != intYear.value) {
        // LoadingDialog.callErrorMessage(
        //     "Month / Year mismatch!\nMultiple Month / Year not allowed!");

        return const Color.fromRGBO(255, 230, 230, 1);
      }
    } else {
      var year = DateFormat('yyyy')
          .format(DateFormat('dd-MM-yyyy').parse(dr['acT_DT']));
      intYear.value = int.parse(year);
    }

    // if (dr.containsKey("isSpotsAvailable") && dr['isSpotsAvailable']) {
    //   return Colors.deepPurple.shade100;
    // }

    return Colors.white; // Return null if no color conditions are met.
  }

  fillGridAddData() {
    if (pdcChequeNoTEC.text.isEmpty ||
        pdcChqAmtTEC.text == "0.00" ||
        pdcBankTEC.text.isEmpty ||
        pdcChequeRecordByTEC.text.isEmpty) {
      LoadingDialog.showErrorDialog(
          "Cheque No cannot be blank, cheque amount hs to be greater then 0,\nbank name has to be specified and cheque received by cannot be blank.");
    } else if (fillPDCList.any((e) => e['chqNo'] == pdcChequeNoTEC.text)) {
      LoadingDialog.showErrorDialog("Duplicate cheque. Cannot add.");
    } else {
      fillPDCList.add({
        "chqNo": pdcChequeNoTEC.text,
        "chqDate": pdcChqDtTEC.text,
        "chqAmount": double.parse(pdcChqAmtTEC.text),
        "bankName": pdcBankTEC.text,
        "chequeReceivedBy": pdcChequeRecordByTEC.text,
        "chequeReceviedOn": pdcRecordOnTEC.text,
        "remarks": pdcRemarksTEC.text,
        "chequeId": 0,
        "rowNo": fillPDCList.length + 1,
      });
    }
  }

  clearFillPdc() {
    pdcActivityPeriodTEC.clear();
    pdcChequeNoTEC.clear();
    pdcChqDtTEC.clear();
    pdcChqAmtTEC.text = "0.00";
    pdcBankTEC.clear();
    pdcChequeRecordByTEC.clear();
    pdcRecordOnTEC.clear();
    pdcRemarksTEC.clear();
    fillPDCList.clear();
  }

  getFillPDC() {
    try {
      LoadingDialog.call();
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.EDI_RO_GET_FILL_PDC(
            selectedClient?.key ?? "",
            selectedAgency?.key ?? "",
            "0",
            DateFormat('yyyy-MM-dd')
                .format(DateFormat('dd-MM-yyyy').parse(effectiveDate.text)),
          ),
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoFillPDC'] != null &&
                map.containsKey('infoFillPDC')) {
              //New PDC
              newPdcList.clear();
              map['infoFillPDC']['lstPDC'].forEach((e) {
                newPdcList.add(DropDownValue(
                    key: e['chequeId'].toString(), value: e['chequeNo']));
              });
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  saveClientPDC() {
    print(fillPDCList);
    if (fillPDCList.isEmpty) {
      LoadingDialog.showErrorDialog("No PDC's there to save.");
    } else if (pdcActivityPeriodTEC.text.isEmpty) {
      LoadingDialog.showErrorDialog(
          "Active period cannot be left blank & Cannot be less than 6\ndigits & Should be numeric.");
    } else {
      try {
        LoadingDialog.call();
        var payload = {
          "clientCode": selectedClient?.key ?? "",
          "activityPeriod": int.parse(pdcActivityPeriodTEC.text) ?? 0,
          "modifiedBy": Get.find<MainController>().user?.logincode ?? "",
          "agencyCode": selectedAgency?.key ?? "",
          "lstClientPDC": fillPDCList.map((e) {
            if (e['chqDate'] != null) {
              e['chqDate'] = DateFormat('yyyy-MM-dd')
                  .format(DateFormat('dd-MM-yyyy').parse(e['chqDate']));
            }
            if (e['chequeReceviedOn'] != null) {
              e['chequeReceviedOn'] = DateFormat('yyyy-MM-dd').format(
                  DateFormat('dd-MM-yyyy').parse(e['chequeReceviedOn']));
            }
            return e;
          }).toList(),
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.EDI_RO_SAVED_CLIENT_PDC,
            json: payload,
            fun: (map) {
              Get.back();
              if (map != null &&
                  map['infoClientPDC'] != null &&
                  map.containsKey('infoClientPDC')) {
                LoadingDialog.callDataSaved(
                    msg: map["infoClientPDC"]["message"],
                    callback: () {
                      getFillPDC();
                      clearFillPdc();
                    });
              } else {
                LoadingDialog.callErrorMessage1(msg: map);
              }
            });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  importMakeGood() {
    try {
      LoadingDialog.call();
      var payload = {
        "files": selectedClient?.key ?? "",
        "lstMakeGood": [],
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EDI_RO_IMPORT_MAKE_GOOD,
          json: payload,
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoShowMakeGood'] != null &&
                map.containsKey('infoShowMakeGood')) {
              print(map);
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  checkAll() {
    if (lstDgvSpotsList.isEmpty) {
      LoadingDialog.showErrorDialog(
          'Object reference not set to an instance of an object.');
    } else {
      try {
        LoadingDialog.call();
        var payload = {
          "lstSpots": lstDgvSpotsList.map((e) {
            if (e['fctok'] != null) {
              e['fctok'] = e['fctok'].toString();
            }
            if (e['dealOK'] != null) {
              e['dealOK'] = e['dealOK'].toString();
            }
            if (e['nO_SPOT'] != null) {
              e['nO_SPOT'] = e['nO_SPOT'].toString();
            }
            if (e['okSpot'] != null) {
              e['okSpot'] = e['okSpot'].toString();
            }
            if (e['groupcode'] != null) {
              e['groupcode'] = e['groupcode'].toString();
            }
            return e;
          }).toList(),
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.EDI_RO_CHECK_ALL,
            json: payload,
            fun: (map) {
              Get.back();
              if (map != null &&
                  map['infoCheckAll'] != null &&
                  map.containsKey('infoCheckAll')) {
                selectedBrand = brand.firstWhereOrNull((element) {
                  var result =
                      element.key == map['infoCheckAll']['brandCodeSelected'];
                  return result;
                });
                lstDgvSpotsList.value.clear();
                lstDgvSpotsList.value = map['infoCheckAll']['lstSpots'];
                tapIdTabelList.clear();
                tempList.clear();
                tapIdTabelList.value = map['infoCheckAll']['brandLeave'];
                tempList.addAll(tapIdTabelList.value);
                isBrandEnable.value = false;
                if (map['infoCheckAll']['message'] != null) {
                  LoadingDialog.callInfoMessage(map['infoCheckAll']['message']);
                } else {
                  dealLeave();
                  checkAllDealUtil();
                }
              }
            });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  checkAllDealUtil() {
    try {
      LoadingDialog.call();
      var payload = {
        "lstDealEntires": lstDgvDealEntriesList.map((e) {
              if (e['fromdate'] != null) {
                e['fromdate'] = dateConvertToyyyy(e['fromdate']);
              }
              if (e['todate'] != null) {
                e['todate'] = dateConvertToyyyy(e['todate']);
              }
              if (e['startdate'] != null) {
                e['startdate'] = dateConvertToyyyy(e['startdate']);
              }
              if (e['enddate'] != null) {
                e['enddate'] = dateConvertToyyyy(e['enddate']);
              }
              return e;
            }).toList() ??
            [],
        "lstSpots": lstDgvSpotsList ?? [],
        "lstTapeIds": tapIdTabelList ?? [],
        "locationCode": selectedLoactions!.key ?? "",
        "channelCode": selectedChannel!.key ?? "",
        "bookingMonth": bookingNo1TEC.text ?? "",
        "txtPreviousBookedAmount": preBAmtTEC.text ?? "",
        "txtPreviousValAmount": preVAmtTEC.text ?? ""
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EDI_RO_CHECK_ALL_DEAL_UTIL,
          json: payload,
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoCheckAllDealUtility'] != null &&
                map.containsKey('infoCheckAllDealUtility')) {
              roBookingCheckAllDealUtility =
                  RoBookingCheckAllDealUtility.fromJson(map);
              lstDgvDealEntries.value = roBookingCheckAllDealUtility!
                  .infoCheckAllDealUtility!.lstDealEntries!;
              lstDgvSpots.value = roBookingCheckAllDealUtility!
                  .infoCheckAllDealUtility!.flagDeals!.lstSpots!;
              lstDgvDealEntriesList.value =
                  map['infoCheckAllDealUtility']['lstDealEntries'] ?? [];
              lstDgvSpotsList.value =
                  map['infoCheckAllDealUtility']['flagDeals']['lstSpots'] ?? [];
              print("==========");
              checkAllProgramFct();
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  checkAllProgramFct() {
    try {
      LoadingDialog.call();
      var payload = {
        "locationCode": selectedLoactions!.key ?? "",
        "channelCode": selectedChannel!.key ?? "",
        "clientCode": selectedClient!.key ?? "",
        "agencyCode": selectedAgency!.key ?? "",
        "txtSpots": spotsBookedTEC.text ?? "",
        "txtDuration": durBookedTEC.text ?? "",
        "txtAmount": amtBookedTEC.text ?? "",
        "txtPreviousValAmount": num.parse(preVAmtTEC.text),
        "txtPreviousBookedAmount": num.parse(preBAmtTEC.text),
        "txtValAmount": amtValAmmountTEC.text ?? "",
        "txtBalanceSpots": spotsBalanceTEC.text ?? "",
        "lstSpot": lstDgvSpots.map((e) {
          return e.toJson();
        }).toList(),
        "lstDgvDealEntries": lstDgvDealEntries.map((e) {
          return e.toJson();
        }).toList(),
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.EDI_RO_CHECK_ALL_PROGRAM_FCT,
          json: payload,
          fun: (map) {
            Get.back();
            if (map != null &&
                map['infoCheckAllProgramFCT'] != null &&
                map.containsKey('infoCheckAllProgramFCT')) {
              isCheckAll = false;
              bookedAmountTEC.text = map['infoCheckAllProgramFCT']
                          ['totalBookedAmount']
                      .toString() ??
                  "";
              valAmountTEC.text =
                  map['infoCheckAllProgramFCT']['totalValAmount'].toString() ??
                      "";

              lstDgvSpotsList.value = map['infoCheckAllProgramFCT']
                      ['getTimeAvailable']['lstSpot'] ??
                  [];
              spotsBookedTEC.text = map['infoCheckAllProgramFCT']
                      ['getTimeAvailable']['txtSpots']
                  .toString();
              durBookedTEC.text = map['infoCheckAllProgramFCT']
                      ['getTimeAvailable']['txtDuration']
                  .toString();
              amtBookedTEC.text = map['infoCheckAllProgramFCT']
                      ['getTimeAvailable']['txtAmount']
                  .toString();
              amtValAmmountTEC.text = map['infoCheckAllProgramFCT']
                      ['getTimeAvailable']['txtValAmount']
                  .toString();
              //Spot Blance
              var spotBlance =
                  num.parse(spotsAllTEC.text) - num.parse(spotsBookedTEC.text);
              spotsBalanceTEC.text = spotBlance.toString();
              //Dur Blance
              var durBlance =
                  num.parse(durAllTEC.text) - num.parse(durBookedTEC.text);
              durBalanceTEC.text = durBlance.toString();
              //Amt Blance
              var amtBlance =
                  num.parse(amtAllTEC.text) - num.parse(amtBookedTEC.text);
              amtBalanceTEC.text = amtBlance.toString();
              //Val Ammount & Booked Ammount
              num bookedSum = 0;
              num valSum = 0;
              for (var i = 0; i < dgvDealEntriesGrid!.refRows.length; i++) {
                bookedSum += num.parse(dgvDealEntriesGrid!
                    .refRows[i].cells['totalBookedAmt']!.value
                    .toString());
                valSum += num.parse(dgvDealEntriesGrid!
                    .refRows[i].cells['totalValAmt']!.value
                    .toString());
              }
              print("Booked===> ${bookedSum.toString()}");
              print("Val===> ${valSum.toString()}");

              bookedAmountTEC.text = bookedSum.toString();
              valAmountTEC.text = valSum.toString();

              if (num.parse(spotsBalanceTEC.text) > 0) {
                if (selectedGstPlant == null) {
                  showGstPopUp = true;
                  gstDilogBox();
                }

                LoadingDialog.callInfoMessage(
                    'All spots are not booked.\nPlease cross check data before saving....');
              } else {
                if (selectedGstPlant == null) {
                  showGstPopUp = true;
                  gstDilogBox();
                }
                LoadingDialog.callInfoMessage('All spots are booked.');
              }
              update(["totalAmount"]);
            }
          });
    } catch (e) {
      print(e.toString());
    }
  }

  save() {
    if (selectedBrand == null) {
      LoadingDialog.showErrorDialog("Please select brand.");
    } else {
      try {
        LoadingDialog.call();
        var payload = {
          "bookingNo": bookingNo1TEC.text ?? "0",
          "grpPDC": false,
          "pdc": selectedPdc?.key ?? "",
          "lstPDCChannels": [],
          "lstSpots": lstDgvSpots.map((e) {
            return e.toJson();
          }).toList(),
          "lstMakeGood": makeGoodReportList.value ?? [],
          "locationCode": selectedLoactions!.key ?? "",
          "channelCode": selectedChannel!.key ?? "",
          "brandCode": selectedBrand!.key ?? "",
          "spot": spotsBookedTEC.text ?? "",
          "chkGSTValidate": true,
          "executiveCode": selectedExecutives!.key ?? "",
          "dealMaxSpent": maxSpendTEC.text ?? "",
          "totalBookedAmount": bookedAmountTEC.text ?? "",
          "totalValAmount": valAmountTEC.text ?? "",
          "amount": amtBookedTEC.text,
          "agencyCode": selectedAgency!.key ?? "",
          "position": selectedPositions!.key ?? "",
          "bookingMonth": bookingNo1TEC.text ?? "0",
          "clientCode": selectedClient!.key ?? "",
          "dtpBookingDate": bkDate.text ?? "",
          "dtpEffDate": effectiveDate.text ?? "",
          "agncyCode": selectedAgency!.key ?? "",
          "cboRORefNo": selectedRoRefNo!.value ?? "",
          "payRoute": payRouteTEC.text ?? "",
          "duration": durBookedTEC.text,
          "zoneCode": zoneTEC.text,
          "dealNo": selectedDealNo!.key ?? "",
          "loggedUser": Get.find<MainController>().user?.logincode ?? "",
          "fileName": selectedFile!.value ?? "",
          "gstPlantsId": selectedGstPlant?.value ?? "",
          "gstRegN": gstNoTEC.text
        };
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.EDI_RO_SAVED_EDI_BOOKING,
            json: payload,
            fun: (map) {
              Get.back();
              if (map != null &&
                  map['infoSave'] != null &&
                  map.containsKey('infoSave')) {
                LoadingDialog.recordExists(map['infoSave']['message'], () {
                  Get.back();
                });
              }
            });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future dealSpotsValidation(int rowIndex, {bool showMessage = false}) async {
    int spotRowIndex = 0;
    double timeSpan = 0;
    double dayTimeSpan = 0;
    double endTimeBuffer = 0;
    bool nextDayDeal = false;

    List<int> intDays = List.filled(7, 0);

    var dealEntriesGrid = dgvDealEntriesGrid!.currentRow!.cells;
    var spotGrid = dvgSpotGrid!.currentRow!.cells;
    var intSpotRowIndex = dvgSpotGrid!.currentRow!.sortIdx;
    print(intSpotRowIndex);
    String sponsorTypeName =
        dealEntriesGrid['sponsorTypeName']!.value.toString();
    intDays[0] = int.parse(dealEntriesGrid['sun']!.value);
    intDays[1] = int.parse(dealEntriesGrid['mon']!.value);
    intDays[2] = int.parse(dealEntriesGrid['tue']!.value);
    intDays[3] = int.parse(dealEntriesGrid['wed']!.value);
    intDays[4] = int.parse(dealEntriesGrid['thu']!.value);
    intDays[5] = int.parse(dealEntriesGrid['fri']!.value);
    intDays[6] = int.parse(dealEntriesGrid['sat']!.value);

    // for (var _dr in dvgSpotGrid!.refRows) {
    //   if (_dr.cells['spoT_RATE'] == true) {
    //     _dr = true;
    //   }
    // }
    var lengthValue = isSelectingChange.isTrue ? lstDgvSpotsList.length : 1;
    for (var i = 0; i < lengthValue; i++) {
      spotRowIndex = isSelectingChange.isTrue ? i : intSpotRowIndex;

      print(
          "$spotRowIndex ====>  ${lstDgvSpotsList[spotRowIndex]['fpcstart']!.toString()}");
      if (lstDgvSpotsList[spotRowIndex]['fpcstart']!.toString() == "") {
        await LoadingDialog.showErrorDialog1("FPC time not entered.",
            callback: () {
          Get.back();
        });
      }

      var weeksName = DateFormat('EEEE').format(DateFormat('dd-MM-yyyy')
          .parse(lstDgvSpotsList[spotRowIndex]['acT_DT']!.toString() ?? ""));
      int intDayOfWeek = weekCount(weeksName);

      var intDealStartTime =
          convertToDouble(dealEntriesGrid['starttime']!.value.toString());
      var intDealEndTime =
          convertToDouble(dealEntriesGrid['endTime']!.value.toString());
      if (intDealStartTime > intDealEndTime) {
        timeSpan = 864000000000;
        endTimeBuffer = 0;
        intDealEndTime = timeSpan + intDealEndTime;
        nextDayDeal = true;
      } else {
        timeSpan = 0;
        endTimeBuffer = 0;
      }

      num intSpotStartTime;
      if (sponsorTypeName == "ROS") {
        intSpotStartTime =
            convertToDouble(lstDgvSpotsList[spotRowIndex]['stime']!.toString());
      } else {
        intSpotStartTime = convertToDouble(
            lstDgvSpotsList[spotRowIndex]['fpcstart']!.toString());
      }
      num intSpotEndTime = lstDgvSpotsList[spotRowIndex]['etime']!.toString() ==
              "00:00:00"
          ? convertToDouble("23:59:59")
          : convertToDouble(lstDgvSpotsList[spotRowIndex]['etime']!.toString());
      if (intSpotEndTime == 0) {
        timeSpan = 0;
      }
      DateTime now = DateTime.now();
      num intCurrentSQLTime =
          convertToDouble("${now.hour}:${now.minute}:${now.second}");
      DateTime actDate = DateFormat('dd-MM-yyyy')
          .parse(lstDgvSpotsList[spotRowIndex]['acT_DT']!.toString() ?? "");

      DateTime toDayDate =
          DateFormat('dd-MM-yyyy').parse("${now.day}-${now.month}-${now.year}");
      if (actDate.isAfter(toDayDate)) {
        dayTimeSpan = 864000000000;
      }
      if (nextDayDeal) {
        timeSpan = 864000000000 + (intSpotEndTime * 2);
      }

      DateTime eFromDate = DateFormat('dd-MM-yyyy')
          .parse(dealEntriesGrid['fromdate']!.value.toString());
      DateTime eToDate = DateFormat('dd-MM-yyyy')
          .parse(dealEntriesGrid['todate']!.value.toString());

      if (intDays[intDayOfWeek] == 1) {
        if (sponsorTypeName != "ROS") {
          if (dealEntriesGrid['groupCode']!.value.toString() == "" ||
              dealEntriesGrid['groupCode']!.value.toString() == null) {
            if (num.parse(dealEntriesGrid['costPer10Sec']!.value.toString()) ==
                num.parse(
                    lstDgvSpotsList[spotRowIndex]['spoT_RATE']!.toString())) {
              if (actDate.isAfter(eFromDate) ||
                  actDate.isAtSameMomentAs(eFromDate) &&
                      actDate.isBefore(eToDate) ||
                  actDate.isAtSameMomentAs(eToDate)) {
                if (intSpotStartTime >= intDealStartTime &&
                    intSpotStartTime <= intDealEndTime) {
                  if (((intSpotEndTime - endTimeBuffer) <= intDealEndTime) ||
                      (intSpotEndTime - intDealEndTime).abs() <= 3000000000) {
                    if ((dayTimeSpan + intDealEndTime).abs() >
                        intCurrentSQLTime) {
                      if (actDate.isAfter(toDayDate)) {
                        if (dealEntriesGrid['locationcode']!.value.toString() ==
                                selectedLoactions!.key.toString() &&
                            dealEntriesGrid['channelCode']!.value.toString() ==
                                selectedChannel!.key.toString()) {
                          lstDgvSpotsList[spotRowIndex]['dealrow'] =
                              dealEntriesGrid['recordnumber']!.value;
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['dealrow']!,
                            dealEntriesGrid['recordnumber']!.value,
                            callOnChangedEvent: false,
                            force: true,
                          );

                          lstDgvSpotsList[spotRowIndex]['dealno'] =
                              dealEntriesGrid['dealnumber']!.value;
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['dealno']!,
                            dealEntriesGrid['dealnumber']!.value,
                            callOnChangedEvent: false,
                            force: true,
                          );
                          if (lstDgvSpotsList[spotRowIndex]['endTime']!
                                      .toString() !=
                                  "" ||
                              lstDgvSpotsList[spotRowIndex]['endTime']! !=
                                  null) {
                            lstDgvSpotsList[spotRowIndex]['endTime'] =
                                dealEntriesGrid['endTime']!;
                            dvgSpotGrid!.changeCellValue(
                              spotGrid['endTime']!,
                              dealEntriesGrid['endTime']!.value,
                              callOnChangedEvent: false,
                              force: true,
                            );
                          }

                          lstDgvSpotsList[spotRowIndex]['nO_SPOT'] = "1";
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['nO_SPOT']!,
                            "1",
                            callOnChangedEvent: false,
                            force: true,
                          );
                          lstDgvSpotsList[spotRowIndex]['amount'] = (num.parse(
                                  dealEntriesGrid['costPer10Sec']!.value) *
                              num.parse(lstDgvSpotsList[spotRowIndex]
                                  ['commercialduration']) /
                              10);
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['amount']!,
                            (num.parse(dealEntriesGrid['costPer10Sec']!.value) *
                                num.parse(lstDgvSpotsList[spotRowIndex]
                                    ['commercialduration']) /
                                10),
                            callOnChangedEvent: false,
                            force: true,
                          );
                        }
                      } else {
                        if (showMessage) {
                          await LoadingDialog.showErrorDialog1(
                              "Date already gone!", callback: () {
                            Get.back();
                          });
                        } else {
                          lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['dealrow']!,
                            "",
                            callOnChangedEvent: false,
                            force: true,
                          );
                          lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['dealno']!,
                            "",
                            callOnChangedEvent: false,
                            force: true,
                          );
                          lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['amount']!,
                            0,
                            callOnChangedEvent: false,
                            force: true,
                          );
                        }
                      }
                    } else {
                      if (showMessage) {
                        await LoadingDialog.showErrorDialog1(
                            "Time already gone!", callback: () {
                          Get.back();
                        });
                      } else {
                        lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                        dvgSpotGrid!.changeCellValue(
                          spotGrid['dealrow']!,
                          "",
                          callOnChangedEvent: false,
                          force: true,
                        );
                        lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                        dvgSpotGrid!.changeCellValue(
                          spotGrid['dealno']!,
                          "",
                          callOnChangedEvent: false,
                          force: true,
                        );
                        lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                        dvgSpotGrid!.changeCellValue(
                          spotGrid['amount']!,
                          0,
                          callOnChangedEvent: false,
                          force: true,
                        );
                      }
                    }
                  } else {
                    if (showMessage) {
                      await LoadingDialog.showErrorDialog1(
                          "End time mismatch with deal row!", callback: () {
                        Get.back();
                      });
                    } else {
                      lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['dealrow']!,
                        "",
                        callOnChangedEvent: false,
                        force: true,
                      );
                      lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['dealno']!,
                        "",
                        callOnChangedEvent: false,
                        force: true,
                      );
                      lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['amount']!,
                        0,
                        callOnChangedEvent: false,
                        force: true,
                      );
                    }
                  }
                } else {
                  if (showMessage) {
                    await LoadingDialog.showErrorDialog1(
                        "Start time mismatch with deal row!", callback: () {
                      Get.back();
                    });
                  } else {
                    lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                    dvgSpotGrid!.changeCellValue(
                      spotGrid['dealrow']!,
                      "",
                      callOnChangedEvent: false,
                      force: true,
                    );
                    lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                    dvgSpotGrid!.changeCellValue(
                      spotGrid['dealno']!,
                      "",
                      callOnChangedEvent: false,
                      force: true,
                    );
                    lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                    dvgSpotGrid!.changeCellValue(
                      spotGrid['amount']!,
                      0,
                      callOnChangedEvent: false,
                      force: true,
                    );
                  }
                }
              } else {
                if (showMessage) {
                  await LoadingDialog.showErrorDialog1("Deal expired!",
                      callback: () {
                    Get.back();
                  });
                } else {
                  lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                  dvgSpotGrid!.changeCellValue(
                    spotGrid['dealrow']!,
                    "",
                    callOnChangedEvent: false,
                    force: true,
                  );
                  lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                  dvgSpotGrid!.changeCellValue(
                    spotGrid['dealno']!,
                    "",
                    callOnChangedEvent: false,
                    force: true,
                  );
                  lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                  dvgSpotGrid!.changeCellValue(
                    spotGrid['amount']!,
                    0,
                    callOnChangedEvent: false,
                    force: true,
                  );
                }
              }
            } else {
              if (showMessage) {
                await LoadingDialog.showErrorDialog1(
                    "Rate mismatch with deal row!", callback: () {
                  Get.back();
                });
              } else {
                lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                dvgSpotGrid!.changeCellValue(
                  spotGrid['dealrow']!,
                  "",
                  callOnChangedEvent: false,
                  force: true,
                );
                lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                dvgSpotGrid!.changeCellValue(
                  spotGrid['dealno']!,
                  "",
                  callOnChangedEvent: false,
                  force: true,
                );
                lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                dvgSpotGrid!.changeCellValue(
                  spotGrid['amount']!,
                  0,
                  callOnChangedEvent: false,
                  force: true,
                );
              }
            }
          } else {
            if (dealEntriesGrid['groupCode']!.value.toString() ==
                lstDgvSpotsList[spotRowIndex]['groupcode']!.toString()) {
              if (num.parse(
                      dealEntriesGrid['costPer10Sec']!.value.toString()) ==
                  num.parse(
                      lstDgvSpotsList[spotRowIndex]['spoT_RATE']!.toString())) {
                if (actDate.isAfter(eFromDate) ||
                    actDate.isAtSameMomentAs(eFromDate) &&
                        actDate.isBefore(eToDate) ||
                    actDate.isAtSameMomentAs(eToDate)) {
                  if (intSpotStartTime >= intDealStartTime &&
                      intSpotStartTime <= intDealEndTime) {
                    if (((intSpotEndTime - endTimeBuffer) <= intDealEndTime) ||
                        (intSpotEndTime - intDealEndTime).abs() <= 3000000000) {
                      if ((dayTimeSpan + intDealEndTime).abs() >
                          intCurrentSQLTime) {
                        if (actDate.isAfter(toDayDate)) {
                          if (dealEntriesGrid['locationcode']!
                                      .value
                                      .toString() ==
                                  selectedLoactions!.key.toString() &&
                              dealEntriesGrid['channelCode']!
                                      .value
                                      .toString() ==
                                  selectedChannel!.key.toString()) {
                            lstDgvSpotsList[intSpotRowIndex]['dealrow'] =
                                dealEntriesGrid['recordnumber']!.value;
                            dvgSpotGrid!.changeCellValue(
                              spotGrid['dealrow']!,
                              dealEntriesGrid['recordnumber']!.value,
                              callOnChangedEvent: false,
                              force: true,
                            );

                            lstDgvSpotsList[intSpotRowIndex]['dealno'] =
                                dealEntriesGrid['dealnumber']!.value;
                            dvgSpotGrid!.changeCellValue(
                              spotGrid['dealno']!,
                              dealEntriesGrid['dealnumber']!.value,
                              callOnChangedEvent: false,
                              force: true,
                            );
                            if (lstDgvSpotsList[spotRowIndex]['endTime']!
                                        .toString() !=
                                    "" ||
                                lstDgvSpotsList[spotRowIndex]['endTime']! !=
                                    null) {
                              lstDgvSpotsList[intSpotRowIndex]['endTime'] =
                                  dealEntriesGrid['endTime']!.value;
                              dvgSpotGrid!.changeCellValue(
                                spotGrid['endTime']!,
                                dealEntriesGrid['endTime']!.value,
                                callOnChangedEvent: false,
                                force: true,
                              );
                            }

                            lstDgvSpotsList[spotRowIndex]['nO_SPOT'] = "1";
                            dvgSpotGrid!.changeCellValue(
                              spotGrid['nO_SPOT']!,
                              "1",
                              callOnChangedEvent: false,
                              force: true,
                            );
                            lstDgvSpotsList[spotRowIndex]
                                ['amount'] = (num.parse(
                                    dealEntriesGrid['costPer10Sec']!.value) *
                                num.parse(lstDgvSpotsList[spotRowIndex]
                                    ['commercialduration']) /
                                10);
                            dvgSpotGrid!.changeCellValue(
                              spotGrid['amount']!,
                              (num.parse(
                                      dealEntriesGrid['costPer10Sec']!.value) *
                                  num.parse(lstDgvSpotsList[spotRowIndex]
                                      ['commercialduration']) /
                                  10),
                              callOnChangedEvent: false,
                              force: true,
                            );
                          }
                        } else {
                          if (showMessage) {
                            await LoadingDialog.showErrorDialog1(
                                "Date already gone!", callback: () {
                              Get.back();
                            });
                          } else {
                            lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                            dvgSpotGrid!.changeCellValue(
                              spotGrid['dealrow']!,
                              "",
                              callOnChangedEvent: false,
                              force: true,
                            );
                            lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                            dvgSpotGrid!.changeCellValue(
                              spotGrid['dealno']!,
                              "",
                              callOnChangedEvent: false,
                              force: true,
                            );
                            lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                            dvgSpotGrid!.changeCellValue(
                              spotGrid['amount']!,
                              0,
                              callOnChangedEvent: false,
                              force: true,
                            );
                          }
                        }
                      } else {
                        if (showMessage) {
                          await LoadingDialog.showErrorDialog1(
                              "Time already gone!", callback: () {
                            Get.back();
                          });
                        } else {
                          lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['dealrow']!,
                            "",
                            callOnChangedEvent: false,
                            force: true,
                          );
                          lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['dealno']!,
                            "",
                            callOnChangedEvent: false,
                            force: true,
                          );
                          lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['amount']!,
                            0,
                            callOnChangedEvent: false,
                            force: true,
                          );
                        }
                      }
                    } else {
                      if (showMessage) {
                        await LoadingDialog.showErrorDialog1(
                            "End time mismatch with deal row!", callback: () {
                          Get.back();
                        });
                      } else {
                        lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                        dvgSpotGrid!.changeCellValue(
                          spotGrid['dealrow']!,
                          "",
                          callOnChangedEvent: false,
                          force: true,
                        );
                        lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                        dvgSpotGrid!.changeCellValue(
                          spotGrid['dealno']!,
                          "",
                          callOnChangedEvent: false,
                          force: true,
                        );
                        lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                        dvgSpotGrid!.changeCellValue(
                          spotGrid['amount']!,
                          0,
                          callOnChangedEvent: false,
                          force: true,
                        );
                      }
                    }
                  } else {
                    if (showMessage) {
                      await LoadingDialog.showErrorDialog1(
                          "Start time mismatch with deal row!", callback: () {
                        Get.back();
                      });
                    } else {
                      lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['dealrow']!,
                        "",
                        callOnChangedEvent: false,
                        force: true,
                      );
                      lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['dealno']!,
                        "",
                        callOnChangedEvent: false,
                        force: true,
                      );
                      lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['amount']!,
                        0,
                        callOnChangedEvent: false,
                        force: true,
                      );
                    }
                  }
                } else {
                  if (showMessage) {
                    await LoadingDialog.showErrorDialog1("Deal expired!",
                        callback: () {
                      Get.back();
                    });
                  } else {
                    lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                    dvgSpotGrid!.changeCellValue(
                      spotGrid['dealrow']!,
                      "",
                      callOnChangedEvent: false,
                      force: true,
                    );
                    lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                    dvgSpotGrid!.changeCellValue(
                      spotGrid['dealno']!,
                      "",
                      callOnChangedEvent: false,
                      force: true,
                    );
                    lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                    dvgSpotGrid!.changeCellValue(
                      spotGrid['amount']!,
                      0,
                      callOnChangedEvent: false,
                      force: true,
                    );
                  }
                }
              } else {
                if (showMessage) {
                  await LoadingDialog.showErrorDialog1(
                      "Rate mismatch with deal row!", callback: () {
                    Get.back();
                  });
                } else {
                  lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                  dvgSpotGrid!.changeCellValue(
                    spotGrid['dealrow']!,
                    "",
                    callOnChangedEvent: false,
                    force: true,
                  );
                  lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                  dvgSpotGrid!.changeCellValue(
                    spotGrid['dealno']!,
                    "",
                    callOnChangedEvent: false,
                    force: true,
                  );
                  lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                  dvgSpotGrid!.changeCellValue(
                    spotGrid['amount']!,
                    0,
                    callOnChangedEvent: false,
                    force: true,
                  );
                }
              }
            } else {
              if (showMessage) {
                await LoadingDialog.showErrorDialog1(
                    "Program name mismatch with deal row!", callback: () {
                  Get.back();
                });
              } else {
                lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                dvgSpotGrid!.changeCellValue(
                  spotGrid['dealrow']!,
                  "",
                  callOnChangedEvent: false,
                  force: true,
                );
                lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                dvgSpotGrid!.changeCellValue(
                  spotGrid['dealno']!,
                  "",
                  callOnChangedEvent: false,
                  force: true,
                );
                lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                dvgSpotGrid!.changeCellValue(
                  spotGrid['amount']!,
                  0,
                  callOnChangedEvent: false,
                  force: true,
                );
              }
            }
          }
        } else {
          if (num.parse(dealEntriesGrid['costPer10Sec']!.value.toString()) ==
              num.parse(
                  lstDgvSpotsList[spotRowIndex]['spoT_RATE']!.toString())) {
            if (actDate.isAfter(eFromDate) ||
                actDate.isAtSameMomentAs(eFromDate) &&
                    actDate.isBefore(eToDate) ||
                actDate.isAtSameMomentAs(eToDate)) {
              if (intSpotStartTime >= intDealStartTime &&
                  intSpotStartTime <= intDealEndTime) {
                if ((((timeSpan - intSpotEndTime).abs() - endTimeBuffer)
                        .abs() >=
                    intDealEndTime)) {
                  if (((intSpotEndTime - endTimeBuffer) <= intDealEndTime) ||
                      (intSpotEndTime - intDealEndTime).abs() <= 3000000000) {
                    if ((dayTimeSpan + intDealEndTime).abs() >
                        intCurrentSQLTime) {
                      if (actDate.isAfter(toDayDate)) {
                        if (dealEntriesGrid['locationcode']!.value.toString() ==
                                selectedLoactions!.key.toString() &&
                            dealEntriesGrid['channelCode']!.value.toString() ==
                                selectedChannel!.key.toString()) {
                          lstDgvSpotsList[intSpotRowIndex]['dealrow'] =
                              dealEntriesGrid['recordnumber']!.value;
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['dealrow']!,
                            dealEntriesGrid['recordnumber']!.value,
                            callOnChangedEvent: false,
                            force: true,
                          );

                          lstDgvSpotsList[intSpotRowIndex]['dealno'] =
                              dealEntriesGrid['dealnumber']!.value;
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['dealno']!,
                            dealEntriesGrid['dealnumber']!.value,
                            callOnChangedEvent: false,
                            force: true,
                          );

                          lstDgvSpotsList[spotRowIndex]['nO_SPOT'] = "1";
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['nO_SPOT']!,
                            "1",
                            callOnChangedEvent: false,
                            force: true,
                          );

                          lstDgvSpotsList[spotRowIndex]['fpcprogram'] = "";
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['fpcprogram']!,
                            "",
                            callOnChangedEvent: false,
                            force: true,
                          );

                          lstDgvSpotsList[spotRowIndex]['fpcstart'] =
                              dealEntriesGrid['starttime']!.value;
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['fpcstart']!,
                            dealEntriesGrid['starttime']!.value,
                            callOnChangedEvent: false,
                            force: true,
                          );

                          lstDgvSpotsList[spotRowIndex]['programCode'] = "";
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['programCode']!,
                            "",
                            callOnChangedEvent: false,
                            force: true,
                          );

                          lstDgvSpotsList[spotRowIndex]['endTime'] =
                              dealEntriesGrid['endTime']!.value;
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['endTime']!,
                            dealEntriesGrid['endTime']!.value,
                            callOnChangedEvent: false,
                            force: true,
                          );

                          lstDgvSpotsList[spotRowIndex]['amount'] = (num.parse(
                                  dealEntriesGrid['costPer10Sec']!.value) *
                              num.parse(lstDgvSpotsList[spotRowIndex]
                                  ['commercialduration']) /
                              10);
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['amount']!,
                            (num.parse(dealEntriesGrid['costPer10Sec']!.value) *
                                num.parse(lstDgvSpotsList[spotRowIndex]
                                    ['commercialduration']) /
                                10),
                            callOnChangedEvent: false,
                            force: true,
                          );
                        }
                      } else {
                        if (showMessage) {
                          await LoadingDialog.showErrorDialog1(
                              "Date already gone!", callback: () {
                            Get.back();
                          });
                        } else {
                          lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['dealrow']!,
                            "",
                            callOnChangedEvent: false,
                            force: true,
                          );
                          lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['dealno']!,
                            "",
                            callOnChangedEvent: false,
                            force: true,
                          );
                          lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                          dvgSpotGrid!.changeCellValue(
                            spotGrid['amount']!,
                            0,
                            callOnChangedEvent: false,
                            force: true,
                          );
                        }
                      }
                    } else {
                      if (showMessage) {
                        await LoadingDialog.showErrorDialog1(
                            "Time already gone!", callback: () {
                          Get.back();
                        });
                      } else {
                        lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                        dvgSpotGrid!.changeCellValue(
                          spotGrid['dealrow']!,
                          "",
                          callOnChangedEvent: false,
                          force: true,
                        );
                        lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                        dvgSpotGrid!.changeCellValue(
                          spotGrid['dealno']!,
                          "",
                          callOnChangedEvent: false,
                          force: true,
                        );
                        lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                        dvgSpotGrid!.changeCellValue(
                          spotGrid['amount']!,
                          0,
                          callOnChangedEvent: false,
                          force: true,
                        );
                      }
                    }
                  } else {
                    if (showMessage) {
                      await LoadingDialog.showErrorDialog1(
                          "RO End time is more than 5 minutes with deal end time! Pl check the deal",
                          callback: () {
                        Get.back();
                      });
                      lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['dealrow']!,
                        "",
                        callOnChangedEvent: false,
                        force: true,
                      );
                      lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['dealno']!,
                        "",
                        callOnChangedEvent: false,
                        force: true,
                      );
                      lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['amount']!,
                        0,
                        callOnChangedEvent: false,
                        force: true,
                      );
                    } else {
                      lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['dealrow']!,
                        "",
                        callOnChangedEvent: false,
                        force: true,
                      );
                      lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['dealno']!,
                        "",
                        callOnChangedEvent: false,
                        force: true,
                      );
                      lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                      dvgSpotGrid!.changeCellValue(
                        spotGrid['amount']!,
                        0,
                        callOnChangedEvent: false,
                        force: true,
                      );
                    }
                  }
                } else {
                  if (showMessage) {
                    await LoadingDialog.showErrorDialog1(
                        "End time mismatch with deal row!", callback: () {
                      Get.back();
                    });
                  } else {
                    lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                    dvgSpotGrid!.changeCellValue(
                      spotGrid['dealrow']!,
                      "",
                      callOnChangedEvent: false,
                      force: true,
                    );
                    lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                    dvgSpotGrid!.changeCellValue(
                      spotGrid['dealno']!,
                      "",
                      callOnChangedEvent: false,
                      force: true,
                    );
                    lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                    dvgSpotGrid!.changeCellValue(
                      spotGrid['amount']!,
                      0,
                      callOnChangedEvent: false,
                      force: true,
                    );
                  }
                }
              } else {
                if (showMessage) {
                  await LoadingDialog.showErrorDialog1(
                      "Start time mismatch with deal row!", callback: () {
                    Get.back();
                  });
                } else {
                  lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                  dvgSpotGrid!.changeCellValue(
                    spotGrid['dealrow']!,
                    "",
                    callOnChangedEvent: false,
                    force: true,
                  );
                  lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                  dvgSpotGrid!.changeCellValue(
                    spotGrid['dealno']!,
                    "",
                    callOnChangedEvent: false,
                    force: true,
                  );
                  lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                  dvgSpotGrid!.changeCellValue(
                    spotGrid['amount']!,
                    0,
                    callOnChangedEvent: false,
                    force: true,
                  );
                }
              }
            } else {
              if (showMessage) {
                await LoadingDialog.showErrorDialog1("Deal expired!",
                    callback: () {
                  Get.back();
                });
              } else {
                lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
                dvgSpotGrid!.changeCellValue(
                  spotGrid['dealrow']!,
                  "",
                  callOnChangedEvent: false,
                  force: true,
                );
                lstDgvSpotsList[spotRowIndex]['dealno'] = "";
                dvgSpotGrid!.changeCellValue(
                  spotGrid['dealno']!,
                  "",
                  callOnChangedEvent: false,
                  force: true,
                );
                lstDgvSpotsList[spotRowIndex]['amount'] = 0;
                dvgSpotGrid!.changeCellValue(
                  spotGrid['amount']!,
                  0,
                  callOnChangedEvent: false,
                  force: true,
                );
              }
            }
          } else {
            if (showMessage) {
              await LoadingDialog.showErrorDialog1(
                  "Rate mismatch with deal row!", callback: () {
                Get.back();
              });
            } else {
              lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
              dvgSpotGrid!.changeCellValue(
                spotGrid['dealrow']!,
                "",
                callOnChangedEvent: false,
                force: true,
              );
              lstDgvSpotsList[spotRowIndex]['dealno'] = "";
              dvgSpotGrid!.changeCellValue(
                spotGrid['dealno']!,
                "",
                callOnChangedEvent: false,
                force: true,
              );
              lstDgvSpotsList[spotRowIndex]['amount'] = 0;
              dvgSpotGrid!.changeCellValue(
                spotGrid['amount']!,
                0,
                callOnChangedEvent: false,
                force: true,
              );
            }
          }
        }
      } else {
        if (showMessage) {
          await LoadingDialog.showErrorDialog1("Day mismatch!", callback: () {
            Get.back();
          });
          // return;
        } else {
          lstDgvSpotsList[spotRowIndex]['dealrow'] = "";
          dvgSpotGrid!.changeCellValue(
            spotGrid['dealrow']!,
            "",
            callOnChangedEvent: false,
            force: true,
          );
          lstDgvSpotsList[spotRowIndex]['dealno'] = "";
          dvgSpotGrid!.changeCellValue(
            spotGrid['dealno']!,
            "",
            callOnChangedEvent: false,
            force: true,
          );
          lstDgvSpotsList[spotRowIndex]['amount'] = 0;
          dvgSpotGrid!.changeCellValue(
            spotGrid['amount']!,
            0,
            callOnChangedEvent: false,
            force: true,
          );
        }
      }
    }
  }

  // int weekNumber(DateTime date) {
  //   int dayOfYear = int.parse(DateFormat("D").format(date));
  //   return ((dayOfYear - date.weekday + 10) / 7).floor();
  // }

  convertToDouble(String timeString) {
    List<String> timeComponents = timeString.split(':');
    int hours = int.parse(timeComponents[0]);
    int minutes = int.parse(timeComponents[1]);
    int seconds = int.parse(timeComponents[2]);

    // double totalMinutes = hours * 60 + minutes + seconds / 60.0;
    Duration duration =
        Duration(hours: hours, minutes: minutes, seconds: seconds);
    int intDealStartTime = duration.inMicroseconds;

    return intDealStartTime;
  }

  weekCount(weekName) {
    switch (weekName) {
      case "Monday":
        return 1;
      case "Tuesday":
        return 2;
      case "Wednesday":
        return 3;
      case "Thursday":
        return 4;
      case "Friday":
        return 5;
      case "Saturday":
        return 6;
      case "Sunday":
        return 0;
      default:
        return 0;
    }
  }

  String convertDate(String date) {
    return (DateFormat('dd/MM/yyyy')
        .format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date)));
  }

  String dateConvertToyyyy(String date) {
    return (DateFormat('yyyy-MM-ddTHH:mm:ss')
        .format(DateFormat('dd/MM/yyyy').parse(date)));
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
