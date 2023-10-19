class consultingqueuewaitholdresponse {
  dynamic patientCheckInId;
  dynamic patientId;
  dynamic doctorId;
  dynamic branchId;
  dynamic patientName;
  dynamic patientImagePath;
  dynamic identityNo;
  dynamic mRNO;
  dynamic referMessage;
  dynamic referBy;
  dynamic referTime;
  dynamic visitNo;
  dynamic visitTime;
  dynamic waitingTime;
  dynamic consultedTime;
  dynamic departmentId;
  dynamic subDepartmentId;
  dynamic isOnline;
  dynamic chatURL;
  dynamic doctorName;
  dynamic prescribedInValue;
  dynamic patientStatusValue;
  dynamic status;
  dynamic admissionNumber;
  dynamic isFirstTimeVisit;
  dynamic reasons;
  dynamic reportURL;

  consultingqueuewaitholdresponse(
      {this.patientCheckInId,
      this.patientId,
      this.doctorId,
      this.branchId,
      this.patientName,
      this.patientImagePath,
      this.identityNo,
      this.mRNO,
      this.referMessage,
      this.referBy,
      this.referTime,
      this.visitNo,
      this.visitTime,
      this.waitingTime,
      this.consultedTime,
      this.departmentId,
      this.subDepartmentId,
      this.isOnline,
      this.chatURL,
      this.doctorName,
      this.prescribedInValue,
      this.patientStatusValue,
      this.status,
      this.admissionNumber,
      this.isFirstTimeVisit,
      this.reasons,
      this.reportURL});

  consultingqueuewaitholdresponse.fromJson(Map<String, dynamic> json) {
    patientCheckInId = json['PatientCheckInId'];
    patientId = json['PatientId'];
    doctorId = json['DoctorId'];
    branchId = json['BranchId'];
    patientName = json['PatientName'];
    patientImagePath = json['PatientImagePath'];
    identityNo = json['IdentityNo'];
    mRNO = json['MRNO'];
    referMessage = json['ReferMessage'];
    referBy = json['ReferBy'];
    referTime = json['ReferTime'];
    visitNo = json['VisitNo'];
    visitTime = json['VisitTime'];
    waitingTime = json['WaitingTime'];
    consultedTime = json['ConsultedTime'];
    departmentId = json['DepartmentId'];
    subDepartmentId = json['SubDepartmentId'];
    isOnline = json['IsOnline'];
    chatURL = json['ChatURL'];
    doctorName = json['DoctorName'];
    prescribedInValue = json['PrescribedInValue'];
    patientStatusValue = json['PatientStatusValue'];
    status = json['Status'];
    admissionNumber = json['AdmissionNumber'];
    isFirstTimeVisit = json['IsFirstTimeVisit'];
    reasons = json['Reasons'];
    reportURL = json['ReportURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PatientCheckInId'] = this.patientCheckInId;
    data['PatientId'] = this.patientId;
    data['DoctorId'] = this.doctorId;
    data['BranchId'] = this.branchId;
    data['PatientName'] = this.patientName;
    data['PatientImagePath'] = this.patientImagePath;
    data['IdentityNo'] = this.identityNo;
    data['MRNO'] = this.mRNO;
    data['ReferMessage'] = this.referMessage;
    data['ReferBy'] = this.referBy;
    data['ReferTime'] = this.referTime;
    data['VisitNo'] = this.visitNo;
    data['VisitTime'] = this.visitTime;
    data['WaitingTime'] = this.waitingTime;
    data['ConsultedTime'] = this.consultedTime;
    data['DepartmentId'] = this.departmentId;
    data['SubDepartmentId'] = this.subDepartmentId;
    data['IsOnline'] = this.isOnline;
    data['ChatURL'] = this.chatURL;
    data['DoctorName'] = this.doctorName;
    data['PrescribedInValue'] = this.prescribedInValue;
    data['PatientStatusValue'] = this.patientStatusValue;
    data['Status'] = this.status;
    data['AdmissionNumber'] = this.admissionNumber;
    data['IsFirstTimeVisit'] = this.isFirstTimeVisit;
    data['Reasons'] = this.reasons;
    data['ReportURL'] = this.reportURL;
    return data;
  }
}
