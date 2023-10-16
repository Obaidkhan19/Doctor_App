class DayViewAppointmentSlotModel {
  int? status;
  List<Appointments>? appointments;
  List<OverView>? overView;
  String? errorMessage;

  DayViewAppointmentSlotModel(
      {this.status, this.appointments, this.overView, this.errorMessage});

  DayViewAppointmentSlotModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Appointments'] != null) {
      appointments = <Appointments>[];
      json['Appointments'].forEach((v) {
        appointments!.add(new Appointments.fromJson(v));
      });
    }
    if (json['OverView'] != null) {
      overView = <OverView>[];
      json['OverView'].forEach((v) {
        overView!.add(new OverView.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.appointments != null) {
      data['Appointments'] = this.appointments!.map((v) => v.toJson()).toList();
    }
    if (this.overView != null) {
      data['OverView'] = this.overView!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class Appointments {
  String? appointmentId;
  String? patientAppointmentId;
  String? time;
  String? date;
  String? name;
  String? workLocation;
  String? cellNumber;
  String? status;
  bool? isOnlineAppointment;
  bool? isOnlineConsultation;
  String? doctorId;
  String? patientId;
  String? sessionId;
  String? workLocationId;
  String? branchId;
  bool? IsChecked;

  Appointments(
      {this.appointmentId,
      this.patientAppointmentId,
      this.time,
      this.date,
      this.name,
      this.workLocation,
      this.cellNumber,
      this.status,
      this.isOnlineAppointment,
      this.isOnlineConsultation,
      this.doctorId,
      this.patientId,
      this.sessionId,
      this.workLocationId,
      this.branchId,
      this.IsChecked = false});

  Appointments.fromJson(Map<String, dynamic> json) {
    appointmentId = json['AppointmentId'];
    patientAppointmentId = json['PatientAppointmentId'];
    time = json['Time'];
    date = json['Date'];
    name = json['Name'];
    workLocation = json['WorkLocation'];
    cellNumber = json['CellNumber'];
    status = json['Status'];
    isOnlineAppointment = json['IsOnlineAppointment'];
    isOnlineConsultation = json['IsOnlineConsultation'];
    doctorId = json['DoctorId'];
    patientId = json['PatientId'];
    sessionId = json['SessionId'];
    workLocationId = json['WorkLocationId'];
    branchId = json['BranchId'];
    IsChecked = json['IsChecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentId'] = this.appointmentId;
    data['PatientAppointmentId'] = this.patientAppointmentId;
    data['Time'] = this.time;
    data['Date'] = this.date;
    data['Name'] = this.name;
    data['WorkLocation'] = this.workLocation;
    data['CellNumber'] = this.cellNumber;
    data['Status'] = this.status;
    data['IsOnlineAppointment'] = this.isOnlineAppointment;
    data['IsOnlineConsultation'] = this.isOnlineConsultation;
    data['DoctorId'] = this.doctorId;
    data['PatientId'] = this.patientId;
    data['SessionId'] = this.sessionId;
    data['WorkLocationId'] = this.workLocationId;
    data['BranchId'] = this.branchId;
    data['IsChecked'] = this.IsChecked;
    return data;
  }
}

class OverView {
  String? start;
  String? end;
  int? pending;
  int? cancelled;
  int? paid;
  int? confirmed;
  int? consulted;
  int? booked;

  OverView(
      {this.start,
      this.end,
      this.pending,
      this.cancelled,
      this.paid,
      this.confirmed,
      this.consulted,
      this.booked});

  OverView.fromJson(Map<String, dynamic> json) {
    start = json['Start'];
    end = json['End'];
    pending = json['Pending'];
    cancelled = json['Cancelled'];
    paid = json['Paid'];
    confirmed = json['Confirmed'];
    consulted = json['Consulted'];
    booked = json['Booked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Start'] = this.start;
    data['End'] = this.end;
    data['Pending'] = this.pending;
    data['Cancelled'] = this.cancelled;
    data['Paid'] = this.paid;
    data['Confirmed'] = this.confirmed;
    data['Consulted'] = this.consulted;
    data['Booked'] = this.booked;
    return data;
  }
}
