import 'dart:convert';
import 'dart:developer';

import 'package:doctormobileapplication/models/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDb {
  setBaseURL(String? url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('baseurl', '$url');
  }

  Future<String?>? getBaseURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('baseurl');
    return result;
  }

  saveUsername(String? username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('Username', '$username');
  }

  Future<String?>? getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('Username');
    return result;
  }

  savePassword(String? password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('Password', '$password');
  }

  Future<String?>? getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('Password');
    return result;
  }

  static savefingerprint(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('fingerprint', val);
  }

  static getfingerprint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool returnvalue = prefs.getBool('fingerprint') ?? false;
    return returnvalue;
  }

  removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('BranchId');
    prefs.remove('DoctorUserImagePath');
    prefs.remove('DoctorPMDCNumber');
    prefs.remove('DoctorFullName');
    prefs.remove('loginDataObject');
    prefs.remove('DoctorId');
    prefs.remove('token');
    prefs.remove('Onlinestatus');
    prefs.remove('status');
    prefs.remove('Email');
    prefs.remove('PhoneNo');
    prefs.remove('Username');
    prefs.remove('Password');
    prefs.remove('Onlinestatus');
  }

  saveBranchId(String? branchId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('BranchId', '$branchId');
    log('BranchId $result');
  }

  Future<String?>? getBranchId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('BranchId');
    return result;
  }

  saveDoctorUserImagePath(String? DoctorUserImagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('DoctorUserImagePath', '$DoctorUserImagePath');
    log('DoctorId $result');
  }

  Future<String?>? getDoctorUserImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('DoctorUserImagePath');
    return result;
  }

  saveDoctorPMDCNumber(String? DoctorPMDCNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('DoctorPMDCNumber', '$DoctorPMDCNumber');
    log('DoctorId $result');
  }

  Future<String?>? getDoctorPMDCNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('DoctorPMDCNumber');
    return result;
  }

  saveDoctorFullName(String? DoctorFirstName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('DoctorFullName', '$DoctorFirstName');
    log('DoctorId $result');
  }

  Future<String?>? getDoctorFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('DoctorFullName');
    return result;
  }

  saveLoginDataObject(dynamic loginDataObject) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('loginDataObject', '$loginDataObject');
    log('DoctorId $result');
  }

  Future<dynamic>? getLoginDataObject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic result = prefs.getString('loginDataObject');
    return result;
  }

  saveIsFirstTime(bool? isFirstTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setBool('IsFirstTime', isFirstTime!);
    log('IsFirstTime $result');
  }

  Future<bool?>? getIsFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? result = prefs.getBool('IsFirstTime');
    return result;
  }

  saveDoctorId(String? doctorId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('DoctorId', '$doctorId');
    log('DoctorId $result');
  }

  Future<String?>? getDoctorId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('DoctorId');
    return result ?? "";
  }

  saveToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setString('token', '$token');
    log('token is  $result');
  }

  Future<String?>? getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('token');
    return result;
  }

  saveLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setBool('status', status);
    log('patientId $result');
  }

  Future<bool?>? getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? result = prefs.getBool('status');
    return result;
  }

  Future<int?>? getOnlineStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? result = prefs.getInt('Onlinestatus');
    return result;
  }

  saveOnlineStatus(int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.setInt('Onlinestatus', status);
    log('Onlinestatus $result');
  }

  saveDeviceToken(String? token) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    var string = s.setString('devicetoken', token.toString());
    log('saved in pref $token');
  }

  Future<String> getDeviceToken() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String? token = s.getString('devicetoken');
    log('received token $token');
    String receivedToken = token ?? "";
    return receivedToken;
  }

  saveEmail(String? Email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Email', '$Email');
  }

  Future<String?>? getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('Email');
    return result;
  }

  savePhoneNo(String? number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('PhoneNo', '$number');
  }

  Future<String?>? getPhoneNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('PhoneNo');
    return result;
  }

  saveCountry(String? country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Country', '$country');
  }

  Future<String?>? getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('Country');
    return result;
  }

  saveProvince(String? province) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Province', '$province');
  }

  Future<String?>? getProvince() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('Province');
    return result;
  }

  saveCity(String? city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('City', '$city');
  }

  Future<String?>? getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('City');
    return result;
  }

  saveAddress(String? address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Address', '$address');
  }

  Future<String?>? getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('Address');
    return result;
  }

  saveDateofBirth(String? dob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('DOB', '$dob');
  }

  Future<String?>? getDateofBirth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('DOB');
    return result;
  }

  // saveUsername(String? uname) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('UserName', '$uname');
  // }

  // Future<String?>? getUsername() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? result = prefs.getString('UserName');
  //   return result;
  // }

  savefirstname(String? fname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('FirstName', '$fname');
  }

  Future<String?>? getfirstname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('FirstName');
    return result;
  }

  saveCountryId(String? countryid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('CountryId', '$countryid');
  }

  Future<String?>? getCountryId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('CountryId');
    return result;
  }

  saveProvinceId(String? provinceid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ProvinceId', '$provinceid');
  }

  Future<String?>? getProvinceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('ProvinceId');
    return result;
  }

  saveCityId(String? cityid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('CityId', '$cityid');
  }

  Future<String?>? getCityId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('CityId');
    return result;
  }

  setLanguage(LanguageModel? language) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString('language', jsonEncode(language));
  }

  Future<LanguageModel?> getLanguage() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String? data = s.getString("language");
    LanguageModel? lang;
    if (data != null) {
      lang = LanguageModel.fromJson(jsonDecode(data));
    } else {
      lang = null;
    }
    return lang;
  }
}
