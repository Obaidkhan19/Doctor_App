import 'dart:convert';

import 'package:doctormobileapplication/models/diagnostics.dart';
import 'package:doctormobileapplication/models/investigation.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:http/http.dart' as http;

// LocalDb localDB = LocalDb();
// String? doctorId = await localDB.getDoctorId();
// String? branchId = await localDB.getBranchId();
// String? token = await localDB.getToken();
class PrescribeMedicinRepo {
  Future<List<Diagnostics1>> getDiagnostics() async {
    String pl = "150";
    String did = "956315e6-4a1e-4eaa-8a40-f0e9a04609f2";
    String tid = '';
    String search = '';
    String bid = "5bd60354-fefd-4bcc-a58d-b8e27d802e85";
    String pno = '';
    String token = "8f3609d2-0325-4c95-9af3-a872e5176497";
    String url = AppConstants.getDiagnostics;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "TemplateId": tid,
      "Search": search,
      "BranchId": bid,
      "PageNumber": pno,
      "Token": token
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
    String pl = "150";
    String did = "956315e6-4a1e-4eaa-8a40-f0e9a04609f2";
    String tid = '';
    String search = '';
    String bid = "5bd60354-fefd-4bcc-a58d-b8e27d802e85";
    String pno = '';
    String token = "8f3609d2-0325-4c95-9af3-a872e5176497";
    String url = AppConstants.getInvestigations;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "TemplateId": tid,
      "Search": search,
      "BranchId": bid,
      "PageNumber": pno,
      "Token": token
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
}
