import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/utils/constants.dart';

class Genders {
  int? status;
  List<GendersData>? data;

  Genders({this.status, this.data});

  Genders.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <GendersData>[];
      json['Data'].forEach((v) {
        data!.add(GendersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GendersData {
  String? id;
  String? name;

  GendersData({this.id, this.name});

  GendersData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}
