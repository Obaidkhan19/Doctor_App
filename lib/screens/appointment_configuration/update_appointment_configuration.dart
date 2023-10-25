import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/configure_appointment_controller.dart';
import 'package:doctormobileapplication/data/controller/edit_configure_appointment_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interval_time_picker/interval_time_picker.dart';

class UpdateAppointmentConfiguration extends StatefulWidget {
  const UpdateAppointmentConfiguration({super.key});

  @override
  State<UpdateAppointmentConfiguration> createState() =>
      _UpdateAppointmentConfigurationState();
}

class _UpdateAppointmentConfigurationState
    extends State<UpdateAppointmentConfiguration> {
  var contr = Get.put<EditConfigureAppointmentController>(
      EditConfigureAppointmentController());

  TimeOfDay _time = const TimeOfDay(hour: 00, minute: 00);
  final int _interval = 5;
  final VisibleStep _visibleStep = VisibleStep.fifths;
  void _selectTime() async {
    final TimeOfDay? newTime = await showIntervalTimePicker(
      context: context,
      initialTime: _time,
      interval: _interval,
      visibleStep: _visibleStep,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  TimeOfDay _fromtime = const TimeOfDay(hour: 00, minute: 00);
  final int _frominterval = 5;
  final VisibleStep _fromvisibleStep = VisibleStep.fifths;
  void _fromselectTime() async {
    final TimeOfDay? newTime = await showIntervalTimePicker(
      context: context,
      initialTime: _fromtime,
      interval: _frominterval,
      visibleStep: _fromvisibleStep,
    );
    if (newTime != null) {
      setState(() {
        _fromtime = newTime;
      });
    }
  }

  TimeOfDay _tilltime = const TimeOfDay(hour: 00, minute: 00);
  final int _tillinterval = 5;
  final VisibleStep _tillvisibleStep = VisibleStep.fifths;
  void _tillselectTime() async {
    final TimeOfDay? newTime = await showIntervalTimePicker(
      context: context,
      initialTime: _tilltime,
      interval: _tillinterval,
      visibleStep: _tillvisibleStep,
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
          'Edit Configuration',
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
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
          child: SizedBox(
            width: Get.width * 1,
            height: Get.height * 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
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
                              padding: EdgeInsets.only(left: Get.width * 0.03),
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
                                    child: Switch(
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
                          // Visibility(
                          //   visible: contr.switchStates[index],
                          //   child: Card(
                          //     elevation: 1,
                          //     color: ColorManager.kPrimaryLightColor,
                          //     shape: const RoundedRectangleBorder(
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(10.0)),
                          //     ),
                          //     child: Column(
                          //       children: [
                          //         SizedBox(
                          //           height: Get.height * 0.02,
                          //         ),
                          //         Text(
                          //           "addhoursofyouravailability".tr,
                          //           style: GoogleFonts.poppins(
                          //               fontSize: 12,
                          //               color: ColorManager.kPrimaryColor,
                          //               fontWeight: FontWeight.w600),
                          //         ),
                          //         ...contr.dayRows[index],
                          //         SizedBox(
                          //           height: Get.height * 0.01,
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             contr.addRow(index, context);
                          //           },
                          //           child: Text(
                          //             "addmorehours".tr,
                          //             style: GoogleFonts.poppins(
                          //                 fontSize: 12,
                          //                 color: ColorManager.kblackColor,
                          //                 fontWeight: FontWeight.w500),
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           height: Get.height * 0.01,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
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
                            'Time Duration',
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
                                    'From',
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
                                        cursorColor: ColorManager.kPrimaryColor,
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
                                              color: ColorManager.kPrimaryColor,
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
                                    'Till',
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
                                        cursorColor: ColorManager.kPrimaryColor,
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
                                              color: ColorManager.kPrimaryColor,
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
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
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
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, bottom: 10, top: 10),
                      child: Row(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "consultancyfee".tr,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: ColorManager.kPrimaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Container(
                                  height: Get.height * 0.065,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        height: 25,
                                        width: 40,
                                        child: Center(
                                          child: Text(
                                            "aed".tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: ColorManager.kblackColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.02,
                                              right: Get.width * 0.02,
                                              bottom: Get.height * 0.015),
                                          child: TextField(
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d*\.?\d{0,2}')),
                                            ],
                                            controller:
                                                contr.consultancyfeeController,
                                            // keyboardType:
                                            //     TextInputType.number,

                                            decoration: const InputDecoration(
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
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  "followupfee".tr,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: ColorManager.kPrimaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Container(
                                  height: Get.height * 0.065,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        height: 25,
                                        width: 40,
                                        child: Center(
                                          child: Text(
                                            "aed".tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: ColorManager.kblackColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.02,
                                              right: Get.width * 0.02,
                                              bottom: Get.height * 0.015),
                                          child: TextField(
                                            controller:
                                                contr.followupfeeController,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d*\.?\d{0,2}')),
                                            ],
                                            decoration: const InputDecoration(
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "slotduration".tr,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: ColorManager.kPrimaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                InkWell(
                                  onTap: () {
                                    _selectTime();
                                  },
                                  child: TextField(
                                    enabled: false,
                                    cursorColor: ColorManager.kPrimaryColor,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(CupertinoIcons.clock),
                                            Text(
                                              "${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color:
                                                      ColorManager.kblackColor,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: ColorManager.kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  "followupdays".tr,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: ColorManager.kPrimaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Container(
                                  height: Get.height * 0.065,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.06,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.02,
                                              right: Get.width * 0.02,
                                              bottom: Get.height * 0.015),
                                          child: TextField(
                                            maxLength: 4,
                                            controller:
                                                contr.followupdayController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              counterText: "",
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
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
                            Text.rich(
                              TextSpan(
                                text: "nonpaidappointmentapproval".tr,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: "approvalcriteria".tr,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: ColorManager.kblackColor,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            InkWell(
                              onTap: () async {
                                EditApprovalCriteria generic =
                                    await searchabledropdown(context,
                                        contr.approvalCriteriaList ?? []);
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
                                width: Get.width * 1,
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
                      // print(contr.daylst);
                      // String? hospitalid = contr.selectedhospital?.id;
                      // String hid = '';
                      // if (contr.daylst.isNotEmpty) {
                      //   if (contr.isOnline == true && hospitalid == null ||
                      //       contr.isOnline == false && hospitalid != null) {
                      //     String? dit = await LocalDb().getDoctorId();
                      //     ConfigureAppointmentRepo car =
                      //         ConfigureAppointmentRepo();
                      //     if (_time ==
                      //         const TimeOfDay(hour: 0, minute: 0)) {
                      //       showSnackbar(
                      //           context, "Please select time Slot");
                      //     }

                      //     if (_time !=
                      //         const TimeOfDay(hour: 0, minute: 0)) {
                      //       hospitalid ??= "";
                      //       String? res =
                      //           await car.addAppointmentConfiguration(
                      //         contr.selectedApprovalCriteria!.id,
                      //         hospitalid,
                      //         dit,
                      //         "${_fromtime.hour.toString().padLeft(2, '0')}:${_fromtime.minute.toString().padLeft(2, '0')}",
                      //         "${_tilltime.hour.toString().padLeft(2, '0')}:${_tilltime.minute.toString().padLeft(2, '0')}",
                      //         contr.consultancyfeeController.text,
                      //         "${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}",
                      //         contr.followupfeeController.text,
                      //         contr.followupdayController.text,
                      //         contr.daylst
                      //             .toString()
                      //             .split(']')[0]
                      //             .split('[')[1],
                      //         contr.isOnline,
                      //         true,
                      //       );

                      //       if (res == 'true') {
                      //         await ConfigureAppointmentController.i
                      //             .updateIsloading(true);
                      //         await contr.updatedispose();
                      //         await disposedatepicker();
                      //         await _getWorklocation();
                      //         setState(() {});
                      //         await ConfigureAppointmentController.i
                      //             .updateIsloading(false);
                      //       }
                      //     }
                      //   } else {
                      //     showSnackbar(context,
                      //         "Select Hospital or enable online consultation");
                      //   }
                      // } else {
                      //   showSnackbar(context, "Select at least One Day");
                      // }
                    },
                    child: Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.7,
                      decoration: BoxDecoration(
                        color: ColorManager.kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Update',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.kWhiteColor),
                        ),
                      ),
                    ),
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
    );
  }
}
