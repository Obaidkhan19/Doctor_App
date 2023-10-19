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
        appointments!.add(Appointments.fromJson(v));
      });
    }
    if (json['OverView'] != null) {
      overView = <OverView>[];
      json['OverView'].forEach((v) {
        overView!.add(OverView.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (appointments != null) {
      data['Appointments'] = appointments!.map((v) => v.toJson()).toList();
    }
    if (overView != null) {
      data['OverView'] = overView!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = errorMessage;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AppointmentId'] = appointmentId;
    data['PatientAppointmentId'] = patientAppointmentId;
    data['Time'] = time;
    data['Date'] = date;
    data['Name'] = name;
    data['WorkLocation'] = workLocation;
    data['CellNumber'] = cellNumber;
    data['Status'] = status;
    data['IsOnlineAppointment'] = isOnlineAppointment;
    data['IsOnlineConsultation'] = isOnlineConsultation;
    data['DoctorId'] = doctorId;
    data['PatientId'] = patientId;
    data['SessionId'] = sessionId;
    data['WorkLocationId'] = workLocationId;
    data['BranchId'] = branchId;
    data['IsChecked'] = IsChecked;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Start'] = start;
    data['End'] = end;
    data['Pending'] = pending;
    data['Cancelled'] = cancelled;
    data['Paid'] = paid;
    data['Confirmed'] = confirmed;
    data['Consulted'] = consulted;
    data['Booked'] = booked;
    return data;
  }
}
