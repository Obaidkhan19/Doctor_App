import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/utils/constants.dart';

class CountriesData {
  int? status;
  List<Countries>? data;

  CountriesData({this.status, this.data});

  CountriesData.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <Countries>[];
      json['Data'].forEach((v) {
        data!.add(Countries.fromJson(v));
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

class Countries {
  String? id;
  String? name;

  Countries({this.id, this.name});

  Countries.fromJson(Map<String, dynamic> json) {
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
