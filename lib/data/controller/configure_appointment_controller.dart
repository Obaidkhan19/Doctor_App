import 'package:doctormobileapplication/components/Customrowdesign.dart';
import 'package:doctormobileapplication/models/hospital_clinic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  List<HospitalORClinics> approvalcriterialList = [];
  HospitalORClinics? selectedapprovalcriterial;
  updateapprovalcriterialList(List<HospitalORClinics> hlist) {
    approvalcriterialList = hlist;
    update();
  }

  updateapprovalcriterial(HospitalORClinics bran) {
    selectedapprovalcriterial = bran;
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
