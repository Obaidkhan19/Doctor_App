import 'dart:convert';
import 'dart:developer';

import 'package:doctormobileapplication/data/controller/ManageAppointments_Controller.dart';
import 'package:doctormobileapplication/models/monthlyappointmentresponse.dart';
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

class Manageappointmentrepo {
  static getDailyDoctorAppointment() async {
    DateTime now = DateTime.now();
    String? Date = DateFormat('yyyy-MM-dd').format(now);

    String? userId = await LocalDb().getDoctorId();
    var body = {"Date": Date, "DoctorId": "$userId"};
    var headers = {'Content-Type': 'application/json'};

    try {
      ManageAppointmentController.i.updateIsloadingScreen(true);
      var response = await http.post(
          Uri.parse(AppConstants.getDailyAppointment),
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

  // static GetmonthlyDoctorAppointment(
  //     String date, String worklocationid, IsOnline) async {
  //   ManageAppointmentController.i.paid =
  //       ManageAppointmentController.i.unpaid = 0;
  //   String? userId = await LocalDb().getDoctorId();

  //   var body = {
  //     "MonthAndYear": date,
  //     "DoctorId": "$userId",
  //     "WorkLocationId": worklocationid,
  //     "IsOnline": IsOnline,
  //   };

  //   var headers = {'Content-Type': 'application/json'};
  //   try {
  //     var response = await http.post(
  //         Uri.parse(AppConstants.getMonthlyAppointment),
  //         headers: headers,
  //         body: jsonEncode(body));
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);

  //       if (result['Status'] == 1) {
  //         Iterable data = result['Appointments'];
  //         List<monthlyappointresponse> monthlyDoctorAppointment =
  //             data.map((e) => monthlyappointresponse.fromJson(e)).toList();

  //         for (int i = 0; i < monthlyDoctorAppointment.length; i++) {
  //           if (monthlyDoctorAppointment[i].paid != 0) {
  //             ManageAppointmentController.i.paid =
  //                 monthlyDoctorAppointment[i].paid +
  //                     ManageAppointmentController.i.paid;
  //           } else if (monthlyDoctorAppointment[i].unPaid != 0) {
  //             ManageAppointmentController.i.unpaid =
  //                 monthlyDoctorAppointment[i].unPaid +
  //                     ManageAppointmentController.i.unpaid;
  //           }
  //         }
  //         return monthlyDoctorAppointment;
  //       }
  //     } else {
  //       log(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     log('$e exception caught');
  //   }
  // }

  static GetmonthlyDoctorAppointment(
      String date, String worklocationid, IsOnline) async {
    ManageAppointmentController.i.paid =
        ManageAppointmentController.i.unpaid = 0;
    String? userId = await LocalDb().getDoctorId();
    var body = {
      "MonthAndYear": date,
      "DoctorId": "$userId",
      "WorkLocationId": worklocationid,
      "IsOnline": IsOnline,
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getMonthlyAppointment),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Iterable data = result['Appointments'];
          List<monthlyappointresponse> monthlyDoctorAppointment =
              data.map((e) => monthlyappointresponse.fromJson(e)).toList();
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
      "IsOnline": IsOnline,
      "WorkLocationId": WorkLocationId,
    };
    log(body.toString());
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getDayAppointment),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        DayViewAppointmentSlotModel DayViewAppointmentSlot =
            DayViewAppointmentSlotModel();
        if (result['Status'] == 1) {
          DayViewAppointmentSlot =
              DayViewAppointmentSlotModel.fromJson(jsonDecode(response.body));
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
      "Appointments": jsonEncode(Appointments),
    };
    log(body.toString());
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.rescheduleApi),
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
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.approveApi),
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
