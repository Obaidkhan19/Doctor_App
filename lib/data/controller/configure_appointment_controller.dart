import 'package:doctormobileapplication/components/Customrowdesign.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:doctormobileapplication/models/hospital_clinic.dart';
import 'package:doctormobileapplication/models/work_locations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigureAppointmentController extends GetxController
    implements GetxService {
  TextEditingController consultancyfeeController = TextEditingController();
  TextEditingController followupfeeController = TextEditingController();
  TextEditingController followupdayController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  updateIsloading(bool value) {
    _isLoading = value;
    update();
  }

  bool isSavingLoading = false;
  updateIsSavingloading(bool value) {
    isSavingLoading = value;
    update();
  }

  bool hasOnlineConsultation = false;
  updatehasOnlineConsultation() {
    hasOnlineConsultation = true;
    update();
  }

  updatedispose() {
    switchStates = [false, false, false, false, false, false, false];
    isOnline = false;
    followupdayController.clear();
    followupfeeController.clear();
    consultancyfeeController.clear();
    hasOnlineConsultation = false;
    initializeSelectedApprovalCriteria();

    updatehospital(HospitalORClinics());
  }

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

  List<ApprovalCriteria> approvalCriteriaList = [
    ApprovalCriteria(1, 'approvedByPAOnly'.tr),
    ApprovalCriteria(2, 'approvedByDoctorOnly'.tr),
    ApprovalCriteria(3, 'approvedByPAandDoctor'.tr),
    ApprovalCriteria(4, 'autoApproved'.tr),
  ];

  ApprovalCriteria? selectedApprovalCriteria;

  void initializeSelectedApprovalCriteria() {
    selectedApprovalCriteria = approvalCriteriaList[0];
  }

  void updateApprovalCriteria(ApprovalCriteria criteria) {
    selectedApprovalCriteria = criteria;
  }

  List<WorkLocations> workLocationsList = [];
  WorkLocations? selectedWorkLocations;
  updateWorkLocationslist(List<WorkLocations> wllist) {
    workLocationsList = wllist;
    update();
  }

  updateWorkLocations(WorkLocations wl) {
    selectedWorkLocations = wl;
    update();
  }

  List<AppointmentConfigurations> appointmentconfigurationList = [];
  AppointmentConfigurations? selectedappointmentconfiguration;
  updateAppointmentConfigurationsList(List<AppointmentConfigurations> aflist) {
    appointmentconfigurationList = aflist;
    for (int i = 0; i < aflist.length; i++) {
      if (aflist[i].isOnlineConfiguration == true) {
        updatehasOnlineConsultation();
      }
    }
    update();
  }

  updateAppointmentConfigurations(AppointmentConfigurations af) {
    selectedappointmentconfiguration = af;
    update();
  }

  bool isOnline = false;
  updateoOnline(value) {
    if (value) {
      isOnline = true;
      selectedhospital = null;
    } else {
      isOnline = false;
    }
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

  List<int> daylst = [];

  // addintodays(int index) {
  //   daylst.add(index);
  //   update();
  // }

  // deletefromdays(int index) {
  //   daylst.removeAt(index);
  //   update();
  // }

  addintodays(int index) {
    if (!daylst.contains(index)) {
      daylst.add(index);
    }
    update();
  }

  deletefromdays(int index) {
    if (daylst.contains(index)) {
      daylst.remove(index);
    }
    update();
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
    daylst.clear();
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

class ApprovalCriteria {
  int id;
  String name;

  ApprovalCriteria(this.id, this.name);
}
