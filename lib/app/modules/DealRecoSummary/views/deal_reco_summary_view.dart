import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
import '../../../../widgets/FormButton.dart';
import '../../../../widgets/dropdown.dart';
import '../../../controller/HomeController.dart';
import '../../../controller/MainController.dart';
import '../../../data/PermissionModel.dart';
import '../../../providers/Utils.dart';
import '../controllers/deal_reco_summary_controller.dart';

class DealRecoSummaryView extends GetView<DealRecoSummaryController> {
   DealRecoSummaryView({Key? key}) : super(key: key);

   DealRecoSummaryController controllerX =
   Get.put<DealRecoSummaryController>(DealRecoSummaryController());

   final GlobalKey rebuildKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: rebuildKey,
      body: Center(
        child: SizedBox(
          width: size.width * 0.74,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('Deal Reco Summary'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.locationList.value??[],
                                  (value) {
                                controllerX.selectedLocation = value;
                              }, "Location", .23,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedLocation,
                              dialogHeight: Get.height * .7,
                              autoFocus: true,),),
                            Obx(()=>DropDownField.formDropDown1WidthMap(
                              controllerX.locationList.value??[],
                                  (value) {
                                controllerX.selectedLocation = value;
                              }, "Channel", .23,
                              isEnable: controllerX.isEnable,
                              selected: controllerX.selectedLocation,
                              dialogHeight: Get.height * .7,
                              autoFocus: true,),),
                          ],
                        ),
                      ),


                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.09,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 14.0, left: 10, right: 10),
                          child: FormButtonWrapper(
                            btnText: "Generate",
                            callback: () {
                              // controllerX.callGetRetrieve();
                            },
                            showIcon: false,
                          ),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.locationList.value??[],
                              (value) {
                            controllerX.selectedLocation = value;
                          }, "Client", .55,
                          isEnable: controllerX.isEnable,
                          selected: controllerX.selectedLocation,
                          dialogHeight: Get.height * .7,
                          autoFocus: true,),),
                      ),


                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.09,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 14.0, left: 10, right: 10),
                          child: FormButtonWrapper(
                            btnText: "Clear",
                            callback: () {
                              // controllerX.callGetRetrieve();
                            },
                            showIcon: false,
                          ),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Obx(()=>DropDownField.formDropDown1WidthMap(
                          controllerX.locationList.value??[],
                              (value) {
                            controllerX.selectedLocation = value;
                          }, "Agency", .55,
                          isEnable: controllerX.isEnable,
                          selected: controllerX.selectedLocation,
                          dialogHeight: Get.height * .7,
                          autoFocus: true,),),
                      ),


                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.09,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 14.0, left: 10, right: 10),
                          child: FormButtonWrapper(
                            btnText: "Exit",
                            callback: () {
                              // controllerX.callGetRetrieve();
                            },
                            showIcon: false,
                          ),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width*0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Obx(()=>DropDownField.formDropDown1WidthMap(
                            controllerX.locationList.value??[],
                                (value) {
                              controllerX.selectedLocation = value;
                            }, "DealNo", .1,
                            isEnable: controllerX.isEnable,
                            selected: controllerX.selectedLocation,
                            dialogHeight: Get.height * .7,
                            autoFocus: true,),),
                          DateWithThreeTextField(
                            title: "Util As ON",
                            mainTextController: TextEditingController(),
                            widthRation: .1,
                            isEnable: controllerX.isEnable,
                          ),
                          DateWithThreeTextField(
                            title: "From Date",
                            mainTextController: TextEditingController(),
                            widthRation: .1,
                            isEnable: controllerX.isEnable,
                          ),
                          DateWithThreeTextField(
                            title: "To Date Date",
                            mainTextController: TextEditingController(),
                            widthRation: .1,
                            isEnable: controllerX.isEnable,
                          ),
                        ],),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width*0.1,
                      ),



                    ],
                  ),
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child:  GetBuilder<DealRecoSummaryController>(
                            id: "grid",
                            builder: (controllerX) {
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),

                              );
                            }
                        ),

                      ),
                    ),
                  ),

                  /// bottom common buttons
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
