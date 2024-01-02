import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:doctormobileapplication/data/controller/add_specialization_controller.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:doctormobileapplication/models/institutes.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      ProfileController.i.updateIsloading(false);
      return false;
    }
    return false;
  }

  Future<List<Countries>> getCountries() async {
    // ProfileController.i.updateval(false);
    // ProfileController.i.updateaddval(false);
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

  Future<List<Degrees>> getOrganization() async {
    String url = AppConstants.getOrganization;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Organizations']; //Data
      List<Degrees> degreeList =
          data.map((json) => Degrees.fromJson(json)).toList();

      return degreeList;
    } else {
      throw Exception('Failed to fetch Organization details');
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

        List<dynamic> rawawardsdetail = responseData['Awards'] ?? [];
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
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
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
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kRedColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            Get.back(result: true);
            return 'true';
          } else {
            Fluttertoast.showToast(
                msg: 'Failed to update',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kRedColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'false';
          }
        } else {
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
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
        Fluttertoast.showToast(
            msg: "Updated",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.kPrimaryColor,
            textColor: ColorManager.kWhiteColor,
            fontSize: 14.0);
      } else {
        Fluttertoast.showToast(
            msg: "Failed to update",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.kRedColor,
            textColor: ColorManager.kWhiteColor,
            fontSize: 14.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Failed to update",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
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
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kRedColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        } else {
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
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

    // String designationids = "";
    // for (int i = 0; i < designationslist.length; i++) {
    //   designationids += designationslist[i].id;
    //   if (i < designationslist.length - 1) {
    //     designationids += ',';
    //   }
    // }

    // List<String> designationid = [];
    // for (int i = 0; i < designationslist.length; i++) {
    //   String id = designationslist[i].id;
    //   designationid.add(id);
    // }

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
      "DesignationList": jsonEncode(designationslist),
    };
    print(body);
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
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
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
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);

            return 'true';
          } else {
            Fluttertoast.showToast(
                msg: "Failed to update",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kRedColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'false';
          }
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> editSpecilization(id, sid, ssid) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";
    String bid = await LocalDb().getBranchId() ?? "";

    var body = {
      "Id": id,
      "SpecialityId": sid,
      "SubSpecialityId": ssid,
      "DoctorId": did,
      "BranchId": bid
    };

    try {
      EditProfileController.i.updateisloading(true);
      var response = await http.post(Uri.parse(AppConstants.editSpecilaity),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Added") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            EditProfileController.i.updateisloading(false);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          EditProfileController.i.updateisloading(false);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          EditProfileController.i.updateisloading(false);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      EditProfileController.i.updateisloading(false);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    EditProfileController.i.updateisloading(false);
    return 'false';
  }

  Future<String> addSpecilization(sid, ssid) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";
    String bid = await LocalDb().getBranchId() ?? "";

    var body = {
      "SpecialityId": sid,
      "SubSpecialityId": ssid,
      "DoctorId": did,
      "BranchId": bid
    };

    try {
      AddSpecializationController.i.updateisloading(true);
      var response = await http.post(Uri.parse(AppConstants.addSpecilaity),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Added") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            AddSpecializationController.i.updateisloading(false);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          AddSpecializationController.i.updateisloading(false);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          AddSpecializationController.i.updateisloading(false);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      AddSpecializationController.i.updateisloading(false);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    AddSpecializationController.i.updateisloading(false);
    return 'false';
  }

  Future<String> deleteSpecilization(sid, ssid) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "SpecialityId": sid,
      "SubSpecialityId": ssid,
      "DoctorId": did,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.deleteSpecilaity),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Deleted") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);

            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> setdefaultSpecilization(sid, ssid) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "SpecialityId": sid,
      "SubSpecialityId": ssid,
      "DoctorId": did,
    };

    try {
      var response = await http.post(
          Uri.parse(AppConstants.setdefaultSpecilaity),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Default Speciality Successfully Updated") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);

            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> setdefaultBank(id) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {"Id": id, "DoctorId": did};

    try {
      var response = await http.post(Uri.parse(AppConstants.setdefaultBank),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Default Account Updated Successfully") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);

            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> updatePrescriptionConfiguration(
    userdisplayeducation,
    userdisplaydesignation,
    professionalsummary,
    stamp,
    margintop,
    marginbottom,
    eduenglish,
    eduurdu,
    designationenglish,
    designationurdu,
    othersenglish,
    othersurdu,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";
    var body = {
      "DoctorId": did,
      "UserDisplayEducation": userdisplayeducation,
      "UserDisplayDesignation": userdisplaydesignation,
      "ProfessionalSummary": professionalsummary,
      "Stamp": stamp,
      "MarginTop": margintop,
      "MarginBottom": marginbottom,
      "EducationEnglish": eduenglish,
      "EducationUrdu": eduurdu,
      "DesignationEnglish": designationenglish,
      "DesignationUrdu": designationurdu,
      "OthersEnglish": othersenglish,
      "OthersUrdu": othersurdu
    };
    EditProfileController.i.updateisloading(true);
    try {
      var response = await http.post(
          Uri.parse(AppConstants.updateprescriptionConfiguration),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Updated") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            EditProfileController.i.updateisloading(false);
            return 'true';
          } else {
            Fluttertoast.showToast(
                msg: "Failed to update",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kRedColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            EditProfileController.i.updateisloading(false);
            return 'false';
          }
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          EditProfileController.i.updateisloading(false);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      EditProfileController.i.updateisloading(false);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    EditProfileController.i.updateisloading(false);
    return 'false';
  }

  Future<String> addEducation(
      countryid,
      schoolid,
      degreeid,
      fieldofstudyid,
      startdate,
      enddate,
      issuedate,
      isActive,
      gradingsystem,
      totalmarks,
      obtainedmarks,
      obtainedpercentage) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "DoctorId": did,
      "CountryId": countryid,
      "InstitutionId": schoolid,
      "DegreeId": degreeid,
      "FieldOfStudyId": fieldofstudyid,
      "StartDate": startdate,
      "EndDate": enddate,
      "IsActive": isActive,
      "GradingSystem": gradingsystem,
      "TotalMarks": totalmarks,
      "ObtainedMarks": obtainedmarks,
      "ObtainedPercentage": obtainedpercentage,
      "IssueDate": issuedate
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.addeducation),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Added") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> editEducation(
      id,
      countryid,
      schoolid,
      degreeid,
      fieldofstudyid,
      startdate,
      enddate,
      issuedate,
      isActive,
      gradingsystem,
      totalmarks,
      obtainedmarks,
      obtainedpercentage) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "Id": id,
      "DoctorId": did,
      "CountryId": countryid,
      "InstitutionId": schoolid,
      "DegreeId": degreeid,
      "FieldOfStudyId": fieldofstudyid,
      "StartDate": startdate,
      "EndDate": enddate,
      "IsActive": isActive,
      "GradingSystem": gradingsystem,
      "TotalMarks": totalmarks,
      "ObtainedMarks": obtainedmarks,
      "ObtainedPercentage": obtainedpercentage,
      "IssueDate": issuedate
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.editeducation),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Updated") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> addExperience(title, description, iscurrentlyworking, orgid,
      locid, fromdate, todate, path) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "DoctorId": did,
      "Title": title,
      "Description": description,
      "IsCurrentWorking": iscurrentlyworking,
      "OrganizationId": orgid,
      "LocationId": locid,
      "FromDate": fromdate,
      "ToDate": todate,
      "Path": path,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.addexperience),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Added") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> editExperience(id, title, description, iscurrentlyworking,
      orgid, locid, fromdate, todate, path) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "Id": id,
      "DoctorId": did,
      "Title": title,
      "Description": description,
      "IsCurrentWorking": iscurrentlyworking,
      "OrganizationId": orgid,
      "LocationId": locid,
      "FromDate": fromdate,
      "ToDate": todate,
      "Path": path,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.editexperience),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Updated") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> deleteEducation(id) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    // String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "Id": id,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.deleteEducation),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Deleted") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);

            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> addAwards(
      title, code, awardeddate, description, organizationId, locationid) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "DoctorId": did,
      "Title": title,
      "Code": code,
      "AwardedDate": awardeddate,
      "Description": description,
      "OrganizationId": organizationId,
      "LocationId": locationid,
    };

    try {
      AddSpecializationController.i.updateisloading(true);
      var response = await http.post(Uri.parse(AppConstants.addAward),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Added") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            AddSpecializationController.i.updateisloading(false);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          AddSpecializationController.i.updateisloading(false);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          AddSpecializationController.i.updateisloading(false);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      AddSpecializationController.i.updateisloading(false);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    AddSpecializationController.i.updateisloading(false);
    return 'false';
  }

  Future<String> editAwards(id, title, code, awardeddate, description,
      organizationId, locationid) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "Id": id,
      "DoctorId": did,
      "Title": title,
      "Code": code,
      "AwardedDate": awardeddate,
      "Description": description,
      "OrganizationId": organizationId,
      "LocationId": locationid,
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.editAward),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Updated") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);

            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);

          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);

          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);

      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);

    return 'false';
  }

  Future<String> editMembership(id, title, code, fromdate, todate, description,
      organizationId, locationid) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "Id": id,
      "DoctorId": did,
      "Title": title,
      "Code": code,
      "FromDate": fromdate,
      "ToDate": todate,
      "Description": description,
      "OrganizationId": organizationId,
      "LocationId": locationid,
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.editMembership),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Updated") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);

            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);

          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);

          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);

      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);

    return 'false';
  }

  Future<String> addMembership(title, code, fromdate, todate, description,
      organizationId, locationid) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "DoctorId": did,
      "Title": title,
      "Code": code,
      "FromDate": fromdate,
      "ToDate": todate,
      "Description": description,
      "OrganizationId": organizationId,
      "LocationId": locationid,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.addMembership),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Added") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> deleteAward(id) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "Id": id,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.deleteAward),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Deleted") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);

            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> deleteMemebership(id) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "Id": id,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.deleteMemebership),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Deleted") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);

            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> deleteBank(id) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "Id": id,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.deleteBank),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Deleted") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);

            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> deleteExperience(id) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String? did = await LocalDb().getDoctorId();

    var body = {
      "Id": id,
      "DoctorId": did,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.deleteExperience),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Deleted") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);

            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<String> addBankAccount(bankid, accountno, title, path) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "DoctorId": did,
      "BankId": bankid,
      "AccountNumber": accountno,
      "Title": title,
      "Path": path,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.addBankAccount),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Added") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kRedColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        } else {
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
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

  Future<String> addOldWorklocation(worlocationid, pref) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";
    String bid = await LocalDb().getBranchId() ?? "";

    var body = {
      "DoctorId": did,
      "WorkLocationId": worlocationid,
      "Preference": pref,
      "BranchId": bid,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.addworklocation),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Added") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kRedColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        } else {
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
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

  Future<String> addNewWorklocation(
    name,
    address,
    countryid,
    provinceid,
    cityid,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "DoctorId": did,
      "Name": name,
      "Address": address,
      "CountryId": countryid,
      "StateOrProvinceId": provinceid,
      "CityId": cityid,
      "IsActive": "1"
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.addworklocation),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Added") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kRedColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        } else {
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
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

  Future<String> editBankAccount(id, bankid, accountno, title, path) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    String did = await LocalDb().getDoctorId() ?? "";

    var body = {
      "Id": id,
      "DoctorId": did,
      "BankId": bankid,
      "AccountNumber": accountno,
      "Title": title,
      "Path": path,
    };

    try {
      var response = await http.post(Uri.parse(AppConstants.editBankAccount),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Successfully Updated") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        } else {
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
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
}
