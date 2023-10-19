class monthlyappointbody {
  dynamic doctorId;
  dynamic monthAndYear;
  dynamic workLocationId;
  dynamic isOnline;

  monthlyappointbody(
      {this.doctorId, this.monthAndYear, this.workLocationId, this.isOnline});

  monthlyappointbody.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    monthAndYear = json['MonthAndYear'];
    workLocationId = json['WorkLocationId'];
    isOnline = json['IsOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DoctorId'] = doctorId;
    data['MonthAndYear'] = monthAndYear;
    data['WorkLocationId'] = workLocationId;
    data['IsOnline'] = isOnline;
    return data;
  }
}
