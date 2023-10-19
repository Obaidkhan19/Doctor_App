import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AppointmentHistoryController extends GetxController {
//Getx own datatype
  bool isOnline = false;

  updateSwitch(value) {
    isOnline = value;
    update();
  }

  String barnchselectedoption = '';
  List<String> branchList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
  ];

  String hospitalselectedoption = '';
  List<String> hospitalList = [
    'Hospital 1',
    'Hospital 2',
    'Hospital 3',
  ];
}
