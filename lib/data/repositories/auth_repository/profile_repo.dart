import 'dart:convert';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:doctormobileapplication/utils/constants.dart';

class ProfileRepo {
  Future<bool> getDoctorspeciality() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String? doctorId = await LocalDb().getDoctorId();
    var body = {"DoctorId": doctorId};
    ProfileController.i.updateIsloading(true);
    try {
      var response = await http.post(Uri.parse(AppConstants.getDoctorBasicInfo),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        final prf = Get.put(ProfileController());
        Iterable dt = responseData['Specialities'];
        prf.updatespecialitites(
            dt.map((e) => Specialities.fromJson(e)).toList());
        for (int i = 0; i < prf.specialities.length; i++) {
          if (prf.specialities[i].isDefault == 1) {
            prf.updatemainspeciality(prf.specialities[i]);
            break;
          }
        }
        ProfileController.i.updateIsloading(false);
      }
    } catch (e) {
      showSnackbar(Get.context!, e.toString());
      ProfileController.i.updateIsloading(false);
      return false;
    }
    return false;
  }

  Future<List<Countries>> getCountries() async {
    String url = AppConstants.getCountries;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data
      List<Countries> countriesList =
          data.map((json) => Countries.fromJson(json)).toList();
      return countriesList;
    } else {
      throw Exception('Failed to fetch countries details');
    }
  }

  Future<List<Provinces>> getProvinces(String countryId) async {
    String url = AppConstants.getStatesOrProvince;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "CountryId": countryId,
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data
      List<Provinces> provincesList =
          data.map((json) => Provinces.fromJson(json)).toList();
      if (provincesList.isEmpty) {
        showSnackbar(Get.context!, 'No Province');
      }
      return provincesList;
    } else {
      throw Exception('Failed to fetch provinces details');
    }
  }

  Future<List<Cities>> getCities(String provinceId) async {
    String url = AppConstants.getCities;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "StateORProvinceId": provinceId,
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data
      List<Cities> citiesList =
          data.map((json) => Cities.fromJson(json)).toList();
      if (citiesList.isEmpty) {
        showSnackbar(Get.context!, 'No City');
      }
      return citiesList;
    } else {
      throw Exception('Failed to fetch cities details');
    }
  }

  Future<bool> getDoctorBasicInfo() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String? doctorId = await LocalDb().getDoctorId();
    var body = {"DoctorId": doctorId};
    ProfileController.i.updateIsloading(true);
    try {
      var response = await http.post(Uri.parse(AppConstants.getDoctorBasicInfo),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        final prf = Get.put(ProfileController());
        prf.updatedDoctorInfo(BasicInfo.fromJson(responseData['BasicInfo']));
        ProfileController.i.updateIsloading(false);
      }
    } catch (e) {
      showSnackbar(Get.context!, e.toString());
      ProfileController.i.updateIsloading(false);
      return false;
    }
    return false;
  }

  Future<String> updateaccount(docid, name, dob, contactno, email, countryid,
      provinceid, cityid, address, token) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      'Id': "",
      'AdminUserId': null,
      'DoctorId': docid,
      'EmployeeNumber': "",
      'Prefix': "",
      'FirstName': name,
      'LastName': "",
      'MiddleName': "",
      'FullName': "",
      'GenderId': null,
      'UserName': "",
      'Password': "",
      'ConfirmPassword': "",
      'Email': email,
      'VerificationCode': "",
      'VerificationTime': "",
      'DateofBirth': dob,
      'CNICNumber': "",
      'CNICExpiry': null,
      'PassportNumber': "",
      'PassportExpiry': null,
      'NTNNo': "",
      'BloodGroupId': null,
      'MaritalStatusId': null,
      'CountryId': countryid,
      'StateOrProvinceId': provinceid,
      'CityId': cityid,
      'Address': address,
      'CellNumber': "",
      'TelephoneNumber': "",
      'PicturePath': "",
      'IsActive': null,
      'UserTypeId': null,
      'ScaleId': null,
      'JobTypeId': null,
      'DateOfJoining': null,
      'BasicSalary': null,
      'HouseRentAllowance': null,
      'TransportAllowance': null,
      'MedicalAllowance': null,
      'UtilityAllowance': null,
      'MonthlyNetSalary': null,
      'PersonTitleId': null,
      'NOKFirstName': "",
      'NOKLastName': "",
      'NOKCNICNumber': "",
      'NOKCellNumber': "",
      'NOKRelationshipTypeId': null,
      'BranchId': null,
      'OrganizationId': null,
      'CreatedOn': "",
      'CreatedBy': "",
      'ModifiedOn': "",
      'ModifiedBy': "",
      'FamilyMemberId': null,
      'IsNextOfKin': null,
      'GuardianName': "",
      'RelationshipTypeId': null,
      'CostCenterId': null,
      'PersonalNumber': "",
      'BadgeNumber': "",
      'GPFundNumber': "",
      'DateOfExpiry': null,
      'SalaryStage': null,
      'GPOpeningBalance': null,
      'BFOpeningBalance': null,
      'GroupInsuranceOpeningBalance': null,
      'GPBalance': 0,
      'BFBalance': 0,
      'GroupInsuranceBalance': 0,
      'ReligionId': null,
      'Domicile': null,
      'AppointmentDate': null,
      'UserDisplayEducation': "",
      'UserDisplayDesignation': "",
      'Designations': "",
      'RoasterDepartmentId': null,
      'Stamp': "",
      'ConsultationFee': null,
      'FollowUpFee': null,
      'ContactPublic': contactno,
      'ProfessionalSummary': "",
      'UrduName': "",
      'PriceId': null,
      'CustomPrescriptionPath': "",
      'UserStatusId': null,
      'LineManagerId': null,
      'PMDCCertificateAttachment': "",
      'IsBusy': null,
      'IsOnline': null,
      'PMDCNumber': "",
      'IsVerify': false,
      'IsVerfiyPMDC': false,
      'RoleList': [],
      'DesignationList': [],
      'DepartmentList': [],
      'SubDepartmentList': [],
      'PermissionList': [],
      'SpecialityList': [],
      'SubSpecialityList': [],
      'Token': token,
      'DeviceToken': ""
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.updatedoctorprofile),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];

        if (status == 1) {
          if (msg == "Successfully Updated") {
            showSnackbar(Get.context!, msg);
            Get.back(result: true);
            return 'true';
          } else {
            showSnackbar(Get.context!, 'Failed to update');
            return 'false';
          }
        } else {
          return 'false';
        }
      }
    } catch (e) {
      showSnackbar(Get.context!, e.toString());
      return 'false';
    }
    return 'false';
  }
}
