import 'package:doctormobileapplication/components/custom_checkbox_dropdown.dart';
import 'package:doctormobileapplication/components/custom_expension_listtile.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/erx_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/perscribe_medicine_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/complaints.dart';
import 'package:doctormobileapplication/models/diagnostics.dart';
import 'package:doctormobileapplication/models/followups.dart';
import 'package:doctormobileapplication/models/instruction.dart';
import 'package:doctormobileapplication/models/investigation.dart';
import 'package:doctormobileapplication/models/medicines.dart';
import 'package:doctormobileapplication/models/primary_diagnosis.dart';
import 'package:doctormobileapplication/models/procedures.dart';
import 'package:doctormobileapplication/models/secondart_diagnosis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/AppImages.dart';

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

class HistoryeRXConsultingQueue extends StatefulWidget {
  const HistoryeRXConsultingQueue({
    super.key,
  });

  @override
  State<HistoryeRXConsultingQueue> createState() =>
      _HistoryeRXConsultingQueueState();
}

class _HistoryeRXConsultingQueueState extends State<HistoryeRXConsultingQueue> {
  final controller = Get.put(ERXController());

  // _getPatientDetail() async {
  //   PatientDetail1 pd = PatientDetail1();
  //   controller.updatepatientdata(await pd.getPatientDetailForPrescription(
  //       widget.doctorId, widget.visitNo, widget.patientId, widget.branchId));
  //   if (controller.patientList.isNotEmpty) {
  //     bool isSmoker = controller.patientList[0].smoker == 1;
  //     controller.smokeryesSelected.value = isSmoker;
  //     controller.smokernoSelected.value = !isSmoker;
  //     bool isDiabetic = controller.patientList[0].diabetic == 1;
  //     controller.diabeticyesSelected.value = isDiabetic;
  //     controller.diabeticnoSelected.value = !isDiabetic;
  //   }
  // }

  _getComplaints() async {
    // LocalDb localDB = LocalDb();
    // String? doctorId = await localDB.getDoctorId();
    // String? branchId = await localDB.getBranchId();
    // String? token = await localDB.getToken();

    Complaints1 c = Complaints1();
    controller.updatecomplaintdata(
      await c.getComplaints(
        // "150",
        // doctorId,
        // '',
        // '',
        // branchId,
        // '',
        // token,

        "150",
        "956315e6-4a1e-4eaa-8a40-f0e9a04609f2",
        '',
        '',
        "5bd60354-fefd-4bcc-a58d-b8e27d802e85",
        '',
        "8f3609d2-0325-4c95-9af3-a872e5176497",
      ),
    );
  }

  _getPrimaryDiagnosis() async {
    // LocalDb localDB = LocalDb();
    // String? doctorId = await localDB.getDoctorId();
    // String? branchId = await localDB.getBranchId();
    // String? token = await localDB.getToken();
    PrimaryDiagnosis1 pd = PrimaryDiagnosis1();
    controller.updatePrimarydiagnosislist(
      await pd.getPrimaryDiagnosis(
        // "150",
        // doctorId,
        // '',
        // '',
        // branchId,
        // '',
        // token,
        "150",
        "956315e6-4a1e-4eaa-8a40-f0e9a04609f2",
        '',
        '',
        "5bd60354-fefd-4bcc-a58d-b8e27d802e85",
        '',
        "8f3609d2-0325-4c95-9af3-a872e5176497",
      ),
    );
  }

  _getSecondaryDiagnosis() async {
    // LocalDb localDB = LocalDb();
    // String? doctorId = await localDB.getDoctorId();
    // String? branchId = await localDB.getBranchId();
    // String? token = await localDB.getToken();
    SecondaryDiagnosis1 sd = SecondaryDiagnosis1();
    controller.updateSecondarydiagnosislist(
      await sd.getSecondaryDiagnosis(
        // "150",
        // doctorId,
        // '',
        // '',
        // branchId,
        // '',
        // token,
        "150",
        "956315e6-4a1e-4eaa-8a40-f0e9a04609f2",
        '',
        '',
        "5bd60354-fefd-4bcc-a58d-b8e27d802e85",
        '',
        "8f3609d2-0325-4c95-9af3-a872e5176497",
      ),
    );
  }

  _getInvestigations() async {
    // LocalDb localDB = LocalDb();
    // String? doctorId = await localDB.getDoctorId();
    // String? branchId = await localDB.getBranchId();
    // String? token = await localDB.getToken();
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updateInvestigationlist(
      await pmr.getInvestigations(),
    );
  }

  _getProcedures() async {
    LocalDb localDB = LocalDb();
    String? doctorId = await localDB.getDoctorId();
    String? branchId = await localDB.getBranchId();
    String? token = await localDB.getToken();
    Procedures1 p = Procedures1();
    controller.updateProcedureslist(
      await p.getProcedures(
        // "150",
        // doctorId,
        // '',
        // '',
        // branchId,
        // '',
        // token,
        "150",
        "956315e6-4a1e-4eaa-8a40-f0e9a04609f2",
        '',
        '',
        "5bd60354-fefd-4bcc-a58d-b8e27d802e85",
        '',
        "8f3609d2-0325-4c95-9af3-a872e5176497",
      ),
    );
  }

  _getInstruction() async {
    // LocalDb localDB = LocalDb();
    // String? doctorId = await localDB.getDoctorId();
    // String? branchId = await localDB.getBranchId();
    // String? token = await localDB.getToken();
    Instructions1 i = Instructions1();
    controller.updateInstructionlist(
      await i.getInstruction(
        // "150",
        // doctorId,
        // '',
        // '',
        // branchId,
        // '',
        // token,
        "150",
        "956315e6-4a1e-4eaa-8a40-f0e9a04609f2",
        '',
        '',
        "5bd60354-fefd-4bcc-a58d-b8e27d802e85",
        '',
        "8f3609d2-0325-4c95-9af3-a872e5176497",
      ),
    );
  }

  _getFollowup() async {
    // LocalDb localDB = LocalDb();
    // String? doctorId = await localDB.getDoctorId();
    // String? branchId = await localDB.getBranchId();
    // String? token = await localDB.getToken();
    FollowUps1 i = FollowUps1();
    controller.updateFollowuplist(
      await i.getFollowUps(
        // "150",
        // doctorId,
        // '',
        // '',
        // branchId,
        // '',
        // token,
        "150",
        "956315e6-4a1e-4eaa-8a40-f0e9a04609f2",
        '',
        '',
        "5bd60354-fefd-4bcc-a58d-b8e27d802e85",
        '',
        "8f3609d2-0325-4c95-9af3-a872e5176497",
      ),
    );
  }

  _getDiagnostics() async {
    // LocalDb localDB = LocalDb();
    // String? doctorId = await localDB.getDoctorId();
    // String? branchId = await localDB.getBranchId();
    // String? token = await localDB.getToken();
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updatediagnosticslist(
      await pmr.getDiagnostics(),
    );
  }

  // _getMedicines() async {
  //   // LocalDb localDB = LocalDb();
  //   // String? doctorId = await localDB.getDoctorId();
  //   // String? branchId = await localDB.getBranchId();
  //   // String? token = await localDB.getToken();
  //   Medicines1 m = Medicines1();
  //   controller.updateMedicinelist(
  //     await m.getMedicines(
  //       // "150",
  //       // doctorId,
  //       // '',
  //       // '',
  //       // branchId,
  //       // '',
  //       // token,
  //       "150",
  //       "956315e6-4a1e-4eaa-8a40-f0e9a04609f2",
  //       '',
  //       '',
  //       "5bd60354-fefd-4bcc-a58d-b8e27d802e85",
  //       '',
  //       "8f3609d2-0325-4c95-9af3-a872e5176497",
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    //   _getPatientDetail();
    _getComplaints();
    _getPrimaryDiagnosis();
    _getSecondaryDiagnosis();
    _getInvestigations();
    _getProcedures();
    _getInstruction();
    _getFollowup();
    _getDiagnostics();
    // _getMedicines();
  }

  @override
  void dispose() {
    super.dispose();
    controller.clearLists();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final ERXController controller = Get.put(ERXController());

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              AppImages.back,
            ),
          ),
          title: Text(
            'eRX',
            style: GoogleFonts.raleway(
              textStyle: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          automaticallyImplyLeading: true,
          elevation: 5,
          backgroundColor: ColorManager.kWhiteColor,
        ),
        body: GetBuilder<ERXController>(
          builder: (cont) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.helpful_background_logo),
                alignment: Alignment.center,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.06,
                    right: Get.width * 0.06,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text(
                        '   History',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),

                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          final item = items.first;
                          return Card(
                            elevation: 1,
                            child: CustomExpansionTile(
                              title: Padding(
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.04),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Name: ",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
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
                                        const Text(
                                          "Age: ",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
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
                                  ],
                                ),
                              ),
                              initiallyExpanded: false, // Start collapsed
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
                                          const Text(
                                            "Class: ",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
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
                                          const Text(
                                            "Section: ",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
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
                                          const Text(
                                            "Country: ",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
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
                                        height: Get.height * 0.01,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      Row(
                        children: [
                          Text(
                            'Smoker  ',
                            style: GoogleFonts.raleway(
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
                            style: GoogleFonts.raleway(
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
                              groupValue: controller.smokeryesSelected.value,
                              onChanged: (value) =>
                                  controller.smokerupdateYes(false),
                            ),
                          ),
                          Text(
                            'No',
                            style: GoogleFonts.raleway(
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
                            style: GoogleFonts.raleway(
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
                                  controller.diabeticupdateYes(true),
                            ),
                          ),
                          Text(
                            'Yes',
                            style: GoogleFonts.raleway(
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
                              groupValue: controller.diabeticyesSelected.value,
                              onChanged: (value) =>
                                  controller.diabeticupdateYes(true),
                            ),
                          ),
                          Text(
                            'No',
                            style: GoogleFonts.raleway(
                              textStyle: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),

                      // COMPLAINTS

                      Text(
                        '  Complaints',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          List<Complaints1> result =
                              await searchableDropdownCheckBox(
                                  context,
                                  controller.complaintsList,
                                  controller.selectedComplaintsList,
                                  false,
                                  'complaints');

                          controller.updateselectedComplaintsList(result);
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search',
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.search_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Display list
                      Visibility(
                        visible: controller.selectedComplaintsList.isNotEmpty,
                        child: Container(
                          width: Get.width * 0.88,
                          decoration: BoxDecoration(
                            color: ColorManager.kWhiteColor,
                            border: Border.all(
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  for (int index = 0;
                                      index <
                                          controller
                                              .selectedComplaintsList.length;
                                      index++)
                                    InkWell(
                                      onTap: () {
                                        String cid = controller
                                            .selectedComplaintsList[index].id!;
                                        deleteSelected(
                                            context,
                                            controller.selectedComplaintsList,
                                            cid,
                                            "complaints");
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: ColorManager.kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Text(
                                          controller
                                              .selectedComplaintsList[index]
                                              .name
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: ColorManager.kWhiteColor,
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

                      // PRIMARY DIAGNOSIS
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(
                        '  Primary Diagnosis',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          List<PrimaryDiagnosis1> result =
                              await searchableDropdownCheckBox(
                                  context,
                                  controller.primarydiagnosisList,
                                  controller.selectedprimarydiagnosisList,
                                  true,
                                  'primary');
                          controller.updateselectedPrimarydiagnosislist(result);
                          // for (int i = 0;
                          //     i <
                          //         controller
                          //             .selectedprimarydiagnosisList.length;
                          //     i++) {
                          //   String name = controller
                          //           .selectedprimarydiagnosisList[i].name ??
                          //       "";
                          //   print("name $name");
                          //   String comment = controller
                          //           .selectedprimarydiagnosisList[i].comments ??
                          //       "";
                          //   print("comment $comment");
                          // }
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search',
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.search_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Display list
                      Visibility(
                        visible:
                            controller.selectedprimarydiagnosisList.isNotEmpty,
                        child: Container(
                          width: Get.width * 0.88,
                          decoration: BoxDecoration(
                            color: ColorManager.kWhiteColor,
                            border: Border.all(
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Wrap(
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
                                            .selectedprimarydiagnosisList[index]
                                            .id!;
                                        deleteSelected(
                                            context,
                                            controller
                                                .selectedprimarydiagnosisList,
                                            cid,
                                            "pd");
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: ColorManager.kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Text(
                                          controller
                                              .selectedprimarydiagnosisList[
                                                  index]
                                              .name
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: ColorManager.kWhiteColor,
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

                      //SECONDARY DIAGNOSIS
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(
                        '  Secondary Diagnosis',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          List<SecondaryDiagnosis1> result =
                              await searchableDropdownCheckBox(
                                  context,
                                  controller.secondaryDiagnosisList,
                                  controller.selectedsecondaryDiagnosisList,
                                  true,
                                  'secondary');
                          controller
                              .updateselectedsecondaryDiagnosisList(result);
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search',
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.search_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Display list
                      Visibility(
                        visible: controller
                            .selectedsecondaryDiagnosisList.isNotEmpty,
                        child: Container(
                          width: Get.width * 0.88,
                          decoration: BoxDecoration(
                            color: ColorManager.kWhiteColor,
                            border: Border.all(
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: GetBuilder<ERXController>(builder: (cont) {
                            return Column(
                              children: <Widget>[
                                Wrap(
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
                                        child: Container(
                                          margin: const EdgeInsets.all(8.0),
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: ColorManager.kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Text(
                                            controller
                                                .selectedsecondaryDiagnosisList[
                                                    index]
                                                .name
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 8,
                                              color: ColorManager.kWhiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      ),

                      // DIAGNOSTICS
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(
                        '  Diagnostics',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          List<Diagnostics1> result =
                              await searchableDropdownCheckBox(
                                  context,
                                  controller.diagnosticsList,
                                  controller.selecteddiagnosticslist,
                                  false,
                                  'diagnostics');
                          controller.updateselectedDiagnosticsList(result);
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search',
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.search_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Display list
                      Visibility(
                        visible: controller.selecteddiagnosticslist.isNotEmpty,
                        child: Container(
                          width: Get.width * 0.88,
                          decoration: BoxDecoration(
                            color: ColorManager.kWhiteColor,
                            border: Border.all(
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  for (int index = 0;
                                      index <
                                          controller
                                              .selecteddiagnosticslist.length;
                                      index++)
                                    InkWell(
                                      onTap: () {
                                        String cid = controller
                                            .selecteddiagnosticslist[index].id!;
                                        deleteSelected(
                                            context,
                                            controller.selecteddiagnosticslist,
                                            cid,
                                            "diagnostics");
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: ColorManager.kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Text(
                                          controller
                                              .selecteddiagnosticslist[index]
                                              .name
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: ColorManager.kWhiteColor,
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
                      // INVESTIGATION
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(
                        '  Investigations',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          List<Investigations1> result =
                              await searchableDropdownCheckBox(
                                  context,
                                  controller.investigationList,
                                  controller.selectedinvestigationList,
                                  false,
                                  'investigation');
                          controller.updateselectedInvestigationList(result);
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search',
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.search_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Display list
                      Visibility(
                        visible:
                            controller.selectedinvestigationList.isNotEmpty,
                        child: Container(
                          width: Get.width * 0.88,
                          decoration: BoxDecoration(
                            color: ColorManager.kWhiteColor,
                            border: Border.all(
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  for (int index = 0;
                                      index <
                                          controller
                                              .selectedinvestigationList.length;
                                      index++)
                                    InkWell(
                                      onTap: () {
                                        String cid = controller
                                            .selectedinvestigationList[index]
                                            .id!;
                                        deleteSelected(
                                            context,
                                            controller
                                                .selectedinvestigationList,
                                            cid,
                                            'Investigations');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: ColorManager.kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Text(
                                          controller
                                              .selectedinvestigationList[index]
                                              .name
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: ColorManager.kWhiteColor,
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

                      // PROCEDURES
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(
                        '  Procedures',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          List<Procedures1> result =
                              await searchableDropdownCheckBox(
                                  context,
                                  controller.proceduresList,
                                  controller.selectedproceduresList,
                                  false,
                                  'procedures');

                          controller.updateselectedProceduresList(result);
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search',
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.search_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Display list
                      Visibility(
                        visible: controller.selectedproceduresList.isNotEmpty,
                        child: Container(
                          width: Get.width * 0.88,
                          decoration: BoxDecoration(
                            color: ColorManager.kWhiteColor,
                            border: Border.all(
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  for (int index = 0;
                                      index <
                                          controller
                                              .selectedproceduresList.length;
                                      index++)
                                    InkWell(
                                      onTap: () {
                                        String cid = controller
                                            .selectedproceduresList[index].id!;
                                        deleteSelected(
                                            context,
                                            controller.selectedproceduresList,
                                            cid,
                                            "procedures");
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: ColorManager.kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Text(
                                          controller
                                              .selectedproceduresList[index]
                                              .name
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: ColorManager.kWhiteColor,
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

                      // MEDICINES
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(
                        '  Medicines',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // String result = await addMedicine(
                          //   context,
                          //   controller.medicineList,
                          //   controller.selectedmedicineList,
                          //   controller.selectedmedicine,
                          // );
                          // controller.updateselectedmedicine(result);
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search',
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.search_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.selectedmedicineList.isNotEmpty,
                        child: Container(
                          width: Get.width * 0.88,
                          decoration: BoxDecoration(
                            color: ColorManager.kWhiteColor,
                            border: Border.all(
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  for (int index = 0;
                                      index <
                                          controller
                                              .selectedmedicineList.length;
                                      index++)
                                    InkWell(
                                      onTap: () {
                                        String cid = controller
                                            .selectedmedicineList[index].id!;
                                        deleteSelected(
                                            context,
                                            controller.selectedmedicineList,
                                            cid,
                                            "medicines");

                                        // MAKE OBJECT OF MEDICINE AND SEND IT TO DELETEMEDICINE ALERT NEW
                                        Medicines1 mobj = controller
                                            .selectedmedicineList[index];
                                        deleteSelectedMedicine(context, mobj);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: ColorManager.kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Text(
                                          controller
                                              .selectedmedicineList[index].name
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: ColorManager.kWhiteColor,
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

                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      // Findings
                      Text(
                        '  Findings',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      TextField(
                        controller: controller.findingsController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius as needed
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(
                                10.0), // Match the border radius
                          ),
                          hintText: 'Findings',
                        ),
                      ),

                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      // FOLLOW UP
                      Text(
                        '  Follow Up',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          // String? result = await searchableDropdownRadioButton(
                          //     context,
                          //     controller.selectedfollowup,
                          //     controller.followupList);
                          // controller.updateselectedfollowup(result!);
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search',
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.search_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Display list
                      Visibility(
                        //  visible: controller.selectedfollowup != '',
                        child: Container(
                          width: Get.width * 0.88,
                          decoration: BoxDecoration(
                            color: ColorManager.kWhiteColor,
                            border: Border.all(
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      deleteSelectedRadio(context);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: ColorManager.kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: const Text(
                                        //controller.selectedfollowup,
                                        "",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: ColorManager.kWhiteColor,
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

                      SizedBox(
                        height: Get.height * 0.02,
                      ),

                      //INSTRUCTION
                      Text(
                        '  Instructions',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          List<Instructions1> result =
                              await searchableDropdownCheckBox(
                                  context,
                                  controller.instructionList,
                                  controller.selectedinstructionList,
                                  false,
                                  'instruction');
                          controller.updateselectedInstructionList(result);
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search',
                                  style: GoogleFonts.raleway(
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.search_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Display list
                      Visibility(
                        visible: controller.selectedinstructionList.isNotEmpty,
                        child: Container(
                          width: Get.width * 0.88,
                          decoration: BoxDecoration(
                            color: ColorManager.kWhiteColor,
                            border: Border.all(
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  for (int index = 0;
                                      index <
                                          controller
                                              .selectedinstructionList.length;
                                      index++)
                                    InkWell(
                                      onTap: () {
                                        String cid = controller
                                            .selectedinstructionList[index].id!;
                                        deleteSelected(
                                            context,
                                            controller.selectedinstructionList,
                                            cid,
                                            "instructions");
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: ColorManager.kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Text(
                                          controller
                                              .selectedinstructionList[index]
                                              .name
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: ColorManager.kWhiteColor,
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

                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      // ADVICE
                      Text(
                        '  Advice',
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      TextField(
                        controller: controller.adviceController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius as needed
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(
                                10.0), // Match the border radius
                          ),
                          hintText: 'Advice',
                        ),
                      ),

                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrimaryButton(
                            radius: 20,
                            title: 'Hold',
                            fontSize: 12,
                            height: Get.height * 0.06,
                            width: Get.width * 0.4,
                            onPressed: () async {
                              // ADVICE
                              String advice = controller.adviceController.text;
                              print(advice);

                              // FINDINGS
                              String findings =
                                  controller.findingsController.text;
                              print(findings);
                              // SHARED PREFERENCE DATA
                              LocalDb localDB = LocalDb();
                              String? doctorId = await localDB.getDoctorId();
                              String? branchId = await localDB.getBranchId();
                              String? token = await localDB.getToken();
                              print('3');
                              //  COMPLAINTS IDS
                              List<String> complaintsIds = [];
                              for (int i = 0;
                                  i < controller.selectedComplaintsList.length;
                                  i++) {
                                String cid =
                                    controller.selectedComplaintsList[i].id ??
                                        "";
                                complaintsIds.add(cid);
                              }
                              print('5');
                              //  DIAGNOSTICS IDS
                              List<String> diagnosticsIds = [];
                              for (int i = 0;
                                  i < controller.selecteddiagnosticslist.length;
                                  i++) {
                                String did =
                                    controller.selecteddiagnosticslist[i].id ??
                                        "";
                                diagnosticsIds.add(did);
                              }
                              print('5');
                              // FOLLOW UP
                              // String followupname = controller.selectedfollowup;
                              FollowUps1? followupWithMatchingName;
                              try {
                                // followupWithMatchingName =
                                //     controller.followupList.firstWhere(
                                //   (followup) => followup.name == followupname,
                                // );
                              } catch (e) {
                                followupWithMatchingName = null;
                              }
                              String followupid =
                                  followupWithMatchingName?.id ?? "";
                              print(followupid);

                              print('6');
                              //INVESTIGATION
                              List<String> investigationIds = [];
                              for (int i = 0;
                                  i <
                                      controller
                                          .selectedinvestigationList.length;
                                  i++) {
                                String iid = controller
                                        .selectedinvestigationList[i].id ??
                                    "";
                                investigationIds.add(iid);
                              }
                              print('7');
                              //PROCEDURES
                              List<String> proceduresIds = [];
                              for (int i = 0;
                                  i < controller.selectedproceduresList.length;
                                  i++) {
                                String pid =
                                    controller.selectedproceduresList[i].id ??
                                        "";
                                proceduresIds.add(pid);
                              }
                              print('8');
                              // INSTRUCTION
                              List<String> instructionIds = [];
                              for (int i = 0;
                                  i < controller.selectedinstructionList.length;
                                  i++) {
                                String iid =
                                    controller.selectedinstructionList[i].id ??
                                        "";
                                instructionIds.add(iid);
                              }
                              print('9');
                              // PRIMARY DIAGNOSIS

                              for (int i = 0;
                                  i <
                                      controller
                                          .selectedprimarydiagnosisList.length;
                                  i++) {
                                print(controller
                                    .selectedprimarydiagnosisList[i].id);
                                print(controller
                                    .selectedprimarydiagnosisList[i].name);
                                print(controller
                                    .selectedprimarydiagnosisList[i].comments);
                              }

                              print('10');
                              // SECONDARY DIAGNOSIS

                              for (int i = 0;
                                  i <
                                      controller.selectedsecondaryDiagnosisList
                                          .length;
                                  i++) {
                                print(controller
                                    .selectedsecondaryDiagnosisList[i].id);
                                print(controller
                                    .selectedsecondaryDiagnosisList[i].name);
                                print(controller
                                    .selectedsecondaryDiagnosisList[i]
                                    .comments);
                              }

                              // END
                            },
                            color: ColorManager.kPrimaryColor,
                            textcolor: ColorManager.kWhiteColor,
                          ),
                          PrimaryButton(
                            radius: 20,
                            title: 'Consult',
                            fontSize: 12,
                            height: Get.height * 0.06,
                            width: Get.width * 0.4,
                            onPressed: () {
                              Get.back();
                            },
                            color: ColorManager.kPrimaryColor,
                            textcolor: ColorManager.kWhiteColor,
                          ),
                        ],
                      ),
                      // END
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
