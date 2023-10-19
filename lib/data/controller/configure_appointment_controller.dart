import 'package:doctormobileapplication/components/Customrowdesign.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interval_time_picker/interval_time_picker.dart';

class ConfigureAppointmentController extends GetxController
    implements GetxService {
  TextEditingController consultancyfeeController = TextEditingController();
  TextEditingController followupfeeController = TextEditingController();
  TextEditingController followupdayController = TextEditingController();

  bool isHospitalExpanded = false;

  addAppointmentDateTime() {
    update();
  }

  updateisHospitalExpanded() {
    isHospitalExpanded = !isHospitalExpanded;
    update();
  }

  disposefunction() {
    consultancyfeeController.clear();
    followupdayController.clear();
    followupfeeController.clear();
  }

  String hospitalselectedoption = "Institute of Cardiology";
  List<String> hospitalList = [
    'Institute of Cardiology',
    'Institute of Cardiology 1',
    'Institute of Cardiology 2000',
  ];

  updatehospital(String selected) {
    hospitalselectedoption = selected;
    isHospitalExpanded = false;
    update();
  }

  String approvalselectedoption = "Approved by PA only";
  List<String> approvalList = [
    'Approved by PA only',
    'Approved by PA only 1',
    'Approved by PA only 2000',
  ];

  updateapproval(String selected) {
    approvalselectedoption = selected;
    isApprovalExpanded = false;
    update();
  }

  bool isApprovalExpanded = false;

  updateisApprovalExpanded() {
    isApprovalExpanded = !isApprovalExpanded;
    update();
  }

  bool isOnline = false;
  updateoOnline(value) {
    isOnline = value;
    update();
  }

  String getDayName(int index) {
    switch (index) {
      case 0:
        return 'monday'.tr;
      case 1:
        return 'tuesday'.tr;
      case 2:
        return 'wednesday'.tr;
      case 3:
        return 'thursday'.tr;
      case 4:
        return 'friday'.tr;
      case 5:
        return 'saturday'.tr;
      case 6:
        return 'sunday'.tr;
      default:
        return '';
    }
  }

  List<bool> switchStates = [false, false, false, false, false, false, false];
  List<List<Widget>> dayRows = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
  void toggleSwitch(int index) {
    switchStates[index] = !switchStates[index];
    update();
  }

  falseSwitch() {
    for (int i = 0; i < switchStates.length; i++) {
      switchStates[i] = false;
      update();
    }
  }

  clearrows() {
    for (int i = 0; i < dayRows.length; i++) {
      dayRows[i].clear();
    }
    update();
  }

  initialrows(context) {
    for (int i = 0; i < dayRows.length; i++) {
      dayRows[i].add(configureappointrow(
        ctx: context,
        dayindex: 0,
      ));
      update();
    }
  }

  void addRow(int dayIndex, context) {
    dayRows[dayIndex].add(configureappointrow(
      ctx: context,
      dayindex: dayIndex,
    ));

    update();
  }

  static ConfigureAppointmentController get i =>
      Get.put(ConfigureAppointmentController());
}
