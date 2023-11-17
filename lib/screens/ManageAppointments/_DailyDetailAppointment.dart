import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../components/custom_dialog_box/Custom_Dialog_box_with_Footer.dart';
import '../../components/custom_dialog_box/DatePickerWithDialog.dart';
import '../../data/controller/ManageAppointments_Controller.dart';
import '../../helpers/color_manager.dart';
import '../../helpers/font_manager.dart';
import '../../helpers/values_manager.dart';
import '../../models/DayViewAppointmentModel.dart';

class DailyDetailAppointment extends StatefulWidget {
  String? dateTime;
  String? IsOnline;
  String? WorkLocationId;
  DailyDetailAppointment(
      {super.key,
      required this.dateTime,
      required this.IsOnline,
      required this.WorkLocationId});

  @override
  State<DailyDetailAppointment> createState() => DailyDetailAppointmentState();
}

class DailyDetailAppointmentState extends State<DailyDetailAppointment> {
  String? SelectedDate;
  TextEditingController dateReshedualcontroller = TextEditingController();
  @override
  void initState() {
    DateTime tempDate = DateTime.now();
    if (ManageAppointmentController.i.date == null) {
      SelectedDate = ManageAppointmentController.i.date != null
          ? DateFormat('yyyy-MM-dd')
              .format(ManageAppointmentController.i.date!)
              .toString()
          : DateFormat('yyyy-MM-dd').format(tempDate).toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contr =
        Get.put<ManageAppointmentController>(ManageAppointmentController());
    return Scaffold(
        body: GetBuilder<ManageAppointmentController>(builder: (cont) {
      return /*  SpecialitiesController.i.isLoading == false ?*/
          SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          height: Get.height * 0.14,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorManager.kPrimaryLightColor),
                          child: DatePicker(
                            DateTime.now(),
                            dateTextStyle: GoogleFonts.poppins(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            dayTextStyle: GoogleFonts.poppins(
                              color: ColorManager.kPrimaryColor,
                              fontSize: 12,
                            ),
                            monthTextStyle: GoogleFonts.poppins(
                              color: ColorManager.kPrimaryColor,
                              fontSize: 12,
                            ),
                            deactivatedColor: ColorManager.kPrimaryLightColor,
                            height: Get.height * 0.15,
                            initialSelectedDate:
                                ManageAppointmentController.i.date ??
                                    DateTime.now(),
                            selectionColor: ColorManager.kPrimaryColor,
                            selectedTextColor: Colors.white,
                            onDateChange: (date) {
                              String Date =
                                  DateFormat('yyyy-MM-dd').format(date);
                              SelectedDate = Date;
                              ManageAppointmentController.i
                                  .getDailyDoctorAppointmentSlots(
                                      Date.toString(),
                                      widget.IsOnline.toString(),
                                      widget.WorkLocationId.toString());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          List<Appointments> result =
                              ManageAppointmentController.i
                                  .getCheckedAppointmentSlots();
                          if (result.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'error'.tr,
                                    content: 'noitemisselected'.tr,
                                    footer: 'ok'.tr,
                                    onClosePressed: () {
                                      // print('Dialog closed');
                                    },
                                  );
                                });
                          } else {
                            DateTime dateTime = DateTime.now();
                            dateReshedualcontroller.text =
                                DateFormat('yyyy-MM-dd')
                                    .format(dateTime)
                                    .toString();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog_DatePicker(
                                    dateTime: dateTime,
                                    controller: dateReshedualcontroller,
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      var response =
                                          await ManageAppointmentController.i
                                              .reShedualAppointmentSlots(
                                                  dateReshedualcontroller.text
                                                      .toString(), //Shedule Date
                                                  result[0].branchId.toString(),
                                                  result);
                                      if (response == 1) {
                                        ManageAppointmentController.i
                                            .getDailyDoctorAppointmentSlots(
                                                SelectedDate.toString(),
                                                widget.IsOnline.toString(),
                                                widget.WorkLocationId
                                                    .toString());
                                      }
                                      // print('Dialog closed');
                                    },
                                  );
                                });
                          }
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.34,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: ColorManager
                                  .kWhiteColor, // Set the background color of the container
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.3), // Shadow color
                                  spreadRadius:
                                      2, // Spread radius of the shadow
                                  blurRadius: 2, // Blur radius of the shadow
                                  offset: const Offset(
                                      0, 2), // Offset of the shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              'reschedule'.tr,
                              style: GoogleFonts.poppins(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                      ),
                      InkWell(
                        onTap: () async {
                          List<Appointments> result =
                              ManageAppointmentController.i
                                  .getCheckedAppointmentSlots();
                          if (result.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'error'.tr,
                                    content:
                                        'nopendingappointmentisselected'.tr,
                                    footer: 'ok'.tr,
                                    onClosePressed: () {
                                      // print('Dialog closed');
                                    },
                                  );
                                });
                          } else {
                            var response = await ManageAppointmentController.i
                                .approveAppointmentSlots(
                                    result[0].branchId.toString(), result);
                            if (response == 1) {
                              ManageAppointmentController.i
                                  .getDailyDoctorAppointmentSlots(
                                      SelectedDate.toString(),
                                      widget.IsOnline.toString(),
                                      widget.WorkLocationId.toString());
                            }
                          }
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: ColorManager
                                  .kWhiteColor, // Set the background color of the container
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.3), // Shadow color
                                  spreadRadius:
                                      2, // Spread radius of the shadow
                                  blurRadius: 2, // Blur radius of the shadow
                                  offset: const Offset(
                                      0, 2), // Offset of the shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              'approve'.tr,
                              style: GoogleFonts.poppins(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                      ),
                      InkWell(
                        onTap: () {
                          ManageAppointmentController.i
                              .updateCheckedBoxStatusToSelectAll();
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: ColorManager
                                  .kWhiteColor, // Set the background color of the container
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.3), // Shadow color
                                  spreadRadius:
                                      2, // Spread radius of the shadow
                                  blurRadius: 2, // Blur radius of the shadow
                                  offset: const Offset(
                                      0, 2), // Offset of the shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                    child: Text(
                                  'selectAll'.tr,
                                  style: GoogleFonts.poppins(
                                    color: ColorManager.kPrimaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.05, // Set the desired width for the checkbox
                                    height: MediaQuery.of(context).size.width *
                                        0.05, // Set the desired height for the checkbox
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(
                                              0xfff1272d3)), // Border color
                                      borderRadius: BorderRadius.circular(
                                          4), // Adjust as needed
                                    ),
                                    child: (ManageAppointmentController
                                                .i.selectall ==
                                            true)
                                        ? Icon(Icons.check,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            color: const Color(
                                                0xfff1272d3)) // Show the check icon when checked
                                        : Container(), // No content when not checked
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  if ((((ManageAppointmentController
                                      .i.dayViewAppointmentSlotModel !=
                                  null) &&
                              (ManageAppointmentController
                                      .i
                                      .dayViewAppointmentSlotModel
                                      .appointments !=
                                  null))
                          ? ManageAppointmentController.i
                              .dayViewAppointmentSlotModel.appointments?.length
                          : 0) !=
                      0)
                    GetBuilder<ManageAppointmentController>(
                      builder: (contro) => BlurryModalProgressHUD(
                        inAsyncCall: ManageAppointmentController
                            .i.isLoadingDailyDoctorAppointmentSlots,
                        blurEffectIntensity: 4,
                        progressIndicator: const SpinKitSpinningLines(
                          color: Color(0xfff1272d3),
                          size: 60,
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.52,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: (((ManageAppointmentController
                                              .i.dayViewAppointmentSlotModel !=
                                          null) &&
                                      (ManageAppointmentController
                                              .i
                                              .dayViewAppointmentSlotModel
                                              .appointments !=
                                          null))
                                  ? ManageAppointmentController
                                      .i
                                      .dayViewAppointmentSlotModel
                                      .appointments
                                      ?.length
                                  : 1),
                              itemBuilder: (context, index) {
                                final manageAppointmentSlots =
                                    ((ManageAppointmentController.i
                                                    .dayViewAppointmentSlotModel !=
                                                null) &&
                                            (ManageAppointmentController
                                                    .i
                                                    .dayViewAppointmentSlotModel
                                                    .appointments !=
                                                null))
                                        ? ManageAppointmentController
                                            .i
                                            .dayViewAppointmentSlotModel
                                            .appointments![index]
                                        : null;

                                return ((manageAppointmentSlots != null)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            (manageAppointmentSlots.time !=
                                                    null)
                                                ? ManageAppointmentController.i
                                                    .convertTimeFormat(
                                                        manageAppointmentSlots
                                                                .time ??
                                                            "")
                                                : "",

                                            // manageAppointmentSlots.time ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: ColorManager
                                                        .kblackColor,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .regular),
                                          ),
                                          Text(
                                            ' | ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: ColorManager
                                                        .kblackColor,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .regular),
                                          ),
                                          Material(
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.70,
                                                  // Adjust the width as needed
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: ColorManager
                                                            .kblackColor, // Customize the border color
                                                        width:
                                                            1, // Adjust the border width
                                                      ),
                                                    ),
                                                  ),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  manageAppointmentSlots
                                                                          .name ??
                                                                      "",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                          fontSize:
                                                                              13,
                                                                          color: ColorManager
                                                                              .kblackColor,
                                                                          fontWeight:
                                                                              FontWeightManager.regular),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        manageAppointmentSlots.cellNumber ??
                                                                            "",
                                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                ColorManager.kblackColor,
                                                                            fontWeight: FontWeightManager.regular),
                                                                      ),
                                                                    ),
                                                                    manageAppointmentSlots.appointmentId !=
                                                                            null
                                                                        ? InkWell(
                                                                            onTap:
                                                                                () {
                                                                              // Toggle the checkbox state when the box is tapped
                                                                              setState(() {
                                                                                ManageAppointmentController.i.updateCheckedBoxStatus(manageAppointmentSlots.appointmentId!);
                                                                                //   isChecked = !isChecked;
                                                                              });
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                                                                              child: Container(
                                                                                width: 21, // Set the desired width for the checkbox
                                                                                height: 21, // Set the desired height for the checkbox
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(color: (manageAppointmentSlots.status.toString().toLowerCase().contains('confirmed')) ? Colors.green : Colors.black), // Border color
                                                                                  borderRadius: BorderRadius.circular(4), // Adjust as needed
                                                                                ),
                                                                                child: (manageAppointmentSlots.IsChecked == true)
                                                                                    ? Icon(Icons.check, size: 16, color: (manageAppointmentSlots.status.toString().toLowerCase().contains('confirmed')) ? Colors.green : Colors.black) // Show the check icon when checked
                                                                                    : Container(), // No content when not checked
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container()
                                                                  ],
                                                                ),
                                                              ),
                                                            ])
                                                      ])))
                                        ],
                                      )
                                    : Container());
                              }),
                        ),
                      ),
                    ),
                  (((ManageAppointmentController
                                          .i.dayViewAppointmentSlotModel !=
                                      null) &&
                                  (ManageAppointmentController
                                          .i
                                          .dayViewAppointmentSlotModel
                                          .appointments !=
                                      null))
                              ? ManageAppointmentController
                                  .i
                                  .dayViewAppointmentSlotModel
                                  .appointments
                                  ?.length
                              : 0) ==
                          0
                      ? GetBuilder<ManageAppointmentController>(
                          builder: (controo) => BlurryModalProgressHUD(
                            inAsyncCall: ManageAppointmentController
                                .i.isLoadingDailyDoctorAppointmentSlots,
                            blurEffectIntensity: 4,
                            progressIndicator: const SpinKitSpinningLines(
                              color: Color(0xfff1272d3),
                              size: 60,
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Center(
                                child: Text('NoRecordFound'.tr),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ), // Replace with your content
        ),
      );
    }));
  }
}
