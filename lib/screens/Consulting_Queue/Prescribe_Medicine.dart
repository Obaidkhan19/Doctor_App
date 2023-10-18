import 'dart:ffi';

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
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/perscribe_medicine_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/complaints.dart';
import 'package:doctormobileapplication/models/diagnostics.dart';
import 'package:doctormobileapplication/models/finding.dart';
import 'package:doctormobileapplication/models/followups.dart';
import 'package:doctormobileapplication/models/instruction.dart';
import 'package:doctormobileapplication/models/investigation.dart';
import 'package:doctormobileapplication/models/primary_diagnosis.dart';
import 'package:doctormobileapplication/models/procedures.dart';
import 'package:doctormobileapplication/models/secondart_diagnosis.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/doctor_review.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Item {
  final String name;
  final int age;
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
  Item(
      name: "John",
      age: 25,
      className: "Class A",
      section: "Section 1",
      country: "USA"),
  Item(
      name: "Alice",
      age: 22,
      className: "Class B",
      section: "Section 2",
      country: "Canada"),
  Item(
      name: "Bob",
      age: 23,
      className: "Class A",
      section: "Section 1",
      country: "UK"),
  Item(
      name: "Eve",
      age: 24,
      className: "Class C",
      section: "Section 3",
      country: "Australia"),
  Item(
      name: "Charlie",
      age: 26,
      className: "Class B",
      section: "Section 2",
      country: "USA"),
  // Add more items as needed
];

class PrescribeMedicineScreen extends StatefulWidget {
  const PrescribeMedicineScreen({super.key});

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
    controller.updateInstructionlist(
      await pmr.getInstruction(),
    );
  }

  @override
  void initState() {
    super.initState();
    _getMediciness();
    _getInstructions();
    _getFollowup();
    _getProceduress();
    _getPrimaryDiagnosis();
    _getSecondaryDiagnosis();
    _getComplaints();
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
    ERXController controller = Get.put(ERXController());
    return GestureDetector(
      onTap: () {
        controller.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            titleSpacing: 0,
            leading: Padding(
              padding: EdgeInsets.only(left: Get.width * 0.04),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  AppImages.back,
                ),
              ),
            ),
            title: Text(
              'erx'.tr,
              style: GoogleFonts.poppins(
                textStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.kPrimaryColor),
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(),
            child: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.03,
                  right: Get.width * 0.03,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: Get.width * 0.04),
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
                          width: Get.width * 0.27,
                        ),
                        Text(
                          'History',
                          style: GoogleFonts.poppins(
                            textStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        final item = items.first;
                        return Card(
                          elevation: 4,
                          surfaceTintColor: ColorManager.kWhiteColor,
                          child: MyCustomTile(
                            title: Padding(
                              padding: EdgeInsets.only(left: Get.width * 0.04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Complaints:",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.kblackColor,
                                        ),
                                      ),
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Diagnosis:",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.kblackColor,
                                        ),
                                      ),
                                      Text(
                                        item.age.toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: Get.width * 0.27),
                                    child: InkWell(
                                      onTap: () {
                                        initiallyExpanded:
                                        false;
                                        onExpansionChanged:
                                        (expanded) {
                                          setState(() {
                                            item.isExpanded = expanded;
                                          });
                                        };
                                      },
                                      child: Container(
                                        width: Get.width * 0.3,
                                        height: Get.height * 0.006,
                                        decoration: BoxDecoration(
                                          color: ColorManager.kblackColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            initiallyExpanded: false,
                            onExpansionChanged: (expanded) {
                              setState(() {
                                item.isExpanded = expanded;
                              });
                            },
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.04),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Procedures:",
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.kblackColor,
                                          ),
                                        ),
                                        Text(
                                          item.className,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Diagnostics:",
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.kblackColor,
                                          ),
                                        ),
                                        Text(
                                          item.section,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Investigations:",
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.kblackColor,
                                          ),
                                        ),
                                        Text(
                                          item.country,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Vitals:",
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.kblackColor,
                                          ),
                                        ),
                                        Text(
                                          item.country,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.03,
                        right: Get.width * 0.03,
                      ),
                      child: Row(
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
                                  controller.smokerupdateYes(value!),
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
                              value: true,
                              groupValue: controller.smokernoSelected.value,
                              onChanged: (value) =>
                                  controller.smokerupdateNo(value!),
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
                    ),

                    // diabetic
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * 0.03,
                        right: Get.width * 0.03,
                      ),
                      child: Row(
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
                              groupValue: controller.diabeticyesSelected.value,
                              onChanged: (value) =>
                                  controller.diabeticupdateYes(value!),
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
                              value: true,
                              groupValue: controller.diabeticnoSelected.value,
                              onChanged: (value) =>
                                  controller.diabeticupdateNo(value!),
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
                                        await searchabledropdown(context,
                                            controller.complaintsList ?? []);
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
                                                  .selectedComplaintsList[index]
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
                                                    right: Get.width * 0.01),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height * 0.03,
                                                      width: Get.width * 0.03,
                                                      child: Image.asset(
                                                          AppImages.cross),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.01,
                                                    ),
                                                    Text(
                                                      controller
                                                          .selectedComplaintsList[
                                                              index]
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: ColorManager
                                                            .kblackColor,
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
                                    PrimaryDiagnosis1 generic =
                                        await searchabledropdown(
                                            context,
                                            controller.primarydiagnosisList ??
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
                                    .selectedprimarydiagnosisList.isNotEmpty,
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
                                                    right: Get.width * 0.01),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height * 0.03,
                                                      width: Get.width * 0.03,
                                                      child: Image.asset(
                                                          AppImages.cross),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.01,
                                                    ),
                                                    Text(
                                                      controller
                                                          .selectedprimarydiagnosisList[
                                                              index]
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: ColorManager
                                                            .kblackColor,
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
                                            controller.secondaryDiagnosisList ??
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
                                    .selectedsecondaryDiagnosisList.isNotEmpty,
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
                                                  "pd");
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
                                                      height: Get.height * 0.03,
                                                      width: Get.width * 0.03,
                                                      child: Image.asset(
                                                          AppImages.cross),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.01,
                                                    ),
                                                    Text(
                                                      controller
                                                          .selectedsecondaryDiagnosisList[
                                                              index]
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: ColorManager
                                                            .kblackColor,
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
                      height: Get.height * 0.015,
                    ),

                    SizedBox(
                      height: Get.height * 0.015,
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
                      height: Get.height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ImageContainer(
                          imagePath: AppImages.diagnostics,
                          imageheight: Get.height * 0.05,
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
                          elevation: 4,
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
                      height: Get.height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ImageContainer(
                          imagePath: AppImages.investigation,
                          imageheight: Get.height * 0.05,
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
                          elevation: 4,
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
                                        await searchabledropdown(context,
                                            controller.proceduresList ?? []);
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
                                                  .selectedproceduresList[index]
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
                                                    right: Get.width * 0.01),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height * 0.03,
                                                      width: Get.width * 0.03,
                                                      child: Image.asset(
                                                          AppImages.cross),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.01,
                                                    ),
                                                    Text(
                                                      controller
                                                          .selectedproceduresList[
                                                              index]
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: ColorManager
                                                            .kblackColor,
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
                    // MEDICINES
                    Text(
                      'medicine'.tr,
                      style: GoogleFonts.poppins(
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
                                  style: GoogleFonts.poppins(
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
                                  style: GoogleFonts.poppins(
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
                                  style: GoogleFonts.poppins(
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
                                    keyboardType: TextInputType.number,
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
                                          style: GoogleFonts.poppins(
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
                                          style: GoogleFonts.poppins(
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
                                          style: GoogleFonts.poppins(
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
                          elevation: 4,
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
                                                style: GoogleFonts.poppins(
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
                                      for (int index = 0; index < 3; index++)
                                        Text(
                                          '2',
                                          style: GoogleFonts.poppins(
                                            textStyle: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.03,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'condition'.tr,
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
                                      for (int index = 0; index < 3; index++)
                                        Text(
                                          'After Meal',
                                          style: GoogleFonts.poppins(
                                            textStyle: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.03,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'freq'.tr,
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
                                      for (int index = 0; index < 3; index++)
                                        Text(
                                          '2 Times',
                                          style: GoogleFonts.poppins(
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
                                      for (int index = 0; index < 3; index++)
                                        Text(
                                          '5 Day',
                                          style: GoogleFonts.poppins(
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
                      height: Get.height * 0.01,
                    ),

                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Text(
                      'finding'.tr,
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
                    CustomFormFieldNotes(
                      focusNode: controller.findingfocus,
                      controller: controller.findingsController,
                      lines: 3,
                      hintText: 'finding'.tr,
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
                                visible: controller.selectedfup?.id != null,
                                child: Column(
                                  children: <Widget>[
                                    Wrap(
                                      direction: Axis
                                          .horizontal, // Make sure items are laid out horizontally
                                      runSpacing: 8.0,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            // String cid =
                                            //     controller.selectedfup.id!;
                                            controller.deletefollowup();
                                            // deleteSelected(
                                            //     context,
                                            //     controller.selectedfup
                                            //         ,
                                            //     cid,
                                            //     "followup");
                                          },
                                          child: Card(
                                            elevation: 4,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: Get.width * 0.01,
                                                  right: Get.width * 0.01),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height: Get.height * 0.03,
                                                    width: Get.width * 0.03,
                                                    child: Image.asset(
                                                        AppImages.cross),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.01,
                                                  ),
                                                  Text(
                                                    controller.selectedfup?.name
                                                            .toString() ??
                                                        "Names",
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      color: ColorManager
                                                          .kblackColor,
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
                                        await searchabledropdown(context,
                                            controller.instructionList ?? []);
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
                                                    right: Get.width * 0.01),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height * 0.03,
                                                      width: Get.width * 0.03,
                                                      child: Image.asset(
                                                          AppImages.cross),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.01,
                                                    ),
                                                    Text(
                                                      controller
                                                          .selectedinstructionList[
                                                              index]
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: ColorManager
                                                            .kblackColor,
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
                    Text(
                      'advice'.tr,
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
                    CustomFormFieldNotes(
                      focusNode: controller.notesfocus,
                      controller: controller.noteController,
                      lines: 3,
                      hintText: 'advice'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.45,
                          child: PrimaryButton(
                              title: 'hold'.tr,
                              onPressed: () async {
                                //Get.to(const DoctorReviewScreen());
                              },
                              fontSize: 15,
                              color: ColorManager.kPrimaryColor,
                              textcolor: ColorManager.kWhiteColor),
                        ),
                        SizedBox(
                          width: Get.width * 0.45,
                          child: PrimaryButton(
                              title: 'consult'.tr,
                              onPressed: () async {
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
          )),
    );
  }
}
