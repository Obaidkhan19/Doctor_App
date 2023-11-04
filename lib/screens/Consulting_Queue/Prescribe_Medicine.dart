// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/CustomFormField.dart';
import 'package:doctormobileapplication/components/MyCustomExpansionTile.dart';
import 'package:doctormobileapplication/components/custom_checkbox_dropdown.dart';
import 'package:doctormobileapplication/components/custom_expension_listtile.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/erx_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/perscribe_medicine_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/complaints.dart';
import 'package:doctormobileapplication/models/diagnostics.dart';
import 'package:doctormobileapplication/models/finding.dart';
import 'package:doctormobileapplication/models/followups.dart';
import 'package:doctormobileapplication/models/instruction.dart';
import 'package:doctormobileapplication/models/investigation.dart';
import 'package:doctormobileapplication/models/medicines.dart';
import 'package:doctormobileapplication/models/prescribemedcinemodel.dart'
    as pm;
import 'package:doctormobileapplication/models/primary_diagnosis.dart';
import 'package:doctormobileapplication/models/procedures.dart';
import 'package:doctormobileapplication/models/secondart_diagnosis.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/doctor_review.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Item {
  final String name;
  final String age;
  final String className;
  final String section;
  final String country;
  bool isExpanded;

  Item({
    required this.name,
    required this.age,
    required this.className,
    required this.section,
    required this.country,
    this.isExpanded = false,
  });
}

// Define your list of items
List<Item> items = [
  Item(name: "", age: "", className: "", section: "", country: ""),
];

class PrescribeMedicineScreen extends StatefulWidget {
  String? checkfirst;
  String? patientid;
  String? visitno;
  String? patientstatusvalue;
  // String? ernsbit;
  dynamic currentvisit;
  dynamic prescribedvalue;
  // String? checkintypevalue;
  PrescribeMedicineScreen(
      {this.patientid,
      this.visitno,
      this.checkfirst,
      this.patientstatusvalue,
      // this.ernsbit,
      this.currentvisit,
      this.prescribedvalue,
      // this.checkintypevalue,
      super.key});

  @override
  State<PrescribeMedicineScreen> createState() =>
      _PrescribeMedicineScreenState();
}

class _PrescribeMedicineScreenState extends State<PrescribeMedicineScreen> {
  _getComplaints() async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updatecomplaintdata(
      await pmr.getComplaints(),
    );
  }

  _getPrimaryDiagnosis() async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updatePrimarydiagnosislist(
      await pmr.getPrimaryDiagnosis(),
    );
  }

  _getSecondaryDiagnosis() async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updateSecondarydiagnosislist(
      await pmr.getSecondaryDiagnosis(),
    );
  }

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

  _getProceduress() async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updateProcedureslist(
      await pmr.getProcedures(),
    );
  }

  _getFollowup() async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updateFollowuplist(
      await pmr.getFollowUps(),
    );
  }

  _getInstructions() async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updateInstructionlist(
      await pmr.getInstruction(),
    );
  }

  _getMediciness() async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updateMedicinelist(
      await pmr.getMedicines(),
    );
  }

  _getErnsHistory() async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    await pmr.getErnsHistory(
      widget.patientid,
      widget.visitno,
      widget.prescribedvalue,
    );
  }

  _getErnsDetailHistory() async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    await pmr.getErnsDetailHistory(
      widget.patientid,
      widget.visitno,
      widget.prescribedvalue,
    );
  }

  String? speciality;

  call() async {
    await ProfileRepo().getDoctorspeciality();
  }

  String? performancestartdate;

  @override
  void initState() {
    performancestartdate = DateTime.now().toString().split('.')[0];
    call();
    _getErnsDetailHistory();
    _getErnsHistory();
    _getMediciness();
    _getInstructions();
    _getFollowup();
    _getProceduress();
    _getPrimaryDiagnosis();
    _getSecondaryDiagnosis();
    _getComplaints();
    _getInvestigations();
    _getDiagnostics();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.put<ERXController>(ERXController());
    controller.clearLists();
  }

  bool expand = false;

  @override
  Widget build(BuildContext context) {
    ERXController controller = Get.put(ERXController());
    return GestureDetector(
      onTap: () {
        controller.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: ColorManager.kPrimaryColor,
              onPressed: () {
                // clear all selected and deleted list
                Navigator.pop(context);
              },
            ),
            title: Text(
              'erx'.tr,
              style: GoogleFonts.poppins(
                textStyle: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.kPrimaryColor),
              ),
            ),
          ),
          body: GetBuilder<ERXController>(
            builder: (cont) => BlurryModalProgressHUD(
              inAsyncCall: controller.isLoading,
              blurEffectIntensity: 4,
              progressIndicator: const SpinKitSpinningLines(
                color: Color(0xfff1272d3),
                size: 60,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(),
                child: SafeArea(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.clearLists();
                                _getErnsDetailHistory();
                                _getErnsHistory();
                                _getMediciness();
                                _getInstructions();
                                _getFollowup();
                                _getProceduress();
                                _getPrimaryDiagnosis();
                                _getSecondaryDiagnosis();
                                _getComplaints();
                                _getInvestigations();
                                _getDiagnostics();
                                setState(() {});
                              },
                              child: SizedBox(
                                height: Get.height * 0.05,
                                width: Get.width * 0.1,
                                child: ImageContainer(
                                  imagePath: AppImages.recycle,
                                  imageheight: Get.height * 0.05,
                                  isSvg: false,
                                  color: ColorManager.kWhiteColor,
                                  backgroundColor: ColorManager.kPrimaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.28,
                            ),
                            Text(
                              'History',
                              style: GoogleFonts.poppins(
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        SizedBox(
                            width: Get.width * 0.9,
                            child: Card(
                              elevation: 4,
                              surfaceTintColor: ColorManager.kWhiteColor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.01),
                                child: MyCustomTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Complaints:       ",
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.kblackColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.52,
                                            child: Text(
                                              ERXController.i.historycomplaint,
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Diagnosis:           ",
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.kblackColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.52,
                                            child: Text(
                                              ERXController
                                                  .i.historyprimarydiagnosis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                    ],
                                  ),
                                  initiallyExpanded: false,
                                  onExpansionChanged: (expanded) {
                                    setState(() {
                                      expand = expanded;
                                    });
                                  },
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Procedures:        ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorManager.kblackColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.52,
                                                child: Text(
                                                  controller.historyprecedures,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Diagnostics:       ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorManager.kblackColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.52,
                                                child: Text(
                                                  controller.historydiagnostics,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Investigations:   ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorManager.kblackColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.52,
                                                child: Text(
                                                  controller
                                                      .historyinvestigation,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.03,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Vitals:                       ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorManager.kblackColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.52,
                                                child: Text(
                                                  controller.historyvitals,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Row(
                          children: [
                            Text(
                              'Smoker  ',
                              style: GoogleFonts.poppins(
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Obx(
                              () => Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => ColorManager.kPrimaryColor),
                                value: true,
                                groupValue: controller.smokeryesSelected.value,
                                onChanged: (value) =>
                                    controller.smokerupdateYes(true),
                              ),
                            ),
                            Text(
                              'Yes',
                              style: GoogleFonts.poppins(
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Obx(
                              () => Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => ColorManager.kPrimaryColor),
                                value: false,
                                groupValue: controller.smokeryesSelected.value,
                                onChanged: (value) =>
                                    controller.smokerupdateYes(false),
                              ),
                            ),
                            Text(
                              'No',
                              style: GoogleFonts.poppins(
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),

                        // diabetic
                        Row(
                          children: [
                            Text(
                              'Diabetic',
                              style: GoogleFonts.poppins(
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Obx(
                              () => Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => ColorManager.kPrimaryColor),
                                value: true,
                                groupValue:
                                    controller.diabeticyesSelected.value,
                                onChanged: (value) =>
                                    controller.diabeticupdateYes(true),
                              ),
                            ),
                            Text(
                              'Yes',
                              style: GoogleFonts.poppins(
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Obx(
                              () => Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => ColorManager.kPrimaryColor),
                                value: false,
                                groupValue:
                                    controller.diabeticyesSelected.value,
                                onChanged: (value) =>
                                    controller.diabeticupdateYes(false),
                              ),
                            ),
                            Text(
                              'No',
                              style: GoogleFonts.poppins(
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),

                        Card(
                          elevation: 4,
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
                                  style: GoogleFonts.poppins(
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
                                GetBuilder<ERXController>(
                                  builder: (cont) => Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.06,
                                        right: Get.width * 0.06),
                                    child: CustomTextField(
                                      readonly: true,
                                      onTap: () async {
                                        Complaints1 generic =
                                            await searchabledropdown(
                                                context,
                                                controller.complaintsList ??
                                                    []);
                                        await controller.addCompaint(
                                            generic, BuildContext);
                                        setState(() {});
                                      },
                                      prefixIcon: const Icon(
                                        Icons.search_outlined,
                                        color: ColorManager.kPrimaryColor,
                                        size: 35,
                                      ),
                                      hintText: 'Search',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                GetBuilder<ERXController>(
                                  builder: (contr) => Visibility(
                                    visible: controller
                                        .selectedComplaintsList.isNotEmpty,
                                    child: Column(
                                      children: <Widget>[
                                        Wrap(
                                          direction: Axis
                                              .horizontal, // Make sure items are laid out horizontally
                                          runSpacing: 8.0,
                                          children: <Widget>[
                                            for (int index = 0;
                                                index <
                                                    controller
                                                        .selectedComplaintsList
                                                        .length;
                                                index++)
                                              InkWell(
                                                onTap: () {
                                                  String cid = controller
                                                      .selectedComplaintsList[
                                                          index]
                                                      .id!;
                                                  deleteSelected(
                                                      context,
                                                      controller
                                                          .selectedComplaintsList,
                                                      cid,
                                                      "complaints");
                                                },
                                                child: Card(
                                                  elevation: 4,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.01,
                                                        right:
                                                            Get.width * 0.01),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.03,
                                                          width:
                                                              Get.width * 0.03,
                                                          child: Image.asset(
                                                              AppImages.cross),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.01,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            controller
                                                                .selectedComplaintsList[
                                                                    index]
                                                                .name
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              color: ColorManager
                                                                  .kblackColor,
                                                            ),
                                                          ),
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
                        // Primary Diagnosis
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Card(
                          elevation: 4,
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
                                  'Primary Diagnosis',
                                  style: GoogleFonts.poppins(
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
                                GetBuilder<ERXController>(
                                  builder: (cont) => Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.06,
                                        right: Get.width * 0.06),
                                    child: CustomTextField(
                                      readonly: true,
                                      onTap: () async {
                                        // List<PrimaryDiagnosis1> result =
                                        //     await searchableDropdownCheckBox(
                                        //         context,
                                        //         controller.primarydiagnosisList,
                                        //         controller
                                        //             .checkboxselectedprimarydiagnosisList,
                                        //         true,
                                        //         'primary');

                                        // controller
                                        //     .updateselectedPrimarydiagnosislist(
                                        //         result);
                                        // setState(() {});

                                        PrimaryDiagnosis1 generic =
                                            await searchabledropdown(
                                                context,
                                                controller
                                                        .primarydiagnosisList ??
                                                    []);
                                        await controller.addPrimaryDiagnosis(
                                            generic, BuildContext);
                                        setState(() {});
                                      },
                                      prefixIcon: const Icon(
                                        Icons.search_outlined,
                                        color: ColorManager.kPrimaryColor,
                                        size: 35,
                                      ),
                                      hintText: 'Search',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                GetBuilder<ERXController>(
                                  builder: (contr) => Visibility(
                                    visible: controller
                                        .selectedprimarydiagnosisList
                                        .isNotEmpty,
                                    child: Column(
                                      children: <Widget>[
                                        Wrap(
                                          direction: Axis.horizontal,
                                          runSpacing: 8.0,
                                          children: <Widget>[
                                            for (int index = 0;
                                                index <
                                                    controller
                                                        .selectedprimarydiagnosisList
                                                        .length;
                                                index++)
                                              InkWell(
                                                onTap: () {
                                                  String cid = controller
                                                      .selectedprimarydiagnosisList[
                                                          index]
                                                      .id!;
                                                  deleteSelected(
                                                      context,
                                                      controller
                                                          .selectedprimarydiagnosisList,
                                                      cid,
                                                      "pd");
                                                },
                                                child: Card(
                                                  elevation: 4,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.01,
                                                        right:
                                                            Get.width * 0.01),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.03,
                                                          width:
                                                              Get.width * 0.03,
                                                          child: Image.asset(
                                                              AppImages.cross),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.01,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            controller
                                                                .selectedprimarydiagnosisList[
                                                                    index]
                                                                .name
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              color: ColorManager
                                                                  .kblackColor,
                                                            ),
                                                          ),
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
                          height: Get.height * 0.02,
                        ),
                        // SECONDARY DIAGNOSTIC
                        Card(
                          elevation: 4,
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
                                  'Secondary Diagnosis',
                                  style: GoogleFonts.poppins(
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
                                GetBuilder<ERXController>(
                                  builder: (cont) => Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.06,
                                        right: Get.width * 0.06),
                                    child: CustomTextField(
                                      readonly: true,
                                      onTap: () async {
                                        SecondaryDiagnosis1 generic =
                                            await searchabledropdown(
                                                context,
                                                controller
                                                        .secondaryDiagnosisList ??
                                                    []);
                                        await controller.addsecondaryDiagnosis(
                                            generic, BuildContext);
                                        setState(() {});
                                      },
                                      prefixIcon: const Icon(
                                        Icons.search_outlined,
                                        color: ColorManager.kPrimaryColor,
                                        size: 35,
                                      ),
                                      hintText: 'Search',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                GetBuilder<ERXController>(
                                  builder: (contr) => Visibility(
                                    visible: controller
                                        .selectedsecondaryDiagnosisList
                                        .isNotEmpty,
                                    child: Column(
                                      children: <Widget>[
                                        Wrap(
                                          direction: Axis
                                              .horizontal, // Make sure items are laid out horizontally
                                          runSpacing: 8.0,
                                          children: <Widget>[
                                            for (int index = 0;
                                                index <
                                                    controller
                                                        .selectedsecondaryDiagnosisList
                                                        .length;
                                                index++)
                                              InkWell(
                                                onTap: () {
                                                  String cid = controller
                                                      .selectedsecondaryDiagnosisList[
                                                          index]
                                                      .id!;
                                                  deleteSelected(
                                                      context,
                                                      controller
                                                          .selectedsecondaryDiagnosisList,
                                                      cid,
                                                      "sd");
                                                },
                                                child: Card(
                                                  elevation: 4,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.01,
                                                        right:
                                                            Get.width * 0.01),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.03,
                                                          width:
                                                              Get.width * 0.03,
                                                          child: Image.asset(
                                                              AppImages.cross),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.01,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            controller
                                                                .selectedsecondaryDiagnosisList[
                                                                    index]
                                                                .name
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              color: ColorManager
                                                                  .kblackColor,
                                                            ),
                                                          ),
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
                          height: Get.height * 0.02,
                        ),

                        Card(
                          elevation: 4,
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
                                  'diagnostics'.tr,
                                  style: GoogleFonts.poppins(
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
                                GetBuilder<ERXController>(
                                  builder: (cont) => Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.06,
                                        right: Get.width * 0.06),
                                    child: CustomTextField(
                                      readonly: true,
                                      onTap: () async {
                                        Diagnostics1 generic =
                                            await searchabledropdown(
                                                context,
                                                controller.diagnosticsList ??
                                                    []);
                                        await controller.addDiagnostics(
                                            generic, BuildContext);
                                        setState(() {});
                                      },
                                      prefixIcon: const Icon(
                                        Icons.search_outlined,
                                        color: ColorManager.kPrimaryColor,
                                        size: 35,
                                      ),
                                      hintText: 'Search',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                GetBuilder<ERXController>(
                                  builder: (contr) => Visibility(
                                    visible: controller
                                        .selecteddiagnosticslist.isNotEmpty,
                                    child: Column(
                                      children: <Widget>[
                                        Wrap(
                                          direction: Axis
                                              .horizontal, // Make sure items are laid out horizontally
                                          runSpacing: 8.0,
                                          children: <Widget>[
                                            for (int index = 0;
                                                index <
                                                    controller
                                                        .selecteddiagnosticslist
                                                        .length;
                                                index++)
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
                                                child: Card(
                                                  elevation: 4,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.01,
                                                        right:
                                                            Get.width * 0.01),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.03,
                                                          width:
                                                              Get.width * 0.03,
                                                          child: Image.asset(
                                                              AppImages.cross),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.01,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            controller
                                                                .selecteddiagnosticslist[
                                                                    index]
                                                                .name
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              color: ColorManager
                                                                  .kblackColor,
                                                            ),
                                                          ),
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
                        // Center(
                        //   child: Text(
                        //     'diagnostics'.tr,
                        //     style: GoogleFonts.poppins(
                        //       textStyle: GoogleFonts.poppins(
                        //         fontSize: 12,
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: Get.height * 0.015,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     ImageContainer(
                        //       imagePath: AppImages.diagnostics,
                        //       imageheight: Get.height * 0.05,
                        //       isSvg: false,
                        //       color: ColorManager.kWhiteColor,
                        //       backgroundColor: ColorManager.kPrimaryColor,
                        //     ),
                        //     SizedBox(
                        //       width: Get.width * 0.01,
                        //     ),
                        //     InkWell(
                        //       onTap: () async {
                        //         controller.selecteddiagnostics = null;
                        //         Diagnostics1 generic = await searchabledropdown(
                        //             context, controller.diagnosticsList ?? []);
                        //         controller.selecteddiagnostics = null;
                        //         controller.updatediagnostics(generic);

                        //         if (generic != '') {
                        //           controller.selecteddiagnostics = generic;
                        //           controller.selecteddiagnostics =
                        //               (generic == '')
                        //                   ? null
                        //                   : controller.selecteddiagnostics;
                        //         }
                        //         setState(() {});
                        //       },
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //           border: Border.all(
                        //             color: ColorManager.kPrimaryColor,
                        //           ),
                        //           borderRadius: BorderRadius.circular(10.0),
                        //           color: ColorManager.kPrimaryLightColor,
                        //         ),
                        //         height:
                        //             MediaQuery.of(context).size.height * 0.066,
                        //         width: Get.width * 0.6,
                        //         child: Padding(
                        //           padding: EdgeInsets.symmetric(
                        //               horizontal:
                        //                   MediaQuery.of(context).size.width *
                        //                       0.05),
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(
                        //                 "${(controller.selecteddiagnostics != null && controller.selecteddiagnostics?.name != null) ? (controller.selecteddiagnostics!.name!.length > 20 ? ('${controller.selecteddiagnostics?.name!.substring(0, 20 > controller.selecteddiagnostics!.name!.length ? controller.selecteddiagnostics!.name!.length : 20)}...') : controller.selecteddiagnostics?.name) : "Select Diagnostics"}",
                        //                 semanticsLabel:
                        //                     "${(controller.selecteddiagnostics != null) ? (controller.selecteddiagnostics!.name!.length > 20 ? ('${controller.selecteddiagnostics?.name!.substring(0, 20 > controller.selecteddiagnostics!.name!.length ? controller.selecteddiagnostics!.name!.length : 20)}...') : controller.selecteddiagnostics) : "Select Diagnostics"}",
                        //                 style: GoogleFonts.poppins(
                        //                     fontSize: 12,
                        //                     color: controller
                        //                                 .selecteddiagnostics
                        //                                 ?.name !=
                        //                             null
                        //                         ? Colors.black
                        //                         : Colors.grey[700]),
                        //               ),
                        //               Icon(Icons.arrow_drop_down,
                        //                   size: MediaQuery.of(context)
                        //                           .size
                        //                           .width *
                        //                       0.06,
                        //                   color: Colors.black)
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: Get.width * 0.01,
                        //     ),
                        //     ImageContainer(
                        //       onpressed: () {
                        //         controller.addDiagnostics();
                        //         setState(() {});
                        //       },
                        //       imagePath: Images.add,
                        //       isSvg: false,
                        //       color: ColorManager.kWhiteColor,
                        //       backgroundColor: ColorManager.kPrimaryColor,
                        //     )
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: Get.height * 0.01,
                        // ),
                        // GetBuilder<ERXController>(
                        //   builder: (cont) => Visibility(
                        //     visible:
                        //         controller.selecteddiagnosticslist.isNotEmpty,
                        //     child: Card(
                        //       elevation: 4,
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //           color: ColorManager.kPrimaryLightColor,
                        //           borderRadius: BorderRadius.circular(10),
                        //         ),
                        //         width: Get.width * 1,
                        //         child: Column(
                        //           children: <Widget>[
                        //             Wrap(
                        //               children: <Widget>[
                        //                 for (int index = 0;
                        //                     index <
                        //                         controller
                        //                             .selecteddiagnosticslist
                        //                             .length;
                        //                     index++)
                        //                   Column(
                        //                     children: [
                        //                       Padding(
                        //                         padding: EdgeInsets.only(
                        //                             left: Get.width * 0.03),
                        //                         child: InkWell(
                        //                           onTap: () {
                        //                             String cid = controller
                        //                                 .selecteddiagnosticslist[
                        //                                     index]
                        //                                 .id!;
                        //                             deleteSelected(
                        //                                 context,
                        //                                 controller
                        //                                     .selecteddiagnosticslist,
                        //                                 cid,
                        //                                 "diagnostics");
                        //                           },
                        //                           child: Row(
                        //                             children: [
                        //                               SizedBox(
                        //                                 height:
                        //                                     Get.height * 0.04,
                        //                                 width: Get.width * 0.04,
                        //                                 child: Image.asset(
                        //                                     AppImages.cross),
                        //                               ),
                        //                               SizedBox(
                        //                                 width: Get.width * 0.02,
                        //                               ),
                        //                               Flexible(
                        //                                 child: Text(
                        //                                   controller
                        //                                       .selecteddiagnosticslist[
                        //                                           index]
                        //                                       .name
                        //                                       .toString(),
                        //                                   style: GoogleFonts
                        //                                       .poppins(
                        //                                     fontSize: 10,
                        //                                     color: ColorManager
                        //                                         .kblackColor,
                        //                                   ),
                        //                                 ),
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        Card(
                          elevation: 4,
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
                                  'labinvestigation'.tr,
                                  style: GoogleFonts.poppins(
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
                                GetBuilder<ERXController>(
                                  builder: (cont) => Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.06,
                                        right: Get.width * 0.06),
                                    child: CustomTextField(
                                      readonly: true,
                                      onTap: () async {
                                        Investigations1 generic =
                                            await searchabledropdown(
                                                context,
                                                controller.investigationList ??
                                                    []);
                                        await controller.addInvestigation(
                                            generic, BuildContext);
                                        setState(() {});
                                      },
                                      prefixIcon: const Icon(
                                        Icons.search_outlined,
                                        color: ColorManager.kPrimaryColor,
                                        size: 35,
                                      ),
                                      hintText: 'Search',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                GetBuilder<ERXController>(
                                  builder: (contr) => Visibility(
                                    visible: controller
                                        .selectedinvestigationList.isNotEmpty,
                                    child: Column(
                                      children: <Widget>[
                                        Wrap(
                                          direction: Axis
                                              .horizontal, // Make sure items are laid out horizontally
                                          runSpacing: 8.0,
                                          children: <Widget>[
                                            for (int index = 0;
                                                index <
                                                    controller
                                                        .selectedinvestigationList
                                                        .length;
                                                index++)
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
                                                child: Card(
                                                  elevation: 4,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.01,
                                                        right:
                                                            Get.width * 0.01),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.03,
                                                          width:
                                                              Get.width * 0.03,
                                                          child: Image.asset(
                                                              AppImages.cross),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.01,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            controller
                                                                .selectedinvestigationList[
                                                                    index]
                                                                .name
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              color: ColorManager
                                                                  .kblackColor,
                                                            ),
                                                          ),
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
                          height: Get.height * 0.02,
                        ),

                        // PROCEDURES

                        Card(
                          elevation: 4,
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
                                  'Procedures',
                                  style: GoogleFonts.poppins(
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
                                GetBuilder<ERXController>(
                                  builder: (cont) => Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.06,
                                        right: Get.width * 0.06),
                                    child: CustomTextField(
                                      readonly: true,
                                      onTap: () async {
                                        Procedures1 generic =
                                            await searchabledropdown(
                                                context,
                                                controller.proceduresList ??
                                                    []);
                                        await controller.addprocedures(
                                            generic, BuildContext);
                                        setState(() {});
                                      },
                                      prefixIcon: const Icon(
                                        Icons.search_outlined,
                                        color: ColorManager.kPrimaryColor,
                                        size: 35,
                                      ),
                                      hintText: 'Search',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                GetBuilder<ERXController>(
                                  builder: (contr) => Visibility(
                                    visible: controller
                                        .selectedproceduresList.isNotEmpty,
                                    child: Column(
                                      children: <Widget>[
                                        Wrap(
                                          direction: Axis
                                              .horizontal, // Make sure items are laid out horizontally
                                          runSpacing: 8.0,
                                          children: <Widget>[
                                            for (int index = 0;
                                                index <
                                                    controller
                                                        .selectedproceduresList
                                                        .length;
                                                index++)
                                              InkWell(
                                                onTap: () {
                                                  String cid = controller
                                                      .selectedproceduresList[
                                                          index]
                                                      .id!;
                                                  deleteSelected(
                                                      context,
                                                      controller
                                                          .selectedproceduresList,
                                                      cid,
                                                      "procedures");
                                                },
                                                child: Card(
                                                  elevation: 4,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.01,
                                                        right:
                                                            Get.width * 0.01),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.03,
                                                          width:
                                                              Get.width * 0.03,
                                                          child: Image.asset(
                                                              AppImages.cross),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.01,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            controller
                                                                .selectedproceduresList[
                                                                    index]
                                                                .name
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              color: ColorManager
                                                                  .kblackColor,
                                                            ),
                                                          ),
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

                        // MEDICINE

                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        Card(
                            elevation: 4,
                            surfaceTintColor: ColorManager.kWhiteColor,
                            child: SizedBox(
                                // height: Get.height * 0.09,
                                width: Get.width * 0.9,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Text(
                                        'Medicines',
                                        style: GoogleFonts.poppins(
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
                                      GetBuilder<ERXController>(
                                        builder: (cont) => Padding(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.06,
                                              right: Get.width * 0.06),
                                          child: CustomTextField(
                                            readonly: true,
                                            onTap: () async {
                                              ERXController.i.updatemedicinelist(
                                                  await PrescribeMedicinRepo
                                                      .getMedicinesMatrix());
                                              String result = await addMedicine(
                                                context,
                                                controller.medicineList,
                                                controller.selectedmedicineList,
                                                controller.selectedmedicine,
                                              );
                                              controller.updateselectedmedicine(
                                                  result);
                                            },
                                            prefixIcon: const Icon(
                                              Icons.search_outlined,
                                              color: ColorManager.kPrimaryColor,
                                              size: 35,
                                            ),
                                            hintText: 'Search',
                                          ),
                                        ),
                                      ),
                                    ]))),

                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        // medicine visisbility
                        GetBuilder<ERXController>(
                          builder: (cont) => Visibility(
                            visible: controller.selectedmedicineList.isNotEmpty,
                            // visible: true,
                            child: Card(
                              elevation: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.kPrimaryLightColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: Get.width * 1,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.01,
                                      vertical: Get.height * 0.01),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'medicine'.tr,
                                              style: GoogleFonts.poppins(
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
                                            for (int index = 0;
                                                index <
                                                    controller
                                                        .finalmedicinellist
                                                        .length;
                                                index++)
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      controller
                                                          .removefinalmedindex(
                                                              index);
                                                    },
                                                    child: SizedBox(
                                                      height: Get.height * 0.03,
                                                      width: Get.width * 0.03,
                                                      child: Image.asset(
                                                          AppImages.cross),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.01,
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      controller
                                                              .finalmedicinellist[
                                                                  index]
                                                              .medicine ??
                                                          "",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.04,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Freq",
                                            style: GoogleFonts.poppins(
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
                                          for (int index = 0;
                                              index <
                                                  controller
                                                      .selectedlst
                                                      .medicineFrequencies!
                                                      .length;
                                              index++)
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.1,
                                                  child: Text(
                                                    controller
                                                            .selectedlst
                                                            .medicineFrequencies?[
                                                                index]
                                                            .quantity
                                                            .toString() ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.05,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Dos",
                                            style: GoogleFonts.poppins(
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
                                          for (int index = 0;
                                              index <
                                                  controller.selectedlst
                                                      .medicineDosages!.length;
                                              index++)
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.07,
                                                  child: Text(
                                                    controller
                                                            .selectedlst
                                                            .medicineDosages?[
                                                                index]
                                                            .dosageValue
                                                            .toString() ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Dur",
                                            style: GoogleFonts.poppins(
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
                                          for (int index = 0;
                                              index <
                                                  controller.selectedlst
                                                      .dateList!.length;
                                              index++)
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                                Text(
                                                  "${controller.selectedlst.dateList![index].englishCounting} ${controller.selectedlst.dayList![index].englishDay}",
                                                  style: GoogleFonts.poppins(
                                                    textStyle:
                                                        GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Route",
                                            style: GoogleFonts.poppins(
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
                                          for (int index = 0;
                                              index <
                                                  controller.selectedlst
                                                      .medicineRoutes!.length;
                                              index++)
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.18,
                                                  child: Text(
                                                    controller
                                                            .selectedlst
                                                            .medicineRoutes?[
                                                                index]
                                                            .englishDefinition
                                                            .toString() ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        Center(
                          child: Text(
                            'finding'.tr,
                            style: GoogleFonts.poppins(
                              textStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        GetBuilder<ERXController>(
                          builder: (cont) => CustomFormFieldNotes(
                            focusNode: controller.findingfocus,
                            controller: controller.findingsController,
                            lines: 3,
                            hintText: 'finding'.tr,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.015,
                        ),

                        Card(
                          elevation: 4,
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
                                  'Follow Up',
                                  style: GoogleFonts.poppins(
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
                                GetBuilder<ERXController>(
                                  builder: (cont) => Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.06,
                                        right: Get.width * 0.06),
                                    child: CustomTextField(
                                      readonly: true,
                                      onTap: () async {
                                        FollowUps1 generic =
                                            await searchabledropdown(context,
                                                controller.followupList ?? []);
                                        await controller.addfollowup(generic);
                                        setState(() {});
                                      },
                                      prefixIcon: const Icon(
                                        Icons.search_outlined,
                                        color: ColorManager.kPrimaryColor,
                                        size: 35,
                                      ),
                                      hintText: 'Search',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                GetBuilder<ERXController>(
                                  builder: (contr) => Visibility(
                                    visible: controller.selectedfup?.id != "",
                                    child: Column(
                                      children: <Widget>[
                                        Wrap(
                                          direction: Axis.horizontal,
                                          runSpacing: 8.0,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                String? cid =
                                                    controller.selectedfup!.id;
                                                // controller.deletefollowup();
                                                deleteSelectedObject(
                                                    context,
                                                    controller.selectedfup,
                                                    cid ?? "",
                                                    "followup");
                                              },
                                              child: Card(
                                                elevation: 4,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: Get.width * 0.01,
                                                      right: Get.width * 0.01),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.03,
                                                        width: Get.width * 0.03,
                                                        child: Image.asset(
                                                            AppImages.cross),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.01,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          controller.selectedfup
                                                                  ?.name
                                                                  .toString() ??
                                                              "Names",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 10,
                                                            color: ColorManager
                                                                .kblackColor,
                                                          ),
                                                        ),
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
                          height: Get.height * 0.01,
                        ),
                        Card(
                          elevation: 4,
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
                                  'Instructions',
                                  style: GoogleFonts.poppins(
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
                                GetBuilder<ERXController>(
                                  builder: (cont) => Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.06,
                                        right: Get.width * 0.06),
                                    child: CustomTextField(
                                      readonly: true,
                                      onTap: () async {
                                        Instructions1 generic =
                                            await searchabledropdown(
                                                context,
                                                controller.instructionList ??
                                                    []);
                                        await controller.addinstructions(
                                            generic, BuildContext);
                                        setState(() {});
                                      },
                                      prefixIcon: const Icon(
                                        Icons.search_outlined,
                                        color: ColorManager.kPrimaryColor,
                                        size: 35,
                                      ),
                                      hintText: 'Search',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                GetBuilder<ERXController>(
                                  builder: (contr) => Visibility(
                                    visible: controller
                                        .selectedinstructionList.isNotEmpty,
                                    child: Column(
                                      children: <Widget>[
                                        Wrap(
                                          direction: Axis
                                              .horizontal, // Make sure items are laid out horizontally
                                          runSpacing: 8.0,
                                          children: <Widget>[
                                            for (int index = 0;
                                                index <
                                                    controller
                                                        .selectedinstructionList
                                                        .length;
                                                index++)
                                              InkWell(
                                                onTap: () {
                                                  String cid = controller
                                                      .selectedinstructionList[
                                                          index]
                                                      .id!;
                                                  deleteSelected(
                                                      context,
                                                      controller
                                                          .selectedinstructionList,
                                                      cid,
                                                      "instructions");
                                                },
                                                child: Card(
                                                  elevation: 4,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.01,
                                                        right:
                                                            Get.width * 0.01),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.03,
                                                          width:
                                                              Get.width * 0.03,
                                                          child: Image.asset(
                                                              AppImages.cross),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.01,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            controller
                                                                .selectedinstructionList[
                                                                    index]
                                                                .name
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              color: ColorManager
                                                                  .kblackColor,
                                                            ),
                                                          ),
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
                          height: Get.height * 0.01,
                        ),
                        Center(
                          child: Text(
                            'advice'.tr,
                            style: GoogleFonts.poppins(
                              textStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        GetBuilder<ERXController>(
                          builder: (cont) => CustomFormFieldNotes(
                            focusNode: controller.notesfocus,
                            controller: controller.noteController,
                            lines: 3,
                            hintText: 'advice'.tr,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * 0.4,
                              child: PrimaryButton(
                                  title: 'hold'.tr,
                                  onPressed: () async {
                                    String res = await precribeholdandconsult(
                                        "2", context);
                                    if (res ==
                                        "Patient is Successfully set on Hold ") {
                                      Get.back(result: true);
                                    }
                                    //Get.to(const DoctorReviewScreen());
                                  },
                                  fontSize: 15,
                                  color: ColorManager.kPrimaryColor,
                                  textcolor: ColorManager.kWhiteColor),
                            ),
                            SizedBox(
                              width: Get.width * 0.4,
                              child: PrimaryButton(
                                  title: 'consult'.tr,
                                  onPressed: () async {
                                    String res = await precribeholdandconsult(
                                        "3", context);
                                    if (res ==
                                        "Patient Successfully Consulted") {
                                      Get.back(result: true);
                                    }
                                    // Get.to(const DoctorReviewScreen());
                                  },
                                  fontSize: 15,
                                  color: ColorManager.kPrimaryColor,
                                  textcolor: ColorManager.kWhiteColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            ),
          )),
    );
  }

  Future<String> precribeholdandconsult(
      String val, BuildContext context) async {
    ERXController.i.updateIsloading(true);
    List<pm.MedicineList> data = [];
    String qyt = "";
    for (int i = 0; i < ERXController.i.finalmedicinellist.length; i++) {
      String doseng = ERXController
              .i.selectedlst.medicineDosages?[i].dosageValue
              .toString() ??
          "";
      String dateng =
          ERXController.i.selectedlst.dateList?[i].englishCounting.toString() ??
              "";
      String dayeng =
          ERXController.i.selectedlst.dayList?[i].englishDay.toString() ?? "";
      DateTime dateeng = DateTime.now();
      if (dayeng.toLowerCase() == "day") {
        qyt = "";
        dateeng = dateeng.add(Duration(days: (1 * int.parse(dateng)).toInt()));
        qyt = (int.parse(dateng)).toString();
      } else if (dayeng.toLowerCase() == "week") {
        qyt = "";
        dateeng =
            dateeng.add(Duration(days: (7 * (int.parse(dateng))).toInt()));
        qyt = (int.parse(dateng) * 7).toString();
      } else if (dayeng.toLowerCase() == "month") {
        qyt = "";
        dateeng =
            dateeng.add(Duration(days: (30 * (int.parse(dateng))).toInt()));
        qyt = (int.parse(dateng) * 30).toString();
      }
      String diff = dateeng.toString().split(' ')[0];
      String englishdiscription = "$doseng for $dateng $dayeng    [" +
          performancestartdate!.split(' ')[0] +
          ' - ' +
          diff +
          "]";

      String daturdu =
          ERXController.i.selectedlst.dateList?[i].urduCounting.toString() ??
              "";
      String dayurdu =
          ERXController.i.selectedlst.dayList?[i].urduDay.toString() ?? "";
      DateTime dateurdu = DateTime.now();
      if (dayeng.toLowerCase() == "day") {
        qyt = "";
        dateeng = dateeng.add(Duration(days: (1 * int.parse(dateng)).toInt()));
        qyt = (int.parse(dateng)).toString();
      } else if (dayeng.toLowerCase() == "week") {
        qyt = "";
        dateeng =
            dateeng.add(Duration(days: (7 * (int.parse(dateng))).toInt()));
        qyt = (int.parse(dateng) * 7).toString();
      } else if (dayeng.toLowerCase() == "month") {
        qyt = "";
        dateeng =
            dateeng.add(Duration(days: (30 * (int.parse(dateng))).toInt()));
        qyt = (int.parse(dateng) * 30).toString();
      }

      String urdudiscription = "$doseng for $daturdu $dayurdu  [" +
          performancestartdate!.split(' ')[0] +
          ' - ' +
          diff +
          "]";

      data.add(pm.MedicineList(
          id: ERXController.i.finalmedicinellist[i].id,
          medicineStrengthId: "",
          medicineDosageId:
              ERXController.i.selectedlst.medicineDosages?[i].id ?? "",
          dosageValue: ERXController
                  .i.selectedlst.medicineDosages?[i].dosageValue
                  .toString() ??
              "",
          frequencyNumeric: ERXController
                  .i.selectedlst.medicineFrequencies?[i].numericDisplay ??
              "",
          frequencyQuantity: ERXController
                  .i.selectedlst.medicineFrequencies?[i].quantity
                  .toString() ??
              "",
          dayId: ERXController.i.selectedlst.dayList?[i].id.toString() ?? "",
          dateId: ERXController.i.selectedlst.dateList?[i].id.toString() ?? "",
          medicineRouteId:
              ERXController.i.selectedlst.medicineRoutes?[i].id.toString() ??
                  "",
          medicineEventTimingId: "",
          preference: "1",
          medicineEventTimingDetail: "",
          medicineEnglishDescription: englishdiscription,
          medicineUrduDescription: urdudiscription,
          tappedMedicinesDetail: "",
          medicineDurationDetail: diff,
          quantity: qyt,
          medicineTypeInTakeId: "",
          ophthType: "",
          comment: ""));
    }
    List<String> invest = [];
    for (int i = 0; i < ERXController.i.selectedinvestigationList.length; i++) {
      invest.add(ERXController.i.selectedinvestigationList[i].id ?? "");
    }

    List<String> dignose = [];
    for (int i = 0; i < ERXController.i.selecteddiagnosticslist.length; i++) {
      dignose.add(ERXController.i.selecteddiagnosticslist[i].id ?? "");
    }

    List<pm.Procedures> proceureslt = [];
    for (int i = 0; i < ERXController.i.selectedproceduresList.length; i++) {
      proceureslt.add(pm.Procedures(
        id: ERXController.i.selectedproceduresList[i].id ?? "",
        subDepartmentId: "",
        procedureDate: "",
        procedureTime: "",
        procedureDurationInMinutes: "",
        discountStatus: "4",
        clinicalHistory: "",
        comments: "",
        anesthesiaType: "0",
        ophthType: "",
        isUrgent: "0",
        isGAFitnessRequried: "0",
      ));
    }

    List<pm.Diagnosis> diagnosislst = [];
    for (int i = 0;
        i < ERXController.i.selectedprimarydiagnosisList.length;
        i++) {
      diagnosislst.add(pm.Diagnosis(
          id: ERXController.i.selectedprimarydiagnosisList[i].id ?? "",
          comments:
              ERXController.i.selectedprimarydiagnosisList[i].comments ?? "",
          ophthType: ""));
    }
    List<String> complaintlst = [];
    for (int i = 0; i < ERXController.i.selectedComplaintsList.length; i++) {
      complaintlst.add(ERXController.i.selectedComplaintsList[i].id ?? "");
    }

    List<String> instructionslst = [];
    for (int i = 0; i < ERXController.i.selectedinstructionList.length; i++) {
      instructionslst.add(ERXController.i.selectedinstructionList[i].id ?? "");
    }

    List<pm.SecondayDiagnosis> secondarydiagnosislst = [];
    for (int i = 0;
        i < ERXController.i.selectedsecondaryDiagnosisList.length;
        i++) {
      secondarydiagnosislst.add(pm.SecondayDiagnosis(
          id: ERXController.i.selectedsecondaryDiagnosisList[i].id ?? "",
          comments:
              ERXController.i.selectedsecondaryDiagnosisList[i].comments ?? "",
          ophthType: ""));
    }
// ERXController.i.selectedprimarydiagnosisList

    pm.prescribemedicinemodel prescribe = pm.prescribemedicinemodel(
      branchId: await LocalDb().getBranchId(),
      doctorId: await LocalDb().getDoctorId(),
      patientId: widget.patientid,
      visitNo: widget.visitno,
      prescriptionPerformanceStart: performancestartdate,
      prescriptionPerformanceEnd: DateTime.now().toString().split('.')[0],
      defaultDoctorSpecialityId: ProfileController.i.mainspeciality!.id,
      examFinding: ERXController.i.findingsController.text.toString() != ''
          ? ERXController.i.findingsController.text.toString()
          : "",
      advice: ERXController.i.noteController.text.toString() != ''
          ? ERXController.i.noteController.text.toString()
          : "",
      patientStatusValue: val,
      medicineList: data,
      deletedMedicineList: ERXController.i.deletedmedicineList,
      investigations: invest,
      deletedInvestigations: ERXController.i.deletedinvestigationList,
      diagnosis: diagnosislst,
      deletedDiagnosis: ERXController.i.deletedprimarydiagnosisList,
      procedures: proceureslt,
      deletedProcedures: ERXController.i.deletedproceduresList,
      diagnostics: dignose,
      deletedDiagnostics: ERXController.i.deleteddiagnosticsList,
      complaints: complaintlst,
      deletedComplaints: ERXController.i.deletedComplaintsList,
      proceduralFindingText: "",
      proceduralFindingId: "",
      followUps: [ERXController.i.selectedfup?.id ?? ""],
      instructions: instructionslst,
      deletedInstructions: ERXController.i.deletedinstructionList,
      prescribedInValue: "2",
      dischargeNotes: "",
      secondayDiagnosis: secondarydiagnosislst,
      deletedSecondayDiagnosis: ERXController.i.deletedsecondarydiagnosisList,
      isFirstTimeVisit: widget.checkfirst,
      smoker:
          ERXController.i.smokeryesSelected.toString() == "true" ? "1" : "0",
      diabetic:
          ERXController.i.diabeticyesSelected.toString() == "true" ? "1" : "0",
    );
    log(jsonEncode(prescribe));
    String rep =
        await PrescribeMedicinRepo().precribemedicine(jsonEncode(prescribe));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(rep)));
    print('repreprep');
    print(rep);
    ERXController.i.updateIsloading(false);
    return rep;
  }
}
