class ReschedualAppointmentSlots {
  ReschedualAppointmentSlots(
      {this.AppointmentBranchId,
      this.AppointmentId,
      this.IsOnlineAppointment,
      this.IsOnlineConsultation,
      this.PatientAppointmentId,
      this.SessionId,
      this.WorkLocationId,
      this.PatientId});
  String? AppointmentBranchId;
  String? AppointmentId;
  String? IsOnlineAppointment;
  String? IsOnlineConsultation;
  String? PatientAppointmentId;
  String? SessionId;
  String? WorkLocationId;
  String? PatientId;

  ReschedualAppointmentSlots.fromJson(Map<String, dynamic> json) {
    AppointmentBranchId = json['AppointmentBranchId'];
    AppointmentId = json['AppointmentId'];
    IsOnlineAppointment = json['IsOnlineAppointment'];
    IsOnlineConsultation = json['IsOnlineConsultation'];
    PatientAppointmentId = json['PatientAppointmentId'];
    SessionId = json['SessionId'];
    WorkLocationId = json['WorkLocationId'];
    PatientId = json['PatientId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['AppointmentBranchId'] = AppointmentBranchId;
    _data['AppointmentId'] = AppointmentId;
    _data['IsOnlineAppointment'] = IsOnlineAppointment;
    _data['IsOnlineConsultation'] = IsOnlineConsultation;
    _data['PatientAppointmentId'] = PatientAppointmentId;
    _data['SessionId'] = SessionId;
    _data['WorkLocationId'] = WorkLocationId;
    _data['PatientId'] = PatientId;
    return _data;
  }
}
