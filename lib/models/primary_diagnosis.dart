import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/utils/constants.dart';

class PrimaryDiagnosis {
  int? status;
  List<PrimaryDiagnosis1>? diagnosis;

  PrimaryDiagnosis({this.status, this.diagnosis});

  PrimaryDiagnosis.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Diagnosis'] != null) {
      diagnosis = <PrimaryDiagnosis1>[];
      json['Diagnosis'].forEach((v) {
        diagnosis!.add(PrimaryDiagnosis1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (diagnosis != null) {
      data['Diagnosis'] = diagnosis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrimaryDiagnosis1 {
  String? id;
  String? name;
  String? code;
  String? comments;

  PrimaryDiagnosis1({this.id, this.name, this.code, this.comments});

  PrimaryDiagnosis1.fromJson(Map<String, dynamic> json) {
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

  Future<List<PrimaryDiagnosis1>> getPrimaryDiagnosis(
      dynamic pl,
      dynamic did,
      dynamic tid,
      dynamic search,
      dynamic bid,
      dynamic pno,
      dynamic token) async {
    String url = AppConstants.getPrimaryDiagnosis;
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
      Iterable data = jsonData['Diagnosis'];
      List<PrimaryDiagnosis1> primaryDiagnosis1List =
          data.map((json) => PrimaryDiagnosis1.fromJson(json)).toList();
      return primaryDiagnosis1List;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }
}
