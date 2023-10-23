import 'package:doctormobileapplication/models/branch.dart';
import 'package:doctormobileapplication/models/hospital_clinic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentHistoryController extends GetxController {
//Getx own datatype

  static AppointmentHistoryController get i =>
      Get.put(AppointmentHistoryController());

  String switchText = 'Offline';
  bool isOnline = false;

  updateSwitch(value) {
    isOnline = value;
    if (value == true) {
      switchText = 'Online';
    } else if (value == false) {
      switchText = 'Offline';
    }
    update();
  }

  final dateFormatalert = DateFormat('yyyy-MM-dd');
//  DateTime dateTimealert = DateTime.now().subtract(const Duration(days: 30));
  DateTime dateTimealert = DateTime.now();
  DateTime dateTime2alert = DateTime.now();

  List<BranchData> branchList = [];
  BranchData? selectedbranch;
  updatebranchlist(List<BranchData> blist) {
    branchList = blist;
    update();
  }

  updatebranch(BranchData bran) {
    selectedbranch = bran;
    update();
  }

  List<HospitalORClinics> hospitalList = [];
  HospitalORClinics? selectedhospital;
  updatehospitallist(List<HospitalORClinics> hlist) {
    hospitalList = hlist;
    update();
  }

  updatehospital(HospitalORClinics bran) {
    selectedhospital = bran;
    update();
  }
}
