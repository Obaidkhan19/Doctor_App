import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:doctormobileapplication/models/work_locations.dart';
import 'package:doctormobileapplication/screens/family_screens/status_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentDetail extends StatefulWidget {
  AppointmentConfigurations configureAppointment;
  AppointmentDetail({required this.configureAppointment, super.key});

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  @override
  Widget build(BuildContext context) {
    print(widget.configureAppointment.toJson());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: ColorManager.kPrimaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'View Configuration',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 1.175,
            color: ColorManager.kPrimaryColor,
          ),
        ),
      ),
      body: SizedBox(
        width: Get.width * 1,
        height: Get.height * 1,
        child: Column(
          children: [
            RecordWidgetConfiguration(
                title: "Location",
                name: widget.configureAppointment.workLocation ?? ""),
            SizedBox(
              height: Get.height * 0.01,
            ),
            RecordWidgetConfiguration(
              title: "Address",
              name: widget.configureAppointment.address ?? "",
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            RecordWidgetConfiguration(
              title: "Days",
              name: widget.configureAppointment.weekDays ?? "",
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            RecordWidgetConfiguration(
              title: "Time Duration",
              name: widget.configureAppointment.fromTime != null &&
                      widget.configureAppointment.fromTime != null
                  ? "${"${widget.configureAppointment.fromTime.toString().split(':')[0]}:${widget.configureAppointment.fromTime.toString().split(':')[1]}"} To ${"${widget.configureAppointment.toTime.toString().split(':')[0]}:${widget.configureAppointment.toTime.toString().split(':')[1]}"}"
                  : "",
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            RecordWidgetConfiguration(
              title: "Consultancy Fee",
              name: widget.configureAppointment.consultancyFee.toString(),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            RecordWidgetConfiguration(
              title: "Slot Duration (HH:MM)",
              name:
                  "${widget.configureAppointment.slotDuration.toString().split(':')[0]}:${widget.configureAppointment.slotDuration.toString().split(':')[1]}" ??
                      "",
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            RecordWidgetConfiguration(
              title: "Follow Up Fee",
              name: widget.configureAppointment.followupFee.toString(),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            RecordWidgetConfiguration(
              title: "Follow Up Days",
              name: widget.configureAppointment.noofFollowupDays.toString(),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}

class RecordWidgetConfiguration extends StatelessWidget {
  final String? title;
  final String? name;

  const RecordWidgetConfiguration({Key? key, this.title, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '$title',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorManager.kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
            ),
          ),
          Text(
            ':',
            style: GoogleFonts.poppins(
              color: ColorManager.kPrimaryColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            width: Get.width * 0.07,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
