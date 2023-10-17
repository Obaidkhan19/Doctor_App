import 'package:doctormobileapplication/data/controller/ManageAppointments_Controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting('Conference', startTime, endTime,
      const Color.fromARGB(255, 223, 71, 11), false));
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
  const DetailMonthlyAppointment({super.key});

  @override
  State<DetailMonthlyAppointment> createState() =>
      _DetailMonthlyAppointmentState();
}

class _DetailMonthlyAppointmentState extends State<DetailMonthlyAppointment> {


  @override
  void initState() { 
    call();
    super.initState();
  }

  call() async{
    ManageAppointmentController.i.getmonthlyoctorAppointment(DateTime.now().toString().split(' ')[0]);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ManageAppointmentController>(
        builder: (context) {
          return Padding(
            padding:
                EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
            child: Stack(
              children: [
                // const BackgroundLogoimage(),
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),

                    // CALENDER CODE
                    SfCalendar(
                      cellBorderColor: Colors.transparent,
                      view: CalendarView.month,
                      dataSource: MeetingDataSource(_getDataSource()),
                      firstDayOfWeek: 1,
                      showNavigationArrow: true,
                      showDatePickerButton: true,
                      todayHighlightColor: ColorManager.kPrimaryColor,
                      backgroundColor: Colors.transparent,
                      selectionDecoration: null,
                      headerStyle: const CalendarHeaderStyle(
                        textAlign: TextAlign.center,
                      ),
                      monthViewSettings: const MonthViewSettings(
                        numberOfWeeksInView: 4,
                        appointmentDisplayCount: 2,
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.appointment,
                        showAgenda: false,
                        navigationDirection: MonthNavigationDirection.horizontal,
                      ),
                      appointmentBuilder: (BuildContext context,
                          CalendarAppointmentDetails details) {
                        return SizedBox(
                          height: Get.height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GetBuilder<ManageAppointmentController>(
                                builder: (context) {
                                  return Container(
                                    width: Get.width * 0.04,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child:  Center(
                                      child: Text(
                                        ManageAppointmentController.i.paid.toString(),
                                        style: TextStyle(
                                            color: ColorManager.kWhiteColor,
                                            fontSize: 8),
                                      ),
                                    ),
                                  );
                                }
                              ),
                              Container(
                                width: Get.width * 0.04,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                                child:  Center(
                                  child: Text(
                                    ManageAppointmentController.i.unpaid.toString(),
                                    style: TextStyle(
                                        color: ColorManager.kWhiteColor,
                                        fontSize: 8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      onTap: (CalendarTapDetails details) async {
                        ManageAppointmentController.i.getmonthlyoctorAppointment(details.date.toString().split(' ')[0]);
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
                          color: ColorManager.kRedColor,
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        GetBuilder<ManageAppointmentController>(
                          builder: (context) {
                            return Text(
                              'Paid Appointments | ' '${ManageAppointmentController.i.paid}',
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                              ),
                            );
                          }
                        ),
                        const Spacer(),
                        Container(
                          width: Get.width * 0.08,
                          height: Get.height * 0.04,
                          color: ColorManager.kblackColor,
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        GetBuilder<ManageAppointmentController>(
                          builder: (context) {
                            return Text(
                              'UnPaid Appointments | ' '${ManageAppointmentController.i.unpaid}',
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                              ),
                            );
                          }
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
