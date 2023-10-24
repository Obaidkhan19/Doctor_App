import 'dart:convert';
import 'dart:developer';

import 'package:doctormobileapplication/models/consultingqueuewaithold.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Callrepo{

   CallOpenPrescription(context,consultingqueuewaitholdresponse data) async {
    var body = {
      {
    "PatientId":data.patientId,
    "DoctorId": data.doctorId,
    "VisitNo":data.visitNo,
    "BranchId":data.branchId,
    "DeviceToken":"",
    "PrescribedInValue":"2",
    "IsFirstTimeVisit":data.isFirstTimeVisit??"true",
    "IsOnline":"true"
}
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.opencallprescription),
          body: body, headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
        log("Success");
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong!")));
    }
  }


}