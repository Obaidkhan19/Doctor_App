class prescribemedicinemodel {
  String? doctorId;
  String? branchId;
  String? patientId;
  String? visitNo;
  String? prescriptionPerformanceStart;
  String? prescriptionPerformanceEnd;
  String? defaultDoctorSpecialityId;
  String? examFinding;
  String? advice;
  String? patientStatusValue;
  List<MedicineList>? medicineList;
  List<String>? deletedMedicineList;
  List<String>? investigations;
  List<String>? deletedInvestigations;
  List<String>? diagnostics;
  List<String>? deletedDiagnostics;
  List<Procedures>? procedures;
  List<String>? deletedProcedures;
  List<Diagnosis>? diagnosis;
  List<String>? deletedDiagnosis;
  List<String>? complaints;
  List<String>? deletedComplaints;
  String? proceduralFindingText;
  String? proceduralFindingId;
  List<String>? followUps;
  List<String>? instructions;
  List<String>? deletedInstructions;
  String? prescribedInValue;
  String? dischargeNotes;
  List<SecondayDiagnosis>? secondayDiagnosis;
  List<String>? deletedSecondayDiagnosis;
  String? isFirstTimeVisit;
  String? smoker;
  String? diabetic;

  prescribemedicinemodel(
      {this.doctorId,
      this.branchId,
      this.patientId,
      this.visitNo,
      this.prescriptionPerformanceStart,
      this.prescriptionPerformanceEnd,
      this.defaultDoctorSpecialityId,
      this.examFinding,
      this.advice,
      this.patientStatusValue,
      this.medicineList,
      this.deletedMedicineList,
      this.investigations,
      this.deletedInvestigations,
      this.diagnostics,
      this.deletedDiagnostics,
      this.procedures,
      this.deletedProcedures,
      this.diagnosis,
      this.deletedDiagnosis,
      this.complaints,
      this.deletedComplaints,
      this.proceduralFindingText,
      this.proceduralFindingId,
      this.followUps,
      this.instructions,
      this.deletedInstructions,
      this.prescribedInValue,
      this.dischargeNotes,
      this.secondayDiagnosis,
      this.deletedSecondayDiagnosis,
      this.isFirstTimeVisit,
      this.smoker,
      this.diabetic});

  prescribemedicinemodel.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    branchId = json['BranchId'];
    patientId = json['PatientId'];
    visitNo = json['VisitNo'];
    prescriptionPerformanceStart = json['PrescriptionPerformanceStart'];
    prescriptionPerformanceEnd = json['PrescriptionPerformanceEnd'];
    defaultDoctorSpecialityId = json['DefaultDoctorSpecialityId'];
    examFinding = json['ExamFinding'];
    advice = json['Advice'];
    patientStatusValue = json['PatientStatusValue'];
    if (json['MedicineList'] != null) {
      medicineList = <MedicineList>[];
      json['MedicineList'].forEach((v) {
        medicineList!.add(new MedicineList.fromJson(v));
      });
    }
    deletedMedicineList = json['DeletedMedicineList'].cast<String>();
    // if (json['DeletedMedicineList'] != null) {
    //   deletedMedicineList = <String>[];
    //   json['DeletedMedicineList'].forEach((v) {
    //     deletedMedicineList!.add(new String(v));
    //   });
    // }
    investigations = json['Investigations'].cast<String>();
    deletedInvestigations = json['DeletedInvestigations'].cast<String>();
    diagnostics = json['Diagnostics'].cast<String>();
    deletedDiagnostics = json['DeletedDiagnostics'].cast<String>();
    if (json['Procedures'] != null) {
      procedures = <Procedures>[];
      json['Procedures'].forEach((v) {
        procedures!.add(new Procedures.fromJson(v));
      });
    }
    deletedProcedures = json['DeletedProcedures'].cast<String>();
    if (json['Diagnosis'] != null) {
      diagnosis = <Diagnosis>[];
      json['Diagnosis'].forEach((v) {
        diagnosis!.add(new Diagnosis.fromJson(v));
      });
    }
    deletedDiagnosis = json['DeletedDiagnosis'].cast<String>();
    complaints = json['Complaints'].cast<String>();
    deletedComplaints = json['DeletedComplaints'].cast<String>();
    proceduralFindingText = json['ProceduralFindingText'];
    proceduralFindingId = json['ProceduralFindingId'];
    followUps = json['FollowUps'].cast<String>();
    instructions = json['Instructions'].cast<String>();
    deletedInstructions = json['DeletedInstructions'].cast<String>();
    prescribedInValue = json['PrescribedInValue'];
    dischargeNotes = json['DischargeNotes'];
    if (json['SecondayDiagnosis'] != null) {
      secondayDiagnosis = <SecondayDiagnosis>[];
      json['SecondayDiagnosis'].forEach((v) {
        secondayDiagnosis!.add(new SecondayDiagnosis.fromJson(v));
      });
    }
    deletedSecondayDiagnosis = json['DeletedSecondayDiagnosis'].cast<String>();
    isFirstTimeVisit = json['IsFirstTimeVisit'];
    smoker = json['Smoker'];
    diabetic = json['Diabetic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctorId'] = this.doctorId;
    data['BranchId'] = this.branchId;
    data['PatientId'] = this.patientId;
    data['VisitNo'] = this.visitNo;
    data['PrescriptionPerformanceStart'] = this.prescriptionPerformanceStart;
    data['PrescriptionPerformanceEnd'] = this.prescriptionPerformanceEnd;
    data['DefaultDoctorSpecialityId'] = this.defaultDoctorSpecialityId;
    data['ExamFinding'] = this.examFinding;
    data['Advice'] = this.advice;
    data['PatientStatusValue'] = this.patientStatusValue;
    if (this.medicineList != null) {
      data['MedicineList'] = this.medicineList!.map((v) => v.toJson()).toList();
    }
    // if (this.deletedMedicineList != null) {
    //   data['DeletedMedicineList'] =
    //       this.deletedMedicineList!.map((v) => v.toJson()).toList();
    // }
    data['DeletedMedicineList'] = this.deletedMedicineList;
    data['Investigations'] = this.investigations;
    data['DeletedInvestigations'] = this.deletedInvestigations;
    data['Diagnostics'] = this.diagnostics;
    data['DeletedDiagnostics'] = this.deletedDiagnostics;
    if (this.procedures != null) {
      data['Procedures'] = this.procedures!.map((v) => v.toJson()).toList();
    }
    data['DeletedProcedures'] = this.deletedProcedures;
    if (this.diagnosis != null) {
      data['Diagnosis'] = this.diagnosis!.map((v) => v.toJson()).toList();
    }
    data['DeletedDiagnosis'] = this.deletedDiagnosis;
    data['Complaints'] = this.complaints;
    data['DeletedComplaints'] = this.deletedComplaints;
    data['ProceduralFindingText'] = this.proceduralFindingText;
    data['ProceduralFindingId'] = this.proceduralFindingId;
    data['FollowUps'] = this.followUps;
    data['Instructions'] = this.instructions;
    data['DeletedInstructions'] = this.deletedInstructions;
    data['PrescribedInValue'] = this.prescribedInValue;
    data['DischargeNotes'] = this.dischargeNotes;
    if (this.secondayDiagnosis != null) {
      data['SecondayDiagnosis'] =
          this.secondayDiagnosis!.map((v) => v.toJson()).toList();
    }
    data['DeletedSecondayDiagnosis'] = this.deletedSecondayDiagnosis;
    data['IsFirstTimeVisit'] = this.isFirstTimeVisit;
    data['Smoker'] = this.smoker;
    data['Diabetic'] = this.diabetic;
    return data;
  }
}

class MedicineList {
  String? id;
  String? medicineStrengthId;
  String? medicineDosageId;
  String? dosageValue;
  String? frequencyNumeric;
  String? frequencyQuantity;
  String? dayId;
  String? dateId;
  String? medicineRouteId;
  String? medicineEventTimingId;
  String? preference;
  String? medicineEventTimingDetail;
  String? medicineEnglishDescription;
  String? medicineUrduDescription;
  String? tappedMedicinesDetail;
  String? medicineDurationDetail;
  String? quantity;
  String? medicineTypeInTakeId;
  String? ophthType;
  String? comment;

  MedicineList(
      {this.id,
      this.medicineStrengthId,
      this.medicineDosageId,
      this.dosageValue,
      this.frequencyNumeric,
      this.frequencyQuantity,
      this.dayId,
      this.dateId,
      this.medicineRouteId,
      this.medicineEventTimingId,
      this.preference,
      this.medicineEventTimingDetail,
      this.medicineEnglishDescription,
      this.medicineUrduDescription,
      this.tappedMedicinesDetail,
      this.medicineDurationDetail,
      this.quantity,
      this.medicineTypeInTakeId,
      this.ophthType,
      this.comment});

  MedicineList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    medicineStrengthId = json['MedicineStrength_Id'];
    medicineDosageId = json['MedicineDosageId'];
    dosageValue = json['DosageValue'];
    frequencyNumeric = json['FrequencyNumeric'];
    frequencyQuantity = json['FrequencyQuantity'];
    dayId = json['DayId'];
    dateId = json['DateId'];
    medicineRouteId = json['MedicineRouteId'];
    medicineEventTimingId = json['MedicineEventTimingId'];
    preference = json['Preference'];
    medicineEventTimingDetail = json['MedicineEventTimingDetail'];
    medicineEnglishDescription = json['MedicineEnglishDescription'];
    medicineUrduDescription = json['MedicineUrduDescription'];
    tappedMedicinesDetail = json['TappedMedicinesDetail'];
    medicineDurationDetail = json['MedicineDurationDetail'];
    quantity = json['Quantity'];
    medicineTypeInTakeId = json['MedicineTypeInTakeId'];
    ophthType = json['OphthType'];
    comment = json['Comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['MedicineStrength_Id'] = this.medicineStrengthId;
    data['MedicineDosageId'] = this.medicineDosageId;
    data['DosageValue'] = this.dosageValue;
    data['FrequencyNumeric'] = this.frequencyNumeric;
    data['FrequencyQuantity'] = this.frequencyQuantity;
    data['DayId'] = this.dayId;
    data['DateId'] = this.dateId;
    data['MedicineRouteId'] = this.medicineRouteId;
    data['MedicineEventTimingId'] = this.medicineEventTimingId;
    data['Preference'] = this.preference;
    data['MedicineEventTimingDetail'] = this.medicineEventTimingDetail;
    data['MedicineEnglishDescription'] = this.medicineEnglishDescription;
    data['MedicineUrduDescription'] = this.medicineUrduDescription;
    data['TappedMedicinesDetail'] = this.tappedMedicinesDetail;
    data['MedicineDurationDetail'] = this.medicineDurationDetail;
    data['Quantity'] = this.quantity;
    data['MedicineTypeInTakeId'] = this.medicineTypeInTakeId;
    data['OphthType'] = this.ophthType;
    data['Comment'] = this.comment;
    return data;
  }
}

class Procedures {
  String? id;
  String? subDepartmentId;
  String? procedureDate;
  String? procedureTime;
  String? procedureDurationInMinutes;
  String? discountStatus;
  String? clinicalHistory;
  String? comments;
  String? anesthesiaType;
  String? ophthType;
  String? isUrgent;
  String? isGAFitnessRequried;

  Procedures(
      {this.id,
      this.subDepartmentId,
      this.procedureDate,
      this.procedureTime,
      this.procedureDurationInMinutes,
      this.discountStatus,
      this.clinicalHistory,
      this.comments,
      this.anesthesiaType,
      this.ophthType,
      this.isUrgent,
      this.isGAFitnessRequried});

  Procedures.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    subDepartmentId = json['SubDepartmentId'];
    procedureDate = json['ProcedureDate'];
    procedureTime = json['ProcedureTime'];
    procedureDurationInMinutes = json['ProcedureDurationInMinutes'];
    discountStatus = json['DiscountStatus'];
    clinicalHistory = json['ClinicalHistory'];
    comments = json['Comments'];
    anesthesiaType = json['AnesthesiaType'];
    ophthType = json['OphthType'];
    isUrgent = json['IsUrgent'];
    isGAFitnessRequried = json['IsGAFitnessRequried'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SubDepartmentId'] = this.subDepartmentId;
    data['ProcedureDate'] = this.procedureDate;
    data['ProcedureTime'] = this.procedureTime;
    data['ProcedureDurationInMinutes'] = this.procedureDurationInMinutes;
    data['DiscountStatus'] = this.discountStatus;
    data['ClinicalHistory'] = this.clinicalHistory;
    data['Comments'] = this.comments;
    data['AnesthesiaType'] = this.anesthesiaType;
    data['OphthType'] = this.ophthType;
    data['IsUrgent'] = this.isUrgent;
    data['IsGAFitnessRequried'] = this.isGAFitnessRequried;
    return data;
  }
}

class Diagnosis {
  String? id;
  String? comments;
  String? ophthType;

  Diagnosis({this.id, this.comments, this.ophthType});

  Diagnosis.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    comments = json['Comments'];
    ophthType = json['OphthType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Comments'] = this.comments;
    data['OphthType'] = this.ophthType;
    return data;
  }

  
}
class SecondayDiagnosis {
  String? id;
  String? comments;
  String? ophthType;

  SecondayDiagnosis({this.id, this.comments, this.ophthType});

  SecondayDiagnosis.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    comments = json['Comments'];
    ophthType = json['OphthType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Comments'] = this.comments;
    data['OphthType'] = this.ophthType;
    return data;
  }
}

