import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../widgets/FormButton.dart';
import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/Snack.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/gridFromMap.dart';
import '../../../../widgets/input_fields.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../AsrunDetailsReport/ChannelListModel.dart';
import '../AmagiSpotReplacementModel.dart';
import '../ClientNameModel.dart';
import '../PivotLocalSpotModel.dart';

class AmagiSpotsReplacementController extends GetxController {
  //TODO: Implement AmagiSpotsReplacementController

  bool isEnable = true;
  bool isEnable1 = false;
  final count = 0.obs;

  DropDownValue? selectedLocation;
  DropDownValue? selectedChannel;
  DropDownValue? selectedObjective = DropDownValue(value: "Rate", key: "1");

  RxBool checked = RxBool(false);
  RxBool isSummary = RxBool(false);

  TextEditingController frmDate = TextEditingController();
  TextEditingController toDate = TextEditingController();

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxList<DropDownValue> objectiveList = RxList([
    DropDownValue(key: "0", value: "Amount"),
    DropDownValue(key: "1", value: "Rate"),
    DropDownValue(key: "2", value: "Value"),
    DropDownValue(key: "3", value: "Client Service")
  ]);

  FocusNode locationNode = FocusNode();
  FocusNode channelNode = FocusNode();
  FocusNode objectiveNode = FocusNode();
  Rx<bool> allowMergeSta = Rx<bool>(false);
  Rx<bool> chkChecktimeBand = Rx<bool>(true);

  var canDialogShow = false.obs;
  Widget? dialogWidget;
  Rxn<int> initialOffset = Rxn<int>(null);
  Completer<bool>? completerDialog;

  PlutoGridStateManager? childChannelStateManager;
  PlutoGridStateManager? masterSpotsStateManager;
  PlutoGridStateManager? localSpotsStateManager;
  PlutoGridStateManager? dialogStateManager;

  TextEditingController txCaptionController = TextEditingController();
  TextEditingController txIdController = TextEditingController();

  TextEditingController availableController = TextEditingController();
  TextEditingController allocatedController = TextEditingController();
  TextEditingController unAllocatedController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController msTimeController = TextEditingController();
  TextEditingController lsAllocController = TextEditingController();
  TextEditingController lsRevController = TextEditingController();
  TextEditingController loDurController = TextEditingController();
  TextEditingController loDurMisController = TextEditingController();
  TextEditingController loTotalController = TextEditingController();
  TextEditingController loMissController = TextEditingController();

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  getChannel(String locationCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api:
            "${ApiFactory.AMAGI_SPOT_REPLACEMENT_GET_CHANNEL()}?LocationCode=$locationCode",
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey('channel') &&
              map['channel'] != null) {
            List<DropDownValue> dataList = [];
            map['channel'].forEach((e) {
              dataList.add(DropDownValue.fromJsonDynamic(
                  e, "channelCode", "channelName"));
            });
            channelList.addAll(dataList);
            channelList.refresh();
          }
        });
  }

  getLocation() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.AMAGI_SPOT_REPLACEMENT_GET_LOCATION(),
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey("location") &&
              map['location'] != null) {
            locationList.clear();
            List<DropDownValue> dataList = [];
            map['location'].forEach((e) {
              dataList.add(DropDownValue.fromJsonDynamic(
                  e, "locationCode", "locationName"));
            });
            locationList.addAll(dataList);
            locationList.refresh();
          }
        });
  }

  PivotLocalSpotModel? pivotLocalSpotModel = PivotLocalSpotModel(
      localSpot: LocalSpot(localBookingData: [], localColData: []));

  Future<bool> getPivotList({List<Map<String, dynamic>>? postData}) {
    Completer<bool> completer = Completer<bool>();
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.AMAGI_SPOT_REPLACEMENT_GET_PivotOnLoadLocalTable(),
          fun: (map) {
            Get.back();
            if (map is Map &&
                map.containsKey("localSpot") &&
                map['localSpot'] != null) {
              pivotLocalSpotModel =
                  PivotLocalSpotModel.fromJson(map as Map<String, dynamic>);
              // print(">>>>>>>>>>>mapData$map");
              // print(">>>>>>>>>>>>>>>>>>>pivotLocalSpotModel" +
              //     (pivotLocalSpotModel?.toJson()).toString());
              completer.complete(true);
            } else {
              completer.complete(false);
            }
          },
          json: postData);
    } catch (e) {
      Get.back();
      completer.complete(false);
    }
    return completer.future;
  }

  AmagiSpotReplacementModel? amagiSpotReplacementModel;

  Future<List<dynamic>> getSpots({bool reProcess = false}) {
    Completer<List<dynamic>> completer = Completer<List<dynamic>>();
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "locationcode": selectedLocation?.key ?? "",
      "channelcode": selectedChannel?.key ?? "",
      "fromdate": DateFormat("yyyy-MM-dd")
          .format(DateFormat("dd-MM-yyyy").parse(frmDate.text)),
      "todate": DateFormat("yyyy-MM-dd")
          .format(DateFormat("dd-MM-yyyy").parse(frmDate.text)),
      "isAllowMerge": allowMergeSta.value,
      "reProcess": (reProcess) ? true : false,
      "merge": (allowMergeSta.value == true) ? true : false,
      "priority": selectedObjective?.key ?? "",
      "txIds": "",
      "isPromoMine": true,
      "caption": ""
    };

    try {
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.AMAGI_SPOT_REPLACEMENT_GET_SPOTS(),
          json: postData,
          fun: (map) {
            // print(">>>>>>>>>>>>lstSpots$map");
            if (map is Map &&
                map.containsKey("lstSpots") &&
                map['lstSpots'] != null) {
              amagiSpotReplacementModel = AmagiSpotReplacementModel.fromJson(
                  map as Map<String, dynamic>);

              update(['localSpots', 'masterSpots', 'childChannel']);
              // mapList = ;
              Future.delayed(
                const Duration(seconds: 4),
                () {
                  closeDialogIfOpen();
                },
              );
              completer.complete(amagiSpotReplacementModel
                  ?.lstSpots?.fastInserts?.promoResponse
                  ?.map((e) => e.toJson())
                  .toList());
            } else {
              amagiSpotReplacementModel = null;
              update(['localSpots', 'masterSpots', 'childChannel']);
              Future.delayed(
                const Duration(seconds: 4),
                () {
                  closeDialogIfOpen();
                },
              );
              completer.complete([
                {"data": "Data Not Found"}
              ]);
            }
          });
    } catch (e) {
      closeDialogIfOpen();
      amagiSpotReplacementModel = null;
      update(['localSpots', 'masterSpots', 'childChannel']);
      completer.complete([
        {"data": "Data Not Found"}
      ]);
    }

    return completer.future;
  }

  ClientNameModel? clientNameModel =
      ClientNameModel(clientName: [ClientName()]);
  List<dynamic> clientNameList = [
    {"Data": "Data Not Found"}
  ];
  Rx<List<dynamic>> mapList = Rx<List<dynamic>>([
    {"Data": "Data Not Found"}
  ]);

  Future<List<dynamic>> getClientAPICall() {
    Completer<List<dynamic>> completer = Completer<List<dynamic>>();
    if (localSpotsStateManager == null) {
      LoadingDialog.showErrorDialog("Data not found", callback: () {
        completer.complete(clientNameList);
        return completer.future;
      });
      completer.complete(clientNameList);
      return completer.future;
    } else {
      LoadingDialog.call();
      try {
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.AMAGI_SPOT_REPLACEMENT_GET_CLIENT(),
            // json: getDataFromGrid(localSpotsStateManager!),
            json: amagiSpotReplacementModel?.lstSpots?.localSpots
                ?.map((e) => e.toJson())
                .toList(),
            fun: (map) {
              closeDialogIfOpen();
              if (map != null && map is String) {
                clientNameList.clear();
                clientNameList.addAll(json.decode(map));
                Map<String, dynamic> clientName = {
                  "clientName": clientNameList
                };
                clientNameModel?.clientName?.clear();
                clientNameModel = ClientNameModel.fromJson(clientName);
                update(['childChannel']);
                print(">>>>>>>>>>>>>>>>>mapDataCon$clientNameList");
                // print(">>>>>>>>>>>>>>>>>mapData${clientNameList.value}");
                completer.complete(clientNameModel?.clientName
                    ?.map((e) => e.toJson())
                    .toList());
              } else {
                clientNameList.clear();
                clientNameList = [
                  {"Data": "Data Not Found"}
                ];
                completer.complete(clientNameList);
              }
            });
      } catch (e) {
        closeDialogIfOpen();
        clientNameList.clear();
        clientNameList = [
          {"Data": "Data Not Found"}
        ];
        completer.complete(clientNameList);
      }

      return completer.future;
    }
  }

  Future<List<dynamic>> getSummaryAPICall() {
    Completer<List<dynamic>> completer = Completer<List<dynamic>>();
    if (localSpotsStateManager == null ||
        masterSpotsStateManager == null ||
        childChannelStateManager == null) {
      LoadingDialog.showErrorDialog("Data not found", callback: () {
        completer.complete(clientNameList);
        return completer.future;
      });
      completer.complete(clientNameList);
      return completer.future;
    } else {
      LoadingDialog.call();
      try {
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.AMAGI_SPOT_REPLACEMENT_GET_SUMMARY(),
            json: {
              // "localSpots": getDataFromGrid(localSpotsStateManager!),
              "localSpots": amagiSpotReplacementModel?.lstSpots?.localSpots
                  ?.map((e) => e.toJson())
                  .toList(),
              // "masterSpots": getDataFromGrid(masterSpotsStateManager!),
              "masterSpots": amagiSpotReplacementModel?.lstSpots?.masterSpots
                  ?.map((e) => e.toJson())
                  .toList(),
              // "childChannel": getDataFromGrid(childChannelStateManager!),
              "childChannel": amagiSpotReplacementModel?.lstSpots?.childChannel
                  ?.map((e) => e.toJson())
                  .toList(),
            },
            fun: (map) {
              closeDialogIfOpen();
              if (map is String) {
                clientNameList.clear();
                // String data = map.toString().replaceAll('\n', " ");
                clientNameList = json.decode(map);
                List<Map<String, dynamic>> mapData = [];
                for (Map<String, dynamic> element in clientNameList) {
                  Map<String, dynamic> mapDa = {};
                  element.forEach((key, value) {
                    String k = key.toString().trim().replaceAll("\n", " ");
                    mapDa[k] = value;
                  });
                  mapData.add(mapDa);
                }
                print(">>>>>>>>>>>mapSummary$mapData");
                completer.complete(mapData);
              } else {
                clientNameList.clear();
                clientNameList = [
                  {"Data": "Data Not Found"}
                ];
                completer.complete(clientNameList);
              }
            });
      } catch (e) {
        closeDialogIfOpen();
        clientNameList.clear();
        clientNameList = [
          {"Data": "Data Not Found"}
        ];
        completer.complete(clientNameList);
      }

      return completer.future;
    }
  }

  Future<List<dynamic>> getTotalAPICall() {
    Completer<List<dynamic>> completer = Completer<List<dynamic>>();
    if (localSpotsStateManager == null || masterSpotsStateManager == null) {
      LoadingDialog.showErrorDialog("Data not found", callback: () {
        completer.complete(clientNameList);
        return completer.future;
      });
      completer.complete(clientNameList);
      return completer.future;
    } else {
      LoadingDialog.call();
      try {
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.AMAGI_SPOT_REPLACEMENT_GET_TOTAL(),
            json: {
              // "localSpots": getDataFromGrid(localSpotsStateManager!),
              // "masterSpots": getDataFromGrid(masterSpotsStateManager!),
              "localSpots": amagiSpotReplacementModel?.lstSpots?.localSpots
                  ?.map((e) => e.toJson())
                  .toList(),
              "masterSpots": amagiSpotReplacementModel?.lstSpots?.masterSpots
                  ?.map((e) => e.toJson())
                  .toList(),
            },
            fun: (map) {
              closeDialogIfOpen();
              if (map is String) {
                clientNameList.clear();
                // String data = map.toString().replaceAll('\n', " ");
                clientNameList = json.decode(map);
                completer.complete(clientNameList);
              } else {
                clientNameList.clear();
                clientNameList = [
                  {"Data": "Data Not Found"}
                ];
                completer.complete(clientNameList);
              }
            });
      } catch (e) {
        closeDialogIfOpen();
        clientNameList.clear();
        clientNameList = [
          {"Data": "Data Not Found"}
        ];
        completer.complete(clientNameList);
      }

      return completer.future;
    }
  }

  List<Map<String, dynamic>> getDataFromGrid(
      PlutoGridStateManager? statemanager) {
    // statemanager.setFilter((element) => true);
    // statemanager.notifyListeners();
    List<Map<String, dynamic>> mapList = [];
    if (statemanager != null) {
      for (var row in statemanager.rows) {
        Map<String, dynamic> rowMap = {};
        for (var key in row.cells.keys) {
          rowMap[key] = row.cells[key]?.value;
        }
        mapList.add(rowMap);
      }
      return mapList;
    } else {
      return mapList;
    }
  }

  Offset? getOffSetValue(BoxConstraints constraints) {
    switch (initialOffset.value) {
      case 1:
        return Offset(
            (constraints.maxWidth / 3) + 30, constraints.maxHeight / 3);
      case 2:
        return Offset(Get.width * 0.09, Get.height * 0.12);
      case 3:
        return const Offset(20, 20);
      default:
        return null;
    }
  }

  int masterSpotIndex = 0;
  int channelSpotIndex = 0;
  int localSpotIndex = 0;

  Future<void> bindData() async {
    //  childChannelStateManager
    //  masterSpotsStateManager
    //  localSpotsStateManager
    try {
      // If tblchannels.Rows.Count == 0 || tblMaster.Rows.Count == 0, return

      String? MStarttime; // tblMaster.CurrentRow.Cells["ScheduleTime"].Value
      String? MDEndtime; // tblMaster.CurrentRow.Cells["EndTime"].Value
      String? MDStarttime; // tblMaster.CurrentRow.Cells["Starttime"].Value

      DateTime? MStarttimeDateTime;
      DateTime? MDEndtimeDateTime;
      DateTime? MDStarttimeDateTime;

      int Parentid, localChannel;
      // print(">>>>>>>>>>masterSpotsStateManager?.currentRow"+(masterSpotsStateManager?.currentRow ?.toJson()).toString());
      // print(">>>>>>>>>>childChannelStateManager?.currentRow"+(childChannelStateManager?.currentRow ?.toJson()).toString());
      if (masterSpotsStateManager?.currentRow == null ||
          childChannelStateManager?.currentRow == null) {
        return;
      }
      // Cursor = Cursors.WaitCursor;
      // String rowFilter;
      int I;

      /*childChannelStateManager?.columns.forEach((element) {
        print(">>>>>>>>>>>channelid"+element.field.toString());
      });*/

      if (masterSpotsStateManager?.currentRow == null) {
        masterSpotsStateManager
                ?.rows[(masterSpotsStateManager?.currentRowIdx ?? 0)]
                .cells[masterSpotsStateManager?.currentCell?.column.key]
                ?.value =
            masterSpotsStateManager?.rows[0].cells["bookingNumber"]?.value;
      }
      msTimeController.text =
          (masterSpotsStateManager?.currentRow?.cells["scheduleTime"]?.value)
              .toString();

      if (childChannelStateManager?.currentCell == null) {
        childChannelStateManager
                ?.rows[(childChannelStateManager?.currentRowIdx ?? 0)]
                .cells[childChannelStateManager?.currentColumnField]
                ?.value =
            childChannelStateManager?.rows[0].cells["locationname"]?.value;
      }

      masterSpotsStateManager?.notifyListeners();
      childChannelStateManager?.notifyListeners();

      Parentid = masterSpotsStateManager?.currentRow?.cells["id"]?.value;
      localChannel =
          childChannelStateManager?.currentRow?.cells["colNo"]?.value ?? 0;
      availableController.text =
          (masterSpotsStateManager?.currentRow?.cells["tapeDuration"]?.value)
              .toString();

      MStarttime = masterSpotsStateManager
          ?.currentRow?.cells["scheduleTime"]?.value
          .toString();
      MDEndtime = masterSpotsStateManager?.currentRow?.cells["endTime"]?.value
          .toString();
      MDStarttime = masterSpotsStateManager
          ?.currentRow?.cells["starttime"]?.value
          .toString();

      MStarttimeDateTime = DateTime.parse("2023-01-01 ${MStarttime}");
      MDEndtimeDateTime = DateTime.parse("2023-01-01 ${MDEndtime}");
      MDStarttimeDateTime = DateTime.parse("2023-01-01 ${MDStarttime}");

      String M_starttime, M_endTime;
      DateTime M_starttimeDateTime, M_endTimeDateTime;

      M_starttime =
          (masterSpotsStateManager?.currentRow?.cells["starttime"]?.value ?? "")
              .toString();
      M_endTime =
          (masterSpotsStateManager?.currentRow?.cells["endTime"]?.value ?? "")
              .toString();

      M_starttimeDateTime = DateTime.parse("2023-01-01 ${M_starttime}");
      M_endTimeDateTime = DateTime.parse("2023-01-01 ${M_endTime}");

      if (masterSpotsStateManager?.currentRow?.cells["hold"]?.value
              .toString()
              .trim() ==
          "0") {
        if (M_starttimeDateTime.isBefore(MStarttimeDateTime)) {
          M_starttime = (masterSpotsStateManager
                  ?.currentRow?.cells["scheduleTime"]?.value)
              .toString();
          M_starttimeDateTime = DateTime.parse("2023-01-01 ${M_starttime}");
        }
        if ((M_endTimeDateTime.isAfter(DateTime.parse(
            "2023-01-01 ${masterSpotsStateManager?.currentRow?.cells["scheduleEndTime"]?.value.toString()}")))) {
          M_endTime = (masterSpotsStateManager
                  ?.currentRow?.cells["scheduleEndTime"]?.value)
              .toString();
          M_endTimeDateTime = DateTime.parse("2023-01-01 ${M_endTime}");
        }
      }

      // tblLocal.DataSource = DtLocalSpots.Select("( Parentid = '" & Parentid & "' or Parentid is null  ) and colno = '" & localChannel & "' ").CopyToDataTable

      if (MDEndtimeDateTime.isBefore(MDStarttimeDateTime)) {
        MDEndtime = "23:59:59";
        MDEndtimeDateTime = DateTime.parse("2023-01-01 ${MDEndtime}");
      }

      int? Tapeduration =
          masterSpotsStateManager?.currentRow?.cells["tapeDuration"]?.value;
      // calc spot amout of local spots
      try {
        lsAllocController.text = "0";

        var drlocalspots = amagiSpotReplacementModel?.lstSpots?.localSpots
            ?.where((element) =>
                element.parentID.toString().trim() ==
                Parentid.toString().trim())
            .toList();

        lsAllocController.text = (drlocalspots?.length ?? 0).toString();
        double amt = 0.0;
        for (LocalSpots dr in drlocalspots!) {
          amt += double.parse((dr.spotAmount).toString());
        }
        lsRevController.text = amt.toString();
      } catch (ex) {}

      // rowFilter = "( Parentid = '" & Parentid & "' or Parentid is null  ) and colno = '" & localChannel & "'  and ('" & MStarttime & "' >= starttime and '" & MStarttime & "' <endtime )  and ( '" & Tapeduration & "' >= tapeduration ) "
      //  rowFilter = rowFilter & " and  ( ('" & MStarttime & "' >= starttime and '" & MStarttime & "' <endtime )  or ( starttime <= '" & MDStarttime & "' and endtime >= '" & MDEndtime & "' )) "
      // Display all allocate and unallocated spots for the channnel and master spot
      // rowFilter = "( Parentid = '" + Parentid.toString() + "' or Parentid is null  ) and colno = '" + localChannel.toString() + "'  and '" +
      //     Tapeduration.toString() + "' >= tapeduration ";

      bool rowFilter = false;

      if (chkChecktimeBand.value) {
        // rowFilter += "  and ( ( starttime <=  '" + M_starttime + "' and endtime >= '" + M_endTime + "' )  )  ";
        rowFilter = true;
      }

      print(">>>>>>>>>>>>>>>rowFilter" + rowFilter.toString());
      print(">>>>>>>>>>>>>>>rowFilter" + Parentid.toString());
      print(">>>>>>>>>>>>>>>rowFilter" + localChannel.toString());
      print(">>>>>>>>>>>>>>>rowFilter" + Tapeduration.toString());
      print(">>>>>>>>>>>>>>>rowFilter" + M_starttimeDateTime.toString());
      print(">>>>>>>>>>>>>>>rowFilter" + M_endTimeDateTime.toString());

      if (rowFilter) {
        localSpotsStateManager?.setFilter((element) => true);
        localSpotsStateManager?.setFilter((element) =>
            (element.cells['parentID']?.value == null ||
                element.cells['parentID']?.value.toString().trim() ==
                    Parentid.toString().trim()) &&
            element.cells['colNo']?.value.toString().trim() ==
                localChannel.toString().trim() &&
            (element.cells['tapeDuration']?.value.toString().trim() ==
                    Tapeduration.toString().trim() ||
                (element.cells['tapeDuration']?.value ?? 0) <= Tapeduration) &&
            (DateTime.parse("2023-01-01 ${element.cells['starttime']?.value}")
                    .isBefore(M_starttimeDateTime) ||
                (DateTime.parse("2023-01-01 ${element.cells['starttime']?.value}")
                        .compareTo(M_starttimeDateTime) ==
                    0)) &&
            (DateTime.parse("2023-01-01 ${element.cells['endTime']?.value}")
                    .isAfter(M_endTimeDateTime) ||
                (DateTime.parse("2023-01-01 ${element.cells['endTime']?.value}")
                        .compareTo(M_endTimeDateTime) ==
                    0)));
        localSpotsStateManager?.notifyListeners();
      } else {
        localSpotsStateManager?.setFilter((element) => true);
        localSpotsStateManager?.setFilter((element) =>
            (element.cells['parentID']?.value == null ||
                element.cells['parentID']?.value.toString().trim() ==
                    Parentid.toString().trim()) &&
            element.cells['colNo']?.value.toString().trim() ==
                localChannel.toString().trim() &&
            (element.cells['tapeDuration']?.value ?? 0) <= Tapeduration);
        localSpotsStateManager?.notifyListeners();
      }

      if (localSpotsStateManager?.rows.length == 0) {
        return;
      }
      localSpotsStateManager?.sortDescending(localSpotsStateManager?.columns
              .where((element) => element.field == "parentID")
              .first ??
          PlutoColumn(
              title: "parentID",
              field: "parentID",
              type: PlutoColumnType.number()));
      localSpotsStateManager?.sortDescending(localSpotsStateManager?.columns
              .where((element) => element.field == "rate")
              .first ??
          PlutoColumn(
              title: "rate", field: "rate", type: PlutoColumnType.number()));
      localSpotsStateManager?.sortDescending(localSpotsStateManager?.columns
              .where((element) => element.field == "spotAmount")
              .first ??
          PlutoColumn(
              title: "spotAmount",
              field: "spotAmount",
              type: PlutoColumnType.number()));
      // (tblLocal.DataSource as DataTable).DefaultView.RowFilter = rowFilter;
      localSpotsStateManager?.notifyListeners();
      // (tblLocal.DataSource as DataTable).DefaultView.sort = "Parentid desc , Rate desc , spotamount desc";
      double Alloc = 0.0, Unalloc = 0.0, AllocDur = 0.0, UnallocDur = 0.0;

      // Displaying allocated and unallocate duration
      for (PlutoRow Dr in (localSpotsStateManager?.rows) ?? []) {
        if (Dr.cells["parentID"]?.value == null) {
          //Dr.DefaultCellStyle.BackColor = Color.Red
          //           For I = 0 To tblLocal.ColumnCount - 1
          // Dr.cells["BookingNumber"].style.font = new Font(Control.DefaultFont, FontStyle.bold);
          //Next
          Dr.cells['bookingNumberIsBold']?.value = true;
          Unalloc = Unalloc +
              double.parse((Dr.cells["tapeDuration"]?.value ?? "0").toString());
        } else {
          //Dr.DefaultCellStyle.BackColor = Color.White
          //For I = 0 To tblLocal.ColumnCount - 1
          // Dr.cells["BookingNumber"].style.font = new Font(Control.DefaultFont, FontStyle.Regular);
          //Next
          Dr.cells['bookingNumberIsBold']?.value = false;
          Alloc = Alloc +
              double.parse((Dr.cells["tapeDuration"]?.value ?? "0").toString());
        }
      }
      allocatedController.text = Alloc.toString();
      unAllocatedController.text = Unalloc.toString();
      balanceController.text =
          (double.parse(availableController.text) - Alloc).toString();

      Unalloc = 0.0;
      Alloc = 0.0;
      // Summary for the day
      for (LocalSpots Dr
          in (amagiSpotReplacementModel?.lstSpots?.localSpots) ?? []) {
        if (Dr.parentID == null) {
          Unalloc = Unalloc + double.parse(Dr.spotAmount.toString());
          UnallocDur = UnallocDur + double.parse(Dr.tapeDuration.toString());
        } else {
          Alloc = Alloc + double.parse(Dr.spotAmount.toString());
          AllocDur = AllocDur + double.parse(Dr.tapeDuration.toString());
        }
      }
      loMissController.text = Unalloc.toString();
      loTotalController.text = Alloc.toString();
      loDurController.text = AllocDur.toString();
      loDurMisController.text = UnallocDur.toString();

      // initialise font for master and channels to regular

      for (PlutoRow dd in (masterSpotsStateManager?.rows) ?? []) {
        dd.cells['bookingNumberIsBold']?.value = false;
        // dd.cells["Bookingnumber"].style.font = new Font(Control.DefaultFont, FontStyle.Regular);
      }

      for (PlutoRow dd in (childChannelStateManager?.rows) ?? []) {
        dd.cells['channelnameIsBold']?.value = false;
        dd.cells['locationnameIsBold']?.value = false;
        dd.cells['totalSpotsIsBold']?.value = false;
        dd.cells['unallocatedSpotsIsBold']?.value = false;
      }
      // High light Spots allocated and channels where they are allocated
      try {
        // var Pivot = new Pivot(DtLocalSpots.where((dr) => dr["parentid"] != null).toList().CopyToDataTable());
        // //Dim Pivot As New Pivot(DtLocalSpots.Select().CopyToDataTable())
        // //Dim _ddsss As DataRow[] = (Pivot.MultiAggregate({"BookingNumber"}, {AggregateFunction.Count}, {"ClientName", "ParentID", "ColNo"})).Select("bookingnumber<>1")
        // var _ddsss = Pivot.MultiAggregate(["BookingNumber"], [AggregateFunction.Count],
        //     ["ClientName", "ParentID", "ColNo"]).toList();

        bool sta = await getPivotList(
            postData: (amagiSpotReplacementModel
                ?.lstSpots
                ?.localSpots?.map((e) => e.toJson()).toList()));
        pivotLocalSpotModel?.localSpot?.localBookingData?.forEach((element) {
          for (PlutoRow dd in (masterSpotsStateManager?.rows) ?? []) {
            if (element.parentID.toString().trim() ==
                dd.cells['id']?.value.toString().trim()) {
              dd.cells['bookingNumberIsBold']?.value = true;
              // dd.Cells["Bookingnumber"].style.font = new Font(Control.DefaultFont, FontStyle.bold);
            }
          }

          for (PlutoRow dd in childChannelStateManager?.rows ?? []) {
            if (element.colNo.toString().trim() ==
                dd.cells['colNo']?.value.toString().trim()) {
              // dd.Cells[I].style.font = new Font(Control.DefaultFont, FontStyle.bold);
              dd.cells['channelnameIsBold']?.value = true;
              dd.cells['locationnameIsBold']?.value = true;
              dd.cells['totalSpotsIsBold']?.value = true;
              dd.cells['unallocatedSpotsIsBold']?.value = true;
            }
          }
        });
        childChannelStateManager?.notifyListeners();
        masterSpotsStateManager?.notifyListeners();

        // var ddss = _ddsss.CopyToDataTable();

        /* for (var dr in ddss.Rows) {
          for (var dd in (masterSpotsStateManager?.rows)??[]) {
            if (dr["Parentid"] == dd.Cells["id"].Value) {
              //       For I = 0 To tblMaster.ColumnCount - 1
              dd.Cells["Bookingnumber"].style.font = new Font(Control.DefaultFont, FontStyle.bold);
              //Next
            }
          }

          for (var dd in tblchannels.Rows) {
            if (dr["colno"] == dd.Cells["colno"].Value) {
              for (I = 0; I < tblchannels.ColumnCount; I++) {
                dd.Cells[I].style.font = new Font(Control.DefaultFont, FontStyle.bold);
              }
            }
          }
        }*/
      } catch (ex) {}

      try {
        // var _dt = DtLocalSpots.Copy();
        // for (var Row in _dt.Rows) {
        //   if (Row["Parentid"] == null) {
        //     Row["Parentid"] = 1;
        //   } else {
        //     Row["Parentid"] = 0;
        //   }
        // }
        //
        // var _Pivot = new Pivot(_dt);
        // var _dts = _Pivot.MultiAggregate(["parentid", "Bookingnumber"],
        //     [AggregateFunction.Sum, AggregateFunction.Count], ["colno"]);
        //
        // for (var dtr in _dts.Rows) {
        //   for (var Dr in tblchannels.Rows) {
        //     if (Dr.Cells["Colno"].Value == dtr["Colno"]) {
        //       //Dr.Cells["Totalspots"].Value = dtr["Bookingnumber"];
        //       Dr.Cells["Unallocatedspots"].Value = dtr["Parentid"] == null ? 0 : dtr["Parentid"];
        //     }
        //   }
        // }

        pivotLocalSpotModel?.localSpot?.localColData?.forEach((element) {
          for (PlutoRow Dr in childChannelStateManager?.rows ?? []) {
            if (element.colNo.toString().trim() ==
                Dr.cells['colNo']?.value.toString().trim()) {
              Dr.cells['unallocatedSpots']?.value = (element.parentid == null)
                  ? 0
                  : int.parse((element.parentid.toString().trim() != "")
                      ? element.parentid.toString().trim()
                      : "0");
            }
          }
        });

        childChannelStateManager?.notifyListeners();
      } catch (ex) {}

      btnFindAllocatedSpotsClick();
      // tblMaster.DataSource = DtMasterSpots
    } catch (ex) {
      // Handle the exception
    }
    // Cursor = Cursors.Default;
  }

  allocatedChannel(int channelId) {
    for (PlutoRow element in (childChannelStateManager?.rows) ?? []) {
      if (channelId == 0) {
        element.cells['channelnameIsBold']?.value = false;
        // element.Cells("Channelname").Style.Font = New Font(Control.DefaultFont, FontStyle.Regular)
      }
      if ((element.cells['channelid']?.value).toString().trim() ==
              channelId.toString().trim() &&
          channelId != 0) {
        element.cells['channelnameIsBold']?.value = true;
        // element.Cells("Channelname").Style.Font = New Font(Control.DefaultFont, FontStyle.Bold)
      }
    }
    childChannelStateManager?.notifyListeners();
  }

  btnFindAllocatedSpotsClick() {
    int? parentId;
    allocatedChannel(0);
    parentId = masterSpotsStateManager?.currentRow?.cells['id']?.value;

    List<PlutoRow>? listOfRow = localSpotsStateManager?.rows
        .where((element) =>
            (element.cells['parentID']?.value ?? 0).toString().trim() ==
            (parentId ?? 0).toString().trim())
        .toList();

    listOfRow?.forEach((element) {
      allocatedChannel(element.cells['channelid']?.value);
    });
  }

  btnDeallocateClick() {
    for (PlutoRow element in localSpotsStateManager?.rows ?? []) {
      element.cells['parentID']?.value = null;
    }
    localSpotsStateManager?.notifyListeners();
    bindData();
  }

  btnAllocateClick() {
    double balance = double.parse(balanceController.text);
    for (PlutoRow element in localSpotsStateManager?.rows ?? []) {
      if (element.cells['tapeDuration']?.value <= balance) {
        element.cells['parentID']?.value =
            masterSpotsStateManager?.currentRow?.cells['id']?.value;
        balance = balance - element.cells['tapeDuration']?.value;
      }
    }
    localSpotsStateManager?.notifyListeners();
    bindData();
  }

  btnDeallocateHoldClick() {
    print(">>>>>>>>>>>>DealHoldClick");
    List<PlutoRow>? _drs = masterSpotsStateManager?.rows
        .where((element) => element.cells['hold']?.value == 1)
        .toList();
    if ((_drs?.length ?? 0) == 0) {
      return;
    }
    int? parentId;
    _drs?.forEach((element) {
      parentId = element.cells['id']?.value;
      for (PlutoRow element1 in (localSpotsStateManager?.rows) ?? []) {
        if (element1.cells['parentID']?.value != null) {
          if (element1.cells['parentID']?.value == parentId) {
            element1.cells['parentID']?.value = null;
          }
        }
      }
    });
    localSpotsStateManager?.notifyListeners();
    bindData();
  }

  Future<List<dynamic>> getUnallocatedHoldCall() {
    Completer<List<dynamic>> completer = Completer<List<dynamic>>();
    if (localSpotsStateManager == null || childChannelStateManager == null) {
      LoadingDialog.showErrorDialog("Data not found", callback: () {
        completer.complete(clientNameList);
        return completer.future;
      });
      completer.complete(clientNameList);
      return completer.future;
    } else {
      LoadingDialog.call();
      try {
        Get.find<ConnectorControl>().POSTMETHOD(
            api: ApiFactory.AMAGI_SPOT_REPLACEMENT_GET_UNALLOCATED(),
            json: {
              // "localSpots": getDataFromGrid(localSpotsStateManager!),
              "localSpots": amagiSpotReplacementModel?.lstSpots?.localSpots
                  ?.map((e) => e.toJson())
                  .toList(),
              // "masterSpots": getDataFromGrid(masterSpotsStateManager!),
              // "masterSpots": amagiSpotReplacementModel?.lstSpots?.masterSpots?.map((e) => e.toJson()).toList(),
              // "childChannel": getDataFromGrid(childChannelStateManager!),
              "childChannel": amagiSpotReplacementModel?.lstSpots?.childChannel
                  ?.map((e) => e.toJson())
                  .toList(),
            },
            fun: (map) {
              closeDialogIfOpen();
              if (map is String) {
                clientNameList.clear();
                // String data = map.toString().replaceAll('\n', " ");
                clientNameList = json.decode(map);
                List<Map<String, dynamic>> mapData = [];
                for (Map<String, dynamic> element in clientNameList) {
                  Map<String, dynamic> mapDa = {};
                  element.forEach((key, value) {
                    String k = key.toString().trim().replaceAll("\n", " ");
                    mapDa[k] = value;
                  });
                  mapData.add(mapDa);
                }
                print(">>>>>>>>>>>mapSummary$mapData");
                completer.complete(mapData);
              } else {
                clientNameList.clear();
                clientNameList = [
                  {"Data": "Data Not Found"}
                ];
                completer.complete(clientNameList);
              }
            });
      } catch (e) {
        closeDialogIfOpen();
        clientNameList.clear();
        clientNameList = [
          {"Data": "Data Not Found"}
        ];
        completer.complete(clientNameList);
      }

      return completer.future;
    }
  }

  Rx<String>? title = Rx<String>("");

  mergeOrDoNotMerge(
      {int merge = 0,
      String? bookingNo = "",
      String? date = "",
      int? bookingDetCode = 0}) {
    Map<String, dynamic> postData = {
      "locationcode": selectedLocation?.key ?? "",
      "channelcode": selectedChannel?.key ?? "",
      "scheduledate": date,
      "bookingnumber": bookingNo,
      "bookingdetailcode": bookingDetCode,
      "dontMerge": merge
    };
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.AMAGI_SPOT_REPLACEMENT_GET_MERGESPOT(),
        fun: (map) {
          print(">>>>>>>>>>>>mergeOrDoNotMerge$map");
        },
        json: postData);
  }

  callExcel() {
    if (amagiSpotReplacementModel == null ||
        amagiSpotReplacementModel?.lstSpots == null ||
        amagiSpotReplacementModel?.lstSpots?.localSpots == null ||
        amagiSpotReplacementModel?.lstSpots?.childChannel == null ||
        amagiSpotReplacementModel?.lstSpots?.masterSpots == null ||
        amagiSpotReplacementModel?.lstSpots?.fastInserts?.promoResponse ==
            null) {
      LoadingDialog.showErrorDialog("Data not found");
    } else {
      LoadingDialog.modify("Do you want to Include Master Spots on Hold?",
          cancelTitle: "Yes", deleteTitle: "No", () {
        callExcelApi(true);
      }, () {
        callExcelApi(false);
      });
    }
  }

  callExcelApi(bool sta) {
    // Completer<List<dynamic>> completer = Completer<List<dynamic>>();
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "localSpots": amagiSpotReplacementModel?.lstSpots?.localSpots
          ?.map((e) => e.toJson())
          .toList(),
      "childChannels": amagiSpotReplacementModel?.lstSpots?.childChannel
          ?.map((e) => e.toJson())
          .toList(),
      "masterSpots": amagiSpotReplacementModel?.lstSpots?.masterSpots
          ?.map((e) => e.toJson())
          .toList(),
      "promoSearch": amagiSpotReplacementModel
          ?.lstSpots?.fastInserts?.promoResponse
          ?.map((e) => e.toJson())
          .toList(),
      "locationCode": selectedLocation?.key ?? "",
      "channelcode": selectedChannel?.key ?? "",
      "locationName": selectedLocation?.value ?? "",
      "channelName": selectedChannel?.value ?? "",
      "scheduledate": DateFormat("yyyy-MM-dd")
          .format(DateFormat("dd-MM-yyyy").parse(frmDate.text)),
      "isMasterSpotOnHold": sta
    };
    try {
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.AMAGI_SPOT_REPLACEMENT_GET_EXCEL(),
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map &&
                map.containsKey("fileName") &&
                map['fileName'] != null &&
                map.containsKey("fileByte") &&
                map['fileByte'] != null) {
              FlutterFileSaver()
                  .writeFileAsBytes(
                fileName: (map['fileName'] ?? "file") + '.xlsx',
                bytes: base64.decode(map['fileByte'] ?? "No data"),
              )
                  .catchError((error) {
                // This code will be executed if there is an error while saving the file.
                Snack.callError("Error saving file: $error");
              });
            } else {}
          },
          json: postData);
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  Future<List<dynamic>> callFastInsert(
      {String? eventType,
      String? txID,
      String? caption,
      String? myProperty,
      bool mine = true}) {
    Completer<List<dynamic>> completer = Completer<List<dynamic>>();
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "locationcode": selectedLocation?.key ?? "",
      "channelcode": selectedChannel?.key ?? "",
      "telecastdate": DateFormat("yyyy-MM-dd")
          .format(DateFormat("dd-MM-yyyy").parse(frmDate.text)),
      "mine": mine,
      "eventType": eventType,
      "txID": txID,
      "caption": caption,
      "myProperty": myProperty
    };
    try {
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.AMAGI_SPOT_REPLACEMENT_GET_FAST_INSERT(),
          json: postData,
          fun: (map) {
            closeDialogIfOpen();
            print(">>>>>>>>>>>>map" + map.toString());
            if (map is Map &&
                map.containsKey("fastInsertsearch") &&
                map['fastInsertsearch']['promoResponse'] != null &&
                map['fastInsertsearch']['promoResponse'].length > 0) {
              print(">>>>>>>>>>map['fastInsertsearch']" +
                  map['fastInsertsearch'].toString());
              completer.complete(
                  (map['fastInsertsearch']['promoResponse']) as List<dynamic>);
            } else {
              print("else call");
              completer.complete([
                {"data": "Data not found"}
              ]);
            }
          });
    } catch (ex) {
      closeDialogIfOpen();
      print("exception call");
      completer.complete([
        {"data": "Data not found"}
      ]);
    }
    return completer.future;
  }

  @override
  void onInit() {
    locationNode = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          if (selectedLocation != null) {
            getChannel(selectedLocation?.key ?? "");
          }
          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
    super.onInit();
  }

  @override
  void onReady() {
    getLocation();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  clearAll() {
    Get.delete<AmagiSpotsReplacementController>();
    Get.find<HomeController>().clearPage1();
  }

  formHandler(String string) {
    if (string == "Clear") {
      clearAll();
    }
  }

  void increment() => count.value++;
}
