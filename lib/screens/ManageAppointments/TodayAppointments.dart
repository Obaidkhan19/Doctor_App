import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/doted_line.dart';
import 'package:doctormobileapplication/screens/dashboard/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../data/controller/ManageAppointments_Controller.dart';
import '../../helpers/color_manager.dart';
import '../../helpers/font_manager.dart';
import '../../utils/AppImages.dart';
import 'DailyViewAppointment.dart';

class TodayAppointments extends StatefulWidget {
  const TodayAppointments({super.key});

  @override
  State<TodayAppointments> createState() => _TodayAppointmentsState();
}

class _TodayAppointmentsState extends State<TodayAppointments> {
  @override
  void initState() {
    call();
    super.initState();
  }

  call() async {
    ManageAppointmentController.i.getDailyDoctorAppointment();
  }

  var contr =
      Get.put<ManageAppointmentController>(ManageAppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: ColorManager.kPrimaryColor,
            onPressed: () {
              Get.offAll(() => const DrawerScreen());
            },
          ),
          centerTitle: true,
          title: Text(
            'todayappointment'.tr,
            style: GoogleFonts.poppins(
              textStyle: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.kPrimaryColor),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: GetBuilder<ManageAppointmentController>(builder: (cont) {
          return BlurryModalProgressHUD(
              inAsyncCall: cont.isLoadingscreen,
              blurEffectIntensity: 4,
              progressIndicator: const SpinKitSpinningLines(
                color: Color(0xfff1272d3),
                size: 60,
              ),
              dismissible: false,
              opacity: 0.4,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ManageAppointmentController.i.dailyDoctorAppointmentsModel
                          .onlineAppointmentStatistics !=
                      null
                  ? SingleChildScrollView(
                      child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                      child: Column(children: [
                        (ManageAppointmentController
                                    .i
                                    .dailyDoctorAppointmentsModel
                                    .onlineAppointmentStatistics !=
                                null)
                            ? Container(
                                decoration: BoxDecoration(
                                  color: const Color(
                                      0xfff1272d3), // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.3), // Shadow color
                                      spreadRadius:
                                          2, // Spread radius of the shadow
                                      blurRadius:
                                          2, // Blur radius of the shadow
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  onTap: () {
                                    DateTime Dates = DateTime.now();
                                    String Date =
                                        DateFormat('yyyy-MM-dd').format(Dates);
                                    ManageAppointmentController.i
                                        .getDailyDoctorAppointmentSlots(
                                            Date.toString(), 'true', '');
                                    Get.to(() => DailyViewAppointments(
                                        dateTime: Date.toString(),
                                        IsOnline: 'true',
                                        WorkLocationId: ''));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  leading: Image.asset(
                                    AppImages.online,
                                    scale: 2,
                                  ),
                                  title: Text(
                                    ManageAppointmentController
                                            .i
                                            .dailyDoctorAppointmentsModel
                                            .onlineAppointmentStatistics
                                            ?.location
                                            .toString() ??
                                        "",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: ColorManager.kWhiteColor,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        ManageAppointmentController
                                                .i
                                                .dailyDoctorAppointmentsModel
                                                .onlineAppointmentStatistics
                                                ?.noofAppointments
                                                .toString() ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: ColorManager.kWhiteColor,
                                                fontWeight:
                                                    FontWeightManager.light,
                                                fontSize: 20),
                                      ),
                                      Text(
                                        " | ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: ColorManager.kWhiteColor,
                                                fontWeight:
                                                    FontWeightManager.light,
                                                fontSize: 20),
                                      ),
                                      const Icon(
                                        Icons.navigate_next_outlined,
                                        size:
                                            20.0, // Adjust icon size as needed
                                        color: ColorManager.kWhiteColor,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        ManageAppointmentController
                                    .i
                                    .dailyDoctorAppointmentsModel
                                    .appointmentStatistics !=
                                null
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ManageAppointmentController
                                    .i
                                    .dailyDoctorAppointmentsModel
                                    .appointmentStatistics
                                    ?.length,
                                itemBuilder: (context, index) {
                                  final manageAppointment =
                                      (ManageAppointmentController
                                                  .i
                                                  .dailyDoctorAppointmentsModel
                                                  .appointmentStatistics !=
                                              null)
                                          ? ManageAppointmentController
                                              .i
                                              .dailyDoctorAppointmentsModel
                                              .appointmentStatistics![index]
                                          : null;
                                  return ((manageAppointment != null)
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .white, // Set the background color of the container
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(
                                                          0.2), // Shadow color
                                                  spreadRadius:
                                                      2, // Spread radius of the shadow
                                                  blurRadius:
                                                      2, // Blur radius of the shadow
                                                  offset: const Offset(0,
                                                      2), // Offset of the shadow
                                                ),
                                              ],
                                            ),
                                            child: ListTile(
                                              onTap: () {
                                                DateTime Dates = DateTime.now();
                                                String Date =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(Dates);

                                                ManageAppointmentController.i
                                                    .getDailyDoctorAppointmentSlots(
                                                        Date.toString(),
                                                        'false',
                                                        manageAppointment
                                                            .workLocationId
                                                            .toString());

                                                Get.to(() =>
                                                    DailyViewAppointments(
                                                        dateTime:
                                                            Date.toString(),
                                                        IsOnline: 'false',
                                                        WorkLocationId:
                                                            manageAppointment
                                                                .workLocationId));
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              leading: Image.asset(
                                                AppImages.locations,
                                                alignment: Alignment.centerLeft,
                                                scale: 2,
                                              ),
                                              title: Text(
                                                "${manageAppointment.location ?? ''}  ${manageAppointment.address ?? ''}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  color: ColorManager
                                                      .kPrimaryColor,
                                                ),
                                              ),
                                              trailing: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    '${ManageAppointmentController.i.dailyDoctorAppointmentsModel.appointmentStatistics?[index].noofAppointments ?? ""}',
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.blue),
                                                  ),
                                                  Text(
                                                    " | ",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 20,
                                                        color: Colors.blue),
                                                  ),
                                                  const Icon(
                                                    Icons
                                                        .navigate_next_outlined,
                                                    size:
                                                        20.0, // Adjust icon size as needed
                                                    color: Colors.blue,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container());
                                })
                            : Container(
                                child: const Text('No Data'),
                              ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        ManageAppointmentController
                                .i
                                .dailyDoctorAppointmentsModel
                                .appointmentSummary!
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Text(
                                'appointmentstimeoverview'.tr,
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: ColorManager.kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        ManageAppointmentController
                                .i
                                .dailyDoctorAppointmentsModel
                                .appointmentSummary!
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.001),
                                child: Card(
                                  elevation: 4,
                                  surfaceTintColor: ColorManager.kWhiteColor,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: Get.height * 0.03,
                                        bottom: Get.height * 0.03,
                                        left: Get.width * 0.025,
                                        right: Get.width * 0.025),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: Get.width * 0.25,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'timeSlot'.tr,
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 9,
                                                            color: ColorManager
                                                                .kblackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                ManageAppointmentController
                                                        .i
                                                        .dailyDoctorAppointmentsModel
                                                        .appointmentSummary!
                                                        .isNotEmpty
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                            "${ManageAppointmentController.i.dailyDoctorAppointmentsModel.appointmentSummary?[0].start.toString().split(':')[0] ?? ""}:${ManageAppointmentController.i.dailyDoctorAppointmentsModel.appointmentSummary?[0].start.toString().split(':')[1] ?? ""} to ${ManageAppointmentController.i.dailyDoctorAppointmentsModel.appointmentSummary?[0].end.toString().split(':')[0] ?? ""}:${ManageAppointmentController.i.dailyDoctorAppointmentsModel.appointmentSummary?[0].end.toString().split(':')[1] ?? ""}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 9,
                                                              color: ColorManager
                                                                  .kblackColor,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : const Text("0"),
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.045,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: Get.height * 0.02),
                                              child: SizedBox(
                                                height: Get.height * 0.09,
                                                child:
                                                    const MyVerticalSeparator(
                                                  color:
                                                      ColorManager.kblackColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.02,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'booked'.tr,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 9,
                                                          color: ColorManager
                                                              .kRedColor,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Row(
                                                  children: [
                                                    ManageAppointmentController
                                                                .i
                                                                .dailyDoctorAppointmentsModel
                                                                .appointmentSummary !=
                                                            null
                                                        ? Text(
                                                            ManageAppointmentController
                                                                    .i
                                                                    .dailyDoctorAppointmentsModel
                                                                    .appointmentSummary?[
                                                                        0]
                                                                    .confirmed
                                                                    .toString() ??
                                                                "",
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 9,
                                                                color: ColorManager
                                                                    .kblackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )
                                                        : const Text("0"),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: Get.height * 0.02),
                                              child: SizedBox(
                                                height: Get.height * 0.09,
                                                child:
                                                    const MyVerticalSeparator(
                                                  color:
                                                      ColorManager.kblackColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'arrived'.tr,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 9,
                                                          color: ColorManager
                                                              .kPrimaryColor,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Row(
                                                  children: [
                                                    ManageAppointmentController
                                                                .i
                                                                .dailyDoctorAppointmentsModel
                                                                .appointmentSummary !=
                                                            null
                                                        ? Text(
                                                            ManageAppointmentController
                                                                    .i
                                                                    .dailyDoctorAppointmentsModel
                                                                    .appointmentSummary?[
                                                                        0]
                                                                    .consulted
                                                                    .toString() ??
                                                                "",
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 9,
                                                                color: ColorManager
                                                                    .kblackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )
                                                        : const Text("0"),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: Get.height * 0.02),
                                              child: SizedBox(
                                                height: Get.height * 0.09,
                                                child:
                                                    const MyVerticalSeparator(
                                                  color:
                                                      ColorManager.kblackColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'waiting'.tr,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 9,
                                                          color: ColorManager
                                                              .kblueColor,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Row(
                                                  children: [
                                                    ManageAppointmentController
                                                                .i
                                                                .dailyDoctorAppointmentsModel
                                                                .appointmentSummary !=
                                                            null
                                                        ? Text(
                                                            ManageAppointmentController
                                                                    .i
                                                                    .dailyDoctorAppointmentsModel
                                                                    .appointmentSummary?[
                                                                        0]
                                                                    .pending
                                                                    .toString() ??
                                                                "",
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 9,
                                                                color: ColorManager
                                                                    .kblackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )
                                                        : const Text("0"),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: Get.height * 0.02),
                                              child: SizedBox(
                                                height: Get.height * 0.09,
                                                child:
                                                    const MyVerticalSeparator(
                                                  color:
                                                      ColorManager.kblackColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'noshow'.tr,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 9,
                                                          color: ColorManager
                                                              .kyellowContainer,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Row(
                                                  children: [
                                                    ManageAppointmentController
                                                                .i
                                                                .dailyDoctorAppointmentsModel
                                                                .appointmentSummary !=
                                                            null
                                                        ? Text(
                                                            ManageAppointmentController
                                                                    .i
                                                                    .dailyDoctorAppointmentsModel
                                                                    .appointmentSummary?[
                                                                        0]
                                                                    .cancelled
                                                                    .toString() ??
                                                                "",
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 9,
                                                                color: ColorManager
                                                                    .kblackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )
                                                        : const Text("0"),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.005,
                                        ),
                                        const MySeparator(
                                          color: ColorManager.kblackColor,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.25,
                                              child: Text(
                                                'totalAppointments'.tr,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 8,
                                                    color: ColorManager
                                                        .kblackColor,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(width: Get.width * 0.105),
                                            ManageAppointmentController
                                                        .i
                                                        .dailyDoctorAppointmentsModel
                                                        .appointmentSummary !=
                                                    null
                                                ? Text(
                                                    ManageAppointmentController
                                                            .i
                                                            .dailyDoctorAppointmentsModel
                                                            .appointmentSummary?[
                                                                0]
                                                            .confirmed
                                                            .toString() ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 8,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                : const Text("0"),
                                            SizedBox(width: Get.width * 0.11),
                                            Text(
                                              ManageAppointmentController
                                                      .i
                                                      .dailyDoctorAppointmentsModel
                                                      .appointmentSummary?[0]
                                                      .consulted
                                                      .toString() ??
                                                  "",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 8,
                                                  color:
                                                      ColorManager.kblackColor,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(width: Get.width * 0.11),
                                            ManageAppointmentController
                                                        .i
                                                        .dailyDoctorAppointmentsModel
                                                        .appointmentSummary !=
                                                    null
                                                ? Text(
                                                    ManageAppointmentController
                                                            .i
                                                            .dailyDoctorAppointmentsModel
                                                            .appointmentSummary?[
                                                                0]
                                                            .pending
                                                            .toString() ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 8,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                : const Text("0"),
                                            SizedBox(width: Get.width * 0.12),
                                            ManageAppointmentController
                                                        .i
                                                        .dailyDoctorAppointmentsModel
                                                        .appointmentSummary !=
                                                    null
                                                ? Text(
                                                    ManageAppointmentController
                                                            .i
                                                            .dailyDoctorAppointmentsModel
                                                            .appointmentSummary?[
                                                                0]
                                                            .cancelled
                                                            .toString() ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 8,
                                                        color: ColorManager
                                                            .kblackColor,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                : const Text("0"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ]),
                    ))
                  : Center(
                      child: Text("NoRecordFound".tr),
                    ));
        }));
  }
}
