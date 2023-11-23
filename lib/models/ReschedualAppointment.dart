class ReschedualAppointmentSlots {
  ReschedualAppointmentSlots(
      {this.AppointmentBranchId,
      this.AppointmentId,
      this.IsOnlineAppointment,
      this.IsOnlineConsultation,
      this.PatientAppointmentId,
      this.SessionId,
      this.WorkLocationId,
      this.DoctorId,
      this.BranchId,
      this.PatientId});
  String? AppointmentBranchId;
  String? AppointmentId;
  String? IsOnlineAppointment;
  String? IsOnlineConsultation;
  String? PatientAppointmentId;
  String? SessionId;
  String? WorkLocationId;
  String? PatientId;
  String? DoctorId;
  String? BranchId;

  ReschedualAppointmentSlots.fromJson(Map<String, dynamic> json) {
    AppointmentBranchId = json['AppointmentBranchId'];
    AppointmentId = json['AppointmentId'];
    IsOnlineAppointment = json['IsOnlineAppointment'];
    IsOnlineConsultation = json['IsOnlineConsultation'];
    PatientAppointmentId = json['PatientAppointmentId'];
    SessionId = json['SessionId'];
    WorkLocationId = json['WorkLocationId'];
    PatientId = json['PatientId'];
    BranchId = json['BranchId'];
    DoctorId = json['DoctorId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['AppointmentBranchId'] = AppointmentBranchId;
    data['AppointmentId'] = AppointmentId;
    data['IsOnlineAppointment'] = IsOnlineAppointment;
    data['IsOnlineConsultation'] = IsOnlineConsultation;
    data['PatientAppointmentId'] = PatientAppointmentId;
    data['SessionId'] = SessionId;
    data['WorkLocationId'] = WorkLocationId;
    data['PatientId'] = PatientId;
    data['DoctorId'] = DoctorId;
    data['BranchId'] = BranchId;
    return data;
  }
}
