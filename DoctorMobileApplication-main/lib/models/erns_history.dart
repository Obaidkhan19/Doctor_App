class ernsHistory {
  int? status;
  List<VitalsHistory>? vitalsHistory;
  List<InvestigationsHistory>? investigationsHistory;
  List<DiagnosticsHistory>? diagnosticsHistory;
  List<ComplaintsHistory>? complaintsHistory;
  List<PrimaryDiagnosisHistory>? primaryDiagnosisHistory;
  List<PrceduresHistory>? prceduresHistory;

  ernsHistory({
    this.status,
    this.vitalsHistory,
    this.investigationsHistory,
    this.diagnosticsHistory,
    this.complaintsHistory,
    this.primaryDiagnosisHistory,
    this.prceduresHistory,
  });

  ernsHistory.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Vitals'] != null) {
      vitalsHistory = <VitalsHistory>[];
      json['Vitals'].forEach((v) {
        vitalsHistory!.add(VitalsHistory.fromJson(v));
      });
    }
    if (json['Investigations'] != null) {
      investigationsHistory = <InvestigationsHistory>[];
      json['Investigations'].forEach((v) {
        investigationsHistory!.add(InvestigationsHistory.fromJson(v));
      });
    }
    if (json['Diagnostics'] != null) {
      diagnosticsHistory = <DiagnosticsHistory>[];
      json['Diagnostics'].forEach((v) {
        diagnosticsHistory!.add(DiagnosticsHistory.fromJson(v));
      });
    }
    if (json['Complaints'] != null) {
      complaintsHistory = <ComplaintsHistory>[];
      json['Complaints'].forEach((v) {
        complaintsHistory!.add(ComplaintsHistory.fromJson(v));
      });
    }
    if (json['PrimaryDiagnosis'] != null) {
      primaryDiagnosisHistory = <PrimaryDiagnosisHistory>[];
      json['PrimaryDiagnosis'].forEach((v) {
        primaryDiagnosisHistory!.add(PrimaryDiagnosisHistory.fromJson(v));
      });
    }

    if (json['Prcedures'] != null) {
      prceduresHistory = <PrceduresHistory>[];
      json['Prcedures'].forEach((v) {
        prceduresHistory!.add(PrceduresHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (vitalsHistory != null) {
      data['Vitals'] = vitalsHistory!.map((v) => v.toJson()).toList();
    }
    if (investigationsHistory != null) {
      data['Investigations'] =
          investigationsHistory!.map((v) => v.toJson()).toList();
    }
    if (diagnosticsHistory != null) {
      data['Diagnostics'] = diagnosticsHistory!.map((v) => v.toJson()).toList();
    }
    if (complaintsHistory != null) {
      data['Complaints'] = complaintsHistory!.map((v) => v.toJson()).toList();
    }
    if (primaryDiagnosisHistory != null) {
      data['PrimaryDiagnosis'] =
          primaryDiagnosisHistory!.map((v) => v.toJson()).toList();
    }

    if (prceduresHistory != null) {
      data['Prcedures'] = prceduresHistory!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class VitalsHistory {
  dynamic id;
  dynamic name;
  dynamic patientId;
  dynamic temperature;
  dynamic pulse;
  dynamic bloodPressureSystolic;
  dynamic bloodPressureDiastolic;
  dynamic respiratoryRate;
  dynamic weight;
  dynamic age;
  dynamic height;
  dynamic sPO2;
  dynamic visitNo;
  dynamic headCircumference;
  dynamic timeStampString;

  VitalsHistory(
      {this.id,
      this.name,
      this.patientId,
      this.temperature,
      this.pulse,
      this.bloodPressureSystolic,
      this.bloodPressureDiastolic,
      this.respiratoryRate,
      this.weight,
      this.age,
      this.height,
      this.sPO2,
      this.visitNo,
      this.headCircumference,
      this.timeStampString});

  VitalsHistory.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    patientId = json['PatientId'];
    temperature = json['Temperature'];
    pulse = json['Pulse'];
    bloodPressureSystolic = json['BloodPressureSystolic'];
    bloodPressureDiastolic = json['BloodPressureDiastolic'];
    respiratoryRate = json['RespiratoryRate'];
    weight = json['Weight'];
    age = json['Age'];
    height = json['Height'];
    sPO2 = json['SPO2'];
    visitNo = json['VisitNo'];
    headCircumference = json['HeadCircumference'];
    timeStampString = json['TimeStampString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['PatientId'] = patientId;
    data['Temperature'] = temperature;
    data['Pulse'] = pulse;
    data['BloodPressureSystolic'] = bloodPressureSystolic;
    data['BloodPressureDiastolic'] = bloodPressureDiastolic;
    data['RespiratoryRate'] = respiratoryRate;
    data['Weight'] = weight;
    data['Age'] = age;
    data['Height'] = height;
    data['SPO2'] = sPO2;
    data['VisitNo'] = visitNo;
    data['HeadCircumference'] = headCircumference;
    data['TimeStampString'] = timeStampString;
    return data;
  }
}

class InvestigationsHistory {
  String? id;
  String? name;
  dynamic code;
  dynamic comments;

  InvestigationsHistory({this.id, this.name, this.code, this.comments});

  InvestigationsHistory.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    code = json['Code'];
    comments = json['Comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Code'] = code;
    data['Comments'] = comments;
    return data;
  }
}

class PrimaryDiagnosisHistory {
  String? eRNSId;
  String? genericName;
  dynamic investigationName;
  dynamic dianosticName;
  dynamic comments;
  dynamic patientStatus;
  dynamic code;
  dynamic uRL;

  PrimaryDiagnosisHistory(
      {this.eRNSId,
      this.genericName,
      this.investigationName,
      this.dianosticName,
      this.comments,
      this.patientStatus,
      this.code,
      this.uRL});

  PrimaryDiagnosisHistory.fromJson(Map<String, dynamic> json) {
    eRNSId = json['ERNSId'];
    genericName = json['GenericName'];
    investigationName = json['InvestigationName'];
    dianosticName = json['DianosticName'];
    comments = json['Comments'];
    patientStatus = json['PatientStatus'];
    code = json['Code'];
    uRL = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ERNSId'] = eRNSId;
    data['GenericName'] = genericName;
    data['InvestigationName'] = investigationName;
    data['DianosticName'] = dianosticName;
    data['Comments'] = comments;
    data['PatientStatus'] = patientStatus;
    data['Code'] = code;
    data['URL'] = uRL;
    return data;
  }
}

class PrceduresHistory {
  String? eRNSId;
  dynamic genericName;
  dynamic investigationName;
  String? dianosticName;
  dynamic comments;
  String? patientStatus;
  dynamic code;
  dynamic uRL;

  PrceduresHistory(
      {this.eRNSId,
      this.genericName,
      this.investigationName,
      this.dianosticName,
      this.comments,
      this.patientStatus,
      this.code,
      this.uRL});

  PrceduresHistory.fromJson(Map<String, dynamic> json) {
    eRNSId = json['ERNSId'];
    genericName = json['GenericName'];
    investigationName = json['InvestigationName'];
    dianosticName = json['DianosticName'];
    comments = json['Comments'];
    patientStatus = json['PatientStatus'];
    code = json['Code'];
    uRL = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ERNSId'] = eRNSId;
    data['GenericName'] = genericName;
    data['InvestigationName'] = investigationName;
    data['DianosticName'] = dianosticName;
    data['Comments'] = comments;
    data['PatientStatus'] = patientStatus;
    data['Code'] = code;
    data['URL'] = uRL;
    return data;
  }
}

class DiagnosticsHistory {
  String? id;
  String? name;
  String? code;
  String? comments;

  DiagnosticsHistory({this.id, this.name, this.code, this.comments});

  DiagnosticsHistory.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    code = json['Code'];
    comments = json['Comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Code'] = code;
    data['Comments'] = comments;
    return data;
  }
}

class ComplaintsHistory {
  String? id;
  String? name;
  String? code;
  String? comments;

  ComplaintsHistory({this.id, this.name, this.code, this.comments});

  ComplaintsHistory.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    code = json['Code'];
    comments = json['Comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Code'] = code;
    data['Comments'] = comments;
    return data;
  }
}
