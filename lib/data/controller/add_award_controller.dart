import 'package:doctormobileapplication/models/degree.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddAwardController extends GetxController implements GetxService {
  static AddAwardController get i => Get.put(AddAwardController());

  bool isaddloading = false;
  updateisaddloading(value) {
    isaddloading = value;
    update();
  }

  late TextEditingController title;
  late TextEditingController code;
  late TextEditingController description;

  @override
  void onInit() {
    title = TextEditingController();
    code = TextEditingController();
    description = TextEditingController();
    super.onInit();
  }

  List<Degrees> awardList = [];
  Degrees? selectedawardlocation = Degrees();

  updateawardList(List<Degrees> dlist) {
    awardList = dlist;
    update();
  }

  updateselectedaward(Degrees ins) {
    selectedawardlocation = ins;
    update();
  }

  List<Degrees> OrganizationList = [];
  Degrees? selectedOrganization = Degrees();

  updateOrganizationList(List<Degrees> olist) {
    OrganizationList = olist;
    update();
  }

  updateselectedOrganization(Degrees org) {
    selectedOrganization = org;
    update();
  }

  static DateTime? awardeddate = DateTime.now();
  String? formattedawardeddate = awardeddate!.toIso8601String();
  RxString? formateawardeddate = DateFormat.yMMMd().format(awardeddate!).obs;

  bool awarddateselect = false;
  updateawarddateselect(value) {
    awarddateselect = value;
    update();
  }

  Future<void> selectformattedawardedDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      formattedDate.value = DateFormat.yMMMd().format(date);
      final iso8601Format = DateFormat("yyyy-MM-dd'T'00:00:00");
      formattedawardeddate = iso8601Format.format(date);
      updateawarddateselect(true);
      update();
    }
  }
}
