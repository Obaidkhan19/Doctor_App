import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/controller/registration_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/blood_group.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/designation.dart';
import 'package:doctormobileapplication/models/genders_model.dart';
import 'package:doctormobileapplication/models/marital_status.dart';
import 'package:doctormobileapplication/models/person_title.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:doctormobileapplication/models/relation.dart';
import 'package:doctormobileapplication/models/religion.dart';
import 'package:doctormobileapplication/models/speciality.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/screens/auth_screens/otp_screen.dart';
import 'package:doctormobileapplication/screens/auth_screens/sucessfull_registration.dart';
import 'package:doctormobileapplication/screens/dashboard/menu_drawer.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:device_info_plus/device_info_plus.dart';

class AuthRepo {
  Future<String> uploadPicture(File file) async {
    String r = '';
    var url = AppConstants.uploadimage;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    final res = await request.send();
    if (res.statusCode == 200) {
      dynamic data = jsonDecode(await res.stream.bytesToString());
      r = data["PicturePath"];
    } else {}
    return r;
  }

  Future<String> uploadFile(PlatformFile file) async {
    String r = '';

    var url = AppConstants.uploadimage;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('image', file.path ?? ""));
    final res = await request.send();
    if (res.statusCode == 200) {
      dynamic data = jsonDecode(await res.stream.bytesToString());
      r = data["PicturePath"];
    } else {}

    return r;
  }

  Future<List<GendersData>> getGendersList() async {
    String url = AppConstants.getGenders;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data
      List<GendersData> gendersList =
          data.map((json) => GendersData.fromJson(json)).toList();

      return gendersList;
    } else {
      throw Exception('Failed to fetch genders details');
    }
  }

  static getGenders() async {
    var body = {};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getGenders),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Genders genders = Genders.fromJson(result);

          return genders.data;
        }
      }
    } catch (e) {
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

  static getCountries() async {
    var body = {};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getCountries),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          CountriesData countries = CountriesData.fromJson(result);
          return countries.data;
        } else {
          Fluttertoast.showToast(
              msg: '${result['Message']}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        }
      }
      Fluttertoast.showToast(
          msg: '${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
    } catch (e) {
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

  static getProvinces(String countryId) async {
    var body = {"CountryId": countryId};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          Uri.parse(AppConstants.getStatesOrProvince),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ProvincesData provinces = ProvincesData.fromJson(result);
          return provinces.data;
        } else {
          Fluttertoast.showToast(
              msg: '${result['Message']}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        }
      }
      Fluttertoast.showToast(
          msg: '${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
    } catch (e) {
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

  static getCities(String provinceId) async {
    var body = {"StateORProvinceId": provinceId};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getCities),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          CitiesDatas cities = CitiesDatas.fromJson(result);
          return cities.data;
        } else {
          Fluttertoast.showToast(
              msg: '${result['Message']}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        }
      }
      Fluttertoast.showToast(
          msg: '${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
    } catch (e) {
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

  Future<String> signupPersonalcnic() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String token = await LocalDb().getDeviceToken();
    var body = {
      "IsVerify": 0,
      "FirstName": RegistrationController.i.firstname.text,
      "LastName": RegistrationController.i.lastname.text,
      "GenderId": RegistrationController.i.selectedgender!.id,
      "UserName": RegistrationController.i.username.text,
      "Password": RegistrationController.i.password.text,
      "ConfirmPassword": RegistrationController.i.retypePassword.text,
      "Email": RegistrationController.i.email.text,
      "DateofBirth": RegistrationController.i.formattedArrival,
      "CNICNumber": RegistrationController.i.idnumber.text,
      "MaritalStatusId": RegistrationController.i.selectedmaritalStatus!.id,
      "CountryId": RegistrationController.i.selectedcountry!.id,
      "StateOrProvinceId": RegistrationController.i.selectedprovince!.id,
      "CityId": RegistrationController.i.selectedcity!.id,
      "Address": RegistrationController.i.address.text,
      "PicturePath": RegistrationController.i.imagepath,
      "PersonTitleId": RegistrationController.i.selectedpersonalTitle!.id,
      "ContactPublic": RegistrationController.i.phone.text,
      "PMDCCertificateAttachment": RegistrationController.i.filepath,
      "PMDCNumber": RegistrationController.i.imcno.text,
      "SpecialityList":
          jsonEncode(RegistrationController.i.selectedSpecialitiesList),
      "SubSpecialityList":
          jsonEncode(RegistrationController.i.selectedSubSpecialitiesList),
      "DeviceToken": token,
    };

    log(body.toString());
    try {
      var response = await http.post(
        Uri.parse(AppConstants.signupdoctor),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var errormsg = responseData['ErrorMessage'];

        // var doctorid = responseData['DoctorId'];

        if (status == 1) {
          if (errormsg == 'Successfully Created ') {
            RegistrationController.i.disposevalues();
            Get.to(const SucessfullRegistrationScreen());
          }
        } else {
          Fluttertoast.showToast(
              msg: errormsg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return errormsg;
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Somethingwentwrong'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    return 'false';
  }

  Future<String> signupPersonalpassport() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String token = await LocalDb().getDeviceToken();
    var body = {
      "IsVerify": 0,
      "FirstName": RegistrationController.i.firstname.text,
      "LastName": RegistrationController.i.lastname.text,
      "GenderId": RegistrationController.i.selectedgender!.id,
      "UserName": RegistrationController.i.username.text,
      "Password": RegistrationController.i.password.text,
      "ConfirmPassword": RegistrationController.i.retypePassword.text,
      "Email": RegistrationController.i.email.text,
      "DateofBirth": RegistrationController.i.formattedArrival,
      "PassportNumber": RegistrationController.i.idnumber.text,
      "MaritalStatusId": RegistrationController.i.selectedmaritalStatus!.id,
      "CountryId": RegistrationController.i.selectedcountry!.id,
      "StateOrProvinceId": RegistrationController.i.selectedprovince!.id,
      "CityId": RegistrationController.i.selectedcity!.id,
      "Address": RegistrationController.i.address.text,
      "PicturePath": RegistrationController.i.imagepath,
      "PersonTitleId": RegistrationController.i.selectedpersonalTitle!.id,
      "ContactPublic": RegistrationController.i.phone.text,
      "PMDCCertificateAttachment": RegistrationController.i.filepath,
      "PMDCNumber": RegistrationController.i.imcno.text,
      "SpecialityList":
          jsonEncode(RegistrationController.i.selectedSpecialitiesList),
      "SubSpecialityList":
          jsonEncode(RegistrationController.i.selectedSubSpecialitiesList),
      "DeviceToken": token,
    };

    try {
      var response = await http.post(
        Uri.parse(AppConstants.signupdoctor),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var errormsg = responseData['ErrorMessage'];

        if (status == 1) {
          if (errormsg == 'Successfully Created ') {
            RegistrationController.i.disposevalues();
            Get.to(const SucessfullRegistrationScreen());
          }
        } else {
          Fluttertoast.showToast(
              msg: errormsg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return errormsg;
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Somethingwentwrong'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    return 'false';
  }

  // static signup(
  //     {String? name,
  //     String? id,
  //     String? selectedDate,
  //     String? phoneNumber,
  //     String? email,
  //     File? file,
  //     String? genderId,
  //     String? cityId,
  //     String? password,
  //     String? retypePassword}) async {
  //   String? branchId = await LocalDb().getBranchId();
  //   log('$name, $id, $selectedDate, $phoneNumber, $email, ${file!.path}, $genderId, $cityId');
  //   var body = {
  //     "FirstName": "$name",
  //     "CNICNumber": "$id",
  //     "DateOfBirth": "$selectedDate",
  //     "CellNumber": "$phoneNumber",
  //     "TelephoneNumber": "",
  //     "Email": "$email",
  //     "PicturePath": file.path,
  //     "GenderId": "$genderId",
  //     "RelationshipTypeId": "",
  //     "PatientTypeId": "BEB03D33-E8AA-E711-80C1-A0B3CCE147BA",
  //     "CountryId": "",
  //     "StateOrProvinceId": "",
  //     "CityId": "$cityId",
  //     "BranchId": "$branchId",
  //     "Password": "$password",
  //     "ConfirmPassword": "$retypePassword"
  //   };
  //   var headers = {'Content-Type': 'application/json'};
  //   AuthController.i.updateIsloading(true);
  //   try {
  //     var response = await http.post(Uri.parse(AppConstants.signup),
  //         body: jsonEncode(body), headers: headers);
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       if (result['Status'] == 1) {
  //         showSnackbar(Get.context!, '${result['ErrorMessage']}');
  //         Get.offAll(() => const DrawerScreen());
  //         LocalDb().saveDoctorId(result['Id'] ?? '');
  //         if (result['PatientBranches'][0]['PatientId'] != null) {
  //           LocalDb()
  //               .saveDoctorId(result['PatientBranches'][0]['PatientId'] ?? '');
  //         }
  //         LocalDb().saveLoginStatus(true);
  //         AuthController.i.updateIsloading(false);
  //       } else {
  //         AuthController.i.updateIsloading(false);
  //         showSnackbar(Get.context!, '${result['ErrorMessage']}');
  //       }
  //     } else {
  //       showSnackbar(Get.context!, '${response.statusCode}');
  //       AuthController.i.updateIsloading(false);
  //     }
  //   } catch (e) {
  //     // showSnackbar(Get.context!, e.toString());
  //     AuthController.i.updateIsloading(false);
  //   }
  // }

  static login({String? cnic, String? password}) async {
    //TODO : Values should be dynamics
    AuthController.i.updateIsloading(true);

    String? DeviceToken = await LocalDb().getDeviceToken();
    String? Manufacturer = "";
    String? Model = "";
    String? AppVersion = "";
    String? DeviceVersionIos;
    String? DeviceVersion;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      Model = androidInfo.model;
      Manufacturer = androidInfo.manufacturer;
      AppVersion = "";
      DeviceVersion = androidInfo.version.baseOS;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      Model = iosInfo.model;
      Manufacturer = iosInfo.identifierForVendor;
      AppVersion = "";
      DeviceVersionIos = iosInfo.systemVersion;
    }

    var body = {
      "UserName": "$cnic",
      "Password": "$password",
      "DeviceToken": DeviceToken,
      "Manufacturer": Manufacturer,
      "Model": Model,
      "AppVersion": AppVersion,
      "DeviceVersion": Platform.isAndroid ? DeviceVersion : DeviceVersionIos,
      // "UserName": "generalpractitioner ",
      // "Password": "123123",
      // "DeviceToken":
      //     "fels3Jf1QjuclS4WnqxvlZ:APA91bGUJsLeW75_KSyGifJHl4H70AtNFJNbBDf3j5UVeLI5qnNetQV45ZCPZKGKCRVhw9ev1akGkzBeuLrVyFyoax_Fz33_d28PG6plNzEmDSWLzBUmvo8m_YMwlHROQBvtNiPg0l9W",
      // "Manufacturer": "SHARP",
      // "Model": "706SH",
      // "AppVersion": "",
      // "DeviceVersion": "",
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.login),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          AuthController.i.updateIsloading(false);
          Get.offAll(() => const DrawerScreen());
          LocalDb().saveLoginDataObject(result);
          LocalDb().saveDoctorId(result['Id']);
          LocalDb().saveToken(result['Token']);
          LocalDb().saveLoginStatus(true);
          LocalDb().saveBranchId(result['BranchId']);
          LocalDb().saveDoctorFullName(result['FullName']);
          LocalDb().saveDoctorPMDCNumber(result['PMDCNumber']);
          LocalDb().saveDoctorUserImagePath(result['UserImagePath']);
          LocalDb().saveUsername(cnic);
          LocalDb().savePassword(password);
          LocalDb().saveOnlineStatus(0);
        } else {
          AuthController.i.updateIsloading(false);
          Fluttertoast.showToast(
              msg: result['ErrorMessage'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        }
      } else {
        AuthController.i.updateIsloading(false);
        Fluttertoast.showToast(
            msg: response.statusCode.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.kRedColor,
            textColor: ColorManager.kWhiteColor,
            fontSize: 14.0);
      }
    } catch (e) {
      AuthController.i.updateIsloading(false);
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

  static deleteAccount({
    String? patientId,
    String? token,
  }) async {
    log('$patientId, $token');
    var body = {"PatientId": "$patientId", "Token": "$token"};
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.deleteAccountURI),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Get.offAll(() => const LoginScreen());
          Fluttertoast.showToast(
              msg: '${result['ErrorMessage']}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          LocalDb().saveLoginStatus(false);
        } else {
          Fluttertoast.showToast(
              msg: '${result['ErrorMessage']}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: '${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.kRedColor,
            textColor: ColorManager.kWhiteColor,
            fontSize: 14.0);
      }
    } catch (e) {
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

  static logout(
      {String? DoctorId,
      String? token,
      String? DeviceToken,
      String? IsLogOffAllDevice}) async {
    log('$DoctorId, $token');
    var body = {
      "DoctorId": "$DoctorId",
      "Token": "$token",
      "DeviceToken": "$DeviceToken",
      "IsLogOffAllDevice": "$IsLogOffAllDevice",
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.logoutApi),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          // Get.offAll(() => const LoginScreen());
          LocalDb().saveLoginStatus(false);
        } else {
          Fluttertoast.showToast(
              msg: result['ErrorMessage'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: '${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.kRedColor,
            textColor: ColorManager.kWhiteColor,
            fontSize: 14.0);
      }
    } catch (e) {
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

  Future<List<MSData>> getMaritalStatus() async {
    String url = AppConstants.getMaritalStatus;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data

      List<MSData> maritalstatusList =
          data.map((json) => MSData.fromJson(json)).toList();
      return maritalstatusList;
    } else {
      throw Exception('Failed to fetch marital status details');
    }
  }

  Future<List<PTitle>> getPersonalTitle() async {
    String url = AppConstants.getTitle;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    // ProfileController.i.updateval(false);
    // ProfileController.i.updateaddval(false);
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);

      Iterable data = jsonData['Data']; //Data

      List<PTitle> ptitleList =
          data.map((json) => PTitle.fromJson(json)).toList();
      return ptitleList;
    } else {
      throw Exception('Failed to fetch title details');
    }
  }

  Future<List<Specialities1>> getSpecialities() async {
    String url = AppConstants.getSpecialities;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Specialities']; //Data

      List<Specialities1> specialitiesList =
          data.map((json) => Specialities1.fromJson(json)).toList();
      return specialitiesList;
    } else {
      throw Exception('Failed to fetch specialties details');
    }
  }

  Future<List<Specialities1>> getSubSpecialities(subspeciality) async {
    String url = AppConstants.getSubSpecialities;
    Uri uri = Uri.parse(url);
    var body = {
      "SpecialityIds": [
        subspeciality,
      ]
    };
    print(body);
    var response = await http.post(uri,
        body: jsonEncode(body),
        // );
        headers: <String, String>{'Content-Type': 'application/json'});
    print(jsonEncode(body));
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['SubSpecialities']; //Data

      List<Specialities1> subspecialitiesList =
          data.map((json) => Specialities1.fromJson(json)).toList();
      return subspecialitiesList;
    } else {
      throw Exception('Failed to fetch sub specialties details');
    }
  }

  Future<String> changePassword(oldpassword, newpassword) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String token = await LocalDb().getDeviceToken();
    String doctorid = await LocalDb().getDoctorId() ?? "";
    var body = {
      "Id": doctorid,
      "Password": newpassword,
      "OldPassword": oldpassword,
      "Token": token
    };
    try {
      var response = await http.post(
        Uri.parse(AppConstants.changePassword),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var errormsg = responseData['ErrorMessage'];

        if (status == 1) {
          if (errormsg == 'Password Changed Sucessfully') {
            Get.to(() => const LoginScreen());
          }
        } else {
          Fluttertoast.showToast(
              msg: errormsg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return errormsg;
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Somethingwentwrong'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    return 'false';
  }

  Future<String> newPassword(
      password, confirmpassword, username, email, verificationcode) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "UserName": username,
      "Email": email,
      "Password": password,
      "ConfirmPassword": confirmpassword,
      "VerificationCode": verificationcode
    };

    try {
      var response = await http.post(
        Uri.parse(AppConstants.newPassword),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var errormsg = responseData['ErrorMessage'];

        if (status == 1) {
          if (errormsg == 'Your password has been updated successfully.') {
            Get.to(() => const LoginScreen());
          }
        } else {
          Fluttertoast.showToast(
              msg: errormsg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return errormsg;
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Somethingwentwrong'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    return 'false';
  }

  Future<String> otpCode(email) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {"Email": email};
    AuthController.i.updateIsotploading(true);
    try {
      var response = await http.post(
        Uri.parse(AppConstants.forgetPassword),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var errormsg = responseData['ErrorMessage'];
        var verificationCode = responseData['VerificationCode'];
        var username = responseData['Username'];
        var email = responseData['Email'];
        if (status == 1) {
          AuthController.i.updateverificationcode(verificationCode);
          AuthController.i.updateusername(username);
          AuthController.i.updatotpemail(email);
          AuthController.i.updateIsotploading(false);
          Get.to(() => const OtpScreen());
        } else if (status == -5) {
          if (errormsg == 'No account found against this user') {
            AuthController.i.updateIsotploading(false);

            Fluttertoast.showToast(
                msg: 'Wrongemail'.tr,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kRedColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
          }
        }
      }
    } catch (e) {
      AuthController.i.updateIsotploading(false);
      Fluttertoast.showToast(
          msg: 'Somethingwentwrong'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    return 'false';
  }

  Future<bool> usernameAvaibility(username) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "UserName": username,
    };
    try {
      var response = await http.post(
        Uri.parse(AppConstants.usernameavaibility),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        if (status == 1) {
          RegistrationController.i.updateusernameavaibility(true);
          return true;
        } else {
          RegistrationController.i.updateusernameavaibility(false);
          Fluttertoast.showToast(
              msg: ('UsernameAlreadyTaken'.tr),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return false;
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Somethingwentwrong'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return false;
    }
    return false;
  }

  Future<bool> passportAvaibility(passport) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "PassportNumber": passport,
    };
    try {
      var response = await http.post(
        Uri.parse(AppConstants.passportavaibility),
        body: jsonEncode(body),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];

        if (status == 1) {
          RegistrationController.i.updatepassportavaibility(true);
          return true;
        } else {
          RegistrationController.i.updatepassportavaibility(false);
          Fluttertoast.showToast(
              msg: ('PassportNumberAlreadyTaken'.tr),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return false;
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Somethingwentwrong'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return false;
    }
    return false;
  }

  Future<bool> cnicAvaibility(cnic) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "CNICNumber": cnic,
    };
    try {
      var response = await http.post(
        Uri.parse(AppConstants.cnicavaibility),
        body: jsonEncode(body),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        if (status == 1) {
          RegistrationController.i.updateidnoavaibility(true);
          return true;
        } else {
          RegistrationController.i.updateidnoavaibility(false);
          Fluttertoast.showToast(
              msg: 'NationalIDNumberAlreadyTaken'.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return false;
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Somethingwentwrong'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return false;
    }
    return false;
  }

  Future<bool> pmdcAvaibility(pmdc) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "PMDCNumber": pmdc,
    };
    try {
      var response = await http.post(
        Uri.parse(AppConstants.pmdcavaibility),
        body: jsonEncode(body),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        if (status == 1) {
          RegistrationController.i.updateepmdcavaibility(true);
          return true;
        } else {
          RegistrationController.i.updateepmdcavaibility(false);
          Fluttertoast.showToast(
              msg: 'LMPCNoAlreadyTaken'.tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return false;
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Somethingwentwrong'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return false;
    }
    return false;
  }

  Future<List<bloodGroupData>> getBloodGroup() async {
    String url = AppConstants.getbloodgroup;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data

      List<bloodGroupData> bloodGroupDataList =
          data.map((json) => bloodGroupData.fromJson(json)).toList();
      return bloodGroupDataList;
    } else {
      throw Exception('Failed to fetch bloodGroupData details');
    }
  }

  Future<List<bloodGroupData>> getBloodGroupDetail() async {
    String url = AppConstants.getbloodgroup;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data

      List<bloodGroupData> bloodGroupDataList =
          data.map((json) => bloodGroupData.fromJson(json)).toList();
      return bloodGroupDataList;
    } else {
      throw Exception('Failed to fetch bloodGroupData details');
    }
  }

  Future<List<Religion>> getReligion() async {
    String url = AppConstants.getreligion;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Religion']; //Data
      List<Religion> ReligionList =
          data.map((json) => Religion.fromJson(json)).toList();
      return ReligionList;
    } else {
      throw Exception('Failed to fetch Religion details');
    }
  }

  Future<List<RelationData>> getRelation() async {
    String url = AppConstants.getrelation;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data
      List<RelationData> RelationDataList =
          data.map((json) => RelationData.fromJson(json)).toList();
      return RelationDataList;
    } else {
      throw Exception('Failed to fetch RelationData details');
    }
  }

  Future<List<RelationData>> getNOKRelation() async {
    String url = AppConstants.getnokrelation;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data
      List<RelationData> RelationDataList =
          data.map((json) => RelationData.fromJson(json)).toList();
      return RelationDataList;
    } else {
      throw Exception('Failed to fetch RelationData details');
    }
  }

  Future<List<Designations>> getDesignation() async {
    String url = AppConstants.getdesignation;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Designations']; //Data
      List<Designations> DesignationsList =
          data.map((json) => Designations.fromJson(json)).toList();
      return DesignationsList;
    } else {
      throw Exception('Failed to fetch Designations details');
    }
  }
}
