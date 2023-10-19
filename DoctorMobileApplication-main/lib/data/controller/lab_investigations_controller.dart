import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/data/repositories/lab_investigation_repo/lab_investigation_repo.dart';
import 'package:doctormobileapplication/models/packages_model.dart';

import '../../models/lab_tests_model.dart';
import '../../screens/lab_screens/lab_investigations.dart';

class LabInvestigationController extends GetxController implements GetxService {
  int? _selectedValue;
  int? get selectedalue => _selectedValue;
  List<Data>? labtests = [];
  List<LabPackages>? labPackages = [];
  static TimeOfDay selectedTime = TimeOfDay.now();
  RxString? formattedSelectedTime = selectedTime.toString().obs;

  Data? selectedLabtest;
  LabPackages? selectedLabPackage;
  DateTime? selectedDate;
  late TextEditingController? description;

  List<Widget> summaryWidgets = []; // Initialize with an empty list

  updateSelectedValue(int value) {
    _selectedValue = value;
    update();
  }

  updateSelectedDatae(DateTime date) {
    selectedDate = date;
    update();
  }

  updatePackages(List<LabPackages>? packages) {
    labPackages = packages;
    update();
  }

  updateSelectedLabPackage(LabPackages packages) {
    selectedLabPackage = packages;
    update();
  }

  getAllPackages() async {
    List<LabPackages> packages = await LabInvestigationRepo().getPackages();
    updatePackages(packages);
    log('${labPackages?.length}');
  }

  // updateSummaryWidgets() {
  //   // Update the list of widgets as needed
  //   summaryWidgets = [
  //     const DetailsRow(
  //       title: 'Test Sample',
  //       description: 'Oral Glucose Tolerance',
  //     ),
  //     const DetailsRow(
  //       title: 'Date & Hour',
  //       description: 'Aug 19, 2023 || 9:00 AM - 10 AM',
  //     ),
  //     const DetailsRow(
  //       title: 'Package',
  //       description: 'Home Sampling',
  //     ),
  //     DetailsRow(
  //       title: 'Prescribed By',
  //       description: '${LabInvestigationController().selectedalue}',
  //     ),
  //     const DetailsRow(
  //       title: 'Address',
  //       description: 'RawalPindi, Pakistan',
  //     ),
  //   ];
  //   update();
  // }

  Future<void> selectTime(
    BuildContext context,
    TimeOfDay time,
    RxString? formattedTime,
  ) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (pickedTime != null && pickedTime != time) {
      time = pickedTime;
      formattedTime!.value = time.format(Get.context!);
      update();
    }
  }

  getLabTests() async {
    LabTestsModel result = await LabInvestigationRepo.getLabTests();
    labtests = result.data;
    log(labtests!.length.toString());
  }

  updateLabTest(Data labTest) {
    selectedLabtest = labTest;
    update();
  }

  @override
  void onInit() {
    description = TextEditingController();
    super.onInit();
  }

  static LabInvestigationController get i =>
      Get.put(LabInvestigationController());
}
