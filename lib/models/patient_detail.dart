import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/utils/constants.dart';

class PatientDetail {
  int? status;
  List<PatientDetail>? patientDetail;

  PatientDetail({this.status, this.patientDetail});

  PatientDetail.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['PatientDetail'] != null) {
      patientDetail = <PatientDetail>[];
      json['PatientDetail'].forEach((v) {
        patientDetail!.add(PatientDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (patientDetail != null) {
      data['PatientDetail'] = patientDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientDetail1 {
  String? id;
  String? mRNo;
  String? name;
  String? identityType;
  String? patientCheckInId;
  int? checkInTypeValue;
  String? cNICNumber;
  String? picturePath;
  String? age;
  String? visitNo;
  String? modifiedOn;
  String? modifiedById;
  String? telephoneNumber;
  String? cellNumber;
  String? address;
  String? patientTypeName;
  String? reportedDate;
  String? lastVisitDate;
  String? lastVisitTo;
  bool? isInPatient;
  int? patientTypeForProcedureBooking;
  int? patientStatus;
  int? smoker;
  int? diabetic;
  String? patientPicturePath;
  String? branchType;

  PatientDetail1(
      {this.id,
      this.mRNo,
      this.name,
      this.identityType,
      this.patientCheckInId,
      this.checkInTypeValue,
      this.cNICNumber,
      this.picturePath,
      this.age,
      this.visitNo,
      this.modifiedOn,
      this.modifiedById,
      this.telephoneNumber,
      this.cellNumber,
      this.address,
      this.patientTypeName,
      this.reportedDate,
      this.lastVisitDate,
      this.lastVisitTo,
      this.isInPatient,
      this.patientTypeForProcedureBooking,
      this.patientStatus,
      this.smoker,
      this.diabetic,
      this.patientPicturePath,
      this.branchType});

  PatientDetail1.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    mRNo = json['MRNo'];
    name = json['Name'];
    identityType = json['IdentityType'];
    patientCheckInId = json['PatientCheckInId'];
    checkInTypeValue = json['CheckInTypeValue'];
    cNICNumber = json['CNICNumber'];
    picturePath = json['PicturePath'];
    age = json['Age'];
    visitNo = json['VisitNo'];
    modifiedOn = json['ModifiedOn'];
    modifiedById = json['ModifiedById'];
    telephoneNumber = json['TelephoneNumber'];
    cellNumber = json['CellNumber'];
    address = json['Address'];
    patientTypeName = json['PatientTypeName'];
    reportedDate = json['ReportedDate'];
    lastVisitDate = json['LastVisitDate'];
    lastVisitTo = json['LastVisitTo'];
    isInPatient = json['IsInPatient'];
    patientTypeForProcedureBooking = json['PatientTypeForProcedureBooking'];
    patientStatus = json['PatientStatus'];
    smoker = json['Smoker'];
    diabetic = json['Diabetic'];
    patientPicturePath = json['PatientPicturePath'];
    branchType = json['BranchType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['MRNo'] = mRNo;
    data['Name'] = name;
    data['IdentityType'] = identityType;
    data['PatientCheckInId'] = patientCheckInId;
    data['CheckInTypeValue'] = checkInTypeValue;
    data['CNICNumber'] = cNICNumber;
    data['PicturePath'] = picturePath;
    data['Age'] = age;
    data['VisitNo'] = visitNo;
    data['ModifiedOn'] = modifiedOn;
    data['ModifiedById'] = modifiedById;
    data['TelephoneNumber'] = telephoneNumber;
    data['CellNumber'] = cellNumber;
    data['Address'] = address;
    data['PatientTypeName'] = patientTypeName;
    data['ReportedDate'] = reportedDate;
    data['LastVisitDate'] = lastVisitDate;
    data['LastVisitTo'] = lastVisitTo;
    data['IsInPatient'] = isInPatient;
    data['PatientTypeForProcedureBooking'] = patientTypeForProcedureBooking;
    data['PatientStatus'] = patientStatus;
    data['Smoker'] = smoker;
    data['Diabetic'] = diabetic;
    data['PatientPicturePath'] = patientPicturePath;
    data['BranchType'] = branchType;
    return data;
  }

  Future<List<PatientDetail1>> getPatientDetailForPrescription(
      String dit, String vno, String pid, String bid) async {
    print("a");
    String url = AppConstants.getPatientDetailForPrescription;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "DoctorId": dit,
      "VisitNo": vno,
      "PatientId": pid,
      "BranchId": bid,
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);

      // Check if the JSON data is a list or a single object
      if (jsonData is List) {
        List<PatientDetail1> patientdetailList =
            jsonData.map((json) => PatientDetail1.fromJson(json)).toList();
        return patientdetailList;
      } else if (jsonData is Map<String, dynamic>) {
        // Handle the case when jsonData is a single object
        PatientDetail1 patientDetail = PatientDetail1.fromJson(jsonData);
        return [patientDetail]; // Return a list with a single element
      } else {
        throw Exception('Invalid JSON response');
      }
    } else {
      throw Exception('Failed to fetch patient details');
    }
  }
}
