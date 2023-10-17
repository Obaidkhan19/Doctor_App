import 'dart:convert';

import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/models/diagnostics.dart';
import 'package:doctormobileapplication/models/investigation.dart';
import 'package:doctormobileapplication/utils/constants.dart';
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
    print("bodybodybody");
    print(body);
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
