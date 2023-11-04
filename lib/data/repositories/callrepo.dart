import 'dart:convert';
import 'dart:developer';

import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/models/consultingqueuewaithold.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Callrepo {
  cancelcall(did, bid, pid, vno) async {
    var headers = {
      "Content-Type": "application/json",
    };
    var body = {
      "DoctorId": did,
      "BranchId": bid,
      "PatientId": pid,
      "VisitNo": vno,
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.cancelcall),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result["Status"] == 1) {
          return result["Status"];
        } else {
          showSnackbar(Get.context!, "${result["ErrorMessage"]}");
        }
      }
    } catch (e) {}
  }

  callOpenPrescription(context, consultingqueuewaitholdresponse data) async {
    String dt = await LocalDb().getDeviceToken();
    var body = {
      "PatientId": data.patientId,
      "DoctorId": data.doctorId,
      "VisitNo": data.visitNo,
      "BranchId": data.branchId,
      "DeviceToken": dt,
      "PrescribedInValue": "2".toString(),
      "IsFirstTimeVisit": data.isFirstTimeVisit == 1 ? "true" : "false",
      "IsOnline": "true"
    };

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
