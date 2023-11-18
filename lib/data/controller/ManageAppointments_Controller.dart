import 'dart:developer';

import 'package:doctormobileapplication/models/monthlyappointmentresponse.dart';
import 'package:get/get.dart';

import '../../models/DayViewAppointmentModel.dart';
import '../../models/ReschedualAppointment.dart';
import '../../models/TodayAppointmentModel.dart';
import '../repositories/ManageAppointment_repo/manageAppointment_repo.dart';

class Manageappointmentcontroller extends GetxController
    implements GetxService {
  static Manageappointmentcontroller get i =>
      Get.put(Manageappointmentcontroller());
  List<monthlyappointresponse> monthlyappintment = [];
  int unpaid = 0;
  int paid = 0;

  DateTime? date;

  selectedmonthlyspecificdate(dt) {
    date = dt;
    update();
  }

  bool _isLoadingscreen = false;
  bool get isLoadingscreen => _isLoadingscreen;

  updateIsloadingScreen(bool value) {
    _isLoadingscreen = value;
    update();
  }

  DailyDoctorAppointmentsModel _dailyDoctorAppointmentsModel =
      DailyDoctorAppointmentsModel();
  DailyDoctorAppointmentsModel get dailyDoctorAppointmentsModel =>
      _dailyDoctorAppointmentsModel;
  bool? isLoading = false;
  bool? isLoadingDailyDoctorAppointment = false;
  bool? isLoadingDailyDoctorAppointmentSlots = false;

  bool? _selectall = false;
  bool? get selectall => _selectall;

  int _index = 0;
  int get index => _index;

  DayViewAppointmentSlotModel _dayViewAppointmentSlotModel =
      DayViewAppointmentSlotModel();
  DayViewAppointmentSlotModel get dayViewAppointmentSlotModel =>
      _dayViewAppointmentSlotModel;

  updatemonthlyappointment(List<monthlyappointresponse> app) async {
    monthlyappintment = app;
    update();
  }

  List<monthlyappointresponse> data = [];
  updatemonthlysecondlist(List<monthlyappointresponse> app) async {
    data = app;
    update();
  }

  bool isLoadingMonthlyDoctorAppointment = false;
  getmonthlyoctorAppointment(date, wlid, isonline, diffr) async {
    monthlyappintment.clear();
    data.clear();
    try {
      isLoadingMonthlyDoctorAppointment = true;
      monthlyappintment =
          await Manageappointmentrepo.GetmonthlyDoctorAppointment(
              date.toString().split(' ')[0], wlid, isonline);
      if (date.toString().split(' ')[0].trim() !=
          date.toString().split(' ')[1].trim()) {
        data = await Manageappointmentrepo.GetmonthlyDoctorAppointment(
            date.toString().split(' ')[1], wlid, isonline);
        if (date.toString().split(' ')[1] == date.toString().split(' ')[0]) {
          for (var element in data) {
            if (monthlyappintment.contains(element)) {
            } else {
              monthlyappintment.add(element);
            }
          }
        } else {
          monthlyappintment = monthlyappintment + data;
        }
      }
      paid = 0;
      unpaid = 0;
      for (int i = 0; i < monthlyappintment.length; i++) {
        log(monthlyappintment[i].date);
        log(diffr);
        // if (int.parse(monthlyappintment[i]
        //             .date
        //             .toString()
        //             .split('T')[0]
        //             .split('-')[2]) >
        //         int.parse(diffr.toString().split(' ')[0]) &&
        //     int.parse(monthlyappintment[i]
        //             .date
        //             .toString()
        //             .split('T')[0]
        //             .split('-')[2]) <
        //         int.parse(diffr.toString().split(' ')[1]))
        {
          if (monthlyappintment[i].paid != 0) {
            paid = monthlyappintment[i].paid + paid;
          } else if (monthlyappintment[i].unPaid != 0) {
            unpaid = monthlyappintment[i].unPaid + unpaid;
          }
        }
      }

      isLoadingMonthlyDoctorAppointment = false;
      update();
    } catch (e) {
      isLoadingMonthlyDoctorAppointment = false;
      update();
    }
  }

  getPageIndexofDayViewAppointment() {
    return _index;
  }

  setPageIndexofDayViewAppointment(int ind) {
    _index = ind;
    if (_index == 0) {
      monthlyappintment.clear();
    }
    update();
  }

  getDailyDoctorAppointment() async {
    isLoadingDailyDoctorAppointment = true;
    _dailyDoctorAppointmentsModel = DailyDoctorAppointmentsModel();

    try {
      _isLoadingscreen = true;
      _dailyDoctorAppointmentsModel =
          await Manageappointmentrepo.getDailyDoctorAppointment();
      _isLoadingscreen = false;
      update();
    } catch (e) {
      isLoadingDailyDoctorAppointment = false;
      update();
    }
    // Timer(const Duration(milliseconds: 500), () {
    //   isLoadingDailyDoctorAppointment = false;
    // });
    isLoadingDailyDoctorAppointment = false;
    update();
  }

  getDailyDoctorAppointmentSlots(
      String Dates, String IsOnline, String WorkLocationId) async {
    _selectall = false;
    isLoadingDailyDoctorAppointmentSlots = true;
    if (_dayViewAppointmentSlotModel.appointments != null) {
      _dayViewAppointmentSlotModel.appointments?.clear();
    }
    try {
      _dayViewAppointmentSlotModel =
          await Manageappointmentrepo.getDailyDoctorAppointmentSlots(
              Dates, IsOnline, WorkLocationId);
      isLoadingDailyDoctorAppointmentSlots = false;
    } catch (e) {
      isLoadingDailyDoctorAppointmentSlots = false;
    }
    isLoadingDailyDoctorAppointmentSlots = false;
    update();
  }

  updateCheckedBoxStatus(String appointmentId) {
    if (_dayViewAppointmentSlotModel.appointments != null) {
      final appointmentToUpdate = _dayViewAppointmentSlotModel.appointments
          ?.firstWhere(
              (appointment) => appointment.appointmentId == appointmentId);
      if (appointmentToUpdate != null) {
        _dayViewAppointmentSlotModel.appointments
                ?.firstWhere(
                    (appointment) => appointment.appointmentId == appointmentId)
                .IsChecked =
            ((appointmentToUpdate.IsChecked != null)
                ? (!appointmentToUpdate.IsChecked!)
                : true);
      }
      update();
    }
  }

  updateCheckedBoxStatusToSelectAll() {
    if (_selectall == true) {
      _selectall = false;
    } else {
      _selectall = true;
    }
    update();
    if (_dayViewAppointmentSlotModel.appointments != null) {
      _dayViewAppointmentSlotModel.appointments?.forEach((appointment) {
        if (appointment.appointmentId != null) {
          appointment.IsChecked = _selectall;
        }
      });
      update();
    }
  }

  getCheckedAppointmentSlots() {
    List<Appointments> checkedAppointments = <Appointments>[];

    if (_dayViewAppointmentSlotModel.appointments != null) {
      _dayViewAppointmentSlotModel.appointments?.forEach((appointment) {
        if (appointment.IsChecked == true) {
          checkedAppointments.add(appointment);
        }
      });
    }
    return checkedAppointments;
  }

  reShedualAppointmentSlots(
      String Dates, String BranchId, List<Appointments> result) async {
    isLoadingDailyDoctorAppointmentSlots = true;
    update();
    List<ReschedualAppointmentSlots> appointments = [];
    for (var element in result) {
      ReschedualAppointmentSlots reschedualAppointmentSlots =
          ReschedualAppointmentSlots();
      reschedualAppointmentSlots.WorkLocationId = element.workLocationId;
      reschedualAppointmentSlots.AppointmentBranchId = element.branchId;
      reschedualAppointmentSlots.AppointmentId = element.appointmentId;
      reschedualAppointmentSlots.IsOnlineAppointment =
          element.isOnlineAppointment.toString();
      reschedualAppointmentSlots.PatientAppointmentId =
          element.patientAppointmentId;
      reschedualAppointmentSlots.SessionId = element.sessionId.toString();
      reschedualAppointmentSlots.IsOnlineConsultation =
          element.isOnlineConsultation.toString();
      reschedualAppointmentSlots.PatientId = element.patientId;
      appointments.add(reschedualAppointmentSlots);
    }
    var resultResponse;
    try {
      resultResponse = await Manageappointmentrepo.resheduleAppointmentSlots(
          Dates, BranchId, appointments);
      isLoadingDailyDoctorAppointmentSlots = false;
      update();
    } catch (e) {
      isLoadingDailyDoctorAppointmentSlots = false;
      update();
      return 999;
    }
    // Timer(const Duration(milliseconds: 500), () {
    //   isLoading = false;
    // });
    isLoadingDailyDoctorAppointmentSlots = false;
    update();
    return resultResponse;
  }

  approveAppointmentSlots(String BranchId, List<Appointments> result) async {
    isLoadingDailyDoctorAppointmentSlots = true;
    update();
    List<ReschedualAppointmentSlots> appointments = [];
    for (var element in result) {
      ReschedualAppointmentSlots reschedualAppointmentSlots =
          ReschedualAppointmentSlots();
      reschedualAppointmentSlots.AppointmentId = element.appointmentId;
      reschedualAppointmentSlots.PatientAppointmentId =
          element.patientAppointmentId;
      reschedualAppointmentSlots.IsOnlineAppointment =
          element.isOnlineAppointment.toString();
      reschedualAppointmentSlots.IsOnlineAppointment =
          element.isOnlineAppointment.toString();
      reschedualAppointmentSlots.PatientId = element.patientId;
      appointments.add(reschedualAppointmentSlots);
    }
    var resultResponse;
    try {
      resultResponse = await Manageappointmentrepo.approveAppointmentSlots(
          BranchId, appointments);
      isLoadingDailyDoctorAppointmentSlots = false;
      update();
    } catch (e) {
      print("eexectption$e");
      isLoadingDailyDoctorAppointmentSlots = false;
      update();
    }
    isLoadingDailyDoctorAppointmentSlots = false;
    update();
    return resultResponse;
  }

  String convertTimeFormat(String inputTime) {
    try {
      List<String> timeParts = inputTime.split(':');

      if (timeParts.length != 3) {
        return inputTime; // Invalid input format, return as is
      }

      int hours = int.tryParse(timeParts[0]) ?? 0;
      int minutes = int.tryParse(timeParts[1]) ?? 0;

      String period = hours >= 12 ? 'PM' : 'AM';

      if (hours > 12) {
        hours -= 12;
      } else if (hours == 0) {
        hours = 12;
      }

      String formattedTime =
          '$hours:${minutes.toString().padLeft(2, '0')} $period';

      return formattedTime;
    } catch (e) {
      return "";
    }
  }
}
