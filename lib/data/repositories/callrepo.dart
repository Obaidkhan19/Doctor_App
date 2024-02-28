import 'dart:convert';
import 'dart:developer';

import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/consultingqueuewaithold.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
          Fluttertoast.showToast(
              msg: "${result["ErrorMessage"]}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
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
      Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
    }
  }
}
