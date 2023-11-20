import 'dart:async';
import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/data/controller/ManageAppointments_Controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
//   return Column(
//     children: [
//       Container(
//         child: Text(details.date.day.toString()),
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 15,
//             width: 13,
//             color: ColorManager.kRedColor,
//           ),
//           Container(
//             height: 15,
//             width: 13,
//             color: ColorManager.kblackColor,
//           ),
//         ],
//       )
//     ],
//   );
// }

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final List<Meeting> meetings1 = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  for (int i = 0;
      i < ManageAppointmentController.i.monthlyappintment.length;
      i++) {
    meetings.add(Meeting(
        '${ManageAppointmentController.i.monthlyappintment[i].paid} ',
        DateTime.parse(ManageAppointmentController.i.monthlyappintment[i].date),
        DateTime.parse(ManageAppointmentController.i.monthlyappintment[i].date),
        ColorManager.kPrimaryColor,
        false));
    meetings.add(Meeting(
        '${ManageAppointmentController.i.monthlyappintment[i].unPaid} ',
        DateTime.parse(ManageAppointmentController.i.monthlyappintment[i].date),
        DateTime.parse(ManageAppointmentController.i.monthlyappintment[i].date),
        ColorManager.KgreenColor,
        false));
  }

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class DetailMonthlyAppointment extends StatefulWidget {
  String worklocationid;
  String isonline;
  DetailMonthlyAppointment(
      {required this.worklocationid, required this.isonline, super.key});

  @override
  State<DetailMonthlyAppointment> createState() =>
      _DetailMonthlyAppointmentState();
}

class _DetailMonthlyAppointmentState extends State<DetailMonthlyAppointment> {
  @override
  void initState() {
    // call();
    Timer.periodic(const Duration(seconds: 6), (timer) {
      chk = true;
      timer.cancel();
    });
    super.initState();
  }

  String monthyearDate = DateFormat('MM-yyyy').format(DateTime.now());
  String monthyearDate2 = DateFormat('MM-yyyy').format(DateTime.now());

  // call() async {
  //   log("${monthyearDate.split(' ')[0].split('-')[1]}-${monthyearDate.split(' ')[0].split('-')[0]} ${int.parse(monthyearDate.split(' ')[0].split('-')[1]) < 12 ? int.parse(monthyearDate.split(' ')[0].split('-')[1]) + 1 : 01}-${monthyearDate.split(' ')[0].split('-')[0]}");
  //   ManageAppointmentController.i.getmonthlyoctorAppointment(
  //       "${monthyearDate.split(' ')[0].split('-')[1]}-${monthyearDate.split(' ')[0].split('-')[0]} ${int.parse(monthyearDate.split(' ')[0].split('-')[1]) < 12 ? int.parse(monthyearDate.split(' ')[0].split('-')[1]) + 1 : 01}-${monthyearDate.split(' ')[0].split('-')[0]}",
  //       widget.worklocationid,
  //       widget.isonline);
  // }

  bool chk = false;

  int? previousdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ManageAppointmentController>(builder: (context) {
        return BlurryModalProgressHUD(
          inAsyncCall:
              ManageAppointmentController.i.isLoadingMonthlyDoctorAppointment,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitSpinningLines(
            color: Color(0xfff1272d3),
            size: 60,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SfCalendar(
                      cellBorderColor: Colors.transparent,
                      view: CalendarView.month,
                      dataSource: MeetingDataSource(_getDataSource()),
                      firstDayOfWeek: 1,
                      showNavigationArrow: true,
                      showDatePickerButton: false,
                      todayHighlightColor: ColorManager.kPrimaryColor,
                      backgroundColor: Colors.transparent,
                      selectionDecoration: null,
                      headerStyle: const CalendarHeaderStyle(
                        textAlign: TextAlign.center,
                      ),
                      monthViewSettings: const MonthViewSettings(
                        numberOfWeeksInView: 4,
                        appointmentDisplayCount: 2,
                        showTrailingAndLeadingDates: false,
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.appointment,
                        showAgenda: false,
                        navigationDirection:
                            MonthNavigationDirection.horizontal,
                      ),
                      onViewChanged: (viewChangedDetails) {
                        // ManageAppointmentController.i
                        //     .getmonthlyoctorAppointment(monthyearDate,
                        //         widget.worklocationid, widget.isonline);
                        // if (chk) {
                        //   previousdate = int.parse(viewChangedDetails
                        //       .visibleDates.first
                        //       .toString()
                        //       .split(' ')[0]
                        //       .split('-')[1]);
                        //   String date = viewChangedDetails.visibleDates.last
                        //       .toString()
                        //       .split(' ')[0];
                        //   int current = int.parse(viewChangedDetails
                        //       .visibleDates.last
                        //       .toString()
                        //       .split(' ')[0]
                        //       .split('-')[1]);
                        //   if (previousdate != current) {
                        //     date =
                        //         "${date.split('-')[1]}-${date.split('-')[0]}";
                        //   } else {
                        //     date = "${date.split('-')[0]}-${current + 1}";
                        //   }
                        //   ManageAppointmentController.i
                        //       .getmonthlyoctorAppointment(
                        //           date, widget.worklocationid, widget.isonline);

                        //   log(viewChangedDetails.visibleDates.length
                        //       .toString());
                        // }
                        // ManageAppointmentController.i
                        //     .getmonthlyoctorAppointment(monthyearDate,
                        //         widget.worklocationid, widget.isonline);
                        // if (int.parse(monthyearDate.toString().split('-')[0]) ==
                        //     int.parse(viewChangedDetails.visibleDates.last.month
                        //         .toString())) {
                        //   ManageAppointmentController.i.getmonthlyoctorAppointment(
                        //       "${viewChangedDetails.visibleDates.last.month + 1}-${viewChangedDetails.visibleDates.last.year}",
                        //       widget.worklocationid,
                        //       widget.isonline);
                        // } else {
                        ManageAppointmentController.i.getmonthlyoctorAppointment(
                            "${viewChangedDetails.visibleDates.first.month}-${viewChangedDetails.visibleDates.first.year} ${viewChangedDetails.visibleDates.last.month}-${viewChangedDetails.visibleDates.last.year}",
                            widget.worklocationid,
                            widget.isonline,
                            "${viewChangedDetails.visibleDates.first} ${viewChangedDetails.visibleDates.last}");
                        // }
                      },
                      // monthCellBuilder: monthCellBuilder,
                      // onViewChanged: (viewChangedDetails) {
                      //   // in first parameter add month and year
                      //   Manageappointmentcontroller.i
                      //       .getmonthlyoctorAppointment(monthyearDate,
                      //           widget.worklocationid, widget.isonline);
                      // },
                      onTap: (CalendarTapDetails details) async {
                        ManageAppointmentController.i
                            .selectedmonthlyspecificdate(details.date);

                        String dt = DateFormat('yyyy-MM-dd')
                            .format(ManageAppointmentController.i.date!)
                            .toString();

                        if (widget.worklocationid == '') {
                          ManageAppointmentController.i
                              .getDailyDoctorAppointmentSlots(
                                  dt.toString(), "true", "");
                        } else {
                          ManageAppointmentController.i
                              .getDailyDoctorAppointmentSlots(dt.toString(),
                                  "false", widget.worklocationid);
                        }

                        ManageAppointmentController.i
                            .setPageIndexofDayViewAppointment(0);

                        // print(details.date.toString().split(' ')[0]);
                        // Manageappointmentcontroller.i.getmonthlyoctorAppointment(details.date.toString().split(' ')[0]);
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    Row(
                      children: [
                        Container(
                          width: Get.width * 0.08,
                          height: Get.height * 0.04,
                          color: ColorManager.kPrimaryColor,
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        GetBuilder<ManageAppointmentController>(
                            builder: (context) {
                          return Text(
                            '${'paidappointments'.tr} |  ${ManageAppointmentController.i.paid}'
                            '',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                            ),
                          );
                        }),
                        const Spacer(),
                        Container(
                          width: Get.width * 0.08,
                          height: Get.height * 0.04,
                          color: ColorManager.KgreenColor,
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        GetBuilder<ManageAppointmentController>(
                            builder: (context) {
                          return Text(
                            '${'unPaidappointments'.tr} |  ${ManageAppointmentController.i.unpaid}'
                            '',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                            ),
                          );
                        })
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
