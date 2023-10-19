class ConsultingQueueModel {
  int? status;
  List<Queue>? queue;
  int? totalRecord;
  int? filterRecord;
  String? errorMessage;

  ConsultingQueueModel(
      {this.status,
      this.queue,
      this.totalRecord,
      this.filterRecord,
      this.errorMessage});

  ConsultingQueueModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Queue'] != null) {
      queue = <Queue>[];
      json['Queue'].forEach((v) {
        queue!.add(Queue.fromJson(v));
      });
    }
    totalRecord = json['TotalRecord'];
    filterRecord = json['FilterRecord'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (queue != null) {
      data['Queue'] = queue!.map((v) => v.toJson()).toList();
    }
    data['TotalRecord'] = totalRecord;
    data['FilterRecord'] = filterRecord;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}

class Queue {
  String? patientCheckInId;
  String? patientId;
  String? doctorId;
  String? branchId;
  String? patientName;
  String? patientImagePath;
  String? identityNo;
  String? mRNO;
  String? referMessage;
  String? referBy;
  String? referTime;
  String? visitNo;
  String? visitTime;
  String? waitingTime;
  String? consultedTime;
  String? departmentId;
  String? subDepartmentId;
  bool? isOnline;
  String? chatURL;
  String? doctorName;
  int? prescribedInValue;
  int? patientStatusValue;
  String? status;
  String? admissionNumber;
  int? isFirstTimeVisit;
  String? reasons;
  String? reportURL;

  Queue(
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

  Queue.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientCheckInId'] = patientCheckInId;
    data['PatientId'] = patientId;
    data['DoctorId'] = doctorId;
    data['BranchId'] = branchId;
    data['PatientName'] = patientName;
    data['PatientImagePath'] = patientImagePath;
    data['IdentityNo'] = identityNo;
    data['MRNO'] = mRNO;
    data['ReferMessage'] = referMessage;
    data['ReferBy'] = referBy;
    data['ReferTime'] = referTime;
    data['VisitNo'] = visitNo;
    data['VisitTime'] = visitTime;
    data['WaitingTime'] = waitingTime;
    data['ConsultedTime'] = consultedTime;
    data['DepartmentId'] = departmentId;
    data['SubDepartmentId'] = subDepartmentId;
    data['IsOnline'] = isOnline;
    data['ChatURL'] = chatURL;
    data['DoctorName'] = doctorName;
    data['PrescribedInValue'] = prescribedInValue;
    data['PatientStatusValue'] = patientStatusValue;
    data['Status'] = status;
    data['AdmissionNumber'] = admissionNumber;
    data['IsFirstTimeVisit'] = isFirstTimeVisit;
    data['Reasons'] = reasons;
    data['ReportURL'] = reportURL;
    return data;
  }
}
