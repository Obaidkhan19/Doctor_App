import 'dart:convert';
import 'dart:developer';

import 'package:doctormobileapplication/data/controller/ConsultingQueue_Controller.dart';
import 'package:doctormobileapplication/data/controller/appointment_history.dart';
import 'package:doctormobileapplication/models/branch.dart';
import 'package:doctormobileapplication/models/consultingqueueresponse.dart';
import 'package:doctormobileapplication/models/consultingqueuewaithold.dart';
import 'package:doctormobileapplication/models/cosultingqueuepatient.dart';
import 'package:doctormobileapplication/models/hospital_clinic.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../localDB/local_db.dart';

class ConsultingQueueRepo {
  static GetConsultingQueue(lenght) async {
    String? userId = await LocalDb().getDoctorId();
    String? branchId = await LocalDb().getBranchId();
    var body = {
      "DoctorId": userId,
      "Search": "",
      "BranchId": AppointmentHistoryController.i.selectedbranch?.id ?? branchId,
      "WorkLocationId":
          AppointmentHistoryController.i.selectedhospital?.id ?? "",
      "Status": "",
      // "FromDate": DateTime.now().toString().split(' ')[0],
      // "ToDate": DateTime.now().toString().split(' ')[0],
      "FromDate":
          AppointmentHistoryController.i.dateTimealert.toString().split(' ')[0],
      "ToDate": AppointmentHistoryController.i.dateTime2alert
          .toString()
          .split(' ')[0],
      "IsOnline": AppointmentHistoryController.i.isOnline,
      "Token": "",
      "Start": "0",
      "Length": lenght,
      "OrderColumn": "0",
      "OrderDir": "desc"
    };

    print(body);
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.consultingqueuepatient),
          headers: headers,
          body: jsonEncode(body));
      // print(body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        if (result['Status'] == 0) {
          ConsultingQueueController.i.pastconsultation.clear();
        } else if (result['Status'] == 1) {
          Iterable lst = result['Consultations'];
          List<consultingqueuereponse> rep =
              lst.map((e) => consultingqueuereponse.fromJson(e)).toList();
          log('${rep.toString()} ConsultingQueue');
          ConsultingQueueController.i.updatepastconsultinglist(rep);
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }

  // static getpatientconsultingqueue(consultingqueuepatients consult) async {
  //   ConsultingQueueModel ConsultingQueue = ConsultingQueueModel();

  //   var body = consult.toJson();
  //   print(body);
  //   var headers = {'Content-Type': 'application/json'};
  //   try {
  //     var response = await http.post(
  //         Uri.parse(AppConstants.consultingqueuepatient),
  //         headers: headers,
  //         body: jsonEncode(body));
  //     // print(body);
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       if (result['Status'] == 1) {
  //         Iterable lst = result['Consultations'];
  //         List<consultingqueuereponse> rep =
  //             lst.map((e) => consultingqueuereponse.fromJson(e)).toList();
  //         log('${rep.toString()} ConsultingQueue');
  //         ConsultingQueueController.i.updateconsultinglist(rep);
  //         //   print(ConsultingQueue);

  //       }

  //     } else {
  //       log(response.statusCode.toString());

  //     }
  //   } catch (e) {
  //     log('$e exception caught');
  //   }
  // }

  static GetConsultingQueuewaitinghold(consultingqueuepatients consult) async {
    var body = consult.toJson();
    var headers = {'Content-Type': 'application/json'};
    try {
      ConsultingQueueController.i.response.clear();
      ConsultingQueueController.i.consultingqueuewait.clear();
      ConsultingQueueController.i.consultingqueuehold.clear();
      ConsultingQueueController.i.updateIsclinicloading(true);
      var response = await http.post(
          Uri.parse(AppConstants.consultingqueuewait),
          headers: headers,
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 0) {
          ConsultingQueueController.i.updateIsclinicloading(false);
        }
        if (result['Status'] == 1) {
          Iterable lst = result['Queue'];
          List<consultingqueuewaitholdresponse> rep = lst
              .map((e) => consultingqueuewaitholdresponse.fromJson(e))
              .toList();
          if (consult.status == "1") {
            ConsultingQueueController.i.updateconsultingqueuewait(rep);
          } else if (consult.status == "2") {
            // print('waiting wueeeer');
            // print(rep);
            // print(result);
            ConsultingQueueController.i.updateconsultingqueuehold(rep);
          } else if (consult.status == "3") {
            ConsultingQueueController.i.updateconsultinglist(rep);
          }
          log('${rep.toString()} ConsultingQueue');
          ConsultingQueueController.i.updateIsclinicloading(false);
          //   print(ConsultingQueue);
        }
      } else {
        ConsultingQueueController.i.updateIsclinicloading(false);
        log(response.statusCode.toString());
      }
    } catch (e) {
      ConsultingQueueController.i.updateIsclinicloading(false);
      log('$e exception caught');
    }
  }

  Future<List<BranchData>> getBranch() async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String url = AppConstants.getBranch;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "DoctorId": doctorid,
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data'];
      List<BranchData> branchList =
          data.map((json) => BranchData.fromJson(json)).toList();

      return branchList;
    } else {
      throw Exception('Failed to fetch details');
    }
  }

  Future<List<HospitalORClinics>> getHospitalORClinic() async {
    String doctorid = await LocalDb().getDoctorId() ?? "";
    String url = AppConstants.getHospital;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "DoctorId": doctorid,
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['HospitalORClinics'];
      List<HospitalORClinics> hospitalList =
          data.map((json) => HospitalORClinics.fromJson(json)).toList();

      return hospitalList;
    } else {
      throw Exception('Failed to fetch details');
    }
  }
}
