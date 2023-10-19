import 'dart:convert';
import 'dart:developer';

import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/models/search_models.dart';
import 'package:doctormobileapplication/models/specialities_model.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../../models/online_statuS.dart';

class SpecialitiesRepo {
  static getSpecialities() async {
    var body = {};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getSpecialities),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Specialities specialities =
              Specialities.fromJson(jsonDecode(response.body));
          log('${specialities.toString()} specialities');
          return specialities;
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }

  getSearchDoctors(String id) async {
    var body = {
      "PatientId": "",
      "Token": "",
      "BranchId": "",
      "DoctorName": "",
      "WorkLocationId": "",
      "SpecialityId": id,
      "IsOnline": false,
      "MinConsultancyFee": "",
      "MaxConsultancyFee": "",
      "Date": "",
      "FromTime": "",
      "ToTime": "",
      "CityId": ""
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.searchDoctor),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          SearchDoctors search =
              SearchDoctors.fromJson(jsonDecode(response.body));
          return search;
        } else {
          log('message');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static getStatuses(OnlineStatusRequest object) async {
    // String dit = await LocalDb().getDoctorId() ?? "";
    //  String it = await LocalDb().getDoctorId() ?? "";
    //   String dit = await LocalDb().getDoctorId() ?? "";
    var body = {};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.onlineStatus),
          headers: headers, body: jsonEncode(object.toJson()));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          var status = result['ErrorMessage'];
          log('${status.toString()} status');
          return result['CurrentStatus'];
        } else {
          return -5;
        }
      } else {
        return -29;
      }
    } catch (e) {
      log('$e exception caught');
    }
  }
}
