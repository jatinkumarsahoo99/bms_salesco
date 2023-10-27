import 'package:bms_salesco/widgets/LoadingDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../CommonSearch/views/common_search_view.dart';

class ProductLevel1Controller extends GetxController {
  //TODO: Implement ProductLevel1Controller

  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;
  RxList<DropDownValue> typeList = RxList([]);

  Rxn<DropDownValue>? selectedType = Rxn<DropDownValue>(null);

  TextEditingController level1Controller = TextEditingController();
  FocusNode typeNode = FocusNode();
  FocusNode level1Node = FocusNode();
  // bool isListenerActive = false;
  String strProductevel2 = "0";

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PRODUCT_LEVEL1_LOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          // Get.back();
          print(">>>>>>"+map.toString());
          typeList.clear();
          if(map is Map && map.containsKey("productLevel1Onload") &&
              map['productLevel1Onload'] != null && map['productLevel1Onload'].length >0 ){
            RxList<DropDownValue>? dataList = RxList([]);
            map['productLevel1Onload'].forEach((e){
              dataList.add(DropDownValue.fromJsonDynamic(
                  e, "ptcode", "ptname"));
            });
            typeList = dataList;
          }
        });
  }

  level1OnLeave(){
    LoadingDialog.call();
    // isListenerActive = false;
    level1Controller.text = (level1Controller.text??"").toString().toUpperCase();
    Map<String,dynamic> sendData = {
      "Pl1":0,
      "Level1Name":level1Controller.text
    };
    try{
      Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
          api: ApiFactory.PRODUCT_LEVEL1_RETRIEVE,
          json: sendData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            print(">>>>>>"+map.toString());
            // strProductevel2
            if(map is Map && map.containsKey("retrieveRecord") && map['retrieveRecord'] != null &&
                map['retrieveRecord'].length >0 ){
              strProductevel2 =(map['retrieveRecord'][0]['pl1']??"0").toString();
              level1Controller.text =map['retrieveRecord'][0]['level1Name'];
              for (var element in typeList) {
                if(element.key == map['retrieveRecord'][0]['pTcode'].toString()){
                  selectedType?.value = new DropDownValue(key:element.key.toString() ,value:element.value) ;
                  selectedType?.refresh();
                  break;
                }
              }
            }else{
              // strProductevel2 = "0";
              // LoadingDialog.showErrorDialog((map??"").toString());
            }
          });
    }catch(e){
      closeDialogIfOpen();
    }

  }

  // bool contin = true;
  productLevel1Save(){
    if(level1Controller.text == null || level1Controller.text == ""){
      LoadingDialog.showErrorDialog("Product Type cannot be empty.");
    }else if(selectedType?.value == null){
      LoadingDialog.showErrorDialog("Product Type cannot be empty.");
    }
    else if(strProductevel2 != "0" && strProductevel2 != ""){
      LoadingDialog.recordExists(
          "Record Already exist!\nDo you want to modify it?",
              (){
            // isListenerActive =false;
            // contin = false;
            saveApiCall();
          });
    }else{
      saveApiCall();
    }
  }

  saveApiCall(){
    try{
      LoadingDialog.call();
      Map<String,dynamic> postData = {
        "pl1":int.parse(strProductevel2),
        "level1Name": level1Controller.text??"",
        "pTcode":int.parse((selectedType?.value?.key)??"0"),
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.PRODUCT_LEVEL1_SAVE,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            // print(">>>>>>"+map.toString());
            if(map is Map && map.containsKey('save')){
              LoadingDialog.callDataSavedMessage(map['save']??"",callback: (){
                clearAll();
              });
            }else{
              LoadingDialog.showErrorDialog((map??"").toString());
            }
            // strProductevel2

          });
    }catch(e){
      closeDialogIfOpen();
    }


  }

  @override
  void onInit() {
    fetchAllLoaderData();
   /* level1Node.addListener(() {
      if(level1Node.hasFocus){
        isListenerActive = true;
      }if(!level1Node.hasFocus && isListenerActive){
        level1OnLeave();
      }

    });*/
    level1Node = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          if(level1Controller.text != null && level1Controller.text != ""){
            level1OnLeave();
          }
          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );

    super.onInit();
  }
  clearAll() {
    Get.delete<ProductLevel1Controller>();
    Get.find<HomeController>().clearPage1();
  }
  void search() {
    // Get.delete<TransformationController>();
    Get.to(SearchPage(
        key: Key("Product Level1"),
        screenName: "Product Level1",
        appBarName: "Product Level1",
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
  formHandler(String str) {
    if(str == "Save"){
      productLevel1Save();
    }else if(str == "Clear"){
      clearAll();
    }else if(str == "Search"){
      search();
    }

  }
  void increment() => count.value++;
}
