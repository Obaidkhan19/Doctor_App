import 'dart:convert';
import 'package:doctormobileapplication/data/controller/erx_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/advice.dart';
import 'package:doctormobileapplication/models/complaints.dart';
import 'package:doctormobileapplication/models/diagnostics.dart';
import 'package:doctormobileapplication/models/erns_history.dart';
import 'package:doctormobileapplication/models/findings.dart';
import 'package:doctormobileapplication/models/followups.dart';
import 'package:doctormobileapplication/models/instruction.dart';
import 'package:doctormobileapplication/models/investigation.dart';
import 'package:doctormobileapplication/models/medicincematrix.dart';
import 'package:doctormobileapplication/models/medicines.dart';
import 'package:doctormobileapplication/models/pastMedicine.dart';
import 'package:doctormobileapplication/models/patient_detail.dart';
import 'package:doctormobileapplication/models/primary_diagnosis.dart';
import 'package:doctormobileapplication/models/procedures.dart';
import 'package:doctormobileapplication/models/secondart_diagnosis.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class PrescribeMedicinRepo {
  Future<List<Diagnostics1>> getDiagnostics(search) async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String branchid = await LocalDb().getBranchId() ?? "";
    String pl = "150";
    String did = doctorid;
    String bid = branchid;
    String url = AppConstants.getDiagnostics;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "BranchId": bid,
      "Search": search
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      if (status == -5) {
        return [];
      }
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Diagnostics'];
      List<Diagnostics1> diagnosticsList =
          data.map((json) => Diagnostics1.fromJson(json)).toList();
      return diagnosticsList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  precribemedicine(data) async {
    String url = AppConstants.prescribemed;
    Uri uri = Uri.parse(url);
    var body = data;
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);

      dynamic data = jsonData['ErrorMessage'];
      return data;
    } else {
      throw Exception('Failed');
    }
  }

  Future<List<Investigations1>> getInvestigations(search) async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String branchid = await LocalDb().getBranchId() ?? "";
    String pl = "150";
    String did = doctorid;
    String bid = branchid;
    String url = AppConstants.getInvestigations;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "BranchId": bid,
      "Search": search
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      if (status == -5) {
        return [];
      }
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Investigations'];
      List<Investigations1> investigationList =
          data.map((json) => Investigations1.fromJson(json)).toList();
      return investigationList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<Complaints1>> getComplaints(search) async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String branchid = await LocalDb().getBranchId() ?? "";
    String pl = "150";
    String did = doctorid;
    String bid = branchid;
    String url = AppConstants.getComplaints;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "BranchId": bid,
      "Search": search
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      if (status == -5) {
        return [];
      }
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Complaints'];
      List<Complaints1> complaints1List =
          data.map((json) => Complaints1.fromJson(json)).toList();

      return complaints1List;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<PrimaryDiagnosis1>> getPrimaryDiagnosis(search) async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String branchid = await LocalDb().getBranchId() ?? "";
    String pl = "150";
    String did = doctorid;
    String bid = branchid;
    String url = AppConstants.getPrimaryDiagnosis;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "BranchId": bid,
      "Search": search
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      if (status == -5) {
        return [];
      }
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Diagnosis'];
      List<PrimaryDiagnosis1> primaryDiagnosis1List =
          data.map((json) => PrimaryDiagnosis1.fromJson(json)).toList();
      return primaryDiagnosis1List;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<SecondaryDiagnosis1>> getSecondaryDiagnosis(search) async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String branchid = await LocalDb().getBranchId() ?? "";
    String pl = "150";
    String did = doctorid;
    String bid = branchid;
    String url = AppConstants.getSecondaryDiagnosis;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "BranchId": bid,
      "Search": search
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      if (status == -5) {
        return [];
      }
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['SecondaryDiagnosis'];
      List<SecondaryDiagnosis1> secondaryDiagnosisList =
          data.map((json) => SecondaryDiagnosis1.fromJson(json)).toList();
      return secondaryDiagnosisList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<Procedures1>> getProcedures(search) async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String branchid = await LocalDb().getBranchId() ?? "";
    String pl = "150";
    String did = doctorid;
    String bid = branchid;
    String url = AppConstants.getProcedures;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "BranchId": bid,
      "Search": search
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      if (status == -5) {
        return [];
      }
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Procedures'];
      List<Procedures1> proceduresList =
          data.map((json) => Procedures1.fromJson(json)).toList();
      return proceduresList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<Instructions1>> getInstruction(search) async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String branchid = await LocalDb().getBranchId() ?? "";
    String pl = "150";
    String did = doctorid;
    String bid = branchid;
    String url = AppConstants.getInstruction;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "BranchId": bid,
      "Search": search
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      if (status == -5) {
        return [];
      }
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Instructions'];
      List<Instructions1> instructionList =
          data.map((json) => Instructions1.fromJson(json)).toList();
      return instructionList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<FollowUps1>> getFollowUps(search) async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String branchid = await LocalDb().getBranchId() ?? "";
    String pl = "150";
    String did = doctorid;
    String bid = branchid;
    String url = AppConstants.getFollowup;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "BranchId": bid,
      "Search": search
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['FollowUps'];
      List<FollowUps1> followupsList =
          data.map((json) => FollowUps1.fromJson(json)).toList();
      return followupsList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<Medicines1>> getMedicines(search) async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String branchid = await LocalDb().getBranchId() ?? "";
    String pl = "150";
    String did = doctorid;
    String bid = branchid;
    String url = AppConstants.getMedicines;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "BranchId": bid,
      "Search": search
    });

    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      if (status == -5) {
        return [];
      }
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Medicines'];
      List<Medicines1> medicinesList =
          data.map((json) => Medicines1.fromJson(json)).toList();
      return medicinesList;
    } else {
      throw Exception('Failed to fetch medicines details');
    }
  }

  static Future<medicinematric> getMedicinesMatrix() async {
    String branchid = await LocalDb().getBranchId() ?? "";

    String url = AppConstants.getMedicinesMatrix;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "BranchId": branchid,
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];

      if (status == 1) {
        medicinematric mm = medicinematric.fromJson(responseData);
        return mm;
      } else {
        Fluttertoast.showToast(
            msg: "Failed to update",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.kRedColor,
            textColor: ColorManager.kWhiteColor,
            fontSize: 14.0);
        return medicinematric();
      }
    } else {
      throw Exception('Failed to fetch medicines details');
    }
  }

  Future<String> getErnsHistory(
    patientid,
    visitno,
    prescribedvalue,
  ) async {
    String branchid = await LocalDb().getBranchId() ?? "";
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String url = AppConstants.getErnsHistory;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "DoctorId": doctorid,
      "BranchId": branchid,
      "PatientId": patientid,
      "VisitNo": visitno,
      "PrescribedInValue": prescribedvalue,
      "currentVisit": visitno,
      "CheckInTypeValue": 3,
      "ERNSBit": 3,
    });
    try {
      ERXController.i.updateIsloading(true);
      var response = await http.post(uri,
          body: body,
          headers: <String, String>{'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];

        List<dynamic> rawvitalsData = responseData['Vitals'] ?? [];
        List<VitalsHistory> vitals =
            rawvitalsData.map((item) => VitalsHistory.fromJson(item)).toList();

        List<dynamic> rawpdData = responseData['PrimaryDiagnosis'] ?? [];
        List<PrimaryDiagnosisHistory> primarydiagnosis = rawpdData
            .map((item) => PrimaryDiagnosisHistory.fromJson(item))
            .toList();

        List<dynamic> rawinvestData = responseData['Investigations'] ?? [];
        List<InvestigationsHistory> investigations = rawinvestData
            .map((item) => InvestigationsHistory.fromJson(item))
            .toList();

        List<dynamic> rawdData = responseData['Diagnostics'] ?? [];
        List<DiagnosticsHistory> diagnostics =
            rawdData.map((item) => DiagnosticsHistory.fromJson(item)).toList();

        List<dynamic> rawcomplaintData = responseData['Complaints'] ?? [];
        List<ComplaintsHistory> complaints = rawcomplaintData
            .map((item) => ComplaintsHistory.fromJson(item))
            .toList();

        List<dynamic> rawprceduresData = responseData['Prcedures'] ?? [];
        List<PrceduresHistory> prcedures = rawprceduresData
            .map((item) => PrceduresHistory.fromJson(item))
            .toList();

        if (status == 1) {
          ERXController.i.updatevitalshistorydata(vitals);
          ERXController.i.updateprimarydiagnosishistorydata(primarydiagnosis);
          ERXController.i.updateinvestigationistorydata(investigations);
          ERXController.i.updatediagnosticshistorydata(diagnostics);
          ERXController.i.updatecomplainthistorydata(complaints);
          ERXController.i.updateprcedureshistorydata(prcedures);
          ERXController.i.updateIsloading(false);
          return 'Ok';
        } else {
          Fluttertoast.showToast(
              msg: 'Failed to fetch details',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          ERXController.i.updateIsloading(false);
          return 'NotOk';
        }
      } else {
        ERXController.i.updateIsloading(false);
        throw Exception('Failed to fetch details');
      }
    } catch (e) {
      ERXController.i.updateIsloading(false);
      return 'NotOk';
    }
  }

  // DETAIL HISTORY

  Future<String> getErnsDetailHistory(
    patientid,
    visitno,
    prescribedvalue,
  ) async {
    String branchid = await LocalDb().getBranchId() ?? "";
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String url = AppConstants.getErnsDetailHistory;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "DoctorId": doctorid,
      "BranchId": branchid,
      "PatientId": patientid,
      "VisitNo": visitno,
      "PrescribedInValue": prescribedvalue,
      "currentVisit": visitno,
      "CheckInTypeValue": 3,
      "ERNSBit": 3,
    });

    try {
      ERXController.i.updateIsloading(true);
      var response = await http.post(uri,
          body: body,
          headers: <String, String>{'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];

        List<dynamic> rawinvestData = responseData['Investigations'] ?? [];
        List<Investigations1> investigations = rawinvestData
            .map((item) => Investigations1.fromJson(item))
            .toList();

        List<dynamic> rawdData = responseData['Diagnostics'] ?? [];
        List<Diagnostics1> diagnostics =
            rawdData.map((item) => Diagnostics1.fromJson(item)).toList();

        List<dynamic> rawcomplaintData = responseData['Complaints'] ?? [];
        List<Complaints1> complaints =
            rawcomplaintData.map((item) => Complaints1.fromJson(item)).toList();

        List<dynamic> rawpdData = responseData['Diagnosis'] ?? [];
        List<PrimaryDiagnosis1> primarydiagnosis =
            rawpdData.map((item) => PrimaryDiagnosis1.fromJson(item)).toList();

        List<dynamic> rawinstructionData = responseData['Instructions'] ?? [];
        List<Instructions1> instruction = rawinstructionData
            .map((item) => Instructions1.fromJson(item))
            .toList();

        List<dynamic> rawproceduresData = responseData['Procedures'] ?? [];
        List<Procedures1> procedures = rawproceduresData
            .map((item) => Procedures1.fromJson(item))
            .toList();

        List<dynamic> followUpsData = responseData['FollowUps'] ?? [];

        FollowUps1 followUp = FollowUps1(
          id: "",
          name: "",
          code: null,
          comments: null,
        );

        if (followUpsData.isNotEmpty) {
          followUp = FollowUps1(
            id: followUpsData[0]['Id'],
            name: followUpsData[0]['Name'],
            code: followUpsData[0]['Code'],
            comments: followUpsData[0]['Comments'],
          );
        }

        List<dynamic> rawsdData = responseData['SecondaryDiagnosis'] ?? [];
        List<SecondaryDiagnosis1> secondarydiagnosis = rawsdData
            .map((item) => SecondaryDiagnosis1.fromJson(item))
            .toList();

        List<dynamic> adviceData = responseData['Advices'] ?? [];

        Advices advices = Advices(
          advice: "",
          doctorName: "",
          createdOn: null,
          isDeleteable: null,
        );

        if (adviceData.isNotEmpty) {
          advices = Advices(
            advice: adviceData[0]['Advice'],
            doctorName: adviceData[0]['DoctorName'],
            createdOn: adviceData[0]['CreatedOn'],
            isDeleteable: adviceData[0]['IsDeleteable'],
          );
        }

        List<dynamic> findingsData = responseData['ExamFindings'] ?? [];

        ExamFindings findings = ExamFindings(
          examFinding: "",
          doctorName: "",
          createdOn: null,
          isDeleteable: null,
        );

        if (findingsData.isNotEmpty) {
          findings = ExamFindings(
            examFinding: findingsData[0]['ExamFinding'],
            doctorName: findingsData[0]['DoctorName'],
            createdOn: findingsData[0]['CreatedOn'],
            isDeleteable: findingsData[0]['IsDeleteable'],
          );
        }

        if (status == 1) {
          ERXController.i.updateselectedComplaintsList(complaints);
          ERXController.i.updateselectedInvestigationList(investigations);
          ERXController.i.updateselectedDiagnosticsList(diagnostics);
          ERXController.i.updateselectedPrimarydiagnosislist(primarydiagnosis);
          ERXController.i
              .updateselectedsecondarydiagnosislist(secondarydiagnosis);
          ERXController.i.updateselectedInstructionList(instruction);
          ERXController.i.updateselectedProceduresList(procedures);
          ERXController.i.addfollowup(followUp);
          ERXController.i.addadvice(advices);
          ERXController.i.addfindings(findings);

          ERXController.i.updateIsloading(false);
          return 'Ok';
        } else {
          Fluttertoast.showToast(
              msg: 'Failed to fetch details',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          ERXController.i.updateIsloading(false);
          return 'NotOk';
        }
      } else {
        ERXController.i.updateIsloading(false);
        throw Exception('Failed to fetch  details');
      }
    } catch (e) {
      ERXController.i.updateIsloading(false);
      return 'NotOk';
    }
  }

  Future<List<PatientDetail1>> getPatientDetailPrescription(pid, vno) async {
    String? did = await LocalDb().getDoctorId();
    String? bid = await LocalDb().getBranchId();
    String url = AppConstants.getpatientdetailprescription;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "DoctorId": did,
      "BranchId": bid,
      "PatientId": pid,
      "VisitNo": vno
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['PatientDetail'];
      List<PatientDetail1> patientdetailList =
          data.map((json) => PatientDetail1.fromJson(json)).toList();
      return patientdetailList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<Medicinesss1>> getPatientpastMedicine(pid, vno) async {
    String? did = await LocalDb().getDoctorId();
    String? bid = await LocalDb().getBranchId();
    String url = AppConstants.getpatientpastmedicine;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "DoctorId": did,
      "BranchId": bid,
      "PatientId": pid,
      "VisitNo": vno
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      try {
        Iterable data = jsonData['Medicines'];
        List<Medicinesss1> pastmedList =
            data.map((json) => Medicinesss1.fromJson(json)).toList();
        return pastmedList;
      } catch (e) {
        throw Exception(e);
      }
    } else {
      throw Exception('Failed to fetch past medicine');
    }
  }
}
