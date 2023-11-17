import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/hospital_clinic.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddWorklocationController extends GetxController implements GetxService {
  static AddWorklocationController get i =>
      Get.put(AddWorklocationController());

  late TextEditingController worklocationpreference;
  late TextEditingController newworklocationname;
  late TextEditingController newworklocationnameaddress;

  @override
  void onInit() {
    worklocationpreference = TextEditingController();
    newworklocationname = TextEditingController();
    newworklocationnameaddress = TextEditingController();
    super.onInit();
  }

  bool newworklocationisChecked = false;

  List<HospitalORClinics> addworklocationhospitalList = [];
  HospitalORClinics? addworklocationselectedhospital;
  updateaddworklocationhospitallist(List<HospitalORClinics> hlist) {
    addworklocationhospitalList = hlist;
    update();
  }

  updateaddworklocationselectedhospital(HospitalORClinics bran) {
    addworklocationselectedhospital = bran;
    update();
  }

  List<Countries> addworklocationcountriesList = [];
  Countries? addselectedworklocationcountry = Countries();
  updateaddworklocationcountriesList(List<Countries> clist) {
    addworklocationcountriesList = clist;
    update();
  }

  updateaddselectedworklocationcountry(Countries country) {
    addselectedworklocationcountry = country;
    update();
  }

  List<Provinces> addworklocationstateList = [];
  Provinces? addselectedworklocationstate = Provinces();
  updateaddworklocationstateList(List<Provinces> plist) {
    addworklocationstateList = plist;
    update();
  }

  updateaddselectedworklocationstate(Provinces state) {
    addselectedworklocationstate = state;
    update();
  }

  List<Cities> addworklocationcitiesList = [];
  Cities? addselectedworklocationCities = Cities();
  updateaddworklocationcitiesList(List<Cities> clist) {
    addworklocationcitiesList = clist;
    update();
  }

  updateaddselectedworklocationCities(Cities cities) {
    addselectedworklocationCities = cities;
    update();
  }
}
