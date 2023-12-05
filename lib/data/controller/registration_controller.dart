import 'dart:io';

import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/genders_model.dart';
import 'package:doctormobileapplication/models/marital_status.dart';
import 'package:doctormobileapplication/models/person_title.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:doctormobileapplication/models/speciality.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class RegistrationController extends GetxController implements GetxService {
  static RegistrationController get i => Get.put(RegistrationController());

  bool usernameavaibility = false;
  bool passportavaibility = false;
  bool pmdcavaibility = false;
  bool idnoavaibility = false;

  updateusernameavaibility(value) {
    usernameavaibility = value;
    update();
  }

  updatepassportavaibility(value) {
    passportavaibility = value;
    update();
  }

  updateepmdcavaibility(value) {
    pmdcavaibility = value;
    update();
  }

  updateidnoavaibility(value) {
    idnoavaibility = value;
    update();
  }

  disposevalues() {
    _indexp = 0;
    firstname.clear();
    lastname.clear();
    email.clear();
    idnumber.clear();
    imcno.clear();
    username.clear();
    password.clear();
    phone.clear();
    retypePassword.clear();
    address.clear();
    imagepath = null;
    filepath = null;
    arrival = DateTime.now();
    formattedArrival = null;
    formatearrival = DateFormat.yMMMd().format(arrival!).obs;
    selectedgender = null;
    selectedSpecialitiesList.clear();
    selectedSubSpecialitiesList.clear();
    selectedcountry = null;
    selectedpersonalTitle = null;
    selectedcity = null;
    selectedprovince = null;
    selectedmaritalStatus = null;
    selectedspecialities = null;
    selectedsubspecialities = null;
    file = null;
    pmcfile = null;
    ontap = false;
    update();
  }

  bool securitypassword = true;
  bool securityconfirmpassword = true;

  updatesecuritypassword() {
    securitypassword = !securitypassword;
    update();
  }

  updateconfirmpassword() {
    securityconfirmpassword = !securityconfirmpassword;
    update();
  }

  String countryfullnumber = '';
  updatecountryfullno(no) {
    countryfullnumber = no;
    update();
  }

  bool _isSavingPath = false;
  bool get isSavingPath => _isSavingPath;

  updateIsSavingPath(bool value) {
    _isSavingPath = value;
    update();
  }

  String? imagepath;
  String? filepath;

  updateimagepath(String path) {
    imagepath = path;
    update();
  }

  updatefilepath(String path) {
    filepath = path;
    update();
  }

  bool ontap = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsloading(bool value) {
    _isLoading = value;
    update();
  }

  int _indexp = 0;
  int get indexp => _indexp;

  getPageIndexofPersonal() {
    return _indexp;
  }

  setPageIndexofDayPersonal(int ind) {
    _indexp = ind;
    update();
  }

  String userage = '';

  void calculateUserAge(DateTime? birthDate) {
    final currentDate = DateTime.now();
    final age = currentDate.year -
        birthDate!.year -
        (currentDate.month > birthDate.month ||
                (currentDate.month == birthDate.month &&
                    currentDate.day >= birthDate.day)
            ? 0
            : 1);
    userage = age.toString();
    if (age > 1) {
      userage = "$userage  Years";
    }
    if (age <= 1) {
      userage = "$userage  Year";
    }
  }

  static DateTime? arrival = DateTime.now();
  updatearrival(ardate) {
    arrival = ardate;
    update();
  }

  String? formattedArrival = arrival!.toIso8601String();
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
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      formattedDate.value = DateFormat.yMMMd().format(date);
      final iso8601Format = DateFormat("yyyy-MM-dd'T'00:00:00");
      formattedArrival = iso8601Format.format(date);
      calculateUserAge(date);
      updatearrival(date);
      update();
    }
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
      bool permissioncheck = await Permission.storage.isGranted;
      if (!permissioncheck) {
        Fluttertoast.showToast(
            msg: 'PleasegivestoragePermissiontoapplication'.tr,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.kRedColor,
            textColor: ColorManager.kWhiteColor,
            fontSize: 14.0);
      } else {
        Fluttertoast.showToast(
            msg: 'Somethingwentwrong'.tr,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.kRedColor,
            textColor: ColorManager.kWhiteColor,
            fontSize: 14.0);
      }
    }
    update();
    return file;
  }

  PlatformFile? pmcfile;
  Future<void> picksinglefile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        pmcfile = result.files.first;
      }
    } catch (e) {
      bool permissioncheck = await Permission.storage.isGranted;
      if (!permissioncheck) {
        Fluttertoast.showToast(
            msg: 'PleasegivestoragePermissiontoapplication'.tr,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.kRedColor,
            textColor: ColorManager.kWhiteColor,
            fontSize: 14.0);
      } else {
        Fluttertoast.showToast(
            msg: 'Somethingwentwrong'.tr,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.kRedColor,
            textColor: ColorManager.kWhiteColor,
            fontSize: 14.0);
      }
    }
  }

  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController email;
  late TextEditingController idnumber;
  late TextEditingController imcno;
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController phone;
  late TextEditingController retypePassword;
  late TextEditingController address;
  late TextEditingController dob;

  @override
  void onInit() {
    dob = TextEditingController();
    firstname = TextEditingController();
    lastname = TextEditingController();
    email = TextEditingController();
    idnumber = TextEditingController();
    imcno = TextEditingController();
    username = TextEditingController();
    password = TextEditingController();
    retypePassword = TextEditingController();
    phone = TextEditingController();
    address = TextEditingController();
    super.onInit();
  }

  List<GendersData> genderList = [];
  GendersData? selectedgender;
  updategenderList(List<GendersData> glist) {
    genderList = glist;
    update();
  }

  updateselectedgender(GendersData gender) {
    selectedgender = gender;
    update();
  }

  deleteSelectedgender() {
    selectedgender = null;
    update();
  }

  String selectedRadioValue = 'idno';

  updateRadioValue(value) {
    selectedRadioValue = value;
    update();
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

  List<MSData> maritalStatusList = [];
  MSData? selectedmaritalStatus;
  updatemaritalStatusList(List<MSData> mslist) {
    maritalStatusList = mslist;
    update();
  }

  updateselectedmaritalStatus(MSData maritalstatus) {
    selectedmaritalStatus = maritalstatus;
    update();
  }

  deleteSelectedmaritalStatus() {
    selectedmaritalStatus = null;
    update();
  }

  List<Specialities1> specialitiesList = [];
  List<Specialities1> selectedSpecialitiesList = [];
  Specialities1? selectedspecialities;
  updatespecialitiesList(List<Specialities1> slist) {
    specialitiesList = slist;

    update();
  }

  updateselectedspeciality(Specialities1 s) {
    selectedspecialities = s;
    selectedSpecialitiesList.add(s);
    update();
  }

  deleteSelectedspeciality() {
    selectedspecialities = null;
    update();
  }

  //
  List<Specialities1> subspecialitiesList = [];
  Specialities1? selectedsubspecialities;
  List<Specialities1> selectedSubSpecialitiesList = [];
  updatesubspecialitiesList(List<Specialities1> slist) {
    subspecialitiesList = slist;
    update();
  }

  updateselectedsubspeciality(Specialities1 s) {
    selectedsubspecialities = s;
    selectedSubSpecialitiesList.add(s);
    update();
  }

  deleteSelectedsubspeciality() {
    selectedsubspecialities = null;
    update();
  }

  List<PTitle> personalTitleList = [];
  PTitle? selectedpersonalTitle;
  updatepersonalTitleList(List<PTitle> plist) {
    personalTitleList = plist;
    update();
  }

  updateselectedpersonalTitle(PTitle p) {
    selectedpersonalTitle = p;
    update();
  }

  deleteSelectedpersonalTitle() {
    selectedpersonalTitle = null;
    update();
  }
}
