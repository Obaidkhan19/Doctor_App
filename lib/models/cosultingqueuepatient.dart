class consultingqueuepatients {
  String? doctorId;
  String? search;
  String? branchId;
  String? workLocationId;
  String? status;
  String? fromDate;
  String? toDate;
  String? isOnline;
  String? token;
  String? start;
  String? length;
  String? orderColumn;
  String? orderDir;

  consultingqueuepatients(
      {this.doctorId,
      this.search,
      this.branchId,
      this.workLocationId,
      this.status,
      this.fromDate,
      this.toDate,
      this.isOnline,
      this.token,
      this.start,
      this.length,
      this.orderColumn,
      this.orderDir});

  consultingqueuepatients.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    search = json['Search'];
    branchId = json['BranchId'];
    workLocationId = json['WorkLocationId'];
    status = json['Status'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    isOnline = json['IsOnline'];
    token = json['Token'];
    start = json['Start'];
    length = json['Length'];
    orderColumn = json['OrderColumn'];
    orderDir = json['OrderDir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DoctorId'] = doctorId;
    data['Search'] = search;
    data['BranchId'] = branchId;
    data['WorkLocationId'] = workLocationId;
    data['Status'] = status;
    data['FromDate'] = fromDate;
    data['ToDate'] = toDate;
    data['IsOnline'] = isOnline;
    data['Token'] = token;
    data['Start'] = start;
    data['Length'] = length;
    data['OrderColumn'] = orderColumn;
    data['OrderDir'] = orderDir;
    return data;
  }
}
