import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/models/advice.dart';
import 'package:doctormobileapplication/models/complaints.dart';
import 'package:doctormobileapplication/models/diagnostics.dart';
import 'package:doctormobileapplication/models/erns_history.dart';
import 'package:doctormobileapplication/models/finding.dart';
import 'package:doctormobileapplication/models/findings.dart';
import 'package:doctormobileapplication/models/followups.dart';
import 'package:doctormobileapplication/models/instruction.dart';
import 'package:doctormobileapplication/models/investigation.dart';
import 'package:doctormobileapplication/models/medicine_matrix.dart';
import 'package:doctormobileapplication/models/medicines.dart';
import 'package:doctormobileapplication/models/pastMedicine.dart';
import 'package:doctormobileapplication/models/patient_detail.dart';
import 'package:doctormobileapplication/models/primary_diagnosis.dart';
import 'package:doctormobileapplication/models/procedures.dart';
import 'package:doctormobileapplication/models/secondart_diagnosis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/models/medicincematrix.dart' as med;

class ERXController extends GetxController implements GetxService {
  static ERXController get i => Get.put(ERXController());

  List<dynamic> deletedidlist = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  updateIsloading(bool value) {
    _isLoading = value;
    update();
  }

  FocusNode mycomplaintfocus = FocusNode();
  FocusNode findingfocus = FocusNode();
  FocusNode qtyfocus = FocusNode();
  FocusNode medicinefocus = FocusNode();
  FocusNode notesfocus = FocusNode();

  int medindex = 0;
  med.MedicineFrequencies? medicineFrequencies;
  med.DateList? dateList;
  med.DayList? dayList;
  med.MedicineEventList? medicineEventList;
  med.MedicineDosages? medicineDosages;
  med.MedicineRoutes? medicineRoutes;

  updatemedfrequency(med.MedicineFrequencies freq) {
    medicineFrequencies = freq;
    update();
  }

  updatedayList(med.DayList freq) {
    dayList = freq;
    update();
  }

  updateDateList(med.DateList freq) {
    dateList = freq;
    update();
  }

  updateMedicineEventList(med.MedicineEventList freq) {
    medicineEventList = freq;
    update();
  }

  updatemedicineDosages(med.MedicineDosages freq) {
    medicineDosages = freq;
    update();
  }

  updatemedicineroutes(med.MedicineRoutes freq) {
    medicineRoutes = freq;
    update();
  }

  updateselectedlst(med.medicinematric dt) {
    selectedlst = dt;
    update();
  }

  med.medicinematric selectedlst = med.medicinematric(
      dateList: [],
      dayList: [],
      medicineDosages: [],
      medicineEventList: [],
      medicineFrequencies: [],
      medicineRoutes: []);
  med.medicinematric medicinelst = med.medicinematric(
      dateList: [],
      dayList: [],
      medicineDosages: [],
      medicineEventList: [],
      medicineFrequencies: [],
      medicineRoutes: []);

  updatemedindex() {
    medindex += 1;
    update();
  }

  List<String> deletedmedicineList = [];
  removefinalmedindex(int index) {
    deletedmedicineList.add(finalmedicinellist[index].id!);
    selectedlst.dateList?.removeAt(index);
    selectedlst.dayList?.removeAt(index);
    selectedlst.medicineRoutes?.removeAt(index);
    selectedlst.medicineFrequencies?.removeAt(index);
    selectedlst.medicineDosages?.removeAt(index);
    finalmedicinellist.removeAt(index);

    update();
  }

  updateselectedduration(med.DayList data, med.DateList d) {
    med.DayList route = data;
    med.DateList r = d;
    if (selectedlst.dayList!.isEmpty) {
      selectedlst.dateList!.add(r);
      selectedlst.dayList!.add(route);
    } else {
      if (selectedlst.dayList!.length >= medindex) {
        selectedlst.dayList!.last = route;
        selectedlst.dateList!.last = r;
      } else {
        selectedlst.dateList!.add(r);
        selectedlst.dayList!.add(route);
      }
    }
    update();
  }

  updateselectedmedicince(med.MedicineRoutes data) {
    med.MedicineRoutes route = data;

    if (selectedlst.medicineRoutes!.isEmpty) {
      selectedlst.medicineRoutes!.add(route);
    } else {
      if (selectedlst.medicineRoutes!.length >= medindex) {
        selectedlst.medicineRoutes!.last = route;
      } else {
        selectedlst.medicineRoutes!.add(route);
      }
    }
    update();
  }

  updateselecteddosages(med.MedicineDosages data) {
    med.MedicineDosages route = data;

    if (selectedlst.medicineDosages!.isEmpty) {
      selectedlst.medicineDosages!.add(route);
    } else {
      if (selectedlst.medicineDosages!.length >= medindex) {
        selectedlst.medicineDosages!.last = route;
      } else {
        selectedlst.medicineDosages!.add(route);
      }
    }
    update();
  }

  updateselectedfrequency(med.MedicineFrequencies data) {
    med.MedicineFrequencies route = data;

    if (selectedlst.medicineFrequencies!.isEmpty) {
      selectedlst.medicineFrequencies!.add(route);
    } else {
      if (selectedlst.medicineFrequencies!.length >= medindex) {
        selectedlst.medicineFrequencies!.last = route;
      } else {
        selectedlst.medicineFrequencies!.add(route);
      }
    }

    update();
  }

  updatemedicinelist(med.medicinematric data) {
    medicinelst = data;
    update();
  }

  unfocus() {
    mycomplaintfocus.unfocus();
    findingfocus.unfocus();
    qtyfocus.unfocus();
    medicinefocus.unfocus();
    notesfocus.unfocus();
    update();
  }

  medicineMatrix? medicedata;

  updatemedicinedata(medicineMatrix dt) {
    medicedata = dt;
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
  void smokerupdateYes(bool value) {
    smokeryesSelected.value = value;
  }

  RxBool diabeticyesSelected = false.obs;
  void diabeticupdateYes(bool value) {
    diabeticyesSelected.value = value;
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
    selectedmedicineList.clear();
    selectedmedicine == '';
    complaintList.clear();
    findingsController.clear();
    adviceController.clear();
    complaintController.clear();
    noteController.clear();
    medicineController.clear();
    qtyController.clear();
    deletedComplaintsList.clear();
    deletedprimarydiagnosisList.clear();
    deletedsecondarydiagnosisList.clear();
    deleteddiagnosticsList.clear();
    deletedinstructionList.clear();
    deletedinvestigationList.clear();
    deletedproceduresList.clear();
    deletedmedicineList.clear();
    finalmedicinellist.clear();
    selectedlst.dateList!.clear();
    selectedlst.medicineFrequencies!.clear();
    selectedlst.medicineRoutes!.clear();
    selectedlst.medicineDosages!.clear();

    // smoker and diabetic false

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
  List<Complaints1> checkboxselectedcomplaintssList = [];
  List<String> deletedComplaintsList = [];

  updatecomplaintdata(List<Complaints1> clist) {
    complaintsList = clist;
    update();
  }

  // addCompaint(Complaints1 c, ctx) {
  //   if (selectedComplaintsList.contains(c)) {
  //     showSnackbar(ctx, "Already Added");
  //   }
  //   selectedComplaintsList.add(c);
  //   update();
  // }

  updateselectedComplaintsList(List<Complaints1> cmplist) {
    selectedComplaintsList = cmplist;
    checkboxselectedcomplaintssList = cmplist;
    update();
  }

  deleteSelectedComplaintsList(String id) {
    selectedComplaintsList.removeWhere((element) => element.id == id);
    deletedComplaintsList.add(id);
    update();
  }

  TextEditingController trailingtextController = TextEditingController();

  // PRIMARY DIAGNOSIS DATA
  List<PrimaryDiagnosis1> primarydiagnosisList = [];
  List<PrimaryDiagnosis1> selectedprimarydiagnosisList = [];
  List<PrimaryDiagnosis1> checkboxselectedprimarydiagnosisList = [];
  List<String> deletedprimarydiagnosisList = [];
  updatePrimarydiagnosislist(List<PrimaryDiagnosis1> pdlist) {
    primarydiagnosisList = pdlist;
    update();
  }

  addPrimaryDiagnosis(PrimaryDiagnosis1 c, ctx) {
    if (selectedprimarydiagnosisList.contains(c)) {
      showSnackbar(ctx, "Already Added");
    }
    selectedprimarydiagnosisList.add(c);
    update();
  }

// ON SAVE BUTTON
  updateselectedPrimarydiagnosislist(List<PrimaryDiagnosis1> pdlist) {
    selectedprimarydiagnosisList = pdlist;
    checkboxselectedprimarydiagnosisList = pdlist;

    update();
  }

  void updateprimarycomments(String id, String comment) {
    final itemToUpdate = checkboxselectedprimarydiagnosisList.firstWhere(
      (item) => item.id == id,
      orElse: () => PrimaryDiagnosis1(),
    );
    itemToUpdate.comments = comment;
    trailingtextController.clear();
    update();
  }

  deleteselectedprimarydiagnosisList(String id) {
    selectedprimarydiagnosisList.removeWhere((element) => element.id == id);
    deletedprimarydiagnosisList.add(id);
    update();
  }

  // SECONDAY DIAGNOSIS DATA
  List<SecondaryDiagnosis1> secondaryDiagnosisList = [];
  List<SecondaryDiagnosis1> checkboxselectedsecondarydiagnosisList = [];
  List<SecondaryDiagnosis1> selectedsecondaryDiagnosisList = [];
  List<String> deletedsecondarydiagnosisList = [];
  updateSecondarydiagnosislist(List<SecondaryDiagnosis1> sdlist) {
    secondaryDiagnosisList = sdlist;
    update();
  }

  addsecondaryDiagnosis(SecondaryDiagnosis1 c, ctx) {
    if (selectedsecondaryDiagnosisList.contains(c)) {
      showSnackbar(ctx, "Already Added");
    }
    selectedsecondaryDiagnosisList.add(c);
    update();
  }

// ON SAVE BUTTON
  updateselectedsecondarydiagnosislist(List<SecondaryDiagnosis1> sdlist) {
    selectedsecondaryDiagnosisList = sdlist;
    checkboxselectedsecondarydiagnosisList = sdlist;
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

  deleteselectedsecondaryDiagnosisList(String id) {
    selectedsecondaryDiagnosisList.removeWhere((element) => element.id == id);
    deletedsecondarydiagnosisList.add(id);
    update();
  }

  // COMPLAINTS

  // INVESTIGATION DATA
  List<Investigations1> investigationList = [];
  List<Investigations1> selectedinvestigationList = [];
  // Investigations1? selectedinvestigation;
  List<Investigations1> checkboxselectedinvestigationList = [];
  List<String> deletedinvestigationList = [];
  updateInvestigationlist(List<Investigations1> ilist) {
    investigationList = ilist;
    update();
  }

  addInvestigation(Investigations1 c, ctx) {
    if (selectedinvestigationList.contains(c)) {
      showSnackbar(ctx, "Already Added");
    }
    selectedinvestigationList.add(c);
    update();
  }

  updateselectedInvestigationList(List<Investigations1> ilist) {
    selectedinvestigationList = ilist;
    checkboxselectedinvestigationList = ilist;
    update();
  }

  deleteselectedInvestigationList(String id) {
    selectedinvestigationList.removeWhere((element) => element.id == id);
    deletedinvestigationList.add(id);
    update();
  }

  // PROCEDURES DATA
  List<Procedures1> proceduresList = [];
  List<Procedures1> selectedproceduresList = [];
  List<Procedures1> checkboxselectedproceduresList = [];
  List<String> deletedproceduresList = [];
  updateProcedureslist(List<Procedures1> plist) {
    proceduresList = plist;
    update();
  }

  addprocedures(Procedures1 c, ctx) {
    if (selectedproceduresList.contains(c)) {
      showSnackbar(ctx, "Already Added");
    }
    selectedproceduresList.add(c);
    update();
  }

  updateselectedProceduresList(List<Procedures1> plist) {
    selectedproceduresList = plist;
    checkboxselectedproceduresList = plist;
    update();
  }

  deleteSelectedProceduresList(String id) {
    selectedproceduresList.removeWhere((element) => element.id == id);
    deletedproceduresList.add(id);
    update();
  }

  // INSTRUCTION DATA
  List<Instructions1> instructionList = [];
  List<Instructions1> checkboxselectedinstructionList = [];
  List<Instructions1> selectedinstructionList = [];
  List<String> deletedinstructionList = [];
  updateInstructionlist(List<Instructions1> ilist) {
    instructionList = ilist;
    update();
  }

  addinstructions(Instructions1 c, ctx) {
    if (selectedinstructionList.contains(c)) {
      showSnackbar(ctx, "Already Added");
    }
    selectedinstructionList.add(c);
    update();
  }

  updateselectedInstructionList(List<Instructions1> ilist) {
    selectedinstructionList = ilist;
    checkboxselectedinstructionList = ilist;
    update();
  }

  deleteSelectedinstructionList(String id) {
    selectedinstructionList.removeWhere((element) => element.id == id);
    deletedinstructionList.add(id);
    update();
  }

  // FOLLOW UP DATA
  List<FollowUps1> followupList = [];

  FollowUps1? selectedfup;
  updateFollowuplist(List<FollowUps1> fuplist) {
    followupList = fuplist;
    update();
  }

  deletefollowup() {
    selectedfup = FollowUps1(name: "", id: "");
    update();
  }

  addfollowup(FollowUps1 f) {
    selectedfup = f;
    update();
  }

  // ADVICE

  Advices? selecteadvice;

  deleteadvice() {
    selecteadvice = Advices();
    update();
  }

  addadvice(Advices a) {
    selecteadvice = a;
    noteController.text = selecteadvice?.advice ?? "Advice";
    update();
  }

  // Findings

  ExamFindings? selectefindings;

  deletefindings() {
    selectefindings = ExamFindings();
    update();
  }

  addfindings(ExamFindings a) {
    selectefindings = a;
    findingsController.text = selectefindings?.examFinding ?? "Findings";
    update();
  }

  // DIAGNOSTICS DATA
  List<Diagnostics1> diagnosticsList = [];
  List<Diagnostics1> selecteddiagnosticslist = [];
  List<Diagnostics1> checkboxselectediagnosticsList = [];
  List<String> deleteddiagnosticsList = [];
  updatediagnosticslist(List<Diagnostics1> dlist) {
    diagnosticsList = dlist;
    update();
  }

  addDiagnostics(Diagnostics1 c, ctx) {
    if (selecteddiagnosticslist.contains(c)) {
      showSnackbar(ctx, "Already Added");
    }
    selecteddiagnosticslist.add(c);
    update();
  }

  updateselectedDiagnosticsList(List<Diagnostics1> dlist) {
    selecteddiagnosticslist = dlist;
    checkboxselectediagnosticsList = dlist;
    update();
  }

  deleteSelecteddiagnosticsList(String id) {
    selecteddiagnosticslist.removeWhere((element) => element.id == id);
    deleteddiagnosticsList.add(id);
    update();
  }

  // MEDICINES DATA
  List<Medicines1> medicineList = [];
  List<Medicines1> selectedmedicineList = [];

  List<Medicines1> finalmedicinellist = [];

  updatefinalmed(Medicines1 m1) {
    finalmedicinellist.add(m1);
    update();
  }

  updateMedicinelist(List<Medicines1> mlist) {
    medicineList = mlist;
    update();
  }

  addmedicines(Medicines1 c, ctx) {
    if (selectedmedicineList.contains(c)) {
      showSnackbar(ctx, "Already Added");
    }
    selectedmedicineList.add(c);

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

  // =========== ERNS HISTORY

  String historycomplaint = '';
  List<ComplaintsHistory> complaintsHistoryList = [];
  updatecomplainthistorydata(List<ComplaintsHistory> clist) {
    complaintsHistoryList = clist;
    List<String> names = [];
    for (int i = 0; i < complaintsHistoryList.length; i++) {
      names.add(complaintsHistoryList[i].name ?? '');
    }
    historycomplaint = names.join(', ');
    update();
  }

  String historyprimarydiagnosis = '';
  List<PrimaryDiagnosisHistory> primarydiagnosisHistoryList = [];
  updateprimarydiagnosishistorydata(List<PrimaryDiagnosisHistory> clist) {
    primarydiagnosisHistoryList = clist;

    List<String> names = [];

    for (int i = 0; i < primarydiagnosisHistoryList.length; i++) {
      names.add(primarydiagnosisHistoryList[i].genericName ?? '');
    }
    historyprimarydiagnosis = names.join(', ');
    update();
  }

  String historyprecedures = '';
  List<PrceduresHistory> prceduresHistoryList = [];
  updateprcedureshistorydata(List<PrceduresHistory> clist) {
    prceduresHistoryList = clist;

    List<String> names = [];

    for (int i = 0; i < prceduresHistoryList.length; i++) {
      names.add(prceduresHistoryList[i].genericName ?? '');
    }
    historyprecedures = names.join(', ');
    update();
  }

  String historydiagnostics = '';
  List<DiagnosticsHistory> diagnosticsHistoryList = [];
  updatediagnosticshistorydata(List<DiagnosticsHistory> clist) {
    diagnosticsHistoryList = clist;

    List<String> names = [];

    for (int i = 0; i < diagnosticsHistoryList.length; i++) {
      names.add(diagnosticsHistoryList[i].name ?? '');
    }
    historydiagnostics = names.join(', ');
    update();
  }

  String historyinvestigation = '';
  List<InvestigationsHistory> investigationHistoryList = [];
  updateinvestigationistorydata(List<InvestigationsHistory> clist) {
    investigationHistoryList = clist;

    List<String> names = [];

    for (int i = 0; i < investigationHistoryList.length; i++) {
      names.add(investigationHistoryList[i].name ?? '');
    }
    historyinvestigation = names.join(', ');
    update();
  }

  String historyvitals = '';
  List<VitalsHistory> vitalsHistoryList = [];
  updatevitalshistorydata(List<VitalsHistory> clist) {
    vitalsHistoryList = clist;
    List<String> names = [];
    for (int i = 0; i < vitalsHistoryList.length; i++) {
      names.add(vitalsHistoryList[i].name ?? '');
    }
    historyvitals = names.join(', ');
    update();
  }

  // patient detail for prescription

  List<PatientDetail1> patientdeailprescriptionList = [];

  PatientDetail1? selectedpatientdeailprescription;
  updatepatientdeailprescriptionList(List<PatientDetail1> plist) {
    patientdeailprescriptionList = plist;

    // update radio
    if (plist[0].smoker == 0) {
      smokeryesSelected = false.obs;
    } else if (plist[0].smoker == 1) {
      smokeryesSelected = true.obs;
    }

    if (plist[0].diabetic == 0) {
      diabeticyesSelected = false.obs;
    } else if (plist[0].diabetic == 1) {
      diabeticyesSelected = true.obs;
    }

    update();
  }

  List<Medicinesss1> pastmedicineList = [];
  updatePastmedicineList(List<Medicinesss1> pmlist) {
    List<med.DateList> datelist = [];
    List<med.DayList> daylist = [];
    List<med.MedicineFrequencies> freq = [];
    List<med.MedicineDosages> dosage = [];
    List<med.MedicineRoutes> routes = [];
    pastmedicineList = pmlist;
    for (int i = 0; i < pmlist.length; i++) {
      finalmedicinellist.add(
          Medicines1(id: pmlist[i].eRNSId, medicine: pmlist[i].medicineName));
      dosage.add(med.MedicineDosages(
          id: pmlist[i].medicineDosageId,
          dosageValue: pmlist[i].dosageValue.toString()));
      freq.add(med.MedicineFrequencies(
          quantity: pmlist[i].frequencyQuantity.toString(),
          numericDisplay: pmlist[i].frequencyNumeric));
      datelist.add(med.DateList(
        id: pmlist[i].medicineEventTimingId,
        englishCounting: pmlist[i].englishCounting,
      ));
      daylist.add(med.DayList(
        id: pmlist[i].dateId,
        englishDay: pmlist[i].englishDay,
      ));
      routes.add(med.MedicineRoutes(
        id: pmlist[i].medicineRouteId,
        englishDefinition: pmlist[i].routeName,
      ));
      // finalmedicinellist.add(pmlist[i].)
    }

    selectedlst = med.medicinematric(
      dateList: datelist,
      dayList: daylist,
      medicineDosages: dosage,
      medicineRoutes: routes,
      medicineFrequencies: freq,
    );
    update();
  }
}
