import 'dart:convert';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:http/http.dart' as http;

class Complaints {
  int? status;
  List<Complaints>? complaints;

  Complaints({this.status, this.complaints});

  Complaints.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Complaints'] != null) {
      complaints = <Complaints>[];
      json['Complaints'].forEach((v) {
        complaints!.add(Complaints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (complaints != null) {
      data['Complaints'] = complaints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Complaints1 {
  String? id;
  String? name;
  String? code;
  String? comments;

  Complaints1({this.id, this.name, this.code, this.comments});

  Complaints1.fromJson(Map<String, dynamic> json) {
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

  Future<List<Complaints1>> getComplaints(dynamic pl, dynamic did, dynamic tid,
      dynamic search, dynamic bid, dynamic pno, dynamic token) async {
    String url = AppConstants.getComplaints;
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
      Iterable data = jsonData['Complaints'];
      List<Complaints1> complaints1List =
          data.map((json) => Complaints1.fromJson(json)).toList();
      return complaints1List;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }
}
