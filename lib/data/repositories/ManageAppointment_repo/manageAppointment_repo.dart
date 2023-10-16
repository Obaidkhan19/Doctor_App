import 'dart:convert';
import 'dart:developer';

import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../components/snackbar.dart';
import '../../../models/DayViewAppointmentModel.dart';
import '../../../models/ReschedualAppointment.dart';
import '../../../models/TodayAppointmentModel.dart';
import '../../localDB/local_db.dart';

class ManageAppointmentRepo {
  static GetDailyDoctorAppointment() async {
    DateTime now = DateTime.now();
    String? Date = DateFormat('yyyy-MM-dd').format(now);

    String? userId = await LocalDb().getDoctorId();
    String? userToken = await LocalDb().getToken();
    print(Date);
    print(userId);
    print(userToken);
    var body = {"Date": Date, "DoctorId": "$userId", "Token": "$userToken"};
    var headers = {'Content-Type': 'application/json'};
    print("$body  a");
    try {
      var response = await http.post(
          Uri.parse(AppConstants.GetDailyAppointment),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          DailyDoctorAppointmentsModel DailyDoctorAppointment =
              DailyDoctorAppointmentsModel.fromJson(jsonDecode(response.body));
          log('${DailyDoctorAppointment.toString()} DailyDoctorAppointment');
          return DailyDoctorAppointment;
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }

  static getDailyDoctorAppointmentSlots(
      String Date, String IsOnline, String WorkLocationId) async {
    String? userId = await LocalDb().getDoctorId();
    String? userToken = await LocalDb().getToken();
    var body = {
      "Date": Date,
      "DoctorId": "$userId",
      "Token": "$userToken",
      "WorkLocationId": WorkLocationId,
      "IsOnline": IsOnline,
    };
    print("$body  b");
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.GetDayAppointment),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        DayViewAppointmentSlotModel DayViewAppointmentSlot =
            DayViewAppointmentSlotModel();
        if (result['Status'] == 1) {
          DayViewAppointmentSlot =
              DayViewAppointmentSlotModel.fromJson(jsonDecode(response.body));
          log('${DayViewAppointmentSlot.toString()} DayViewAppointmentSlot');
          return DayViewAppointmentSlot;
        } else {
          return DayViewAppointmentSlot;
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }

  static resheduleAppointmentSlots(String Date, String BranchId,
      List<ReschedualAppointmentSlots> Appointments) async {
    String? userId = await LocalDb().getDoctorId();
    String? userToken = await LocalDb().getToken();
    var body = {
      "Date": Date,
      "DoctorId": "$userId",
      "Token": "$userToken",
      "BranchId": BranchId,
      "Appointments": Appointments,
    };
    print(jsonEncode(body));
    print(Appointments[0]);
    print("$body  c");
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.RescheduleApi),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          showSnackbar(Get.context!, '${result['ErrorMessage']}',
              color: Colors.green);
        } else {
          showSnackbar(Get.context!, '${result['ErrorMessage']}',
              color: Colors.red);
        }
        return result['Status'];
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }

  static approveAppointmentSlots(
      String BranchId, List<ReschedualAppointmentSlots> Appointments) async {
    String? userId = await LocalDb().getDoctorId();
    String? userToken = await LocalDb().getToken();
    var body = {
      "DoctorId": "$userId",
      "Token": "$userToken",
      "BranchId": BranchId,
      "Appointments": Appointments,
    };
    print("$body  d");
    print(jsonEncode(body));
    print(Appointments[0]);
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.ApproveApi),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          showSnackbar(Get.context!, '${result['ErrorMessage']}',
              color: Colors.green);
        } else {
          showSnackbar(Get.context!, '${result['ErrorMessage']}',
              color: Colors.red);
        }
        print('response of reshedul is ${result['Status']}');
        return result['Status'];
      } else {
        log(response.statusCode.toString());
        return 998;
      }
    } catch (e) {
      log('$e exception caught');
      return 999;
    }
  }

  // getSearchDoctors(String id) async {
  //   var body = {
  //     "PatientId": "",
  //     "Token": "",
  //     "BranchId": "",
  //     "DoctorName": "",
  //     "WorkLocationId": "",
  //     "SpecialityId": id,
  //     "IsOnline": false,
  //     "MinConsultancyFee": "",
  //     "MaxConsultancyFee": "",
  //     "Date": "",
  //     "FromTime": "",
  //     "ToTime": "",
  //     "CityId": ""
  //   };
  //   var headers = {'Content-Type': 'application/json'};
  //   try {
  //     var response = await http.post(Uri.parse(AppConstants.searchDoctor),
  //         body: jsonEncode(body), headers: headers);
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       if (result['Status'] == 1) {
  //         SearchDoctors search =
  //             SearchDoctors.fromJson(jsonDecode(response.body));
  //         return search;
  //       } else {
  //         log('message');
  //       }
  //     } else {
  //       log(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
  //
  // static getStatuses(OnlineStatusRequest object) async {
  //   var body = {};
  //   var headers = {'Content-Type': 'application/json'};
  //   try {
  //     var response = await http.post(Uri.parse(AppConstants.onlineStatus),
  //         headers: headers, body: jsonEncode(object.toJson()));
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       if (result['Status'] == 1) {
  //         var status = result['ErrorMessage'];
  //         log('${status.toString()} status');
  //         return result['CurrentStatus'];
  //       } else {
  //         return -5;
  //       }
  //     } else {
  //       return -29;
  //     }
  //   } catch (e) {
  //     log('$e exception caught');
  //   }
  // }
}
