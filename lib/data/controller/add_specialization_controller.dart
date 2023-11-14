import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/models/institutes.dart';
import 'package:doctormobileapplication/models/speciality.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddSpecializationController extends GetxController
    implements GetxService {
  static AddSpecializationController get i =>
      Get.put(AddSpecializationController());

  List<Specialities1> addspecialitiesList = [];
  Specialities1? addselectedspecialities;
  updateaddspecialitiesList(List<Specialities1> slist) {
    addspecialitiesList = slist;
    update();
  }

  updateaddselectedspeciality(Specialities1 s) {
    addselectedspecialities = s;
    update();
  }

  List<Specialities1> addsubspecialitiesList = [];
  Specialities1? addselectedsubspecialities;

  updateaddsubspecialitiesList(List<Specialities1> slist) {
    addsubspecialitiesList = slist;
    update();
  }

  updateaddselectedsubspeciality(Specialities1 s) {
    addselectedsubspecialities = s;
    update();
  }
}
