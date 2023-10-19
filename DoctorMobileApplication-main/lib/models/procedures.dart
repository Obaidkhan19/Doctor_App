import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/utils/constants.dart';

class Procedures {
  int? status;
  List<Procedures>? procedures;

  Procedures({this.status, this.procedures});
  Procedures.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Procedures'] != null) {
      procedures = <Procedures>[];
      json['Procedures'].forEach((v) {
        procedures!.add(Procedures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (procedures != null) {
      data['Procedures'] = procedures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Procedures1 {
  String? id;
  String? name;
  String? code;
  String? comments;

  Procedures1({this.id, this.name, this.code, this.comments});

  Procedures1.fromJson(Map<String, dynamic> json) {
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

  Future<List<Procedures1>> getProcedures(dynamic pl, dynamic did, dynamic tid,
      dynamic search, dynamic bid, dynamic pno, dynamic token) async {
    String url = AppConstants.getProcedures;
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
      Iterable data = jsonData['Procedures'];
      List<Procedures1> proceduresList =
          data.map((json) => Procedures1.fromJson(json)).toList();
      return proceduresList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }
}
