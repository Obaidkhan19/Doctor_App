import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:doctormobileapplication/screens/auth_screens/forget_password.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/genders_model.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';

import '../../models/cities_model.dart';

class AuthController extends GetxController implements GetxService {
  bool _isotpLoading = false;
  bool get isotpLoading => _isotpLoading;
  bool obsecure = true;
  bool changepassword = true;
  bool changeconfirmpassword = true;
  bool oldpassword = true;
  bool newpassword = true;
  bool newconfirmpassword = true;

  updateobsecurepassword(bool ob) {
    obsecure = !obsecure;
    update();
  }

  updatechangepassword(bool ob) {
    changepassword = !changepassword;
    update();
  }

  updatechangeconfirmpassword(bool ob) {
    changeconfirmpassword = !changeconfirmpassword;
    update();
  }

  updateoldpassword(bool ob) {
    oldpassword = !oldpassword;
    update();
  }

  updatenewpassword(bool ob) {
    newpassword = !newpassword;
    update();
  }

  updatenewconfirmpassword(bool ob) {
    newconfirmpassword = !newconfirmpassword;
    update();
  }

  updateIsotploading(bool value) {
    _isotpLoading = value;
    update();
  }

  String code = '';
  updatecode(c) {
    code = c;
    update();
  }

  String verificationcode = '';
  updateverificationcode(c) {
    verificationcode = c;
    update();
  }

  String otpemail = '';
  updatotpemail(c) {
    otpemail = c;
    update();
  }

  String otpusername = '';
  updateusername(c) {
    otpusername = c;
    update();
  }

  // Forget Password Timer
  RxInt timer = 300.obs;
  var isTimerOver = false.obs;
  void startTimer(ctx) {
    isTimerOver.value = false;
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (tim) {
      if (timer == 0) {
        isTimerOver.value = true;
        tim.cancel();
        Get.to(() => const ForgetPassword());
        showSnackbar(ctx, 'codeexpire'.tr);
      } else {
        timer--;
      }
    });
  }

  File? file;
  late TextEditingController fullname;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController identity;
  late TextEditingController password;
  late TextEditingController retypePassword;
  late TextEditingController street;

  final bool _loginStatus = false;
  bool? get loginStatus => _loginStatus;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsloading(bool value) {
    _isLoading = value;
    update();
  }

// =======> LoginControllers
  late TextEditingController emailController;
  late TextEditingController passwordController;

  resettimerupdate() {
    timer = 0.obs;
    update();
  }

  disposefields() {
    emailController.clear();
    passwordController.clear();
  }

// ===========>
  List<GendersData>? genders = [];
  GendersData? selectedGender;
  static DateTime? arrival = DateTime.now();
  RxString? formatArrival = DateFormat.yMMMd().format(arrival!).obs;
  List<Countries>? mycountries = [];
  Countries? selectedCountry;
  List<Provinces> provinces = [];
  Provinces? selectedProvince;
  List<Cities> cities = [];
  Cities? selectedCity;

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

// =================> update isLoading

// =================> Genders
  updateGender(GendersData genders) {
    selectedGender = genders;
    update();
  }

  getGendersFromAPI() async {
    genders = await AuthRepo.getGenders();

    update();
  }

  updateGenders(List<GendersData> data) {
    genders = data;
    update();
  }
//===========================> Countries

  updateSelectedCountry(Countries country) {
    selectedCountry = country;
    update();
  }

  getCountriesFromAPI() async {
    mycountries = await AuthRepo.getCountries();
    update();
    log('the countries are ${mycountries!.length}');
  }

  updateCountries(List<Countries> data) {
    mycountries = data;
    update();
  }

//===========================> Provinces

  updateSelectedProvince(Provinces? province) {
    selectedProvince = province;
    update();
  }

  getProvincesFromAPI(String countryId) async {
    provinces = await AuthRepo.getProvinces(countryId);
    update();
    log('the countries are ${mycountries!.length}');
  }

  updateProvince(Provinces data) {
    selectedProvince = data;
    update();
  }

  //=========================> Cities

  getCitiesFromAPI(String provinceId) async {
    cities = await AuthRepo.getCities(provinceId);
    update();
    log('the countries are ${mycountries!.length}');
  }

  updateCity(Cities city) {
    selectedCity = city;
    update();
  }

  updateFile(File? value) {
    file = value;
    update();
  }

  @override
  void onInit() {
    fullname = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    identity = TextEditingController();
    password = TextEditingController();
    retypePassword = TextEditingController();
    street = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // selectedGender  = genders![0];
    // log(genders![0].name.toString());

    super.onInit();
  }

  static AuthController get i => Get.put(AuthController());
}
