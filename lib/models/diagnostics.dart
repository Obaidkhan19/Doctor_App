import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/utils/constants.dart';

class Diagnostics {
  int? status;
  List<Diagnostics>? diagnostics;

  Diagnostics({this.status, this.diagnostics});

  Diagnostics.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Diagnostics'] != null) {
      diagnostics = <Diagnostics>[];
      json['Diagnostics'].forEach((v) {
        diagnostics!.add(Diagnostics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (diagnostics != null) {
      data['Diagnostics'] = diagnostics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Diagnostics1 {
  String? id;
  String? name;
  String? code;
  String? comments;

  Diagnostics1({this.id, this.name, this.code, this.comments});

  Diagnostics1.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    code = json['Code'];
    comments = json['Comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Code'] = code;
    data['Comments'] = comments;
    return data;
  }

  // Future<List<Diagnostics1>> getDiagnostics(
  //     dynamic pl,
  //     dynamic did,
  //     dynamic tid,
  //     dynamic search,
  //     dynamic bid,
  //     dynamic pno,
  //     dynamic token) async {
  //   String url = AppConstants.getDiagnostics;
  //   Uri uri = Uri.parse(url);
  //   var body = jsonEncode(<String, dynamic>{
  //     "PageLength": pl,
  //     "DoctorId": did,
  //     "TemplateId": tid,
  //     "Search": search,
  //     "BranchId": bid,
  //     "PageNumber": pno,
  //     "Token": token
  //   });
  //   var response = await http.post(uri,
  //       body: body,
  //       headers: <String, String>{'Content-Type': 'application/json'});
  //   if (response.statusCode == 200) {
  //     dynamic jsonData = jsonDecode(response.body);
  //     Iterable data = jsonData['Diagnostics'];
  //     List<Diagnostics1> diagnosticsList =
  //         data.map((json) => Diagnostics1.fromJson(json)).toList();
  //     return diagnosticsList;
  //   } else {
  //     throw Exception('Failed to fetch patient details');
  //   }
  // }
}
