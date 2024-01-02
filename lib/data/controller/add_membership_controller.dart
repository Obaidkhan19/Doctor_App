import 'package:doctormobileapplication/models/degree.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddMembershipController extends GetxController implements GetxService {
  static AddMembershipController get i => Get.put(AddMembershipController());

  bool isaddloading = false;
  updateisaddloading(value) {
    isaddloading = value;
    update();
  }

  late TextEditingController membershiptitle;
  late TextEditingController membershipcode;
  late TextEditingController membershipdescription;

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

  @override
  void onInit() {
    membershiptitle = TextEditingController();
    membershipcode = TextEditingController();
    membershipdescription = TextEditingController();
    super.onInit();
  }

  List<Degrees> addmembershiplocationList = [];
  Degrees? addselectedmembershiplocation = Degrees();

  updateaddmembershiplocationList(List<Degrees> dlist) {
    addmembershiplocationList = dlist;
    update();
  }

  updateaddselectedmembershiplocation(Degrees ins) {
    addselectedmembershiplocation = ins;
    update();
  }

  static DateTime? membershipfrom = DateTime.now();
  String? formattedmembershipfrom = membershipfrom!.toIso8601String();
  RxString? formatemembershipfrom =
      DateFormat.yMMMd().format(membershipfrom!).obs;

  bool addmembershipfrom = false;
  updateaddmembershipfrom(value) {
    addmembershipfrom = value;
    update();
  }

  static DateTime? membershipto = DateTime.now();
  String? formattedmembershipto = membershipto!.toIso8601String();
  RxString? formatemembershipto = DateFormat.yMMMd().format(membershipto!).obs;
  bool addmembershipto = false;
  updateaddmembershipto(value) {
    addmembershipto = value;
    update();
  }

  Future<void> selectmembershipfromDateAndTime(
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
      formattedmembershipfrom = iso8601Format.format(date);
      updateaddmembershipfrom(true);
      update();
    }
  }

  Future<void> selectmembershiptoDateAndTime(
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
      formattedmembershipto = iso8601Format.format(date);
      updateaddmembershipto(true);
      update();
    }
  }
}
