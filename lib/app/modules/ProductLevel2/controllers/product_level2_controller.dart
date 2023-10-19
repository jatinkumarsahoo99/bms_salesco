import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../CommonSearch/views/common_search_view.dart';

class ProductLevel2Controller extends GetxController {
  //TODO: Implement ProductLevel2Controller
  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;
  RxList<DropDownValue> typeList = RxList([]);
  RxList<DropDownValue> level1List = RxList([]);

  Rxn<DropDownValue>? selectedType = Rxn<DropDownValue>(null);
  Rxn<DropDownValue>? selectedLevel1 = Rxn<DropDownValue>(null);

  TextEditingController level2Controller = TextEditingController();
  FocusNode typeNode = FocusNode();
  FocusNode level1Node = FocusNode();
  FocusNode level2Node = FocusNode();
  bool isListenerActive = false;
  String strProductevel2 = "0";

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PRODUCT_LEVEL2_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          // Get.back();
          // print(">>>>>>"+map.toString());
          typeList.clear();
          if(map is Map && map.containsKey("productLevelTwoOnload") &&
              map['productLevelTwoOnload'] != null && map['productLevelTwoOnload'].length >0 ){
            RxList<DropDownValue>? dataList = RxList([]);
            map['productLevelTwoOnload'].forEach((e){
              dataList.add(DropDownValue.fromJsonDynamic(
                  e, "ptcode", "ptname"));
            });
            typeList = dataList;
          }
        });
  }
  fetchProductLevel1(String ptcode,{String? pl1}){
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PRODUCT_LEVEL2_GET_PRODUCT_LEVEL1+"?ptcode="+ptcode,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          level1List.clear();
          // print(">>>>>>"+map.toString());
          if(map is Map && map.containsKey("productLevelTwo") &&
              map['productLevelTwo'] != null && map['productLevelTwo'].length >0){
            RxList<DropDownValue>? dataList = RxList([]);
            map['productLevelTwo'].forEach((e){
              dataList.add(DropDownValue.fromJsonDynamic(
                  e, "pl1", "level1Name"));
            });
            level1List = dataList;
            if(pl1 != null && pl1 != "" && level1List.isNotEmpty){
              for (var element in level1List) {
                if(element.key.toString().trim() == pl1.toString().trim()){
                  selectedLevel1?.value =  DropDownValue(key:element.key ,value:element.value) ;
                  selectedLevel1?.refresh();
                  break;
                }
              }
            }

          }else{
            level1List.clear();
          }

        });
  }

  level2OnLeave(){
    LoadingDialog.call();
    isListenerActive = false;
    level2Controller.text = (level2Controller.text??"").toString().toUpperCase();
    Map<String,dynamic> sendData = {
      // "Pl2":int.parse(strProductevel2),
      "Pl2":0,
      "Level1Name":level2Controller.text,
      "Pl1":int.parse((selectedLevel1?.value?.key??"0")),
    };

    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.PRODUCT_LEVEL2_RETRIEVE,
        json: sendData,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          // print(">>>>>>"+map.toString());
          // strProductevel2
          if(map is Map && map.containsKey("retrieveRecord") && map['retrieveRecord'] != null &&
              map['retrieveRecord'].length >0 ){
            print("in if block");
            strProductevel2 =(map['retrieveRecord'][0]['pl2']??"0").toString();
            level2Controller.text =map['retrieveRecord'][0]['level2Name']??"";
            for (var element in typeList) {
              if(element.key == map['retrieveRecord'][0]['pTcode'].toString()){
                selectedType?.value = new DropDownValue(key:element.key.toString() ,value:element.value) ;
                selectedType?.refresh();
                break;
              }
            }
            // map['retrieveRecord'][0]['pl1'].toString()
            fetchProductLevel1((map['retrieveRecord'][0]['pTcode'].toString()),pl1: map['retrieveRecord'][0]['pl1'].toString());
          }else{
            // strProductevel2 = "0";
            // LoadingDialog.showErrorDialog((map??"").toString());
          }
        });
  }

  @override
  void onInit() {
    fetchAllLoaderData();
    level2Node.addListener(() {
      if(level2Node.hasFocus){
        isListenerActive = true;
      }if(!level2Node.hasFocus && isListenerActive){
        level2OnLeave();
      }

    });
    super.onInit();
  }
  bool contin = true;
  productLevel2Save(){
    if (strProductevel2 != "0") {
      LoadingDialog.recordExists(
          "Record Already exist!\nDo you want to modify it?", () {
        isListenerActive = false;
        // contin = false;
        saveCall();
      }, cancel: () {
        // Get.back();
      });
    }else{
      saveCall();
    }
  }

  saveCall() {
    if (level2Controller.text == null || level2Controller.text == "") {
      LoadingDialog.showErrorDialog("Product Type cannot be empty.");
    } else {
      Map<String, dynamic> postData = {
        "pl2": int.parse(strProductevel2),
        "level2Name":level2Controller.text ?? "",
        "pl1": int.parse((selectedLevel1?.value?.key) ?? "0"),
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.PRODUCT_LEVEL2_SAVE,
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
  void search() {
    // Get.delete<TransformationController>();
    Get.to(SearchPage(
        key: Key("Product Level 2"),
        screenName: "Product Level 2",
        appBarName: "Product Level 2",
        strViewName: "vTesting",
        isAppBarReq: true));
  }
  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  clearAll() {
    Get.delete<ProductLevel2Controller>();
    Get.find<HomeController>().clearPage1();
  }
  formHandler(String str) {
    if(str == "Save"){
      productLevel2Save();
    }else if(str == "Clear"){
      clearAll();
    }else if(str == "Search"){
      search();
    }

  }
  void increment() => count.value++;
}
