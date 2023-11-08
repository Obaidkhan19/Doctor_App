import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/configure_appointment_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/ConfigureAppointment_repo/configure_appointment_repo.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/consultingQueue_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/hospital_clinic.dart';
import 'package:doctormobileapplication/screens/appointment_configuration/update_appointment_configuration.dart';
import 'package:doctormobileapplication/screens/appointment_configuration/view_appointment_detail.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interval_time_picker/interval_time_picker.dart';

enum _MenuValues { view, update }

class ConfigureAppointmentScreen extends StatefulWidget {
  const ConfigureAppointmentScreen({super.key});

  @override
  State<ConfigureAppointmentScreen> createState() =>
      _ConfigureAppointmentScreenState();
}

class _ConfigureAppointmentScreenState
    extends State<ConfigureAppointmentScreen> {
  var contr =
      Get.put<ConfigureAppointmentController>(ConfigureAppointmentController());
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

  disposedatepicker() {
    _fromtime = const TimeOfDay(hour: 00, minute: 00);
    _tilltime = const TimeOfDay(hour: 00, minute: 00);
    _time = const TimeOfDay(hour: 00, minute: 00);
  }

  late BuildContext _context;

  _getHospital() async {
    ConsultingQueueRepo cqr = ConsultingQueueRepo();
    contr.updatehospitallist(
      await cqr.getHospitalORClinic(),
    );
  }

// top worklocations
  _getWorklocation() async {
    ConfigureAppointmentRepo car = ConfigureAppointmentRepo();
    ConfigureAppointmentController.i.updateWorkLocationslist(
      await car.getWorklocation(),
    );
  }

  Future<void> _getAppointmentConfiguration() async {
    ConfigureAppointmentRepo car = ConfigureAppointmentRepo();
    car.getAppointmentConfiguration();
  }

  @override
  void initState() {
    super.initState();
    _context = context;

    _getAppointmentConfiguration();
    _getHospital();
    _getWorklocation();

    ConfigureAppointmentController.i.initialrows(_context);
    ConfigureAppointmentController.i.initializeSelectedApprovalCriteria();
  }

  @override
  void didChangeDependencies() {
    _getAppointmentConfiguration();

    super.didChangeDependencies();
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
    super.dispose();
    ConfigureAppointmentController.i.clearrows();
    contr.disposefunction();
    ConfigureAppointmentController.i.falseSwitch();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfigureAppointmentController>(
      builder: (cont) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: ColorManager.kPrimaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'configureappointmentappbar'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                height: 1.175,
                color: ColorManager.kPrimaryColor,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _getAppointmentConfiguration,
            child: BlurryModalProgressHUD(
              inAsyncCall: ConfigureAppointmentController.i.isLoading,
              blurEffectIntensity: 4,
              progressIndicator: const SpinKitSpinningLines(
                color: Color(0xfff1272d3),
                size: 60,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.background_image),
                          alignment: Alignment.centerLeft),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: ConfigureAppointmentController
                                .i.appointmentconfigurationList.length,
                            itemBuilder: (context, index) {
                              final worklocation =
                                  (ConfigureAppointmentController
                                          .i
                                          .appointmentconfigurationList
                                          .isNotEmpty)
                                      ? ConfigureAppointmentController
                                          .i.appointmentconfigurationList[index]
                                      : null;
                              String name = worklocation!.workLocation ?? "";
                              // if (worklocation.isOnlineConfiguration) {
                              //   ConfigureAppointmentController.i
                              //       .updatehasOnlineConsultation();
                              // }
                              return ((ConfigureAppointmentController.i
                                      .appointmentconfigurationList.isNotEmpty)
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorManager.kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              if (name ==
                                                  'Online Video Consultation')
                                                Image.asset(
                                                  AppImages.online,
                                                  color:
                                                      ColorManager.kWhiteColor,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  scale: 2,
                                                ),
                                              if (name !=
                                                  'Online Video Consultation')
                                                Image.asset(
                                                  AppImages.locations,
                                                  color:
                                                      ColorManager.kWhiteColor,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  scale: 2.5,
                                                ),
                                              SizedBox(
                                                width: Get.width * 0.55,
                                                child: Text(
                                                  worklocation.workLocation ??
                                                      "",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: ColorManager
                                                        .kWhiteColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.1,
                                                child: PopupMenuButton<
                                                        _MenuValues>(
                                                    icon: const Icon(
                                                      Icons.more_vert,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                    itemBuilder: (context) => [
                                                          PopupMenuItem(
                                                              value: _MenuValues
                                                                  .view,
                                                              child: Text(
                                                                'view'.tr,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 12,
                                                                  color: ColorManager
                                                                      .kPrimaryColor,
                                                                ),
                                                              )),
                                                          PopupMenuItem(
                                                              value: _MenuValues
                                                                  .update,
                                                              child: Text(
                                                                'edit'.tr,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 12,
                                                                  color: ColorManager
                                                                      .kPrimaryColor,
                                                                ),
                                                              )),
                                                        ],
                                                    onSelected: (value) async {
                                                      switch (value) {
                                                        case _MenuValues.view:
                                                          Get.to(() =>
                                                              AppointmentDetail(
                                                                configureAppointment:
                                                                    worklocation,
                                                              ));
                                                          break;
                                                        case _MenuValues.update:
                                                          bool res =
                                                              await Get.to(() =>
                                                                  UpdateAppointmentConfiguration(
                                                                    configureAppointment:
                                                                        worklocation,
                                                                  ));

                                                          if (res == true) {
                                                            didChangeDependencies();
                                                          }
                                                          break;
                                                      }
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container());
                            }),
                        // ListView.builder(
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemCount: ConfigureAppointmentController
                        //         .i.workLocationsList.length,
                        //     itemBuilder: (context, index) {
                        //       final worklocation = (ConfigureAppointmentController
                        //               .i.workLocationsList.isNotEmpty)
                        //           ? ConfigureAppointmentController
                        //               .i.workLocationsList[index]
                        //           : null;
                        //       return ((ConfigureAppointmentController
                        //               .i.workLocationsList.isNotEmpty)
                        //           ? Padding(
                        //               padding:
                        //                   const EdgeInsets.symmetric(vertical: 3),
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                   color: ColorManager.kPrimaryColor,
                        //                   borderRadius: BorderRadius.circular(10),
                        //                   boxShadow: [
                        //                     BoxShadow(
                        //                       color: Colors.grey.withOpacity(0.2),
                        //                       spreadRadius: 2,
                        //                       blurRadius: 2,
                        //                       offset: const Offset(0, 2),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.symmetric(
                        //                       vertical: 6),
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceEvenly,
                        //                     children: [
                        //                       Image.asset(
                        //                         AppImages.locations,
                        //                         color: ColorManager.kWhiteColor,
                        //                         alignment: Alignment.centerLeft,
                        //                         scale: 2.5,
                        //                       ),
                        //                       SizedBox(
                        //                         width: Get.width * 0.55,
                        //                         child: Text(
                        //                           worklocation!
                        //                                   .workLocationName ??
                        //                               "",
                        //                           style: GoogleFonts.poppins(
                        //                             fontSize: 12,
                        //                             color:
                        //                                 ColorManager.kWhiteColor,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       SizedBox(
                        //                         width: Get.width * 0.1,
                        //                         child: PopupMenuButton<
                        //                                 _MenuValues>(
                        //                             icon: const Icon(
                        //                               Icons.more_vert,
                        //                               color: Colors.white,
                        //                               size: 30,
                        //                             ),
                        //                             itemBuilder: (context) => [
                        //                                   PopupMenuItem(
                        //                                       value: _MenuValues
                        //                                           .view,
                        //                                       child: Text(
                        //                                         'View',
                        //                                         style: GoogleFonts
                        //                                             .poppins(
                        //                                           fontSize: 12,
                        //                                           color: ColorManager
                        //                                               .kPrimaryColor,
                        //                                         ),
                        //                                       )),
                        //                                   PopupMenuItem(
                        //                                       value: _MenuValues
                        //                                           .update,
                        //                                       child: Text(
                        //                                         'Edit',
                        //                                         style: GoogleFonts
                        //                                             .poppins(
                        //                                           fontSize: 12,
                        //                                           color: ColorManager
                        //                                               .kPrimaryColor,
                        //                                         ),
                        //                                       )),
                        //                                 ],
                        //                             onSelected: (value) async {
                        //                               switch (value) {
                        //                                 case _MenuValues.view:
                        //                                   Get.to(() =>
                        //                                       const AppointmentDetail());
                        //                                   break;
                        //                                 case _MenuValues.update:
                        //                                   Get.to(() =>
                        //                                       const UpdateAppointmentConfiguration());
                        //                                   break;
                        //                               }
                        //                             }),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             )
                        //           : Container());
                        //     }),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "setyouravailabilitytostartattendingpatients".tr,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: ColorManager.kPrimaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        Card(
                          elevation: 4,
                          surfaceTintColor: ColorManager.kWhiteColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "onlinevideoconsultation".tr,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: ColorManager.kPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Transform.scale(
                                  scale: 0.55,
                                  child: Switch(
                                    value: contr.isOnline,
                                    activeColor: ColorManager.kPrimaryColor,
                                    onChanged: (value) {
                                      if (value == true &&
                                          ConfigureAppointmentController
                                                  .i.hasOnlineConsultation ==
                                              true) {
                                        print('aaaaaaaaaaaaaaaaaaaaaa');
                                        showSnackbar(context,
                                            "Already have Online Consultation");
                                      } else {
                                        contr.updateoOnline(value);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ),

                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        Visibility(
                          visible: contr.isOnline == false,
                          child: Card(
                            elevation: 1,
                            color: ColorManager.kPrimaryLightColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "hospitalclinic".tr,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: ColorManager.kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        contr.selectedhospital = null;
                                        HospitalORClinics? generic =
                                            await searchabledropdown(context,
                                                contr.hospitalList ?? []);
                                        contr.selectedhospital = null;
                                        contr.updatehospital(
                                            generic ?? HospitalORClinics());

                                        if (generic != '') {
                                          contr.selectedhospital = generic;
                                          contr.selectedhospital =
                                              (generic == '')
                                                  ? null
                                                  : contr.selectedhospital;
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                "${(contr.selectedhospital != null && contr.selectedhospital?.name != null) ? (contr.selectedhospital!.name!.length > 50 ? ('${contr.selectedhospital?.name!.substring(0, 50 > contr.selectedhospital!.name!.length ? contr.selectedhospital!.name!.length : 50)}...') : contr.selectedhospital?.name) : "selectHospitalClinic".tr}",
                                                // semanticsLabel:
                                                //     "${(contr.selectedhospital != null) ? (contr.selectedhospital!.name!.length > 50 ? ('${contr.selectedhospital?.name!.substring(0, 50 > contr.selectedhospital!.name!.length ? contr.selectedhospital!.name!.length : 50)}...') : contr.selectedhospital) : "Select Hospital/Clinic"}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  color: contr.selectedhospital
                                                              ?.name !=
                                                          null
                                                      ? ColorManager.kblackColor
                                                      : Colors.grey[700],
                                                ),
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
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.03),
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

                        // ConfigureAppointmentListTile(
                        //      dayname: 'Monday', isOpen: false),
                        // ConfigureAppointmentListTile(
                        //     dayname: 'Tuesday', isOpen: false),
                        // ConfigureAppointmentListTile(
                        //     dayname: 'Wednesday', isOpen: false),
                        // ConfigureAppointmentListTile(
                        //     dayname: 'Thursday', isOpen: false),
                        // ConfigureAppointmentListTile(
                        //     dayname: 'Friday', isOpen: false),
                        // ConfigureAppointmentListTile(
                        //     dayname: 'Saturday', isOpen: false),
                        // ConfigureAppointmentListTile(
                        //     dayname: 'Sunday', isOpen: false),

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
                                          child: Switch(
                                            value: contr.switchStates[index],
                                            activeColor:
                                                ColorManager.kPrimaryColor,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: const BorderSide(
                                                    color: ColorManager
                                                        .kPrimaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: const BorderSide(
                                                    color: ColorManager
                                                        .kPrimaryColor,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.03),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 10, top: 10),
                            child: Row(children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: ColorManager.kPrimaryColor,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: Get.width * 0.02,
                                                    right: Get.width * 0.02,
                                                    bottom: Get.height * 0.015),
                                                child: TextField(
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'^\d*\.?\d{0,2}')),
                                                  ],
                                                  controller: contr
                                                      .consultancyfeeController,
                                                  decoration:
                                                      const InputDecoration(
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: ColorManager.kPrimaryColor,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: Get.width * 0.02,
                                                    right: Get.width * 0.02,
                                                    bottom: Get.height * 0.015),
                                                child: TextField(
                                                  controller: contr
                                                      .followupfeeController,
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'^\d*\.?\d{0,2}')),
                                                  ],
                                                  decoration:
                                                      const InputDecoration(
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
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: ColorManager.kPrimaryColor,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            // SizedBox(
                                            //   width: Get.width * 0.06,
                                            // ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: Get.width * 0.02,
                                                    right: Get.width * 0.02,
                                                    bottom: Get.height * 0.015),
                                                child: TextField(
                                                  maxLength: 4,
                                                  controller: contr
                                                      .followupdayController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                                      ApprovalCriteria generic =
                                          await searchabledropdown(context,
                                              contr.approvalCriteriaList ?? []);
                                      contr.updateApprovalCriteria(generic);

                                      if (generic != '') {
                                        contr.selectedApprovalCriteria =
                                            generic;
                                        contr.selectedApprovalCriteria =
                                            (generic == '')
                                                ? null
                                                : contr
                                                    .selectedApprovalCriteria;
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
                                              "${(contr.selectedApprovalCriteria != null && contr.selectedApprovalCriteria?.name != null) ? (contr.selectedApprovalCriteria!.name.length > 50 ? ('${contr.selectedApprovalCriteria?.name.substring(0, 50 > contr.selectedApprovalCriteria!.name.length ? contr.selectedApprovalCriteria!.name.length : 50)}...') : contr.selectedApprovalCriteria?.name) : "SelectApprovalCriteria".tr}",
                                              // semanticsLabel:
                                              //     "${(contr.selectedApprovalCriteria != null) ? (contr.selectedApprovalCriteria!.name.length > 50 ? ('${contr.selectedApprovalCriteria?.name.substring(0, 50 > contr.selectedApprovalCriteria!.name.length ? contr.selectedApprovalCriteria!.name.length : 50)}...') : contr.selectedApprovalCriteria) : "Select Approval Criteria"}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  color:
                                                      ColorManager.kblackColor),
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
                            print(
                                'contr.daylstcontr.daylstcontr.daylstcontr.daylst');
                            print(contr.daylst);

                            String? hospitalid = contr.selectedhospital?.id;
                            String hid = '';
                            if (contr.daylst.isNotEmpty) {
                              if (contr.isOnline == true &&
                                      hospitalid == null ||
                                  contr.isOnline == false &&
                                      hospitalid != null) {
                                String? dit = await LocalDb().getDoctorId();
                                ConfigureAppointmentRepo car =
                                    ConfigureAppointmentRepo();
                                if (_time ==
                                    const TimeOfDay(hour: 0, minute: 0)) {
                                  showSnackbar(
                                      context, "Please select Slot Duration");
                                }
                                // else if (_fromtime ==
                                //     const TimeOfDay(hour: 0, minute: 0)) {
                                //   showSnackbar(
                                //       context, "Please select from time");
                                // } else if (_tilltime ==
                                //     const TimeOfDay(hour: 0, minute: 0)) {
                                //   showSnackbar(
                                //       context, "Please select till time");
                                // }

                                //////
                                // if (_time !=
                                //         const TimeOfDay(hour: 0, minute: 0) &&
                                //     _fromtime !=
                                //         const TimeOfDay(hour: 0, minute: 0) &&
                                //     _tilltime !=
                                //         const TimeOfDay(hour: 0, minute: 0)
                                //         )

                                if (_time !=
                                    const TimeOfDay(hour: 0, minute: 0)) {
                                  hospitalid ??= "";
                                  if (checkSlotDuration(
                                      _fromtime, _tilltime, _time)) {
                                    String? res =
                                        await car.addAppointmentConfiguration(
                                      contr.selectedApprovalCriteria!.id,
                                      hospitalid,
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
                                      contr.isOnline,
                                      true,
                                    );

                                    if (res == 'true') {
                                      await ConfigureAppointmentController.i
                                          .updateIsloading(true);
                                      await contr.updatedispose();
                                      await disposedatepicker();
                                      await _getAppointmentConfiguration();
                                      setState(() {});
                                      await ConfigureAppointmentController.i
                                          .updateIsloading(false);
                                    }
                                  } else {
                                    showSnackbar(
                                        context, "Slot Duration is incorrect");
                                  }
                                }
                              } else {
                                showSnackbar(context,
                                    "Select Hospital or enable online consultation");
                              }
                            } else {
                              showSnackbar(context, "Select at least One Day");
                            }
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
                                'save'.tr,
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
          )),
    );
  }
}
