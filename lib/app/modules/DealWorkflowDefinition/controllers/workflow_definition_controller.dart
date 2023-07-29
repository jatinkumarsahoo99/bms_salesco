import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../DealWorkDefinitionGridModel.dart';
import '../OnLeaveCopyZoneModel.dart';
import '../WorkFlowSaveResModel.dart';

class WorkflowDefinitionController extends GetxController {
  //TODO: Implement WorkflowDefinitionController
  Rx<bool> isEnable = Rx<bool>(true);
  Rx<bool> userEnable = Rx<bool>(true);
  Rx<bool> groupEnable = Rx<bool>(false);
  final count = 0.obs;
  var clientDetails = RxList<DropDownValue>();
  DropDownValue? selectedClientDetails;
  DropDownValue? selectedClient;
  DropDownValue? selectedProduct;

  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);

  RxList<DropDownValue> zoneList = RxList([]);
  RxList<DropDownValue> copyToZoneList = RxList([]);

  RxList<DropDownValue> stationList = RxList([]);
  RxList<DropDownValue> teamList = RxList([]);
  RxList<DropDownValue> typeList = RxList([]);

  DropDownValue? selectedLocation;
  DropDownValue? selectedCopyToLocation;
  DropDownValue? selectedChannel;
  DropDownValue? selectedCopyToChannel;
  DropDownValue? selectedZone;
  DropDownValue? selectedCopyToZone;

  DropDownValue? selectedStation;
  DropDownValue? selectedTeam;
  DropDownValue? selectedType;

  DropDownValue? selectedUser;
  DropDownValue? selectedGroup;

  PlutoGridStateManager? gridStateManager;

  int? selectedIndex = 0;
  int? selectedCopyToIndex = 0;

  TextEditingController stepNameController = new TextEditingController();
  TextEditingController formNameController = new TextEditingController();

  RxString selectRadio1 = RxString("Employee");
  RxString selectRadio2 = RxString("After");

  FocusNode brandName = FocusNode();

  String approvalSequenceId = "0";

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_WORK_FLOW_DEFINITION_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey('dealWorkflowDefinitionOnLoad') &&
              map['dealWorkflowDefinitionOnLoad'] != null) {
            locationList.clear();
            // channelList.clear();
            zoneList.clear();
            copyToZoneList.clear();
            teamList.clear();
            if (map['dealWorkflowDefinitionOnLoad']
                    .containsKey('lstlocation') &&
                map['dealWorkflowDefinitionOnLoad']['lstlocation'] != null &&
                map['dealWorkflowDefinitionOnLoad']['lstlocation'].length > 0) {
              map['dealWorkflowDefinitionOnLoad']['lstlocation'].forEach((e) {
                locationList.add(DropDownValue.fromJsonDynamic(
                    e, "locationCode", "locationName"));
              });
            }
            if (map['dealWorkflowDefinitionOnLoad']
                    .containsKey('lstWorkFlowType') &&
                map['dealWorkflowDefinitionOnLoad']['lstWorkFlowType'] !=
                    null &&
                map['dealWorkflowDefinitionOnLoad']['lstWorkFlowType'].length >
                    0) {
              map['dealWorkflowDefinitionOnLoad']['lstWorkFlowType']
                  .forEach((e) {
                typeList.add(DropDownValue.fromJsonDynamic(
                    e, "workFlowID", "workflowName"));
              });
            }
            if (map['dealWorkflowDefinitionOnLoad'].containsKey('lstZone') &&
                map['dealWorkflowDefinitionOnLoad']['lstZone'] != null &&
                map['dealWorkflowDefinitionOnLoad']['lstZone'].length > 0) {
              map['dealWorkflowDefinitionOnLoad']['lstZone'].forEach((e) {
                zoneList.add(
                    DropDownValue.fromJsonDynamic(e, "zonecode", "zonename"));
              });
            }
            if (map['dealWorkflowDefinitionOnLoad']
                    .containsKey('lstCopyZone') &&
                map['dealWorkflowDefinitionOnLoad']['lstCopyZone'] != null &&
                map['dealWorkflowDefinitionOnLoad']['lstCopyZone'].length > 0) {
              map['dealWorkflowDefinitionOnLoad']['lstCopyZone'].forEach((e) {
                copyToZoneList.add(
                    DropDownValue.fromJsonDynamic(e, "zonecode", "zonename"));
              });
            }
            if (map['dealWorkflowDefinitionOnLoad'].containsKey('lstTeam') &&
                map['dealWorkflowDefinitionOnLoad']['lstTeam'] != null &&
                map['dealWorkflowDefinitionOnLoad']['lstTeam'].length > 0) {
              map['dealWorkflowDefinitionOnLoad']['lstTeam'].forEach((e) {
                teamList.add(
                    DropDownValue.fromJsonDynamic(e, "teaMid", "teamname"));
              });
            }
          }
        });
  }

  onLeaveZone(String zoneCode) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_WORK_FLOW_DEFINITION_ON_LEAVE_ZONE + zoneCode,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          // Get.back();
          stationList.clear();
          List<DropDownValue> dataList = [];
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey('onLeaveZone') &&
              map['onLeaveZone'] != null &&
              map['onLeaveZone'].length > 0) {
            map['onLeaveZone'].forEach((e) {
              dataList.add(DropDownValue.fromJsonDynamic(
                  e, "stationcode", "stationname"));
            });
            stationList.value = dataList;
          } else {
            stationList.clear();
          }
        });
  }

  OnLeaveCopyZoneModel? onLeaveCopyZoneModel;
  onLeaveCopyToZone(String zoneCode) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.DEAL_WORK_FLOW_DEFINITION_ON_LEAVE_COPYZONE + zoneCode,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          // Get.back();

          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey('onLeaveCopyZone') &&
              map['onLeaveCopyZone'] != null &&
              map['onLeaveCopyZone'].length > 0) {
            onLeaveCopyZoneModel =
                OnLeaveCopyZoneModel.fromJson(map as Map<String, dynamic>);
            update(['copyToGrid']);
          } else {
            onLeaveCopyZoneModel = null;
            update(['copyToGrid']);
          }
        });
  }

  onLeaveLocation(String locationId) {
    Get.find<ConnectorControl>().GETMETHODCALL(
        api:
            ApiFactory.DEAL_WORK_FLOW_DEFINITION_ON_LEAVE_LOCATION + locationId,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          channelList.clear();
          List<DropDownValue> data = [];
          // Get.back();
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey('onLeaveLocation') &&
              map['onLeaveLocation'] != null &&
              map['onLeaveLocation'].length > 0) {
            map['onLeaveLocation'].forEach((e) {
              data.add(DropDownValue.fromJsonDynamic(
                  e, "channelCode", "channelName"));
            });
            channelList.value = data;
          } else {
            channelList.clear();
          }
        });
  }

  DealWorkDefinitionGridModel? dealWorkDefinitionGridModel;
  getDisplayApi() {
    LoadingDialog.call();
    Map<String, dynamic> postData = {
      "locationcode": selectedLocation?.key ?? "",
      "channelcode": (selectedChannel?.key) ?? "",
      "zonecode": (selectedZone?.key) ?? "",
      "stationCode": (selectedStation?.key) ?? "",
      "teamid": (selectedTeam?.key) ?? "",
      "WorkflowId": (selectedType?.key) ?? "",
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.DEAL_WORK_FLOW_DEFINITION_GET_DISPLAY,
        json: postData,
        fun: (map) {
          Get.back();
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey('display') &&
              map['display'] != null &&
              map['display'].length > 0) {
            dealWorkDefinitionGridModel = DealWorkDefinitionGridModel.fromJson(
                map as Map<String, dynamic>);
            approvalSequenceId="";
            clearNew();
            update(['grid']);
          } else {
            dealWorkDefinitionGridModel = DealWorkDefinitionGridModel(display: []);
            approvalSequenceId="";
            clearNew();
            update(['grid']);
          }
        });
  }

  WorkFlowSaveResModel? workFlowSaveResModel;
  saveDealWorkFlow() {
    if (selectedZone == null ||
        selectedStation == null ||
        selectedLocation == null ||
        selectedChannel == null) {
      LoadingDialog.showErrorDialog("Please select required dropdown");
    } else {
      LoadingDialog.call();
      if (onLeaveCopyZoneModel == null) {
        onLeaveCopyZoneModel = OnLeaveCopyZoneModel(onLeaveCopyZone: []);
      }

      List<OnLeaveCopyZone>? stationLst = onLeaveCopyZoneModel?.onLeaveCopyZone
          ?.where((element) => element.isChecked == true)
          .toList();
      Map<String, dynamic> postData = {
        "locationcode": selectedLocation?.key ?? "",
        "channelcode": selectedChannel?.key ?? "",
        "zonecode": selectedZone?.key ?? "",
        "workflowid": selectedType?.key ?? "",
        "stationCode": selectedStation?.key ?? "",
        "teamid": selectedTeam?.key ?? "",
        "lstSavedt": dealWorkDefinitionGridModel?.display
            ?.map((e) => e.toJson1())
            .toList(),
        "station": {
          "locationcode": selectedCopyToLocation?.key ?? "",
          "channelcode": selectedCopyToChannel?.key ?? "",
          "zonecode": selectedCopyToZone?.key ?? "",
          "stationLst": stationLst?.map((e) => e.toJson()).toList()
        }
      };
      // print(">>>>>postData>>>"+(postData).toString());
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.DEAL_WORK_FLOW_DEFINITION_SAVE,
          json: postData,
          fun: (map) {
            Get.back();
            print(">>>>res"+map.toString());

            if (map is Map &&
                map.containsKey("save") &&
                map['save'] != null &&
                map['save'].containsKey('lstApprovalTrail') &&
                map['save']['lstApprovalTrail'] != null &&
                map['save']['lstApprovalTrail'].length > 0) {
              dealWorkDefinitionGridModel?.display?.clear();
              workFlowSaveResModel =
                  WorkFlowSaveResModel.fromJson(map as Map<String, dynamic>);
              workFlowSaveResModel?.save?.lstApprovalTrail?.forEach((e) {
                dealWorkDefinitionGridModel?.display?.add(Display(
                    approvalSequenceID: e.approvalSequenceID ?? 0,
                    employees: e.employees ?? "",
                    formName: e.formName ?? "",
                    groupID: e.groupID ?? 0,
                    groupName: e.groupName ?? "",
                    personnelNo: e.personnelNo ?? "",
                    sequenceName: e.sequenceName ?? ""));
              });
              update(['grid']);
            } else {
              LoadingDialog.showErrorDialog(map??"Something went wrong");
            }
            // print("map>>>"+ jsonEncode(map).toString());
          });
    }
  }

  onDoubleTap(int index) {
    // print(">>>>>>>>>>" + ((gridStateManager?.rows[index].cells['groupID'])?.value).toString());
    if ((gridStateManager?.rows[index].cells['groupID'])?.value != null &&
        (gridStateManager?.rows[index].cells['groupID'])?.value != "" &&
        (gridStateManager?.rows[index].cells['groupID'])?.value != "0"
    ) {
      selectRadio1.value = "User Group";
      selectedGroup = DropDownValue(
          value:
              (gridStateManager?.rows[index].cells['groupName'])?.value ?? "",
          key: (gridStateManager?.rows[index].cells['groupID'])?.value ?? "");
      selectedUser = null;
      userEnable.value = false;
      groupEnable.value = true;
    } else {
      selectRadio1.value = "Employee";
      selectedUser = DropDownValue(
          value:
              (gridStateManager?.rows[index].cells['employees'])?.value ?? "",
          key: (gridStateManager?.rows[index].cells['personnelNo'])?.value ??
              "");
      print(">>>>>>"+selectedUser!.value.toString() + selectedUser!.key.toString());
      selectedGroup = null;
      userEnable.value = true;
      groupEnable.value = false;
    }
    stepNameController.text =
        (gridStateManager?.rows[index].cells['sequenceName'])?.value ?? "";
    formNameController.text =
        (gridStateManager?.rows[index].cells['formName'])?.value ?? "";
    approvalSequenceId =
        (gridStateManager?.rows[index].cells['approvalSequenceID'])?.value ??
            "0";
    update(['top']);
    // stepNameController.text =  gridStateManager?.rows[index].cells['sequenceName'] as String ;
    // gridStateManager.ce
  }

  btnAddClick() {
    if (selectRadio2.value == "After") {
      if (approvalSequenceId != null &&
          approvalSequenceId != "" &&
          approvalSequenceId != "0") {
        int selIndex = (selectedIndex ?? 0);
        dealWorkDefinitionGridModel?.display?[selIndex].approvalSequenceID =
            int.parse(approvalSequenceId ?? "0");
        dealWorkDefinitionGridModel?.display?[selIndex].employees =
            selectedUser?.value ?? "";

        dealWorkDefinitionGridModel?.display?[selIndex].formName =
            formNameController.text ?? "";

        dealWorkDefinitionGridModel?.display?[selIndex].personnelNo =
            selectedUser?.key ?? "";

        dealWorkDefinitionGridModel?.display?[selIndex].groupID =
        (selectedGroup?.key != null &&
            selectedGroup?.key != "" )? int.parse(selectedGroup!.key!):null ;

        dealWorkDefinitionGridModel?.display?[selIndex].sequenceName =
            stepNameController.text ?? "";

        dealWorkDefinitionGridModel?.display?[selIndex].groupName =
            selectedGroup?.value ?? "";
      } else {
        int selIndex = (selectedIndex ?? 0) + 1;
        if(dealWorkDefinitionGridModel?.display?.length == 0){
          selIndex = 0;
        }
        dealWorkDefinitionGridModel?.display?.insert(
            selIndex,
            Display(
                approvalSequenceID: int.parse(approvalSequenceId ?? "0"),
                employees: selectedUser?.value ?? "",
                formName: formNameController.text ?? "",
                groupID: (selectedGroup?.key != null &&
                    selectedGroup?.key != "" )? int.parse(selectedGroup!.key!):null,
                groupName: selectedGroup?.value ?? "",
                personnelNo: selectedUser?.key ?? "",
                sequenceName: stepNameController.text ?? ""));
      }
      clearNew();
      update(['grid']);
    } else {
      if (approvalSequenceId != null &&
          approvalSequenceId != "" &&
          approvalSequenceId != "0") {
        dealWorkDefinitionGridModel?.display?[selectedIndex ?? 0]
            .approvalSequenceID = int.parse(approvalSequenceId ?? "0");
        dealWorkDefinitionGridModel?.display?[selectedIndex ?? 0].employees =
            selectedUser?.value ?? "";

        dealWorkDefinitionGridModel?.display?[selectedIndex ?? 0].formName =
            formNameController.text ?? "";

        dealWorkDefinitionGridModel?.display?[selectedIndex ?? 0].personnelNo =
            selectedUser?.key ?? "";

        dealWorkDefinitionGridModel?.display?[selectedIndex ?? 0].groupID =
        (selectedGroup?.key != null &&
            selectedGroup?.key != "" )? int.parse(selectedGroup!.key!):null ;

        dealWorkDefinitionGridModel?.display?[selectedIndex ?? 0].sequenceName =
            stepNameController.text ?? "";

        dealWorkDefinitionGridModel?.display?[selectedIndex ?? 0].groupName =
            selectedGroup?.value ?? "";
      } else {
        dealWorkDefinitionGridModel?.display?.insert(
            selectedIndex ?? 0,
            Display(
                approvalSequenceID: int.parse(approvalSequenceId ?? "0"),
                employees: selectedUser?.value ?? "",
                formName: formNameController.text ?? "",
                groupID:(selectedGroup?.key != null &&
                    selectedGroup?.key != "" )? int.parse(selectedGroup!.key!):null,
                groupName: selectedGroup?.value ?? "",
                personnelNo: selectedUser?.key ?? "",
                sequenceName: stepNameController.text ?? ""));
      }
      clearNew();
      update(['grid']);
    }
    // controllerX.callGetRetrieve();
  }

  clearNew() {
    selectedGroup = null;
    selectedUser = null;
    selectRadio1.value = "Employee";
    stepNameController.text = "";
    formNameController.text = "";
    approvalSequenceId = "0";
    selectedGroup = null;
    selectedUser = null;
    update(['top']);
  }

  clearAll() {
    Get.delete<WorkflowDefinitionController>();
    Get.find<HomeController>().clearPage1();
  }

  @override
  void onInit() {
    fetchAllLoaderData();
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

  formHandler(String string) {
    if (string == "Save") {
      saveDealWorkFlow();
    } else if (string == "Clear") {
      clearAll();
    }
  }

  void increment() => count.value++;
}
