import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/DropDownValue.dart';
import '../../../providers/ApiFactory.dart';
import '../../CommonSearch/views/common_search_view.dart';

class ProductMasterController extends GetxController {
  //TODO: Implement ProductMasterController

  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;
  RxList<DropDownValue> productLevelList = RxList([]);
  

  DropDownValue? selectedProductLevel;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  FocusNode productNode =FocusNode();
  FocusNode productDescriptionNode =FocusNode();
  FocusNode productLevelNode =FocusNode();
  String strcode = "";
  bool isListnerActive = false;

  fetchAllLoaderData() {
    // LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.PRODUCT_MASTER_GET_PRODUCT_LEVEL_THREE,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          productLevelList.clear();
          if(map is Map && map.containsKey("productLevelThree") &&
              map['productLevelThree'] != null && map['productLevelThree'].length >0 ){
            RxList<DropDownValue>? dataList = RxList([]);
            map['productLevelThree'].forEach((e){
              dataList
                  .add(DropDownValue.fromJsonDynamic(e, "pl3", "level3name"));
            });
            productLevelList = dataList;
          }

        });
  }

  retrieveRecord() {
    LoadingDialog.call();
    isListnerActive = false;
    productNameController.text = replaceInvalidChar(productNameController.text).toUpperCase();
    Map<String, dynamic> sendData = {
      // "Pl2":int.parse((selectedLevel2?.value?.key??"0")),
      "ProductCode": null,
      "ProductName": productNameController.text,
    };
    Get.find<ConnectorControl>().GET_METHOD_WITH_PARAM(
        api: ApiFactory.PRODUCT_MASTER_GET_RETRIEVE_RECORD,
        json: sendData,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          Get.back();
          // print(">>>>>>" + map.toString());
          if(map is Map && map.containsKey('retrieveRecord') &&
              map['retrieveRecord'] != null && map['retrieveRecord'].length >0 ){
            strcode = map['retrieveRecord'][0]['productCode'];
            productNameController.text = map['retrieveRecord'][0]['productName'];
            productDescriptionController.text = map['retrieveRecord'][0]['productDescription'];
            for (var element in productLevelList) {
              if(element.key == map['retrieveRecord'][0]['pL3'].toString()){
                selectedProductLevel = DropDownValue(key:element.key ,value:element.value );
                break;
              }
            }
            update(['top']);
          }
          // strProductevel2
        });
  }
  productMasterSave(){
    if(productNameController.text == null || productNameController.text == ""){
      LoadingDialog.showErrorDialog("Please enter product name");
    }else if(productDescriptionController.text == null || productDescriptionController.text == ""){
      LoadingDialog.showErrorDialog("Please enter product description");
    }else if(selectedProductLevel == null){
      LoadingDialog.showErrorDialog("Please enter product level");
    }else if( strcode != ""){
      LoadingDialog.recordExists(
          "Record Already exist!\nDo you want to modify it?", () {
        isListnerActive = false;
        saveCall();
      });
    }else{
      saveCall();
    }
  }
  clearAll() {
    Get.delete<ProductMasterController>();
    Get.find<HomeController>().clearPage1();
  }
  saveCall() {
    LoadingDialog.call();

      Map<String, dynamic> postData = {
        "productCode": strcode,
        "productName": productNameController.text??"",
        "productDescription":productDescriptionController.text??"",
        "pL3":selectedProductLevel?.key??"",
        "modifiedBy":Get.find<MainController>().user?.logincode??""
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.PRODUCT_MASTER_POST,
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

  String replaceInvalidChar(String text, {bool upperCase = false}) {
    text = text.trim();
    if (upperCase == false) {
      text = text.toLowerCase();
      text = text
          .split(' ')
          .map((word) =>
      word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
          .join(' ');
    } else {
      text = text.toUpperCase();
    }
    text = text.replaceAll("'", "`");
    return text;
  }
  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  @override
  void onInit() {
    fetchAllLoaderData();

    productNode = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {

          if((productNameController.text??"").trim() != ""){
            retrieveRecord();
          }
          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );

   /* productNode.addListener(() {
      if(productNode.hasFocus){
        isListnerActive = true;
      }
      if(!productNode.hasFocus && isListnerActive){
        isListnerActive = false;
        retrieveRecord();
      }

    });*/
    super.onInit();
  }
  void search() {
    // Get.delete<TransformationController>();
    Get.to(SearchPage(
        key: Key("Product Master"),
        screenName: "Product Master",
        appBarName: "Product Master",
        strViewName: "vTesting",
        isAppBarReq: true));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  formHandler(String str){
    if (str == "Clear") {
      clearAll();
    } else if (str == "Save") {
      productMasterSave();
    }else if(str == "Search"){
      search();
    }
  }
  void increment() => count.value++;
}
