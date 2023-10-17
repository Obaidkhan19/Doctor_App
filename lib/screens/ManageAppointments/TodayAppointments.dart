import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../data/controller/ManageAppointments_Controller.dart';
import '../../helpers/color_manager.dart';
import '../../helpers/font_manager.dart';
import '../../helpers/values_manager.dart';
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

  call() async
  {
    ManageAppointmentController.i.getDailyDoctorAppointment();
  }

  @override
  Widget build(BuildContext context) {
    var contr =
        Get.put<ManageAppointmentController>(ManageAppointmentController());
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              AppImages.back,
            ),
          ),
          title: Center(
            child: Text(
              'todayappointment'.tr,
              style: GoogleFonts.raleway(
                textStyle: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.kPrimaryColor),
              ),
            ),
          ),
          // actions: const [
          //   Text(
          //     'd    ',
          //     style: TextStyle(color: Colors.white, fontSize: 0.5),
          //   )
          // ],
          backgroundColor: Colors.transparent,
        ),
        body: GetBuilder<ManageAppointmentController>(builder: (cont) {
          return BlurryModalProgressHUD(
              inAsyncCall: cont.isLoadingDailyDoctorAppointment,
              blurEffectIntensity: 4,
              progressIndicator: const SpinKitSpinningLines(
                color: Color(0xfff1272d3),
                size: 60,
              ),
              dismissible: false,
              opacity: 0.4,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SingleChildScrollView(
                  child: SafeArea(
                minimum: const EdgeInsets.all(AppPadding.p22).copyWith(top: 0),
                child: Column(children: [
                  (ManageAppointmentController.i.dailyDoctorAppointmentsModel
                              .onlineAppointmentStatistics !=
                          null)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
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
                                  blurRadius: 2, // Blur radius of the shadow
                                  offset: const Offset(
                                      0, 2), // Offset of the shadow
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
                                // List<Search> search =
                                //     await SpecialitiesController.i
                                //         .getDoctors(doctor.id!);
                                // Get.to(() => Specialists(
                                //       doctors: search,
                                //       title: doctor.name,
                                //     ));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              leading: Image.asset(
                                AppImages.online,
                              ),
                              title: Text(
                                ManageAppointmentController
                                        .i
                                        .dailyDoctorAppointmentsModel
                                        .onlineAppointmentStatistics
                                        ?.location
                                        .toString() ??
                                    "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: ColorManager.kWhiteColor,
                                        fontWeight: FontWeightManager.bold),
                              ),
                              subtitle: Text(
                                ManageAppointmentController
                                        .i
                                        .dailyDoctorAppointmentsModel
                                        .onlineAppointmentStatistics
                                        ?.address
                                        .toString() ??
                                    "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: ColorManager.kWhiteColor,
                                        fontWeight: FontWeightManager.light,
                                        fontSize: 12),
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
                                            fontWeight: FontWeightManager.light,
                                            fontSize: 20),
                                  ),
                                  Text(
                                    " | ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: ColorManager.kWhiteColor,
                                            fontWeight: FontWeightManager.light,
                                            fontSize: 20),
                                  ),
                                  const Icon(
                                    Icons.navigate_next_outlined,
                                    size: 20.0, // Adjust icon size as needed
                                    color: ColorManager.kWhiteColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(
                          child: const Text('No Data'),
                        ),
                  (ManageAppointmentController.i.dailyDoctorAppointmentsModel
                              .appointmentStatistics !=
                          null)
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ((ManageAppointmentController
                                      .i
                                      .dailyDoctorAppointmentsModel
                                      .appointmentStatistics !=
                                  null)
                              ? ManageAppointmentController
                                  .i
                                  .dailyDoctorAppointmentsModel
                                  .appointmentStatistics
                                  ?.length
                              : 1),
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .white, // Set the background color of the container
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.2), // Shadow color
                                            spreadRadius:
                                                2, // Spread radius of the shadow
                                            blurRadius:
                                                2, // Blur radius of the shadow
                                            offset: const Offset(
                                                0, 2), // Offset of the shadow
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          DateTime Dates = DateTime.now();
                                          String Date = DateFormat('yyyy-MM-dd')
                                              .format(Dates);

                                          ManageAppointmentController.i
                                              .getDailyDoctorAppointmentSlots(
                                                  Date.toString(),
                                                  'false',
                                                  manageAppointment
                                                      .workLocationId
                                                      .toString());

                                          Get.to(() => DailyViewAppointments(
                                              dateTime: Date.toString(),
                                              IsOnline: 'false',
                                              WorkLocationId: manageAppointment
                                                  .workLocationId));
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        leading: Image.asset(
                                          AppImages.locations,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        title: Text(
                                          manageAppointment.location ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color:
                                                      ColorManager.kblackColor,
                                                  fontWeight:
                                                      FontWeightManager.bold),
                                        ),
                                        subtitle: Text(
                                          manageAppointment.address ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeightManager.light,
                                                  fontSize: 12),
                                        ),
                                        trailing: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${manageAppointment.noofAppointments ?? ""}',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue),
                                            ),
                                            const Text(
                                              " | ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue),
                                            ),
                                            const Icon(
                                              Icons.navigate_next_outlined,
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
                        )
                ]),
              )));
        }));
  }
}
