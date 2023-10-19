class DailyDoctorAppointmentsModel {
  int? status;
  int? onlineAppointments;
  OnlineAppointmentStatistics? onlineAppointmentStatistics;
  List<AppointmentStatistics>? appointmentStatistics;
  List<AppointmentSummary>? appointmentSummary;
  String? errorMessage;

  DailyDoctorAppointmentsModel(
      {this.status,
      this.onlineAppointments,
      this.onlineAppointmentStatistics,
      this.appointmentStatistics,
      this.appointmentSummary,
      this.errorMessage});

  DailyDoctorAppointmentsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    onlineAppointments = json['OnlineAppointments'];
    onlineAppointmentStatistics = json['OnlineAppointmentStatistics'] != null
        ? new OnlineAppointmentStatistics.fromJson(
            json['OnlineAppointmentStatistics'])
        : null;
    if (json['AppointmentStatistics'] != null) {
      appointmentStatistics = <AppointmentStatistics>[];
      json['AppointmentStatistics'].forEach((v) {
        appointmentStatistics!.add(new AppointmentStatistics.fromJson(v));
      });
    }
    if (json['AppointmentSummary'] != null) {
      appointmentSummary = <AppointmentSummary>[];
      json['AppointmentSummary'].forEach((v) {
        appointmentSummary!.add(new AppointmentSummary.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['OnlineAppointments'] = this.onlineAppointments;
    if (this.onlineAppointmentStatistics != null) {
      data['OnlineAppointmentStatistics'] =
          this.onlineAppointmentStatistics!.toJson();
    }
    if (this.appointmentStatistics != null) {
      data['AppointmentStatistics'] =
          this.appointmentStatistics!.map((v) => v.toJson()).toList();
    }
    if (this.appointmentSummary != null) {
      data['AppointmentSummary'] =
          this.appointmentSummary!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class OnlineAppointmentStatistics {
  String? location;
  String? workLocationId;
  String? address;
  int? noofAppointments;
  int? sunday;
  int? monday;
  int? tuesday;
  int? wednesday;
  int? thursday;
  int? friday;
  int? saturday;

  OnlineAppointmentStatistics(
      {this.location,
      this.workLocationId,
      this.address,
      this.noofAppointments,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday});

  OnlineAppointmentStatistics.fromJson(Map<String, dynamic> json) {
    location = json['Location'];
    workLocationId = json['WorkLocationId'];
    address = json['Address'];
    noofAppointments = json['NoofAppointments'];
    sunday = json['Sunday'];
    monday = json['Monday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
    saturday = json['Saturday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Location'] = this.location;
    data['WorkLocationId'] = this.workLocationId;
    data['Address'] = this.address;
    data['NoofAppointments'] = this.noofAppointments;
    data['Sunday'] = this.sunday;
    data['Monday'] = this.monday;
    data['Tuesday'] = this.tuesday;
    data['Wednesday'] = this.wednesday;
    data['Thursday'] = this.thursday;
    data['Friday'] = this.friday;
    data['Saturday'] = this.saturday;
    return data;
  }
}

class AppointmentStatistics {
  String? location;
  String? workLocationId;
  String? address;
  int? noofAppointments;
  int? sunday;
  int? monday;
  int? tuesday;
  int? wednesday;
  int? thursday;
  int? friday;
  int? saturday;

  AppointmentStatistics(
      {this.location,
      this.workLocationId,
      this.address,
      this.noofAppointments,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday});

  AppointmentStatistics.fromJson(Map<String, dynamic> json) {
    location = json['Location'];
    workLocationId = json['WorkLocationId'];
    address = json['Address'];
    noofAppointments = json['NoofAppointments'];
    sunday = json['Sunday'];
    monday = json['Monday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
    saturday = json['Saturday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Location'] = this.location;
    data['WorkLocationId'] = this.workLocationId;
    data['Address'] = this.address;
    data['NoofAppointments'] = this.noofAppointments;
    data['Sunday'] = this.sunday;
    data['Monday'] = this.monday;
    data['Tuesday'] = this.tuesday;
    data['Wednesday'] = this.wednesday;
    data['Thursday'] = this.thursday;
    data['Friday'] = this.friday;
    data['Saturday'] = this.saturday;
    return data;
  }
}

class AppointmentSummary {
  String? start;
  String? end;
  int? pending;
  int? cancelled;
  int? paid;
  int? confirmed;
  int? consulted;
  int? booked;

  AppointmentSummary(
      {this.start,
      this.end,
      this.pending,
      this.cancelled,
      this.paid,
      this.confirmed,
      this.consulted,
      this.booked});

  AppointmentSummary.fromJson(Map<String, dynamic> json) {
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
