import 'dart:developer';

import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/models/work_locations.dart';
import 'dart:convert';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ConfigureAppointmentRepo {
  Future<List<WorkLocations>> getWorklocation() async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String url = AppConstants.getWorklocation;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "DoctorId": doctorid,
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['WorkLocations'];
      List<WorkLocations> worklocationList =
          data.map((json) => WorkLocations.fromJson(json)).toList();

      return worklocationList;
    } else {
      throw Exception('Failed to fetch details');
    }
  }

  Future<String> addAppointmentConfiguration(
      approvalcrieteriaid,
      worklocationid,
      doctorid,
      fromtime,
      totime,
      consultancyfee,
      slotduration,
      followupfee,
      nooffollowupdays,
      weekdays,
      isolineconfiguratation,
      isactive) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "Id": doctorid,
      "ApprovalCriteria": approvalcrieteriaid,
      "WorkLocationId": worklocationid,
      "DoctorId": doctorid,
      "FromTime": fromtime,
      "ToTime": totime,
      "ConsultancyFee": consultancyfee,
      "SlotDuration": slotduration,
      "FollowupFee": followupfee,
      "NoofFollowupDays": nooffollowupdays,
      "WeekDays": weekdays,
      "IsOnlineConfiguration": isolineconfiguratation,
      "IsActive": isactive,
    };
    log(body.toString());
    try {
      var response = await http.post(
          Uri.parse(AppConstants.appointconfiguration),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];

        if (status == 1) {
          // showSnackbar(Get.context!, msg);
          // Get.back(result: true);
          return 'true';
        } else {
          return 'false';
        }
      }
    } catch (e) {
      showSnackbar(Get.context!, e.toString());
      return 'false';
    }
    return 'false';
  }
}
