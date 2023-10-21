import 'package:doctormobileapplication/models/branch.dart';
import 'package:doctormobileapplication/models/hospital_clinic.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class AppointmentHistoryController extends GetxController {
//Getx own datatype

  static AppointmentHistoryController get i =>
      Get.put(AppointmentHistoryController());
  bool isOnline = false;

  updateSwitch(value) {
    isOnline = value;
    update();
  }

  final dateFormatalert = DateFormat('yyyy-MM-dd');
  DateTime dateTimealert = DateTime.now().subtract(const Duration(days: 30));
  DateTime dateTime2alert = DateTime.now();

  // String barnchselectedoption = '';
  // List<String> branchList = [
  //   'A',
  //   'B',
  //   'C',
  //   'D',
  //   'E',
  //   'F',
  //   'G',
  //   'H',
  //   'I',
  // ];

  // String hospitalselectedoption = '';
  // List<String> hospitalList = [
  //   'Hospital 1',
  //   'Hospital 2',
  //   'Hospital 3',
  // ];

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
