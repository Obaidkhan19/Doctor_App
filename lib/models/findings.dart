class findings {
  List<ExamFindings>? examFindings;

  findings({this.examFindings});

  findings.fromJson(Map<String, dynamic> json) {
    if (json['ExamFindings'] != null) {
      examFindings = <ExamFindings>[];
      json['ExamFindings'].forEach((v) {
        examFindings!.add(ExamFindings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (examFindings != null) {
      data['ExamFindings'] = examFindings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExamFindings {
  String? examFinding;
  String? doctorName;
  String? createdOn;
  int? isDeleteable;

  ExamFindings(
      {this.examFinding, this.doctorName, this.createdOn, this.isDeleteable});

  ExamFindings.fromJson(Map<String, dynamic> json) {
    examFinding = json['ExamFinding'];
    doctorName = json['DoctorName'];
    createdOn = json['CreatedOn'];
    isDeleteable = json['IsDeleteable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ExamFinding'] = examFinding;
    data['DoctorName'] = doctorName;
    data['CreatedOn'] = createdOn;
    data['IsDeleteable'] = isDeleteable;
    return data;
  }
}
