import 'dart:convert';
import 'dart:io';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:doctormobileapplication/models/institutes.dart';
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

  Future<List<Degrees>> getDegree() async {
    String url = AppConstants.getDegree;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Degrees']; //Data
      List<Degrees> degreeList =
          data.map((json) => Degrees.fromJson(json)).toList();

      return degreeList;
    } else {
      throw Exception('Failed to fetch degree details');
    }
  }

  Future<List<Degrees>> getLocations() async {
    String url = AppConstants.getLocations;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Locations']; //Data
      List<Degrees> degreeList =
          data.map((json) => Degrees.fromJson(json)).toList();

      return degreeList;
    } else {
      throw Exception('Failed to fetch Locations details');
    }
  }

  Future<List<Degrees>> getBanks() async {
    String url = AppConstants.getBank;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Banks']; //Data
      List<Degrees> degreeList =
          data.map((json) => Degrees.fromJson(json)).toList();

      return degreeList;
    } else {
      throw Exception('Failed to fetch Banks details');
    }
  }

  Future<List<Degrees>> getFieldofStudy() async {
    String url = AppConstants.getfieldofstudy;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['FieldOfStudies'];
      List<Degrees> degreeList =
          data.map((json) => Degrees.fromJson(json)).toList();

      return degreeList;
    } else {
      throw Exception('Failed to fetch FieldOfStudies details');
    }
  }

  Future<List<Institutions>> getInstitution(cid) async {
    String url = AppConstants.getinstitution;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "CountryId": cid,
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Institutions']; //Data
      List<Institutions> institutionList =
          data.map((json) => Institutions.fromJson(json)).toList();

      return institutionList;
    } else {
      throw Exception('Failed to fetch Institutions details');
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
      // if (provincesList.isEmpty) {
      //   showSnackbar(Get.context!, 'No Province');
      // }
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
      // if (citiesList.isEmpty) {
      //   showSnackbar(Get.context!, 'No City');
      // }
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
        List<dynamic> rawsdData = responseData['Educations'] ?? [];
        List<Educations> education =
            rawsdData.map((item) => Educations.fromJson(item)).toList();

        List<dynamic> rawsExperience = responseData['Expereinces'] ?? [];
        List<Expereinces> experience =
            rawsExperience.map((item) => Expereinces.fromJson(item)).toList();

        List<dynamic> rawsSpecilization = responseData['Specialities'] ?? [];
        List<Specialities> specilization = rawsSpecilization
            .map((item) => Specialities.fromJson(item))
            .toList();

        List<dynamic> rawsbankdetail = responseData['BankAccounts'] ?? [];
        List<BankAccounts> bankdetail =
            rawsbankdetail.map((item) => BankAccounts.fromJson(item)).toList();

        List<dynamic> rawmembershipdetail = responseData['Memberships'] ?? [];
        List<Memberships> membershipdetail = rawmembershipdetail
            .map((item) => Memberships.fromJson(item))
            .toList();

        List<dynamic> rawawardsdetail = responseData['Memberships'] ?? [];
        List<Awards> awardsdetail =
            rawawardsdetail.map((item) => Awards.fromJson(item)).toList();

        List<dynamic> rawsappointmentconfig =
            responseData['AppointmentConfigurations'] ?? [];
        List<AppointmentConfigurations> appointmentconfig =
            rawsappointmentconfig
                .map((item) => AppointmentConfigurations.fromJson(item))
                .toList();

        prf.updatedDoctorawards(awardsdetail);
        prf.updatedDoctorEducation(education);
        prf.updatedDoctorexperienceList(experience);
        prf.updatedDoctormembership(membershipdetail);
        prf.updatedDoctorspecilizationList(specilization);
        prf.updatedDoctorbankDetailList(bankdetail);
        prf.updatedappointmentConfigurationList(appointmentconfig);
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

  Future<String> updatePicture(File file, oldimagepath) async {
    String r = '';
    var url = AppConstants.updateimage;
    String doctorid = await LocalDb().getDoctorId() ?? "";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('fileUpload', file.path));
    // request.fields['OldImagePath'] = oldimagepath;
    request.fields['DoctorId'] = doctorid;

    final res = await request.send();
    final response = await http.Response.fromStream(res);
    if (res.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      int status = responseData['Status'];
      if (status == 1) {
        showSnackbar(Get.context!, "Updated");
      } else {
        showSnackbar(Get.context!, "Failed to update");
      }
    } else {
      showSnackbar(Get.context!, "Failed to update");
    }

    return r;
  }

  Future<String> updatePersonalInfoPassport(
    prefix,
    persontitleid,
    fname,
    mname,
    lname,
    dob,
    maritalstatusid,
    guardianname,
    relationshipid,
    genderid,
    cnic,
    pmdcno,
    pmdcCertificate,
    ntnno,
    consultationfee,
    followupfee,
    bloodgroupid,
    religionid,
    designationslist,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "DoctorId": did,
      "Prefix": prefix,
      "PersonTitleId": persontitleid,
      "FirstName": fname,
      "LastName": lname,
      "MiddleName": mname,
      "DateofBirth": dob,
      "MaritalStatusId": maritalstatusid,
      "RelationshipTypeId": relationshipid,
      "GuardianName": guardianname,
      "GenderId": genderid,
      //  "UserName":"entdoctor",
      "PassportNumber": cnic,
      "PMDCNumber": pmdcno,
      "PMDCCertificateAttachment": pmdcCertificate,
      "NTNNo": ntnno,
      "ConsultationFee": consultationfee,
      "FollowUpFee": followupfee,
      "BloodGroupId": bloodgroupid,
      "ReligionId": religionid,
      "DesignationList": designationslist,
    };

    try {
      var response = await http.post(
          Uri.parse(AppConstants.updatedoctorpersonalinfo),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Updated") {
            showSnackbar(Get.context!, msg);
            return 'true';
          }
        } else if (status == -5) {
          showSnackbar(Get.context!, msg);
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

  Future<String> updatePersonalInfoCNIC(
    prefix,
    persontitleid,
    fname,
    mname,
    lname,
    dob,
    maritalstatusid,
    guardianname,
    relationshipid,
    genderid,
    cnic,
    pmdcno,
    pmdcCertificate,
    ntnno,
    consultationfee,
    followupfee,
    bloodgroupid,
    religionid,
    designationslist,
    passport,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "DoctorId": did,
      "Prefix": prefix,
      "PersonTitleId": persontitleid,
      "FirstName": fname,
      "LastName": lname,
      "MiddleName": mname,
      "DateofBirth": dob,
      "MaritalStatusId": maritalstatusid,
      "RelationshipTypeId": relationshipid,
      "GuardianName": guardianname,
      "GenderId": genderid,
      //  "UserName":"entdoctor",
      "CNICNumber": cnic,
      "PassportNumber": passport,
      "PMDCNumber": pmdcno,
      "PMDCCertificateAttachment": pmdcCertificate,
      "NTNNo": ntnno,
      "ConsultationFee": consultationfee,
      "FollowUpFee": followupfee,
      "BloodGroupId": bloodgroupid,
      "ReligionId": religionid,
      //"DesignationList": jsonEncode(designationslist)
      "DesignationList": designationslist,
    };

    try {
      var response = await http.post(
          Uri.parse(AppConstants.updatedoctorpersonalinfo),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Updated") {
            showSnackbar(Get.context!, msg);
            return 'true';
          }
        } else if (status == -5) {
          showSnackbar(Get.context!, msg);
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

  Future<String> updateContact(
      countryid,
      sid,
      cityid,
      address,
      privateno,
      telephoneno,
      contactpublic,
      nokfname,
      noklname,
      nokrelationid,
      nokcnicno,
      nokcellno,
      email) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";
    var body = {
      "DoctorId": did,
      "CountryId": countryid,
      "StateOrProvinceId": sid,
      "CityId": cityid,
      "Address": address,
      "CellNumber": privateno,
      "TelephoneNumber": telephoneno,
      "ContactPublic": contactpublic,
      "NOKFirstName": nokfname,
      "NOKLastName": noklname,
      "NOKRelationshipTypeId": nokrelationid,
      "NOKCNICNumber": nokcnicno,
      "NOKCellNumber": nokcellno,
      "Email": email,
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.updatedoctorcontact),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Updated") {
            showSnackbar(Get.context!, msg);

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
