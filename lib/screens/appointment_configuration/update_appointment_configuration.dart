// ignore_for_file: must_be_immutable

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_time_picker.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_configure_appointment_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/ConfigureAppointment_repo/configure_appointment_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateAppointmentConfiguration extends StatefulWidget {
  AppointmentConfigurations configureAppointment;
  UpdateAppointmentConfiguration(
      {required this.configureAppointment, super.key});

  @override
  State<UpdateAppointmentConfiguration> createState() =>
      _UpdateAppointmentConfigurationState();
}

class _UpdateAppointmentConfigurationState
    extends State<UpdateAppointmentConfiguration> {
  var contr = Get.put<EditConfigureAppointmentController>(
      EditConfigureAppointmentController());

  getDetail() {
    EditConfigureAppointmentController.i.updateIsloading(true);
    contr.consultancyfeeController.text =
        widget.configureAppointment.consultancyFee.toString();
    contr.followupdayController.text =
        widget.configureAppointment.noofFollowupDays.toString();
    contr.followupfeeController.text =
        widget.configureAppointment.followupFee.toString();
    int approvalcriteria = widget.configureAppointment.approvalCriteria - 1;
    contr.initializeSelectedApprovalCriteria(approvalcriteria);
    _fromtime = TimeOfDay(
        hour: int.parse(widget.configureAppointment.fromTime.split(":")[0]),
        minute: int.parse(widget.configureAppointment.fromTime.split(":")[1]));
    _tilltime = TimeOfDay(
        hour: int.parse(widget.configureAppointment.toTime.split(":")[0]),
        minute: int.parse(widget.configureAppointment.toTime.split(":")[1]));
    _time = TimeOfDay(
        hour: int.parse(widget.configureAppointment.slotDuration.split(":")[0]),
        minute:
            int.parse(widget.configureAppointment.slotDuration.split(":")[1]));

    String weekdays = widget.configureAppointment.weekDays;

    Map<String, int> dayValueMap = {
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
      'Sunday': 7,
    };

    List<String> weekdayNames = weekdays.split(',');
    for (String dayName in weekdayNames) {
      if (dayValueMap.containsKey(dayName)) {
        if (dayName.toLowerCase() == 'monday') {
          contr.switchStates[0] = true;
        } else if (dayName.toLowerCase() == 'tuesday') {
          contr.switchStates[1] = true;
        } else if (dayName.toLowerCase() == 'wednesday') {
          contr.switchStates[2] = true;
        } else if (dayName.toLowerCase() == 'thursday') {
          contr.switchStates[3] = true;
        } else if (dayName.toLowerCase() == 'friday') {
          contr.switchStates[4] = true;
        } else if (dayName.toLowerCase() == 'saturday') {
          contr.switchStates[5] = true;
        } else if (dayName.toLowerCase() == 'sunday') {
          contr.switchStates[6] = true;
        }

        // contr.switchStates
        contr.daylst.add(dayValueMap[dayName]!);
      }
    }

    EditConfigureAppointmentController.i.updateIsloading(false);
  }

  bool checkSlotDuration(
      TimeOfDay fromTime, TimeOfDay tillTime, TimeOfDay slotDuration) {
    int timeDifference = tillTime.hour * 60 +
        tillTime.minute -
        (fromTime.hour * 60 + fromTime.minute);
    int slotDurationMinutes = slotDuration.hour * 60 + slotDuration.minute;
    if (slotDurationMinutes <= timeDifference) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    contr.consultancyfeeController.clear();
    contr.followupdayController.clear();
    contr.followupfeeController.clear();
    contr.initializeSelectedApprovalCriteria(0);
    _time = const TimeOfDay(hour: 00, minute: 00);
    _fromtime = const TimeOfDay(hour: 00, minute: 00);
    _tilltime = const TimeOfDay(hour: 00, minute: 00);
    contr.daylst.clear();
    contr.switchStates = [false, false, false, false, false, false, false];
    super.dispose();
  }

  @override
  void initState() {
    getDetail();
    super.initState();
  }

  TimeOfDay _time = const TimeOfDay(hour: 00, minute: 00);
  final int _interval = 5;
  final CustomVisibleStep _visibleStep = CustomVisibleStep.fifths;
  void _selectTime() async {
    final TimeOfDay? newTime = await showCustomIntervalTimePicker(
      context: context,
      initialTime: _time,
      interval: _interval,
      CustomVisibleStep: _visibleStep,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  TimeOfDay _fromtime = const TimeOfDay(hour: 00, minute: 00);
  final int _frominterval = 5;
  final CustomVisibleStep _fromvisibleStep = CustomVisibleStep.fifths;
  void _fromselectTime() async {
    final TimeOfDay? newTime = await showCustomIntervalTimePicker(
      context: context,
      initialTime: _fromtime,
      interval: _frominterval,
      CustomVisibleStep: _fromvisibleStep,
    );
    if (newTime != null) {
      setState(() {
        _fromtime = newTime;
      });
    }
  }

  TimeOfDay _tilltime = const TimeOfDay(hour: 00, minute: 00);
  final int _tillinterval = 5;
  final CustomVisibleStep _tillvisibleStep = CustomVisibleStep.fifths;
  void _tillselectTime() async {
    final TimeOfDay? newTime = await showCustomIntervalTimePicker(
      context: context,
      initialTime: _tilltime,
      interval: _tillinterval,
      CustomVisibleStep: _tillvisibleStep,
    );
    if (newTime != null) {
      setState(() {
        _tilltime = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'editConfiguration'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 1.175,
            color: ColorManager.kPrimaryColor,
          ),
        ),
      ),
      body: GetBuilder<EditConfigureAppointmentController>(
        builder: (cont) => Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: BlurryModalProgressHUD(
            inAsyncCall: EditConfigureAppointmentController.i.isLoading,
            blurEffectIntensity: 4,
            progressIndicator: const SpinKitSpinningLines(
              color: ColorManager.kPrimaryColor,
              size: 60,
            ),
            child: SizedBox(
              width: Get.width * 1,
              height: Get.height * 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                      child: Row(
                        children: [
                          Text(
                            "selectdays".tr,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: ColorManager.kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Card(
                              elevation: 1,
                              surfaceTintColor: ColorManager.kWhiteColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.03),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      contr.getDayName(index),
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: ColorManager.kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Transform.scale(
                                      scale: 0.55,
                                      child: Switch.adaptive(
                                        value: contr.switchStates[index],
                                        activeColor: ColorManager.kPrimaryColor,
                                        onChanged: (value) {
                                          contr.toggleSwitch(index);
                                          if (value) {
                                            contr.addintodays(index + 1);
                                          } else {
                                            contr.deletefromdays(index + 1);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Card(
                      elevation: 1,
                      color: ColorManager.kPrimaryLightColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.01,
                            vertical: Get.height * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'timeDuration'.tr,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: ColorManager.kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'from'.tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.39,
                                      child: InkWell(
                                        onTap: () {
                                          _fromselectTime();
                                        },
                                        child: TextField(
                                          enabled: false,
                                          cursorColor:
                                              ColorManager.kPrimaryColor,
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Icon(
                                                      CupertinoIcons.clock),
                                                  Text(
                                                    "${_fromtime.hour.toString().padLeft(2, '0')}:${_fromtime.minute.toString().padLeft(2, '0')}",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color:
                                                    ColorManager.kPrimaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'till'.tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.39,
                                      child: InkWell(
                                        onTap: () {
                                          _tillselectTime();
                                        },
                                        child: TextField(
                                          enabled: false,
                                          cursorColor:
                                              ColorManager.kPrimaryColor,
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Icon(
                                                      CupertinoIcons.clock),
                                                  Text(
                                                    "${_tilltime.hour.toString().padLeft(2, '0')}:${_tilltime.minute.toString().padLeft(2, '0')}",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color:
                                                    ColorManager.kPrimaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "feetimeSlot".tr,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: ColorManager.kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 1,
                      color: ColorManager.kPrimaryLightColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.02,
                            vertical: Get.height * 0.02),

                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'consultancyfee'.tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    Container(
                                      width: Get.width * 0.39,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: ColorManager.kPrimaryColor,
                                        ),
                                      ),
                                      child: Transform.translate(
                                        offset: const Offset(0, -10),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.04,
                                              right: Get.width * 0.04),
                                          child: TextField(
                                            textAlign: TextAlign.right,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d*\.?\d{0,2}')),
                                            ],
                                            controller:
                                                contr.consultancyfeeController,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(top: 20),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'slotduration'.tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.39,
                                      child: InkWell(
                                        onTap: () {
                                          _selectTime();
                                        },
                                        child: TextField(
                                          enabled: false,
                                          cursorColor:
                                              ColorManager.kPrimaryColor,
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Icon(
                                                      CupertinoIcons.clock),
                                                  Text(
                                                    "${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color:
                                                    ColorManager.kPrimaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            //2 row
                            SizedBox(height: Get.height * 0.02),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'followupfee'.tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    Container(
                                      width: Get.width * 0.39,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: ColorManager.kPrimaryColor,
                                        ),
                                      ),
                                      child: Transform.translate(
                                        offset: const Offset(0, -10),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.04,
                                              right: Get.width * 0.04),
                                          child: TextField(
                                            textAlign: TextAlign.right,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d*\.?\d{0,2}')),
                                            ],
                                            controller:
                                                contr.followupfeeController,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(top: 20),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'followupdays'.tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    Container(
                                      width: Get.width * 0.39,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: ColorManager.kPrimaryColor,
                                        ),
                                      ),
                                      child: Transform.translate(
                                        offset: const Offset(0, -10),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.04,
                                              right: Get.width * 0.04),
                                          child: TextField(
                                            textAlign: TextAlign.right,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d*\.?\d{0,2}')),
                                            ],
                                            controller:
                                                contr.followupdayController,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(top: 20),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        // child: Row(children: [
                        //   Expanded(
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(left: 5, right: 5),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             "consultancyfee".tr,
                        //             style: GoogleFonts.poppins(
                        //               fontSize: 12,
                        //               color: ColorManager.kPrimaryColor,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: Get.height * 0.01,
                        //           ),
                        //           Container(
                        //             height: Get.height * 0.065,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(15),
                        //               border: Border.all(
                        //                 color: ColorManager.kPrimaryColor,
                        //               ),
                        //             ),
                        //             child: Row(
                        //               children: [
                        //                 Expanded(
                        //                   child: Padding(
                        //                     padding: EdgeInsets.only(
                        //                         left: Get.width * 0.02,
                        //                         right: Get.width * 0.02,
                        //                         bottom: Get.height * 0.015),
                        //                     child: TextField(
                        //                       keyboardType: const TextInputType
                        //                           .numberWithOptions(
                        //                           decimal: true),
                        //                       inputFormatters: [
                        //                         FilteringTextInputFormatter
                        //                             .allow(RegExp(
                        //                                 r'^\d*\.?\d{0,2}')),
                        //                       ],
                        //                       controller: contr
                        //                           .consultancyfeeController,
                        //                       // keyboardType:
                        //                       //     TextInputType.number,

                        //                       decoration: const InputDecoration(
                        //                         focusedBorder:
                        //                             UnderlineInputBorder(
                        //                           borderSide: BorderSide(
                        //                             color: Colors.black,
                        //                           ),
                        //                         ),
                        //                         enabledBorder:
                        //                             UnderlineInputBorder(
                        //                           borderSide: BorderSide(
                        //                             color: Colors.black,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: Get.height * 0.01,
                        //           ),
                        //           Text(
                        //             "followupfee".tr,
                        //             style: GoogleFonts.poppins(
                        //               fontSize: 12,
                        //               color: ColorManager.kPrimaryColor,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: Get.height * 0.01,
                        //           ),
                        //           Container(
                        //             height: Get.height * 0.065,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(15),
                        //               border: Border.all(
                        //                 color: ColorManager.kPrimaryColor,
                        //               ),
                        //             ),
                        //             child: Row(
                        //               children: [
                        //                 Expanded(
                        //                   child: Padding(
                        //                     padding: EdgeInsets.only(
                        //                         left: Get.width * 0.02,
                        //                         right: Get.width * 0.02,
                        //                         bottom: Get.height * 0.015),
                        //                     child: TextField(
                        //                       controller:
                        //                           contr.followupfeeController,
                        //                       keyboardType: const TextInputType
                        //                           .numberWithOptions(
                        //                           decimal: true),
                        //                       inputFormatters: [
                        //                         FilteringTextInputFormatter
                        //                             .allow(RegExp(
                        //                                 r'^\d*\.?\d{0,2}')),
                        //                       ],
                        //                       decoration: const InputDecoration(
                        //                         focusedBorder:
                        //                             UnderlineInputBorder(
                        //                           borderSide: BorderSide(
                        //                             color: Colors.black,
                        //                           ),
                        //                         ),
                        //                         enabledBorder:
                        //                             UnderlineInputBorder(
                        //                           borderSide: BorderSide(
                        //                             color: Colors.black,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   Expanded(
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(left: 5, right: 5),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             "slotduration".tr,
                        //             style: GoogleFonts.poppins(
                        //               fontSize: 12,
                        //               color: ColorManager.kPrimaryColor,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: Get.height * 0.01,
                        //           ),
                        //           InkWell(
                        //             onTap: () {
                        //               _selectTime();
                        //             },
                        //             child: TextField(
                        //               enabled: false,
                        //               cursorColor: ColorManager.kPrimaryColor,
                        //               decoration: InputDecoration(
                        //                 prefixIcon: Padding(
                        //                   padding: const EdgeInsets.only(
                        //                       left: 10, right: 10),
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       const Icon(CupertinoIcons.clock),
                        //                       Text(
                        //                         "${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}",
                        //                         style: GoogleFonts.poppins(
                        //                             fontSize: 12,
                        //                             color: ColorManager
                        //                                 .kblackColor,
                        //                             fontWeight:
                        //                                 FontWeight.w500),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 disabledBorder: OutlineInputBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(15),
                        //                   borderSide: const BorderSide(
                        //                     color: ColorManager.kPrimaryColor,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: Get.height * 0.01,
                        //           ),
                        //           Text(
                        //             "followupdays".tr,
                        //             style: GoogleFonts.poppins(
                        //               fontSize: 12,
                        //               color: ColorManager.kPrimaryColor,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: Get.height * 0.01,
                        //           ),
                        //           Container(
                        //             height: Get.height * 0.065,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(15),
                        //               border: Border.all(
                        //                 color: ColorManager.kPrimaryColor,
                        //               ),
                        //             ),
                        //             child: Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: Get.width * 0.06,
                        //                 ),
                        //                 Expanded(
                        //                   child: Padding(
                        //                     padding: EdgeInsets.only(
                        //                         left: Get.width * 0.02,
                        //                         right: Get.width * 0.02,
                        //                         bottom: Get.height * 0.015),
                        //                     child: TextField(
                        //                       maxLength: 4,
                        //                       controller:
                        //                           contr.followupdayController,
                        //                       keyboardType:
                        //                           TextInputType.number,
                        //                       decoration: const InputDecoration(
                        //                         counterText: "",
                        //                         focusedBorder:
                        //                             UnderlineInputBorder(
                        //                           borderSide: BorderSide(
                        //                             color: Colors.black,
                        //                           ),
                        //                         ),
                        //                         enabledBorder:
                        //                             UnderlineInputBorder(
                        //                           borderSide: BorderSide(
                        //                             color: Colors.black,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ]),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Card(
                      elevation: 1,
                      color: ColorManager.kPrimaryLightColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "approvalcriteria".tr,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              // Text.rich(
                              //   TextSpan(
                              //     text: "nonpaidappointmentapproval".tr,
                              //     style: GoogleFonts.poppins(
                              //         fontSize: 14,
                              //         color: ColorManager.kPrimaryColor,
                              //         fontWeight: FontWeight.bold),
                              //     children: [
                              //       TextSpan(
                              //           text: "approvalcriteria".tr,
                              //           style: GoogleFonts.poppins(
                              //               fontSize: 12,
                              //               color: ColorManager.kblackColor,
                              //               fontWeight: FontWeight.normal)),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              InkWell(
                                onTap: () async {
                                  EditApprovalCriteria generic =
                                      await searchabledropdown(
                                          context, contr.approvalCriteriaList);
                                  contr.updateApprovalCriteria(generic);

                                  if (generic != '') {
                                    contr.selectedApprovalCriteria = generic;
                                    contr.selectedApprovalCriteria =
                                        (generic == '')
                                            ? null
                                            : contr.selectedApprovalCriteria;
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  height: Get.height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorManager.kPrimaryColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.03,
                                        vertical: Get.height * 0.01),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${(contr.selectedApprovalCriteria != null && contr.selectedApprovalCriteria?.name != null) ? (contr.selectedApprovalCriteria!.name.length > 50 ? ('${contr.selectedApprovalCriteria?.name.substring(0, 50 > contr.selectedApprovalCriteria!.name.length ? contr.selectedApprovalCriteria!.name.length : 50)}...') : contr.selectedApprovalCriteria?.name) : "Select Approval Criteria"}",
                                          // semanticsLabel:
                                          //     "${(contr.selectedApprovalCriteria != null) ? (contr.selectedApprovalCriteria!.name.length > 50 ? ('${contr.selectedApprovalCriteria?.name.substring(0, 50 > contr.selectedApprovalCriteria!.name.length ? contr.selectedApprovalCriteria!.name.length : 50)}...') : contr.selectedApprovalCriteria) : "Select Approval Criteria"}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: ColorManager.kblackColor),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 20,
                                          color: ColorManager.kblackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    InkWell(
                      onTap: () async {
                        if (contr.daylst.isNotEmpty) {
                          String? dit = await LocalDb().getDoctorId();
                          ConfigureAppointmentRepo car =
                              ConfigureAppointmentRepo();

                          String mainId = widget.configureAppointment.id;
                          if (_time != const TimeOfDay(hour: 0, minute: 0)) {
                            if (checkSlotDuration(
                                _fromtime, _tilltime, _time)) {
                              String? res =
                                  await car.editAppointmentConfiguration(
                                mainId,
                                contr.selectedApprovalCriteria!.id,
                                widget.configureAppointment.workLocationId,
                                dit,
                                "${_fromtime.hour.toString().padLeft(2, '0')}:${_fromtime.minute.toString().padLeft(2, '0')}",
                                "${_tilltime.hour.toString().padLeft(2, '0')}:${_tilltime.minute.toString().padLeft(2, '0')}",
                                contr.consultancyfeeController.text,
                                "${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}",
                                contr.followupfeeController.text,
                                contr.followupdayController.text,
                                contr.daylst
                                    .toString()
                                    .split(']')[0]
                                    .split('[')[1],
                                widget
                                    .configureAppointment.isOnlineConfiguration,
                                true,
                              );
                              if (res == 'Successfully Updated') {
                                EditConfigureAppointmentController.i
                                    .updateIsSavingloading(false);
                                Get.back(result: true);
                              }
                            }
                          }
                        }
                        EditConfigureAppointmentController.i
                            .updateIsSavingloading(false);
                      },
                      child: Container(
                          height: Get.height * 0.07,
                          width: Get.width * 0.7,
                          decoration: BoxDecoration(
                            color: ColorManager.kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'update'.tr,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.kWhiteColor),
                          )),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
