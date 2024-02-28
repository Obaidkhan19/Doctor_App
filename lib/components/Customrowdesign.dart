import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interval_time_picker/interval_time_picker.dart';

// ignore: must_be_immutable
class configureappointrow extends StatefulWidget {
  BuildContext ctx;
  int dayindex;
  configureappointrow({super.key, required this.ctx, required this.dayindex});

  @override
  State<configureappointrow> createState() => _configureappointrowState();
}

class _configureappointrowState extends State<configureappointrow> {
  TimeOfDay _time = const TimeOfDay(hour: 00, minute: 00);

  final int _interval = 5;

  final VisibleStep _visibleStep = VisibleStep.fifths;

  void _selectTime() async {
    final TimeOfDay? newTime = await showIntervalTimePicker(
      context: widget.ctx,
      initialTime: _time,
      interval: _interval,
      visibleStep: _visibleStep,
    );
    if (newTime != null) {
      _time = newTime;
    }
    setState(() {});
  }

  TimeOfDay _time1 = const TimeOfDay(hour: 00, minute: 00);

  final int _interval1 = 5;

  final VisibleStep _visibleStep1 = VisibleStep.fifths;

  void _selectTime1() async {
    final TimeOfDay? newTime1 = await showIntervalTimePicker(
      context: widget.ctx,
      initialTime: _time1,
      interval: _interval1,
      visibleStep: _visibleStep1,
    );
    if (newTime1 != null) {
      _time1 = newTime1;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                _selectTime();
              },
              child: Container(
                height: 43,
                width: 119,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the border radius as needed
                ),
                child: Center(
                  child: Text(
                    "${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Text(
              "TO",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: ColorManager.kblackColor,
                  fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: () {
                _selectTime1();
              },
              child: Container(
                height: 43,
                width: 119,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the border radius as needed
                ),
                child: Center(
                  child: Text(
                    "${_time1.hour.toString().padLeft(2, '0')}:${_time1.minute.toString().padLeft(2, '0')}",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
