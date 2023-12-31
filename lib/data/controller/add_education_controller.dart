import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/models/institutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEducationController extends GetxController implements GetxService {
  static AddEducationController get i => Get.put(AddEducationController());

  clearAddValues() {
    DateTime? day = DateTime.now();
    formatteddegreestart = day.toIso8601String();
    formatteddegreeend = day.toIso8601String();
    formatteddegreeissue = day.toIso8601String();
    selectededucationaddcountry = null;
    educationaddselectedinstitution = null;
    educationaddselecteddegree = null;
    educationaddselectedfieldofstudy = null;

    totalmarks.clear();
    obtainedmarks.clear();
    percentage.clear();
    inprogressisChecked = false;
    radioselectedValue = "CGPA";
    update();
  }

  bool isaddloading = false;
  updateisaddloading(value) {
    isaddloading = value;
    update();
  }

  List<Countries> educationaddcountriesList = [];
  Countries? selectededucationaddcountry = Countries();
  updateeducationaddcountriesList(List<Countries> clist) {
    educationaddcountriesList = clist;
    update();
  }

  updateselectededucationaddCountry(Countries country) {
    selectededucationaddcountry = country;
    update();
  }

  List<Institutions> educationaddinstitutionList = [];
  Institutions? educationaddselectedinstitution = Institutions();
  updateeducationaddinstitutionlist(List<Institutions> ilist) {
    educationaddinstitutionList = ilist;
    update();
  }

  updateeducationaddselectedInstitution(Institutions ins) {
    educationaddselectedinstitution = ins;
    update();
  }

  List<Degrees> educationadddegreesList = [];
  Degrees? educationaddselecteddegree = Degrees();

  updatededucationaddegreesList(List<Degrees> dlist) {
    educationadddegreesList = dlist;
    update();
  }

  updateeducationaddselecteddegree(Degrees ins) {
    educationaddselecteddegree = ins;

    update();
  }

  List<Degrees> educationaddfieldofstudyList = [];
  Degrees? educationaddselectedfieldofstudy = Degrees();

  updateeducationaddfieldofstudyList(List<Degrees> dlist) {
    educationaddfieldofstudyList = dlist;
    update();
  }

  updateeducationaddselectedfieldofstudy(Degrees ins) {
    educationaddselectedfieldofstudy = ins;

    update();
  }

  static DateTime? degreestart = DateTime.now();
  String? formatteddegreestart = degreestart!.toIso8601String();
  RxString? formatedegreestart = DateFormat.yMMMd().format(degreestart!).obs;
  updatedegreestart(ardate) {
    degreestart = ardate;
    update();
  }

  Future<void> selecteducationstartDateAndTime(
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
      formatteddegreestart = iso8601Format.format(date);
      updatedegreestart(date);
      update();
    }
  }

  bool inprogressisChecked = false;

  static DateTime? degreeend = DateTime.now();
  String? formatteddegreeend = degreeend!.toIso8601String();
  RxString? formatedegreeend = DateFormat.yMMMd().format(degreeend!).obs;

  updatedegreeend(ardate) {
    degreeend = ardate;
    update();
  }

  Future<void> selecteducationendDateAndTime(
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
      formatteddegreeend = iso8601Format.format(date);
      updatedegreeend(date);
      update();
    }
  }

  updatedegreeissue(ardate) {
    degreeissue = ardate;
    update();
  }

  static DateTime? degreeissue = DateTime.now();
  String? formatteddegreeissue = degreeissue!.toIso8601String();
  RxString? formatedegreeissue = DateFormat.yMMMd().format(degreeissue!).obs;

  Future<void> selecteducationissueDateAndTime(
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
      formatteddegreeissue = iso8601Format.format(date);
      updatedegreeissue(date);
      update();
    }
  }

  String radioselectedValue = "CGPA";

  updateradiovalue(value) {
    radioselectedValue = value;
    update();
  }

  late TextEditingController totalmarks;
  late TextEditingController obtainedmarks;
  late TextEditingController percentage;

  @override
  void onInit() {
    totalmarks = TextEditingController();
    obtainedmarks = TextEditingController();
    percentage = TextEditingController();
    super.onInit();
  }
}
