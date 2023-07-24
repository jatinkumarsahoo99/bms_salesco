import 'package:get/get.dart';

import '../../../data/DropDownValue.dart';

class EDIMappingController extends GetxController {
  //TODO: Implement EDIMappingController

  bool isEnable = true;
  final count = 0.obs;
  RxList<DropDownValue> locationList = RxList([]);
  RxList<DropDownValue> channelList = RxList([]);
  RxString selectValue=RxString("");
  DropDownValue? selectedClient;
  DropDownValue? selectedAgency;
  DropDownValue? selectedChannel;

  bool isClient = false;
  bool isAgency = false;
  bool isChannel = false;

  checkRadio(String val){
    if(val == "Client"){
      isClient= true;
       isAgency = false;
       isChannel = false;
      update(['top']);
    }else if(val == "Agency"){
      isClient= false;
      isAgency = true;
      isChannel = false;
      update(['top']);
    }else{
      isClient= false;
      isAgency = false;
      isChannel = true;
      update(['top']);
    }
  }


  @override
  void onInit() {
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

  }

  void increment() => count.value++;
}
