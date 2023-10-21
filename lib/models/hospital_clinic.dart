class hospitalClinci {
  int? status;
  List<HospitalORClinics>? hospitalORClinics;

  hospitalClinci({this.status, this.hospitalORClinics});

  hospitalClinci.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['HospitalORClinics'] != null) {
      hospitalORClinics = <HospitalORClinics>[];
      json['HospitalORClinics'].forEach((v) {
        hospitalORClinics!.add(HospitalORClinics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (hospitalORClinics != null) {
      data['HospitalORClinics'] =
          hospitalORClinics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HospitalORClinics {
  String? id;
  String? name;

  HospitalORClinics({this.id, this.name});

  HospitalORClinics.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}
