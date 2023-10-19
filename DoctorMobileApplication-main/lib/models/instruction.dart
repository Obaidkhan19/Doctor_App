import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/utils/constants.dart';

class Instructions {
  int? status;
  List<Instructions>? instructions;

  Instructions({this.status, this.instructions});

  Instructions.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Instructions'] != null) {
      instructions = <Instructions>[];
      json['Instructions'].forEach((v) {
        instructions!.add(Instructions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (instructions != null) {
      data['Instructions'] = instructions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Instructions1 {
  String? id;
  String? name;
  String? code;
  String? comments;

  Instructions1({this.id, this.name, this.code, this.comments});

  Instructions1.fromJson(Map<String, dynamic> json) {
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

  Future<List<Instructions1>> getInstruction(
      dynamic pl,
      dynamic did,
      dynamic tid,
      dynamic search,
      dynamic bid,
      dynamic pno,
      dynamic token) async {
    String url = AppConstants.getInstruction;
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
      Iterable data = jsonData['Instructions'];
      List<Instructions1> instructionList =
          data.map((json) => Instructions1.fromJson(json)).toList();
      return instructionList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }
}
