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
        medicineList!.add(MedicineList.fromJson(v));
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
        procedures!.add(Procedures.fromJson(v));
      });
    }
    deletedProcedures = json['DeletedProcedures'].cast<String>();
    if (json['Diagnosis'] != null) {
      diagnosis = <Diagnosis>[];
      json['Diagnosis'].forEach((v) {
        diagnosis!.add(Diagnosis.fromJson(v));
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
        secondayDiagnosis!.add(SecondayDiagnosis.fromJson(v));
      });
    }
    deletedSecondayDiagnosis = json['DeletedSecondayDiagnosis'].cast<String>();
    isFirstTimeVisit = json['IsFirstTimeVisit'];
    smoker = json['Smoker'];
    diabetic = json['Diabetic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DoctorId'] = doctorId;
    data['BranchId'] = branchId;
    data['PatientId'] = patientId;
    data['VisitNo'] = visitNo;
    data['PrescriptionPerformanceStart'] = prescriptionPerformanceStart;
    data['PrescriptionPerformanceEnd'] = prescriptionPerformanceEnd;
    data['DefaultDoctorSpecialityId'] = defaultDoctorSpecialityId;
    data['ExamFinding'] = examFinding;
    data['Advice'] = advice;
    data['PatientStatusValue'] = patientStatusValue;
    if (medicineList != null) {
      data['MedicineList'] = medicineList!.map((v) => v.toJson()).toList();
    }
    // if (this.deletedMedicineList != null) {
    //   data['DeletedMedicineList'] =
    //       this.deletedMedicineList!.map((v) => v.toJson()).toList();
    // }
    data['DeletedMedicineList'] = deletedMedicineList;
    data['Investigations'] = investigations;
    data['DeletedInvestigations'] = deletedInvestigations;
    data['Diagnostics'] = diagnostics;
    data['DeletedDiagnostics'] = deletedDiagnostics;
    if (procedures != null) {
      data['Procedures'] = procedures!.map((v) => v.toJson()).toList();
    }
    data['DeletedProcedures'] = deletedProcedures;
    if (diagnosis != null) {
      data['Diagnosis'] = diagnosis!.map((v) => v.toJson()).toList();
    }
    data['DeletedDiagnosis'] = deletedDiagnosis;
    data['Complaints'] = complaints;
    data['DeletedComplaints'] = deletedComplaints;
    data['ProceduralFindingText'] = proceduralFindingText;
    data['ProceduralFindingId'] = proceduralFindingId;
    data['FollowUps'] = followUps;
    data['Instructions'] = instructions;
    data['DeletedInstructions'] = deletedInstructions;
    data['PrescribedInValue'] = prescribedInValue;
    data['DischargeNotes'] = dischargeNotes;
    if (secondayDiagnosis != null) {
      data['SecondayDiagnosis'] =
          secondayDiagnosis!.map((v) => v.toJson()).toList();
    }
    data['DeletedSecondayDiagnosis'] = deletedSecondayDiagnosis;
    data['IsFirstTimeVisit'] = isFirstTimeVisit;
    data['Smoker'] = smoker;
    data['Diabetic'] = diabetic;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['MedicineStrength_Id'] = medicineStrengthId;
    data['MedicineDosageId'] = medicineDosageId;
    data['DosageValue'] = dosageValue;
    data['FrequencyNumeric'] = frequencyNumeric;
    data['FrequencyQuantity'] = frequencyQuantity;
    data['DayId'] = dayId;
    data['DateId'] = dateId;
    data['MedicineRouteId'] = medicineRouteId;
    data['MedicineEventTimingId'] = medicineEventTimingId;
    data['Preference'] = preference;
    data['MedicineEventTimingDetail'] = medicineEventTimingDetail;
    data['MedicineEnglishDescription'] = medicineEnglishDescription;
    data['MedicineUrduDescription'] = medicineUrduDescription;
    data['TappedMedicinesDetail'] = tappedMedicinesDetail;
    data['MedicineDurationDetail'] = medicineDurationDetail;
    data['Quantity'] = quantity;
    data['MedicineTypeInTakeId'] = medicineTypeInTakeId;
    data['OphthType'] = ophthType;
    data['Comment'] = comment;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['SubDepartmentId'] = subDepartmentId;
    data['ProcedureDate'] = procedureDate;
    data['ProcedureTime'] = procedureTime;
    data['ProcedureDurationInMinutes'] = procedureDurationInMinutes;
    data['DiscountStatus'] = discountStatus;
    data['ClinicalHistory'] = clinicalHistory;
    data['Comments'] = comments;
    data['AnesthesiaType'] = anesthesiaType;
    data['OphthType'] = ophthType;
    data['IsUrgent'] = isUrgent;
    data['IsGAFitnessRequried'] = isGAFitnessRequried;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Comments'] = comments;
    data['OphthType'] = ophthType;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Comments'] = comments;
    data['OphthType'] = ophthType;
    return data;
  }
}
