import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/utils/constants.dart';

class FollowUps {
  int? status;
  List<FollowUps>? followUps;

  FollowUps({this.status, this.followUps});

  FollowUps.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['FollowUps'] != null) {
      followUps = <FollowUps>[];
      json['FollowUps'].forEach((v) {
        followUps!.add(FollowUps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (followUps != null) {
      data['FollowUps'] = followUps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowUps1 {
  String? id;
  String? name;
  String? code;
  String? comments;

  FollowUps1({this.id, this.name, this.code, this.comments});

  FollowUps1.fromJson(Map<String, dynamic> json) {
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

  Future<List<FollowUps1>> getFollowUps(dynamic pl, dynamic did, dynamic tid,
      dynamic search, dynamic bid, dynamic pno, dynamic token) async {
    String url = AppConstants.getFollowup;
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
      Iterable data = jsonData['FollowUps'];
      List<FollowUps1> followupsList =
          data.map((json) => FollowUps1.fromJson(json)).toList();
      return followupsList;
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }
}
