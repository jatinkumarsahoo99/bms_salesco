import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';

class ProductLevel3Controller extends GetxController {
  //TODO: Implement ProductLevel3Controller
  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;
  RxList<DropDownValue> typeList = RxList([]);
  RxList<DropDownValue> level1List = RxList([]);
  RxList<DropDownValue> level2List = RxList([]);

  Rxn<DropDownValue>? selectedType = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedLevel1 = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedLevel2 = Rxn<DropDownValue>(null);

  TextEditingController level3Controller = TextEditingController();
  FocusNode typeNode = FocusNode();
  FocusNode level1Node = FocusNode();
  FocusNode level2Node = FocusNode();
  FocusNode level3Node = FocusNode();
  bool isListenerActive = false;
  String strProductevel3 = "0";

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PRODUCT_LEVEL3_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          typeList.clear();
          if (map is Map &&
              map.containsKey("productType") &&
              map['productType'] != null &&
              map['productType'].length > 0) {
            RxList<DropDownValue>? dataList = RxList([]);
            map['productType'].forEach((e) {
              dataList
                  .add(DropDownValue.fromJsonDynamic(e, "ptcode", "ptname"));
            });
            typeList = dataList;
          }
        });
  }

  fetchProductLevel1(String ptcode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PRODUCT_LEVEL3_GET_PRODUCT_LEVEL1 + "?ptcode=" + ptcode,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          level1List.clear();
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey("productLevelOne") &&
              map['productLevelOne'] != null &&
              map['productLevelOne'].length > 0) {
            RxList<DropDownValue>? dataList = RxList([]);
            map['productLevelOne'].forEach((e) {
              dataList
                  .add(DropDownValue.fromJsonDynamic(e, "pl1", "level1Name"));
            });
            level1List = dataList;
          } else {
            level1List.clear();
          }
        });
  }

  fetchProductLevel2(int pl1) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PRODUCT_LEVEL3_GET_PRODUCT_LEVEL2 + "?pl1=${pl1}",
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          level2List.clear();
          // print(">>>>>>"+map.toString());
          if (map is Map &&
              map.containsKey("productLevelTwo") &&
              map['productLevelTwo'] != null &&
              map['productLevelTwo'].length > 0) {
            RxList<DropDownValue>? dataList = RxList([]);
            map['productLevelTwo'].forEach((e) {
              dataList
                  .add(DropDownValue.fromJsonDynamic(e, "pl2", "level2name"));
            });
            level2List = dataList;
          } else {
            level2List.clear();
          }
        });
  }

  leaveLevel3() {
    LoadingDialog.call();
    isListenerActive = false;
    level3Controller.text =
        (level3Controller.text ?? "").toString().toUpperCase();
    Map<String, dynamic> sendData = {
      // "Pl2":int.parse((selectedLevel2?.value?.key??"0")),
      "Pl2": int.parse((selectedLevel2?.value?.key ?? "0")),
      "Level3Name": level3Controller.text,
      "pl3": 0,
    };

    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.PRODUCT_LEVEL3_RETRIEVE,
        json: sendData,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          print(">>>>>>" + map.toString());
          // strProductevel2
          if (map is Map &&
              map.containsKey("retrieveRecord") &&
              map['retrieveRecord'] != null &&
              map['retrieveRecord'].length > 0) {
            strProductevel3 =
                (map['retrieveRecord'][0]['pl3'] ?? "0").toString();
            level3Controller.text =
                map['retrieveRecord'][0]['level3Name'] ?? "";

            for (var element in level1List) {
              if (element.key == map['retrieveRecord'][0]['pl1'].toString()) {
                selectedLevel1?.value =
                    new DropDownValue(key: element.key, value: element.value);
                selectedLevel1?.refresh();
                break;
              }
            }
            for (var element in level2List) {
              if (element.key == map['retrieveRecord'][0]['pl2'].toString()) {
                selectedLevel2?.value =
                    new DropDownValue(key: element.key, value: element.value);
                selectedLevel2?.refresh();
                break;
              }
            }
          } else {
            strProductevel3 = "0";
            // LoadingDialog.showErrorDialog((map??"").toString());
          }
        });
  }

  bool contin = true;
  productLevel3Save() {
    if (strProductevel3 != "0" && contin) {
      LoadingDialog.recordExists(
          "Record Already exist!\nDo you want to modify it?", () {
        isListenerActive = false;
        contin = false;
        saveCall();
      }, cancel: () {
        contin = false;
        // Get.back();
      });
    }else{
      saveCall();
    }

  /*  else if (level3Controller.text == null || level3Controller.text == "") {
      LoadingDialog.showErrorDialog("Product Type cannot be empty.");
    }
    else {
      Map<String, dynamic> postData = {
        "pl3": int.parse(strProductevel3),
        "level3Name": level3Controller.text ?? "",
        "pl2": int.parse((selectedLevel2?.value?.key) ?? "0"),
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.PRODUCT_LEVEL3_SAVE,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            Get.back();
            print(">>>>>>" + map.toString());
            if (map is Map && map.containsKey('save')) {
              clearAll();
              LoadingDialog.callDataSavedMessage(map['save'] ?? "");
            } else {
              LoadingDialog.showErrorDialog((map ?? "").toString());
            }
            // strProductevel2
          });
    }*/
  }

  saveCall() {
    if (level3Controller.text == null || level3Controller.text == "") {
      LoadingDialog.showErrorDialog("Product Type cannot be empty.");
    } else {
      Map<String, dynamic> postData = {
        "pl3": int.parse(strProductevel3),
        "level3Name": level3Controller.text ?? "",
        "pl2": int.parse((selectedLevel2?.value?.key) ?? "0"),
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.PRODUCT_LEVEL3_SAVE,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            Get.back();
            print(">>>>>>" + map.toString());
            if (map is Map && map.containsKey('save')) {
              clearAll();
              LoadingDialog.callDataSavedMessage(map['save'] ?? "");
            } else {
              LoadingDialog.showErrorDialog((map ?? "").toString());
            }
            // strProductevel2
          });
    }
  }

  clearAll() {
    Get.delete<ProductLevel3Controller>();
    Get.find<HomeController>().clearPage1();
  }
  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  @override
  void onInit() {
    fetchAllLoaderData();
    level3Node.addListener(() {
      if (level3Node.hasFocus) {
        isListenerActive = true;
      }
      if (!level3Node.hasFocus && isListenerActive) {
        leaveLevel3();
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

  formHandler(String str) {
    if (str == "Clear") {
      clearAll();
    } else if (str == "Save") {
      productLevel3Save();
    }
  }

  void increment() => count.value++;
}
