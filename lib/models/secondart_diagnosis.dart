import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/utils/constants.dart';

class SecondaryDiagnosis {
  int? status;
  List<SecondaryDiagnosis>? secondaryDiagnosis;

  SecondaryDiagnosis({this.status, this.secondaryDiagnosis});

  SecondaryDiagnosis.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['SecondaryDiagnosis'] != null) {
      secondaryDiagnosis = <SecondaryDiagnosis>[];
      json['SecondaryDiagnosis'].forEach((v) {
        secondaryDiagnosis!.add(SecondaryDiagnosis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (secondaryDiagnosis != null) {
      data['SecondaryDiagnosis'] =
          secondaryDiagnosis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SecondaryDiagnosis1 {
  String? id;
  String? name;
  String? code;
  String? comments;

  SecondaryDiagnosis1({this.id, this.name, this.code, this.comments});

  SecondaryDiagnosis1.fromJson(Map<String, dynamic> json) {
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

  Future<List<SecondaryDiagnosis1>> getSecondaryDiagnosis(
      dynamic pl,
      dynamic did,
      dynamic tid,
      dynamic search,
      dynamic bid,
      dynamic pno,
      dynamic token) async {
    String url = AppConstants.getSecondaryDiagnosis;
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
      Iterable data = jsonData['SecondaryDiagnosis'];
      List<SecondaryDiagnosis1> secondaryDiagnosisList =
          data.map((json) => SecondaryDiagnosis1.fromJson(json)).toList();
      return secondaryDiagnosisList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }
}
