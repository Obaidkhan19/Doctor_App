import 'dart:convert';
import 'dart:developer';

import 'package:doctormobileapplication/data/controller/ConsultingQueue_Controller.dart';
import 'package:doctormobileapplication/models/consultingqueueresponse.dart';
import 'package:doctormobileapplication/models/consultingqueuewaithold.dart';
import 'package:doctormobileapplication/models/cosultingqueuepatient.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/consulting_queue.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../../models/ConsultingQueue.dart';
import '../../localDB/local_db.dart';

class ConsultingQueueRepo {
  static GetConsultingQueue(String? Search, String? Status, int length) async {
    ConsultingQueueModel ConsultingQueue = ConsultingQueueModel();
    String? userId = await LocalDb().getDoctorId();
    String? userToken = await LocalDb().getToken();
    String? branchId = await LocalDb().getBranchId();
    var body = {
      "DoctorId": "$userId",
      "Length": AppConstants.maximumDataTobeFetched.toString(),
      "OrderColumn": "0",
      "Start": "$length",
      "OrderDir": "desc",
      "Search": "$Search",
      "Status": "$Status",
      "Token": "$userToken",
      "BranchId": "$branchId"
    };
    print(body);
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.WaitingQueueApi),
          headers: headers, body: jsonEncode(body));
      // print(body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ConsultingQueue =
              ConsultingQueueModel.fromJson(jsonDecode(response.body));
          log('${ConsultingQueue.toString()} ConsultingQueue');
          //   print(ConsultingQueue);
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
    ConsultingQueueModel ConsultingQueue = ConsultingQueueModel();

    var body = consult.toJson();
    print(body);
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.consultingqueuewait),
          headers: headers,
          body: jsonEncode(body));
      // print(body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Iterable lst = result['Queue'];
          List<consultingqueuewaitholdresponse> rep =
              lst.map((e) => consultingqueuewaitholdresponse.fromJson(e)).toList();
              if(consult.status=="1")
              {
                ConsultingQueueController.i.updateconsultingqueuewait(rep);
              }
              else  if(consult.status=="2"){
                ConsultingQueueController.i.updateconsultingqueuehold(rep);
              }
              else  if(consult.status=="3"){
                ConsultingQueueController.i.updateconsultinglist(rep);
              }
          log('${rep.toString()} ConsultingQueue');
          //   print(ConsultingQueue);
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e exception caught');
    }
  }


}
