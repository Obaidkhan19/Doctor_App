
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/configure_appointment_controller.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
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
      ConfigureAppointmentController.i.workLocationsList.clear();
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['WorkLocations'];
      List<WorkLocations> worklocationList =
          data.map((json) => WorkLocations.fromJson(json)).toList();

      return worklocationList;
    } else {
      throw Exception('Failed to fetch details');
    }
  }

  Future<String> getAppointmentConfiguration() async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String url = AppConstants.getappointconfiguration;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "DoctorId": doctorid,
    });
    ConfigureAppointmentController.i.updateIsloading(true);
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      ConfigureAppointmentController.i.appointmentconfigurationList.clear();
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      if (status == 1) {
        Iterable rawafData = responseData['AppointmentConfigurations'] ?? [];
        List<AppointmentConfigurations> af = rawafData
            .map((item) => AppointmentConfigurations.fromJson(item))
            .toList();
        ConfigureAppointmentController.i
            .updateAppointmentConfigurationsList(af);
        await ConfigureAppointmentController.i.updateIsloading(false);
        return 'true';
      } else {
        await ConfigureAppointmentController.i.updateIsloading(false);
        return 'false';
      }
    } else {
      await ConfigureAppointmentController.i.updateIsloading(false);
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
      "Id": "",
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
    try {
      var response = await http.post(
          Uri.parse(AppConstants.appointconfiguration),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          showSnackbar(Get.context!, msg);
          return 'true';
        } else if (status == -5) {
          showSnackbar(Get.context!, msg);
          return 'false';
        }
      }
    } catch (e) {
      showSnackbar(Get.context!, e.toString());
      return 'false';
    }
    return 'false';
  }

  Future<String> editAppointmentConfiguration(
      mainid,
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
      "Id": mainid,
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
    try {
      var response = await http.post(
          Uri.parse(AppConstants.editappointconfiguration),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          showSnackbar(Get.context!, msg);
          return msg;
        } else if (status == -5) {
          showSnackbar(Get.context!, msg);
          return msg;
        }
      }
    } catch (e) {
      showSnackbar(Get.context!, e.toString());
      return 'false';
    }
    return 'false';
  }

  Future<String> makedefaultAppointmentConfiguration(
    mainid,
    doctorid,
    worklocationid,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "Id": mainid,
      "DoctorId": doctorid,
      "WorkLocationId": worklocationid,
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.makedefaultappointconfiguration),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          showSnackbar(Get.context!, msg);
          return msg;
        } else if (status == -5) {
          showSnackbar(Get.context!, msg);
          return msg;
        }
      }
    } catch (e) {
      showSnackbar(Get.context!, e.toString());
      return 'false';
    }
    return 'false';
  }

  Future<String> pauseresumeAppointmentConfiguration(
    mainid,
    doctorid,
    worklocationid,
    status,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "Id": mainid,
      "DoctorId": doctorid,
      "WorkLocationId": worklocationid,
      "Status": status,
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.changeappointconfigurationstatus),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          showSnackbar(Get.context!, msg);
          return msg;
        } else if (status == -5) {
          showSnackbar(Get.context!, msg);
          return msg;
        }
      }
    } catch (e) {
      showSnackbar(Get.context!, e.toString());
      return 'false';
    }
    return 'false';
  }
}
