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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DoctorId'] = doctorId;
    data['DayDate'] = dayDate;
    data['BranchId'] = branchId;
    data['Token'] = token;
    data['IsOnline'] = isOnline;
    return data;
  }
}
