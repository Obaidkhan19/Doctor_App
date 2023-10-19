import 'dart:convert';

import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/models/complaints.dart';
import 'package:doctormobileapplication/models/diagnostics.dart';
import 'package:doctormobileapplication/models/followups.dart';
import 'package:doctormobileapplication/models/instruction.dart';
import 'package:doctormobileapplication/models/investigation.dart';
import 'package:doctormobileapplication/models/medicincematrix.dart';
import 'package:doctormobileapplication/models/medicines.dart';
import 'package:doctormobileapplication/models/primary_diagnosis.dart';
import 'package:doctormobileapplication/models/procedures.dart';
import 'package:doctormobileapplication/models/secondart_diagnosis.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PrescribeMedicinRepo {
  Future<List<Diagnostics1>> getDiagnostics() async {
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
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Diagnostics'];
      List<Diagnostics1> diagnosticsList =
          data.map((json) => Diagnostics1.fromJson(json)).toList();
      return diagnosticsList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<Investigations1>> getInvestigations() async {
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
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Investigations'];
      List<Investigations1> investigationList =
          data.map((json) => Investigations1.fromJson(json)).toList();
      return investigationList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<Complaints1>> getComplaints() async {
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
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Complaints'];
      List<Complaints1> complaints1List =
          data.map((json) => Complaints1.fromJson(json)).toList();

      return complaints1List;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<PrimaryDiagnosis1>> getPrimaryDiagnosis() async {
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
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Diagnosis'];
      List<PrimaryDiagnosis1> primaryDiagnosis1List =
          data.map((json) => PrimaryDiagnosis1.fromJson(json)).toList();
      return primaryDiagnosis1List;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<SecondaryDiagnosis1>> getSecondaryDiagnosis() async {
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
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['SecondaryDiagnosis'];
      List<SecondaryDiagnosis1> secondaryDiagnosisList =
          data.map((json) => SecondaryDiagnosis1.fromJson(json)).toList();
      return secondaryDiagnosisList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<Procedures1>> getProcedures() async {
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
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Procedures'];
      List<Procedures1> proceduresList =
          data.map((json) => Procedures1.fromJson(json)).toList();
      return proceduresList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<Instructions1>> getInstruction() async {
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
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Instructions'];
      List<Instructions1> instructionList =
          data.map((json) => Instructions1.fromJson(json)).toList();
      return instructionList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }

  Future<List<FollowUps1>> getFollowUps() async {
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

  Future<List<Medicines1>> getMedicines() async {
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
    });

    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
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
        showSnackbar(Get.context!, 'Failed to update');
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
    // ernsbit,currentvisit,prescribedvalue,checkintypevalue
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
        print("responseDataresponseDataresponseData");
        print(responseData);
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
          showSnackbar(Get.context!, 'Failed to get');
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
}
