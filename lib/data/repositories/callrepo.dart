import 'dart:convert';
import 'dart:developer';

import 'package:doctormobileapplication/models/consultingqueuewaithold.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Callrepo {
  callOpenPrescription(context, consultingqueuewaitholdresponse data) async {
    var body = {
      "PatientId": data.patientId,
      "DoctorId": data.doctorId,
      "VisitNo": data.visitNo,
      "BranchId": data.branchId,
      "DeviceToken":
          "f-mzFf6DS0aresVFECDjLq:APA91bGR-ns4FcG23u2cg0O3IWrK2AuM-CALvxv7cBlccXmNm2tSqu4XVDcdpYtSuBs23KbsOhBBO9GndMn4QLSEyeA4fL25L57S6Bpw-uH1GOZyTukqd5c1eOq9CyaYhYvHWKsCNIlQ",
      "PrescribedInValue": "2".toString(),
      "IsFirstTimeVisit": data.isFirstTimeVisit == 1 ? "true" : "false",
      "IsOnline": "true"
    };

    // var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
        Uri.parse(AppConstants.opencallprescription),
        body: body,
      );
      log(jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          log("Success");
          return result['Status'];
        } else {
          return result['Status'];
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong!")));
    }
  }
}
