class consultingqueuereponse {
  String? patientName;
  String? mRNo;
  bool? isOnline;
  String? locationName;
  String? locationAddress;
  List<ConsultationDetails>? consultationDetails;

  consultingqueuereponse(
      {this.patientName,
      this.mRNo,
      this.isOnline,
      this.locationName,
      this.locationAddress,
      this.consultationDetails});

  consultingqueuereponse.fromJson(Map<String, dynamic> json) {
    patientName = json['PatientName'];
    mRNo = json['MRNo'];
    isOnline = json['IsOnline'];
    locationName = json['LocationName'];
    locationAddress = json['LocationAddress'];
    if (json['ConsultationDetails'] != null) {
      consultationDetails = <ConsultationDetails>[];
      json['ConsultationDetails'].forEach((v) {
        consultationDetails!.add(ConsultationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientName'] = patientName;
    data['MRNo'] = mRNo;
    data['IsOnline'] = isOnline;
    data['LocationName'] = locationName;
    data['LocationAddress'] = locationAddress;
    if (consultationDetails != null) {
      data['ConsultationDetails'] =
          consultationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConsultationDetails {
  String? consultedTime;
  String? visitNo;
  String? status;
  String? uRL;

  ConsultationDetails(
      {this.consultedTime, this.visitNo, this.status, this.uRL});

  ConsultationDetails.fromJson(Map<String, dynamic> json) {
    consultedTime = json['ConsultedTime'];
    visitNo = json['VisitNo'];
    status = json['Status'];
    uRL = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ConsultedTime'] = consultedTime;
    data['VisitNo'] = visitNo;
    data['Status'] = status;
    data['URL'] = uRL;
    return data;
  }
}
