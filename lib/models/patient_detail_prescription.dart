class patientdatail_prescription {
  int? status;
  List<PatientDetail>? patientDetail;

  patientdatail_prescription({this.status, this.patientDetail});

  patientdatail_prescription.fromJson(Map<String, dynamic> json) {
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

class PatientDetail {
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
  dynamic patientPicturePath;
  dynamic branchType;

  PatientDetail(
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

  PatientDetail.fromJson(Map<String, dynamic> json) {
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
}
