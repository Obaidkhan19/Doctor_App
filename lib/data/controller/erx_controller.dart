import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/models/complaints.dart';
import 'package:doctormobileapplication/models/diagnostics.dart';
import 'package:doctormobileapplication/models/finding.dart';
import 'package:doctormobileapplication/models/followups.dart';
import 'package:doctormobileapplication/models/instruction.dart';
import 'package:doctormobileapplication/models/investigation.dart';
import 'package:doctormobileapplication/models/lab_test_dropdown.dart';
import 'package:doctormobileapplication/models/medicines.dart';
import 'package:doctormobileapplication/models/patient_detail.dart';
import 'package:doctormobileapplication/models/primary_diagnosis.dart';
import 'package:doctormobileapplication/models/procedures.dart';
import 'package:doctormobileapplication/models/secondart_diagnosis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ERXController extends GetxController implements GetxService {
  static ERXController get i => Get.put(ERXController());
  FocusNode mycomplaintfocus = FocusNode();
  FocusNode findingfocus = FocusNode();
  FocusNode qtyfocus = FocusNode();
  FocusNode medicinefocus = FocusNode();
  FocusNode notesfocus = FocusNode();
  unfocus() {
    mycomplaintfocus.unfocus();
    findingfocus.unfocus();
    qtyfocus.unfocus();
    medicinefocus.unfocus();
    notesfocus.unfocus();
    update();
  }

  TextEditingController findingsController = TextEditingController();
  TextEditingController adviceController = TextEditingController();
  TextEditingController complaintController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  List<Complaints1> complaintList = [];
  updateComplaintList(Complaints1 complaint) {
    String name = complaint.name?.trim() ?? "";

    if (name.isEmpty) {
      showSnackbar(Get.context!, 'Complaint cannot be empty');
    } else if (complaintList
        .any((existingComplaint) => existingComplaint.name == name)) {
      showSnackbar(Get.context!, 'Already Added'.tr);
    } else {
      complaintList.add(complaint);
      complaintController.clear();
    }
    update();
  }

  deleteComplaintList(String id) {
    complaintList.removeWhere((element) => element.id == id);
    update();
  }

  List<Finding> findingList = [];
  updatefindingList(Finding finding) {
    String name = finding.name!.trim();
    if (name.isEmpty) {
      showSnackbar(Get.context!, 'finding cannot be empty');
    } else if (findingList
        .any((existingFinding) => existingFinding.name == name)) {
      showSnackbar(Get.context!, 'Already Added');
    } else {
      findingList.add(finding);
      findingsController.clear();
    }
    update();
  }

  deleteFindingList(String id) {
    findingList.removeWhere((element) => element.id == id);
    update();
  }

  RxBool smokeryesSelected = false.obs;
  RxBool smokernoSelected = false.obs;

  void smokerupdateYes(bool value) {
    smokeryesSelected.value = value;
    smokernoSelected.value = !value;
  }

  void smokerupdateNo(bool value) {
    smokernoSelected.value = value;
    smokeryesSelected.value = !value;
  }

  RxBool diabeticyesSelected = false.obs;
  RxBool diabeticnoSelected = false.obs;

  void diabeticupdateYes(bool value) {
    diabeticyesSelected.value = value;
    diabeticnoSelected.value = !value;
  }

  void diabeticupdateNo(bool value) {
    diabeticnoSelected.value = value;
    diabeticyesSelected.value = !value;
  }

// CLEAR LISTS
  clearLists() {
    selectedComplaintsList.clear();
    selectedprimarydiagnosisList.clear();
    selectedsecondaryDiagnosisList.clear();
    selecteddiagnosticslist.clear();
    selectedinvestigationList.clear();
    selectedproceduresList.clear();
    selectedinstructionList.clear();
    selectedfollowup == '';
    selectedmedicineList.clear();
    selectedmedicine == '';
    complaintList.clear();

    findingsController.clear();
    adviceController.clear();
    complaintController.clear();
    noteController.clear();
    medicineController.clear();
    qtyController.clear();

    update();
  }

// PATIENT DATA
  List<PatientDetail1> patientList = [];
  updatepatientdata(List<PatientDetail1> plist) {
    patientList = plist;
    update();
  }

  // COMPLAINT DATA
  List<Complaints1> complaintsList = [];
  List<Complaints1> selectedComplaintsList = [];

  updatecomplaintdata(List<Complaints1> clist) {
    complaintsList = clist;
    update();
  }

  addCompaint(Complaints1 c, ctx) {
    if (selectedComplaintsList.contains(c)) {
      showSnackbar(ctx, "Already Added");
    }
    selectedComplaintsList.add(c);
    update();
  }

  updateselectedComplaintsList(List<Complaints1> cmplist) {
    selectedComplaintsList = cmplist;
    update();
  }

  deleteSelectedComplaintsList(String id) {
    selectedComplaintsList.removeWhere((element) => element.id == id);
    update();
  }

  TextEditingController trailingtextController = TextEditingController();

  // PRIMARY DIAGNOSIS DATA
  List<PrimaryDiagnosis1> primarydiagnosisList = [];
  List<PrimaryDiagnosis1> selectedprimarydiagnosisList = [];
  updatePrimarydiagnosislist(List<PrimaryDiagnosis1> pdlist) {
    primarydiagnosisList = pdlist;
    update();
  }

  updateselectedPrimarydiagnosislist(List<PrimaryDiagnosis1> pdlist) {
    selectedprimarydiagnosisList = pdlist;
    update();
  }

  void updateprimarycomments(String id, String comment) {
    final itemToUpdate = selectedprimarydiagnosisList.firstWhere(
      (item) => item.id == id,
      orElse: () => PrimaryDiagnosis1(),
    );
    itemToUpdate.comments = comment;
    trailingtextController.clear();
    update();
  }

  updateprimaryDiagnosis(List<PrimaryDiagnosis1> pdlist) {
    selectedprimarydiagnosisList = pdlist;
    update();
  }

  deleteselectedprimarydiagnosisList(String id) {
    selectedprimarydiagnosisList.removeWhere((element) => element.id == id);
    update();
  }

  // SECONDAY DIAGNOSIS DATA
  List<SecondaryDiagnosis1> secondaryDiagnosisList = [];
  List<SecondaryDiagnosis1> selectedsecondaryDiagnosisList = [];
  updateSecondarydiagnosislist(List<SecondaryDiagnosis1> sdlist) {
    secondaryDiagnosisList = sdlist;
    update();
  }

  updateselectedsecondaryDiagnosisList(List<SecondaryDiagnosis1> sdlist) {
    selectedsecondaryDiagnosisList = sdlist;
    update();
  }

  deleteselectedsecondaryDiagnosisList(String id) {
    selectedsecondaryDiagnosisList.removeWhere((element) => element.id == id);
    update();
  }

  void updatesecondartcomments(String id, String comment) {
    final itemToUpdate = selectedsecondaryDiagnosisList.firstWhere(
      (item) => item.id == id,
      orElse: () => SecondaryDiagnosis1(),
    );
    itemToUpdate.comments = comment;
    trailingtextController.clear();
    update();
  }

  // COMPLAINTS

  // INVESTIGATION DATA
  List<Investigations1> investigationList = [];
  List<Investigations1> selectedinvestigationList = [];
  Investigations1? selectedinvestigation;
  updateInvestigationlist(List<Investigations1> ilist) {
    investigationList = ilist;
    update();
  }

  addInvestigation() {
    if (selectedinvestigationList.contains(selectedinvestigation)) {
      showSnackbar(Get.context!, ' Already Selected');
    } else {
      selectedinvestigationList.add(selectedinvestigation!);
    }
    update();
  }

  updateinvestigation(Investigations1 investigations1) {
    selectedinvestigation = investigations1;
    update();
  }

  updateselectedInvestigationList(List<Investigations1> ilist) {
    selectedinvestigationList = ilist;
    update();
  }

  deleteselectedInvestigationList(String id) {
    selectedinvestigationList.removeWhere((element) => element.id == id);
    update();
  }

  // PROCEDURES DATA
  List<Procedures1> proceduresList = [];
  List<Procedures1> selectedproceduresList = [];
  updateProcedureslist(List<Procedures1> plist) {
    proceduresList = plist;
    update();
  }

  updateselectedProceduresList(List<Procedures1> plist) {
    selectedproceduresList = plist;
    update();
  }

  deleteSelectedProceduresList(String id) {
    selectedproceduresList.removeWhere((element) => element.id == id);
    update();
  }

  // INSTRUCTION DATA
  List<Instructions1> instructionList = [];
  List<Instructions1> selectedinstructionList = [];
  updateInstructionlist(List<Instructions1> ilist) {
    instructionList = ilist;
    update();
  }

  updateselectedInstructionList(List<Instructions1> ilist) {
    selectedinstructionList = ilist;
    update();
  }

  deleteSelectedinstructionList(String id) {
    selectedinstructionList.removeWhere((element) => element.id == id);
    update();
  }

  // FOLLOW UP DATA
  List<FollowUps1> followupList = [];
  String selectedfollowup = "";
  updateFollowuplist(List<FollowUps1> fuplist) {
    followupList = fuplist;
    update();
  }

  updateselectedfollowup(String followup) {
    selectedfollowup = followup;
    update();
  }

  deleteSelectedfollowup() {
    selectedfollowup = "";
    update();
  }

  // DIAGNOSTICS DATA
  List<Diagnostics1> diagnosticsList = [];
  List<Diagnostics1> selecteddiagnosticslist = [];
  Diagnostics1? selecteddiagnostics;

  updatediagnostics(Diagnostics1 diagnostics1) {
    selecteddiagnostics = diagnostics1;
    update();
  }

  addDiagnostics() {
    if (selecteddiagnosticslist.contains(selecteddiagnostics)) {
      showSnackbar(Get.context!, ' Already Selected');
    } else {
      selecteddiagnosticslist.add(selecteddiagnostics!);
    }
    update();
  }

  updatediagnosticslist(List<Diagnostics1> dlist) {
    diagnosticsList = dlist;
    update();
  }

  updateselectedDiagnosticsList(List<Diagnostics1> dlist) {
    selecteddiagnosticslist = dlist;
    update();
  }

  deleteSelecteddiagnosticsList(String id) {
    selecteddiagnosticslist.removeWhere((element) => element.id == id);
    update();
  }

  // MEDICINES DATA
  List<Medicines1> medicineList = [];
  List<Medicines1> selectedmedicineList = [];
  updateMedicinelist(List<Medicines1> mlist) {
    // medicineList.clear();
    medicineList = mlist;
    update();
  }

  updateselectedMedicineList(List<Medicines1> mlist) {
    selectedmedicineList = mlist;
    update();
  }

  deleteSelectedmedicineList(String id) {
    selectedmedicineList.removeWhere((element) => element.id == id);
    update();
  }

  String selectedmedicine = '';

  updateselectedmedicine(String med) {
    selectedmedicine = med;
    update();
  }
}
