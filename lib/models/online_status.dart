class OnlineStatusRequest {
  String? doctorId;
  String? dayDate;
  String? branchId;
  String? token;
  String? isOnline;

  OnlineStatusRequest(
      {this.doctorId, this.dayDate, this.branchId, this.token, this.isOnline});

  OnlineStatusRequest.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    dayDate = json['DayDate'];
    branchId = json['BranchId'];
    token = json['Token'];
    isOnline = json['IsOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctorId'] = this.doctorId;
    data['DayDate'] = this.dayDate;
    data['BranchId'] = this.branchId;
    data['Token'] = this.token;
    data['IsOnline'] = this.isOnline;
    return data;
  }
}
