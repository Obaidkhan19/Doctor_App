// class ernsHistory {
//   int? status;
//   List<Vitals>? vitals;
//   List<Investigations>? investigations;
//   List<DiagnosticsHistory>? diagnosticsHistory;
//   List<Complaintshistory>? Complaintshistory;
//   List<PrimaryDiagnosis>? primaryDiagnosis;
//   List<Null>? instructions;
//   List<Prcedures>? prcedures;
//   List<Null>? secondaryDiagnosis;

//   ernsHistory(
//       {this.status,
//       this.vitals,
//       this.investigations,
//       this.diagnostics,
//       this.Complaintshistory,
//       this.primaryDiagnosis,
//       this.instructions,
//       this.prcedures,
//       this.secondaryDiagnosis});

//   ernsHistory.fromJson(Map<String, dynamic> json) {
//     status = json['Status'];
//     if (json['Vitals'] != null) {
//       vitals = <Vitals>[];
//       json['Vitals'].forEach((v) {
//         vitals!.add(new Vitals.fromJson(v));
//       });
//     }
//     if (json['Investigations'] != null) {
//       investigations = <Investigations>[];
//       json['Investigations'].forEach((v) {
//         investigations!.add(new Investigations.fromJson(v));
//       });
//     }
//     if (json['Diagnostics'] != null) {
//       diagnostics = <Diagnostics>[];
//       json['Diagnostics'].forEach((v) {
//         diagnostics!.add(new Diagnostics.fromJson(v));
//       });
//     }
//     if (json['Complaintshistory'] != null) {
//       Complaintshistory = <Complaintshistory>[];
//       json['Complaintshistory'].forEach((v) {
//         Complaintshistory!.add(new Complaintshistory.fromJson(v));
//       });
//     }
//     if (json['PrimaryDiagnosis'] != null) {
//       primaryDiagnosis = <PrimaryDiagnosis>[];
//       json['PrimaryDiagnosis'].forEach((v) {
//         primaryDiagnosis!.add(new PrimaryDiagnosis.fromJson(v));
//       });
//     }
//     if (json['Instructions'] != null) {
//       instructions = <Null>[];
//       json['Instructions'].forEach((v) {
//         instructions!.add(new Null.fromJson(v));
//       });
//     }
//     if (json['Prcedures'] != null) {
//       prcedures = <Prcedures>[];
//       json['Prcedures'].forEach((v) {
//         prcedures!.add(new Prcedures.fromJson(v));
//       });
//     }
//     if (json['SecondaryDiagnosis'] != null) {
//       secondaryDiagnosis = <Null>[];
//       json['SecondaryDiagnosis'].forEach((v) {
//         secondaryDiagnosis!.add(new Null.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Status'] = this.status;
//     if (this.vitals != null) {
//       data['Vitals'] = this.vitals!.map((v) => v.toJson()).toList();
//     }
//     if (this.investigations != null) {
//       data['Investigations'] =
//           this.investigations!.map((v) => v.toJson()).toList();
//     }
//     if (this.diagnostics != null) {
//       data['Diagnostics'] = this.diagnostics!.map((v) => v.toJson()).toList();
//     }
//     if (this.Complaintshistory != null) {
//       data['Complaints'] = this.complaints!.map((v) => v.toJson()).toList();
//     }
//     if (this.primaryDiagnosis != null) {
//       data['PrimaryDiagnosis'] =
//           this.primaryDiagnosis!.map((v) => v.toJson()).toList();
//     }
//     if (this.instructions != null) {
//       data['Instructions'] = this.instructions!.map((v) => v.toJson()).toList();
//     }
//     if (this.prcedures != null) {
//       data['Prcedures'] = this.prcedures!.map((v) => v.toJson()).toList();
//     }
//     if (this.secondaryDiagnosis != null) {
//       data['SecondaryDiagnosis'] =
//           this.secondaryDiagnosis!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Vitals {
//   String? id;
//   String? name;
//   String? patientId;
//   int? temperature;
//   int? pulse;
//   int? bloodPressureSystolic;
//   int? bloodPressureDiastolic;
//   int? respiratoryRate;
//   int? weight;
//   Null? age;
//   int? height;
//   int? sPO2;
//   String? visitNo;
//   Null? headCircumference;
//   Null? timeStampString;

//   Vitals(
//       {this.id,
//       this.name,
//       this.patientId,
//       this.temperature,
//       this.pulse,
//       this.bloodPressureSystolic,
//       this.bloodPressureDiastolic,
//       this.respiratoryRate,
//       this.weight,
//       this.age,
//       this.height,
//       this.sPO2,
//       this.visitNo,
//       this.headCircumference,
//       this.timeStampString});

//   Vitals.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     name = json['Name'];
//     patientId = json['PatientId'];
//     temperature = json['Temperature'];
//     pulse = json['Pulse'];
//     bloodPressureSystolic = json['BloodPressureSystolic'];
//     bloodPressureDiastolic = json['BloodPressureDiastolic'];
//     respiratoryRate = json['RespiratoryRate'];
//     weight = json['Weight'];
//     age = json['Age'];
//     height = json['Height'];
//     sPO2 = json['SPO2'];
//     visitNo = json['VisitNo'];
//     headCircumference = json['HeadCircumference'];
//     timeStampString = json['TimeStampString'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Id'] = this.id;
//     data['Name'] = this.name;
//     data['PatientId'] = this.patientId;
//     data['Temperature'] = this.temperature;
//     data['Pulse'] = this.pulse;
//     data['BloodPressureSystolic'] = this.bloodPressureSystolic;
//     data['BloodPressureDiastolic'] = this.bloodPressureDiastolic;
//     data['RespiratoryRate'] = this.respiratoryRate;
//     data['Weight'] = this.weight;
//     data['Age'] = this.age;
//     data['Height'] = this.height;
//     data['SPO2'] = this.sPO2;
//     data['VisitNo'] = this.visitNo;
//     data['HeadCircumference'] = this.headCircumference;
//     data['TimeStampString'] = this.timeStampString;
//     return data;
//   }
// }

// class Investigations {
//   String? id;
//   String? name;
//   Null? code;
//   Null? comments;

//   Investigations({this.id, this.name, this.code, this.comments});

//   Investigations.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     name = json['Name'];
//     code = json['Code'];
//     comments = json['Comments'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Id'] = this.id;
//     data['Name'] = this.name;
//     data['Code'] = this.code;
//     data['Comments'] = this.comments;
//     return data;
//   }
// }

// class PrimaryDiagnosis {
//   String? eRNSId;
//   String? genericName;
//   Null? investigationName;
//   Null? dianosticName;
//   Null? comments;
//   Null? patientStatus;
//   Null? code;
//   Null? uRL;

//   PrimaryDiagnosis(
//       {this.eRNSId,
//       this.genericName,
//       this.investigationName,
//       this.dianosticName,
//       this.comments,
//       this.patientStatus,
//       this.code,
//       this.uRL});

//   PrimaryDiagnosis.fromJson(Map<String, dynamic> json) {
//     eRNSId = json['ERNSId'];
//     genericName = json['GenericName'];
//     investigationName = json['InvestigationName'];
//     dianosticName = json['DianosticName'];
//     comments = json['Comments'];
//     patientStatus = json['PatientStatus'];
//     code = json['Code'];
//     uRL = json['URL'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ERNSId'] = this.eRNSId;
//     data['GenericName'] = this.genericName;
//     data['InvestigationName'] = this.investigationName;
//     data['DianosticName'] = this.dianosticName;
//     data['Comments'] = this.comments;
//     data['PatientStatus'] = this.patientStatus;
//     data['Code'] = this.code;
//     data['URL'] = this.uRL;
//     return data;
//   }
// }

// class Prcedures {
//   String? eRNSId;
//   Null? genericName;
//   Null? investigationName;
//   String? dianosticName;
//   Null? comments;
//   String? patientStatus;
//   Null? code;
//   Null? uRL;

//   Prcedures(
//       {this.eRNSId,
//       this.genericName,
//       this.investigationName,
//       this.dianosticName,
//       this.comments,
//       this.patientStatus,
//       this.code,
//       this.uRL});

//   Prcedures.fromJson(Map<String, dynamic> json) {
//     eRNSId = json['ERNSId'];
//     genericName = json['GenericName'];
//     investigationName = json['InvestigationName'];
//     dianosticName = json['DianosticName'];
//     comments = json['Comments'];
//     patientStatus = json['PatientStatus'];
//     code = json['Code'];
//     uRL = json['URL'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ERNSId'] = this.eRNSId;
//     data['GenericName'] = this.genericName;
//     data['InvestigationName'] = this.investigationName;
//     data['DianosticName'] = this.dianosticName;
//     data['Comments'] = this.comments;
//     data['PatientStatus'] = this.patientStatus;
//     data['Code'] = this.code;
//     data['URL'] = this.uRL;
//     return data;
//   }
// }
