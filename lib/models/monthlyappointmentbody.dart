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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctorId'] = this.doctorId;
    data['MonthAndYear'] = this.monthAndYear;
    data['WorkLocationId'] = this.workLocationId;
    data['IsOnline'] = this.isOnline;
    return data;
  }
}
