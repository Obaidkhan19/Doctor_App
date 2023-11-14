import 'package:doctormobileapplication/models/degree.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddExperienceController extends GetxController implements GetxService {
  static AddExperienceController get i => Get.put(AddExperienceController());

  late TextEditingController jobtitle;
  late TextEditingController experienceDescription;
  @override
  void onInit() {
    jobtitle = TextEditingController();
    experienceDescription = TextEditingController();
    super.onInit();
  }

  List<Degrees> addexperiencelocationList = [];
  Degrees? addselectedexperiencelocation = Degrees();

  updateaddexperiencelocationList(List<Degrees> dlist) {
    addexperiencelocationList = dlist;
    update();
  }

  updateaddselectedexperiencelocation(Degrees ins) {
    addselectedexperiencelocation = ins;

    update();
  }

  bool currentlyworkingisChecked = false;

  static DateTime? experiencefrom = DateTime.now();
  String? formattedexperiencefrom = experiencefrom!.toIso8601String();
  RxString? formateexperiencefrom =
      DateFormat.yMMMd().format(experiencefrom!).obs;
  Future<void> selectexperiencefromDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      formattedDate.value = DateFormat.yMMMd().format(date);
      final iso8601Format = DateFormat("yyyy-MM-dd'T'00:00:00");
      formattedexperiencefrom = iso8601Format.format(date);
      update();
    }
  }

  PlatformFile? experiencefile;
  Future<void> picksingleexperiencefile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      experiencefile = result.files.first;
    }
  }

  static DateTime? experienceto = DateTime.now();
  String? formattedexperienceto = experienceto!.toIso8601String();
  RxString? formateexperienceto = DateFormat.yMMMd().format(experienceto!).obs;
  Future<void> selectexperiencetoDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      formattedDate.value = DateFormat.yMMMd().format(date);
      final iso8601Format = DateFormat("yyyy-MM-dd'T'00:00:00");
      formattedexperienceto = iso8601Format.format(date);
      update();
    }
  }
}
