import 'package:doctormobileapplication/components/CustomFormField.dart';
import 'package:doctormobileapplication/components/custom_checkbox_dropdown.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/erx_controller.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/perscribe_medicine_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/complaints.dart';
import 'package:doctormobileapplication/models/diagnostics.dart';
import 'package:doctormobileapplication/models/finding.dart';
import 'package:doctormobileapplication/models/investigation.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/doctor_review.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrescribeMedicineScreen extends StatefulWidget {
  const PrescribeMedicineScreen({super.key});

  @override
  State<PrescribeMedicineScreen> createState() =>
      _PrescribeMedicineScreenState();
}

class _PrescribeMedicineScreenState extends State<PrescribeMedicineScreen> {
  final ERXController controller = Get.put(ERXController());

  _getInvestigations() async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updateInvestigationlist(
      await pmr.getInvestigations(),
    );
  }

  _getDiagnostics() async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updatediagnosticslist(
      await pmr.getDiagnostics(),
    );
  }

  @override
  void initState() {
    super.initState();
    _getInvestigations();
    _getDiagnostics();
  }

  @override
  void dispose() {
    super.dispose();
    controller.clearLists();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            titleSpacing: 0,
            leading: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                AppImages.back,
              ),
            ),
            title: Text(
              'prescribemedicinetests'.tr,
              style: GoogleFonts.raleway(
                textStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(),
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.03,
                right: Get.width * 0.03,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 1,
                      surfaceTintColor: ColorManager.kWhiteColor,
                      child: SizedBox(
                        // height: Get.height * 0.09,
                        width: Get.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text(
                              'complains'.tr,
                              style: GoogleFonts.raleway(
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: Get.width * 0.6,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[350],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 0),
                                  ),
                                  child: CustomFormField1(
                                    focusNode: controller.mycomplaintfocus,
                                    controller: controller.complaintController,
                                  ),
                                ),
                                ImageContainer(
                                  onpressed: () {
                                    Complaints1 c = Complaints1();
                                    String idd = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
                                    c.id = idd;
                                    c.name =
                                        controller.complaintController.text;
                                    controller.updateComplaintList(c);
                                  },
                                  imagePath: Images.add,
                                  isSvg: false,
                                  color: ColorManager.kWhiteColor,
                                  backgroundColor: ColorManager.kPrimaryColor,
                                )
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            GetBuilder<ERXController>(
                              builder: (contr) => Visibility(
                                visible: controller.complaintList.isNotEmpty,
                                child: Column(
                                  children: <Widget>[
                                    Wrap(
                                      direction: Axis
                                          .horizontal, // Make sure items are laid out horizontally
                                      runSpacing: 8.0,
                                      children: <Widget>[
                                        for (int index = 0;
                                            index <
                                                controller.complaintList.length;
                                            index++)
                                          InkWell(
                                            onTap: () {
                                              String cid = controller
                                                  .complaintList[index].id!;
                                              deleteSelected(
                                                  context,
                                                  controller.complaintList,
                                                  cid,
                                                  "complaint");
                                            },
                                            child: Card(
                                              elevation: 1,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: Get.width * 0.01,
                                                    right: Get.width * 0.01),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .complaintList[index]
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: ColorManager
                                                            .kblackColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.03,
                                                      width: Get.width * 0.03,
                                                      child: Image.asset(
                                                          AppImages.cross),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Text(
                      'labinvestigation'.tr,
                      style: GoogleFonts.raleway(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ImageContainer(
                          imagePath: AppImages.investigation,
                          isSvg: false,
                          color: ColorManager.kWhiteColor,
                          backgroundColor: ColorManager.kPrimaryColor,
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        InkWell(
                          onTap: () async {
                            controller.selectedinvestigation = null;
                            Investigations1 generic = await searchabledropdown(
                                context, controller.investigationList ?? []);
                            controller.selectedinvestigation = null;
                            controller.updateinvestigation(generic);

                            if (generic != '') {
                              controller.selectedinvestigation = generic;
                              controller.selectedinvestigation = (generic == '')
                                  ? null
                                  : controller.selectedinvestigation;
                            }
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorManager.kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              color: ColorManager.kPrimaryLightColor,
                            ),
                            height: MediaQuery.of(context).size.height * 0.066,
                            width: Get.width * 0.6,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${(controller.selectedinvestigation != null && controller.selectedinvestigation?.name != null) ? (controller.selectedinvestigation!.name!.length > 20 ? ('${controller.selectedinvestigation?.name!.substring(0, 20 > controller.selectedinvestigation!.name!.length ? controller.selectedinvestigation!.name!.length : 20)}...') : controller.selectedinvestigation?.name) : "Select Test"}",
                                    semanticsLabel:
                                        "${(controller.selectedinvestigation != null) ? (controller.selectedinvestigation!.name!.length > 20 ? ('${controller.selectedinvestigation?.name!.substring(0, 20 > controller.selectedinvestigation!.name!.length ? controller.selectedinvestigation!.name!.length : 20)}...') : controller.selectedinvestigation) : "Select Test"}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: controller.selectedinvestigation
                                                    ?.name !=
                                                null
                                            ? Colors.black
                                            : Colors.grey[700]),
                                  ),
                                  Icon(Icons.arrow_drop_down,
                                      size: MediaQuery.of(context).size.width *
                                          0.06,
                                      color: Colors.black)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        ImageContainer(
                          onpressed: () {
                            //  add selectedinvestigation
                            controller.addInvestigation();
                          },
                          imagePath: Images.add,
                          isSvg: false,
                          color: ColorManager.kWhiteColor,
                          backgroundColor: ColorManager.kPrimaryColor,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    GetBuilder<ERXController>(
                      builder: (cont) => Visibility(
                        visible:
                            controller.selectedinvestigationList.isNotEmpty,
                        child: Card(
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorManager.kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: Get.width * 1,
                            child: Column(
                              children: <Widget>[
                                Wrap(
                                  children: <Widget>[
                                    for (int index = 0;
                                        index <
                                            controller.selectedinvestigationList
                                                .length;
                                        index++)
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.03),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    String cid = controller
                                                        .selectedinvestigationList[
                                                            index]
                                                        .id!;
                                                    deleteSelected(
                                                        context,
                                                        controller
                                                            .selectedinvestigationList,
                                                        cid,
                                                        "Investigations");
                                                  },
                                                  child: SizedBox(
                                                    height: Get.height * 0.04,
                                                    width: Get.width * 0.04,
                                                    child: Image.asset(
                                                        AppImages.cross),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Text(
                                                  controller
                                                      .selectedinvestigationList[
                                                          index]
                                                      .name
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 8,
                                                      color: ColorManager
                                                          .kblackColor),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Text(
                      'diagnostics'.tr,
                      style: GoogleFonts.raleway(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ImageContainer(
                          imagePath: AppImages.diagnostics,
                          isSvg: false,
                          color: ColorManager.kWhiteColor,
                          backgroundColor: ColorManager.kPrimaryColor,
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        InkWell(
                          onTap: () async {
                            controller.selecteddiagnostics = null;
                            Diagnostics1 generic = await searchabledropdown(
                                context, controller.diagnosticsList ?? []);
                            controller.selecteddiagnostics = null;
                            controller.updatediagnostics(generic);

                            if (generic != '') {
                              controller.selecteddiagnostics = generic;
                              controller.selecteddiagnostics = (generic == '')
                                  ? null
                                  : controller.selecteddiagnostics;
                            }
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorManager.kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              color: ColorManager.kPrimaryLightColor,
                            ),
                            height: MediaQuery.of(context).size.height * 0.066,
                            width: Get.width * 0.6,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${(controller.selecteddiagnostics != null && controller.selecteddiagnostics?.name != null) ? (controller.selecteddiagnostics!.name!.length > 20 ? ('${controller.selecteddiagnostics?.name!.substring(0, 20 > controller.selecteddiagnostics!.name!.length ? controller.selecteddiagnostics!.name!.length : 20)}...') : controller.selecteddiagnostics?.name) : "Select Diagnostics"}",
                                    semanticsLabel:
                                        "${(controller.selecteddiagnostics != null) ? (controller.selecteddiagnostics!.name!.length > 20 ? ('${controller.selecteddiagnostics?.name!.substring(0, 20 > controller.selecteddiagnostics!.name!.length ? controller.selecteddiagnostics!.name!.length : 20)}...') : controller.selecteddiagnostics) : "Select Diagnostics"}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: controller.selectedinvestigation
                                                    ?.name !=
                                                null
                                            ? Colors.black
                                            : Colors.grey[700]),
                                  ),
                                  Icon(Icons.arrow_drop_down,
                                      size: MediaQuery.of(context).size.width *
                                          0.06,
                                      color: Colors.black)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        ImageContainer(
                          onpressed: () {
                            controller.addDiagnostics();
                            setState(() {});
                          },
                          imagePath: Images.add,
                          isSvg: false,
                          color: ColorManager.kWhiteColor,
                          backgroundColor: ColorManager.kPrimaryColor,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    GetBuilder<ERXController>(
                      builder: (cont) => Visibility(
                        visible: controller.selecteddiagnosticslist.isNotEmpty,
                        child: Card(
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorManager.kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: Get.width * 1,
                            child: Column(
                              children: <Widget>[
                                Wrap(
                                  children: <Widget>[
                                    for (int index = 0;
                                        index <
                                            controller
                                                .selecteddiagnosticslist.length;
                                        index++)
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.03),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    String cid = controller
                                                        .selecteddiagnosticslist[
                                                            index]
                                                        .id!;
                                                    deleteSelected(
                                                        context,
                                                        controller
                                                            .selecteddiagnosticslist,
                                                        cid,
                                                        "diagnostics");
                                                  },
                                                  child: SizedBox(
                                                    height: Get.height * 0.04,
                                                    width: Get.width * 0.04,
                                                    child: Image.asset(
                                                        AppImages.cross),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Text(
                                                  controller
                                                      .selecteddiagnosticslist[
                                                          index]
                                                      .name
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 8,
                                                      color: ColorManager
                                                          .kblackColor),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),

                    // MEDICINES
                    Text(
                      'medicine'.tr,
                      style: GoogleFonts.raleway(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'type'.tr,
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorManager.kblackColor,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: ColorManager.kWhiteColor,
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.066,
                                    width: Get.width * 0.21,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.005),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Tab',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Icon(Icons.arrow_drop_down,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                              color: Colors.black)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'medicine'.tr,
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: Get.width * 0.47,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: ColorManager.kWhiteColor,
                                  ),
                                  child: CustomFormField2(
                                    focusNode: controller.medicinefocus,
                                    controller: controller.medicineController,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'qty'.tr,
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: Get.width * 0.19,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: ColorManager.kWhiteColor,
                                  ),
                                  child: CustomFormField2(
                                    focusNode: controller.qtyfocus,
                                    controller: controller.qtyController,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    // 2 ROW
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'frequency'.tr,
                                          style: GoogleFonts.raleway(
                                            textStyle: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: ColorManager.kblackColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: ColorManager.kWhiteColor,
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.066,
                                            width: Get.width * 0.25,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.005),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "4 Time",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  Icon(Icons.arrow_drop_down,
                                                      size:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                      color: Colors.black)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'condition'.tr,
                                          style: GoogleFonts.raleway(
                                            textStyle: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: ColorManager.kblackColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: ColorManager.kWhiteColor,
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.066,
                                            width: Get.width * 0.25,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.005),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "After Mea",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  Icon(Icons.arrow_drop_down,
                                                      size:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                      color: Colors.black)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'duration'.tr,
                                          style: GoogleFonts.raleway(
                                            textStyle: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: ColorManager.kblackColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: ColorManager.kWhiteColor,
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.066,
                                            width: Get.width * 0.25,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.005),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "1 Day",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  Icon(Icons.arrow_drop_down,
                                                      size:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                      color: Colors.black)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        // IMAGE
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageContainer(
                              onpressed: () {},
                              imagePath: Images.add,
                              isSvg: false,
                              color: ColorManager.kWhiteColor,
                              backgroundColor: ColorManager.kPrimaryColor,
                            )
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: Get.height * 0.02,
                    ),

                    // medicine visisbility
                    GetBuilder<ERXController>(
                      builder: (cont) => Visibility(
                        //  visible: controller.selectedinvestigationList.isNotEmpty,
                        visible: true,
                        child: Card(
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorManager.kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: Get.width * 1,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.06,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.25,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'medicine'.tr,
                                          style: GoogleFonts.raleway(
                                            textStyle: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        for (int index = 0; index < 3; index++)
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.02,
                                                width: Get.width * 0.02,
                                                child: Image.asset(
                                                    AppImages.cross),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                              Text(
                                                'Tab - Panadol 20',
                                                style: GoogleFonts.raleway(
                                                  textStyle:
                                                      GoogleFonts.poppins(
                                                    fontSize: 8,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.03,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'qty'.tr,
                                        style: GoogleFonts.raleway(
                                          textStyle: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      for (int index = 0; index < 3; index++)
                                        Text(
                                          '2',
                                          style: GoogleFonts.raleway(
                                            textStyle: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.05,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'condition'.tr,
                                        style: GoogleFonts.raleway(
                                          textStyle: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      for (int index = 0; index < 3; index++)
                                        Text(
                                          'After Meal',
                                          style: GoogleFonts.raleway(
                                            textStyle: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.05,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'freq'.tr,
                                        style: GoogleFonts.raleway(
                                          textStyle: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      for (int index = 0; index < 3; index++)
                                        Text(
                                          '2 Times',
                                          style: GoogleFonts.raleway(
                                            textStyle: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.05,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'dur'.tr,
                                        style: GoogleFonts.raleway(
                                          textStyle: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      for (int index = 0; index < 3; index++)
                                        Text(
                                          '5 Day',
                                          style: GoogleFonts.raleway(
                                            textStyle: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.06,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: Get.height * 0.03,
                    ),

                    Card(
                      elevation: 1,
                      surfaceTintColor: ColorManager.kWhiteColor,
                      child: SizedBox(
                        // height: Get.height * 0.09,
                        width: Get.width * 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Get.height * 0.015,
                            ),
                            Text(
                              'finding'.tr,
                              style: GoogleFonts.raleway(
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: Get.width * 0.6,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[350],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 0),
                                  ),
                                  child: CustomFormField1(
                                    focusNode: controller.findingfocus,
                                    controller: controller.findingsController,
                                  ),
                                ),
                                ImageContainer(
                                  onpressed: () async {
                                    Finding f = Finding();
                                    String idd = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
                                    f.id = idd;
                                    f.name = controller.findingsController.text;
                                    controller.updatefindingList(f);
                                  },
                                  imagePath: Images.add,
                                  isSvg: false,
                                  color: ColorManager.kWhiteColor,
                                  backgroundColor: ColorManager.kPrimaryColor,
                                )
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            GetBuilder<ERXController>(
                              builder: (contr) => Visibility(
                                visible: controller.findingList.isNotEmpty,
                                child: Column(
                                  children: <Widget>[
                                    Wrap(
                                      direction: Axis
                                          .horizontal, // Make sure items are laid out horizontally
                                      runSpacing: 8.0,
                                      children: <Widget>[
                                        for (int index = 0;
                                            index <
                                                controller.findingList.length;
                                            index++)
                                          InkWell(
                                            onTap: () {
                                              String cid = controller
                                                  .findingList[index].id!;
                                              deleteSelected(
                                                  context,
                                                  controller.findingList,
                                                  cid,
                                                  "finding");
                                            },
                                            child: Card(
                                              elevation: 1,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: Get.width * 0.01,
                                                    right: Get.width * 0.01),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .findingList[index]
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: ColorManager
                                                            .kblackColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.03,
                                                      width: Get.width * 0.03,
                                                      child: Image.asset(
                                                          AppImages.cross),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Text(
                      'notes'.tr,
                      style: GoogleFonts.raleway(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    CustomFormFieldNotes(
                      focusNode: controller.notesfocus,
                      controller: controller.noteController,
                      lines: 5,
                      hintText: 'writenotes'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                      child: PrimaryButton(
                          title: 'prescribe'.tr,
                          onPressed: () async {
                            Get.to(const DoctorReviewScreen());
                          },
                          color: ColorManager.kPrimaryColor,
                          textcolor: ColorManager.kWhiteColor),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                  ],
                ),
              ),
            )),
          )),
    );
  }
}
