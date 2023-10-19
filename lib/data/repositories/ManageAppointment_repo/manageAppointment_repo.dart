import 'dart:convert';
import 'dart:developer';

import 'package:doctormobileapplication/data/controller/ManageAppointments_Controller.dart';
import 'package:doctormobileapplication/models/monthlyappointmentbody.dart';
import 'package:doctormobileapplication/models/monthlyappointmentresponse.dart';
import 'package:doctormobileapplication/screens/doctors_appointment/doctors_appointment.dart';
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
      ManageAppointmentController.i.updateIsloadingScreen(true);
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
          ManageAppointmentController.i.updateIsloadingScreen(false);
          return DailyDoctorAppointment;
        }
      } else {
        ManageAppointmentController.i.updateIsloadingScreen(false);
        log(response.statusCode.toString());
      }
    } catch (e) {
      ManageAppointmentController.i.updateIsloadingScreen(false);
      log('$e exception caught');
    }
  }

  static GetmonthlyDoctorAppointment(String date) async {
    ManageAppointmentController.i.paid =
        ManageAppointmentController.i.unpaid = 0;

    String? userId = await LocalDb().getDoctorId();
    String? userToken = await LocalDb().getToken();

//     {
//     "DoctorId":"e02f9e89-e261-4906-9b33-f49802ddea5f",
//     "MonthAndYear": "2023-10-17",
//     "WorkLocationId":"49576ED4-49C9-EB11-80C2-F8BC123A0405",
//     "IsOnline":"false"

// }

    var body = {
      "MonthAndYear": date,
      "DoctorId": "$userId",
      "49576ED4-49C9-EB11-80C2-F8BC123A0405": "$userToken",
      "IsOnline": "false"
    };
    var headers = {'Content-Type': 'application/json'};
    print("$body  a");
    try {
      var response = await http.post(
          Uri.parse(AppConstants.GetMonthlyAppointment),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          Iterable data = result['Appointments'];
          List<monthlyappointresponse> monthlyDoctorAppointment =
              data.map((e) => monthlyappointresponse.fromJson(e)).toList();

          log('${monthlyDoctorAppointment.toString()} DailyDoctorAppointment');
          ManageAppointmentController.i.monthlyappintment =
              monthlyDoctorAppointment;
          for (int i = 0; i < monthlyDoctorAppointment.length; i++) {
            if (monthlyDoctorAppointment[i].paid != 0) {
              ManageAppointmentController.i.paid =
                  monthlyDoctorAppointment[i].paid +
                      ManageAppointmentController.i.paid;
            } else if (monthlyDoctorAppointment[i].unPaid != 0) {
              ManageAppointmentController.i.unpaid =
                  monthlyDoctorAppointment[i].unPaid +
                      ManageAppointmentController.i.unpaid;
            }
          }
          ManageAppointmentController.i
              .updatemonthlyappointment(monthlyDoctorAppointment);
          return monthlyDoctorAppointment;
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
    var body = {
      "Date": Date,
      "DoctorId": "$userId",
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
