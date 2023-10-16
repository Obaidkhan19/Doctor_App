import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/models/lab_tests_model.dart';
import 'package:doctormobileapplication/models/packages_model.dart';
import 'package:doctormobileapplication/utils/constants.dart';

class LabInvestigationRepo {
  static getLabs() async {
    var body = {
      "TypeBit": "2",
      "Latitude": "",
      "Longitude": "",
      "BranchId": "",
      "Token": "44717866-70BA-4223-8F97-45286B2FD599"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getLabs),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          log('success');
        } else {
          log(result['Status']);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future getLabTests() async {
    var token = "44717866-70BA-4223-8F97-45286B2FD599";
    var body = {"LabId": "", "Token": token};
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

  
    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.getLabTests,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
          log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          LabTestsModel labTestsModel =
              LabTestsModel.fromJson(jsonDecode(response.body));
          return labTestsModel;
        } else {
          log(result['Status'].toString());
          log('failed');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e ===>');
    }
  }

  getPackages() async {
    var body = {
      "BranchId": "D8340ED5-AF5D-4F68-895B-0350114AAB09"
    };
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.getPackages),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Packages package = Packages.fromJson(result);
          log('packages data length ${package.data?.length}');
          return package.data;
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
