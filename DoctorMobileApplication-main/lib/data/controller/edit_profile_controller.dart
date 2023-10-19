import 'dart:io';

import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProfileController extends GetxController implements GetxService {
  static EditProfileController get i => Get.put(EditProfileController());
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsloading(bool value) {
    _isLoading = value;
    update();
  }

  disposefile() {
    file = null;
  }

  File? file;
  Future<File?> pickImage({
    bool allowMultiple = false,
    BuildContext? context,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: allowMultiple);
      if (result != null) {
        file = File(result.files.first.path!);
      }
    } catch (e) {
      showSnackbar(Get.context!, e.toString());
    }
    update();
    return file;
  }

  String? name;
  String? dob;
  String? number;
  String? email;
  String? country;
  String? province;
  String? city;
  String? address;
  String? countryid;
  String? provinceid;
  String? cityid;

  static DateTime? arrival = DateTime.now();
  RxString? formatearrival = DateFormat.yMMMd().format(arrival!).obs;

  Future<void> selectDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);

      update();
    }
  }

  List<Countries> countriesList = [];
  Countries? selectedcountry;
  updatecountriesList(List<Countries> clist) {
    countriesList = clist;
    update();
  }

  updateselectedCountry(Countries country) {
    selectedcountry = country;

    update();
  }

  deleteSelectedCountry() {
    selectedcountry = null;
    update();
  }

  List<Provinces> provinceList = [];
  Provinces? selectedprovince;
  updateprovinceList(List<Provinces> plist) {
    provinceList = plist;
    update();
  }

  updateselectedprovince(Provinces province) {
    selectedprovince = province;
    update();
  }

  deleteSelectedprovince() {
    selectedprovince = null;
    update();
  }

  List<Cities> citiesList = [];
  Cities? selectedcity;
  updatecitiesList(List<Cities> clist) {
    citiesList = clist;
    update();
  }

  updateselectedcity(Cities city) {
    selectedcity = city;
    update();
  }

  deleteSelectedcity() {
    selectedcity = null;
    update();
  }
}
