import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/preference_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/controller/specialities_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/ConsultingQueue.dart';
import 'package:doctormobileapplication/screens/book_your_appointment/book_your_appointment.dart';
import 'package:doctormobileapplication/screens/dashboard/notification.dart';
import 'package:doctormobileapplication/screens/consulted_vault/appointment_history.dart';
import 'package:doctormobileapplication/screens/appointment_configuration/configure_appointments.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/localDB/local_db.dart';
import '../../data/repositories/specialities_repo/specialities_repo.dart';
import '../../models/online_statuS.dart';
import '../ManageAppointments/TodayAppointments.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var profileContr = Get.put<ProfileController>(ProfileController());

  //String name = '';
  // String pmdcno = "";
  _getUserName() async {
    profileContr.value = ((await LocalDb().getOnlineStatus())!);
    if (profileContr.value == 0) {
      profileContr.status = "iamoffline".tr;
    } else if (profileContr.value == 1) {
      profileContr.status = "iamonline".tr;
    }

    // setState(() {});
  }

  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  String imagepath = '';
  String path = '';

  _getimagepath() async {
    path = ProfileController.i.selectedbasicInfo?.picturePath ?? "";
    String baseurl = baseURL;
    imagepath = baseurl + path;
  }

  @override
  void initState() {
    _getDoctorBasicInfo();
    _getUserName();
    _getimagepath();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: Get.width * 0.2,
        leading: InkWell(
          onTap: () {
            if (ZoomDrawer.of(context)!.isOpen()) {
              ZoomDrawer.of(context)!.close();
            } else {
              ZoomDrawer.of(context)!.open();
            }
          },
          child: Container(
            alignment: Alignment.center, // use aligment
            color: ColorManager.kWhiteColor,
            child: Image.asset(
              Images.menuIcon,
              height: 27,
              width: 27,
              fit: BoxFit.contain,
              color: ColorManager.kPrimaryColor,
            ),
          ),
        ),
        toolbarHeight: Get.height * 0.1,
        centerTitle: true,
        // title: SizedBox(
        //     width: Get.width * 0.4,
        //     height: Get.height * 9.97,
        //     child: Image.asset(Images.logo)),
        title: Image.asset(
          Images.logo,
          height: Get.height * 0.07,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    Get.to(() => const NotificationScreen());
                  },
                  child: Image.asset(
                    Images.notification,
                    height: Get.height * 0.035,
                    color: ColorManager.kPrimaryColor,
                  )),
              const SizedBox(
                width: AppPadding.p24,
              ),
            ],
          ),
        ],
      ),
      body: GetBuilder<ProfileController>(builder: (cont) {
        return SafeArea(
          minimum:
              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05)
                  .copyWith(top: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.01, vertical: Get.width * 0.03),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xff1272D3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<ProfileController>(builder: (context) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromRGBO(0, 0, 0, 0),
                                radius: 30,
                                child: CachedNetworkImage(
                                  imageUrl: ProfileController.i
                                              .selectedbasicInfo?.picturePath !=
                                          null
                                      ? baseURL +
                                          ProfileController
                                              .i.selectedbasicInfo?.picturePath
                                      : "",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // fit: BoxFit.fitHeight,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(AppImages.doctorlogo),
                                )));

                        // CircleAvatar(
                        //     backgroundColor:
                        //         const Color.fromRGBO(0, 0, 0, 0),
                        //     radius: 30,
                        //     child: ClipRRect(
                        //         borderRadius: BorderRadius.circular(30),
                        //         child: CachedNetworkImage(
                        //           imageUrl: ProfileController
                        //                       .i
                        //                       .selectedbasicInfo
                        //                       ?.picturePath !=
                        //                   null
                        //               ? baseURL +
                        //                   ProfileController
                        //                       .i
                        //                       .selectedbasicInfo
                        //                       ?.picturePath
                        //               : "",
                        //           fit: BoxFit.fill,
                        //           errorWidget: (context, url, error) =>
                        //               Image.asset(AppImages.doctorlogo),
                        //         )));
                      }),
                      SizedBox(
                        width: Get.width * 0.04,
                      ),
                      SizedBox(
                        width: Get.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width * 0.5,
                              child: Text(
                                ProfileController
                                        .i.selectedbasicInfo?.fullName ??
                                    "",
                                style: GoogleFonts.poppins(
                                  color: ColorManager.kWhiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            GetBuilder<PreferenceController>(
                              builder: (cont) => Text(
                                //   '${''}${'regno'.tr}${ProfileController.i.selectedbasicInfo?.pMDCNumber ?? ""}',
                                '${PreferenceController.i.preferenceObject.doctorRegistrationNoDynamicLabel == null || PreferenceController.i.preferenceObject.doctorRegistrationNoDynamicLabel == "null" ? MedicalNumberLabel : PreferenceController.i.preferenceObject.doctorRegistrationNoDynamicLabel} ${''}${'no'.tr}${' '}${ProfileController.i.selectedbasicInfo?.pMDCNumber ?? ""}',
                                style: GoogleFonts.poppins(
                                  color: ColorManager.kWhiteColor,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.01,
                ),
                Row(
                  children: [
                    Container(
                      height: Get.height * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff1272D3),
                                Color(0xff001D86),
                              ])),
                      width: Get.width * 0.45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () {
                          Get.to(() => const ConsultingQueue());
                          // Get.to(const ConsultingQueueScreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.015,
                              bottom: Get.height * 0.015),
                          child: Text('consultingqueue'.tr,
                              //textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: ColorManager.kWhiteColor)),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.height * 0.008),
                    SizedBox(
                      width: Get.width * 0.43,
                      height: Get.height * 0.08,
                      child: ElevatedButton(
                        onPressed: () async {
                          var doctorId = await LocalDb().getDoctorId();
                          var branchId = await LocalDb().getBranchId();
                          var token = await LocalDb().getToken();
                          OnlineStatusRequest call = OnlineStatusRequest(
                              branchId: "$branchId",
                              doctorId: "$doctorId",
                              token: "$token",
                              isOnline: (profileContr.value == 0 ? true : false)
                                  .toString());
                          log(call.toJson().toString());
                          profileContr.value =
                              await SpecialitiesRepo.getStatuses(call);
                          setState(() {
                            if (profileContr.value == 1) {
                              LocalDb().saveOnlineStatus(profileContr.value);
                              profileContr.status = "iamonline".tr;
                            } else {
                              LocalDb().saveOnlineStatus(0);
                              profileContr.status = "iamoffline".tr;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (profileContr.value == 1)
                              ? const Color(0xff00BE4C)
                              : const Color(
                                  0xffcd0000), // Set the background color
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.015,
                              bottom: Get.height * 0.015),
                          child: Text(
                              profileContr.value == 1
                                  ? "iamonline".tr
                                  : "iamoffline".tr,

                              // profileContr
                              //     .status
                              //     .toLowerCase()
                              //     .replaceAll(' ', '')
                              //     .tr,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: ColorManager.kWhiteColor)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(
                    //   width: Get.width * 0.45,
                    //   height: Get.height * 0.25,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Get.to(const ConfigureAppointmentScreen());
                    //     },
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Image.asset(
                    //           Images.ConfiguationAppointment,
                    //           height: Get.height * 0.1,
                    //         ),
                    //         SizedBox(
                    //           height: Get.height * 0.01,
                    //         ),
                    //         Text('configureappointments'.tr,
                    //             textAlign: TextAlign.center,
                    //             style: GoogleFonts.poppins(
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 12,
                    //                 color: ColorManager.kWhiteColor)),
                    //         SizedBox(
                    //           height: Get.height * 0.005,
                    //         ),
                    //         Text('adjustyourschedule'.tr,
                    //             textAlign: TextAlign.center,
                    //             style: GoogleFonts.poppins(
                    //                 fontSize: 10,
                    //                 color: ColorManager.kWhiteColor))
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Container(
                      width: Get.width * 0.45,
                      height: Get.height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.kPrimaryColor),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () {
                          Get.to(() => const ConfigureAppointmentScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.configuationAppointment,
                              height: Get.height * 0.1,
                              width: Get.width * 0.3,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text('configureappointments'.tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: ColorManager.kWhiteColor)),
                            SizedBox(
                              height: Get.height * 0.005,
                            ),
                            Text('adjustyourschedule'.tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: ColorManager.kWhiteColor))
                          ],
                        ),
                      ),
                    ),

                    Container(
                      width: Get.width * 0.43,
                      height: Get.height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xffFDD504),
                                Color(0xffFCB006),
                              ])),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () {
                          Get.to(() => const TodayAppointments());
                          //Get.to(() => DailyViewAppointments());
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.015,
                              bottom: Get.height * 0.015),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Images.managementAppointment,
                                height: Get.height * 0.1,
                                width: Get.width * 0.3,
                              ),
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              Text('manageappointments'.tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: ColorManager.kWhiteColor)),
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              Text('approve/aisapproveappointments'.tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: ColorManager.kWhiteColor))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: Get.height * 0.01,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(

                    //   width: Get.width * 0.45,
                    //   height: Get.height * 0.25,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       // Get.to(() => NoDataFound(
                    //       //       Title: 'Consulted Vault',
                    //       //     ));

                    //       //  Get.to(() => const PastConsultation());
                    //       Get.to(const AppointmentHistoryscreen());
                    //     },
                    //     child: Padding(
                    //       padding: EdgeInsets.only(
                    //           top: Get.height * 0.015,
                    //           bottom: Get.height * 0.015),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset(
                    //             Images.ConsultedVault,
                    //             height: Get.height * 0.1,
                    //           ),
                    //           SizedBox(
                    //             height: Get.height * 0.01,
                    //           ),
                    //           Text('consultedvault'.tr,
                    //               textAlign: TextAlign.center,
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .bodyMedium
                    //                   ?.copyWith(
                    //                       color: ColorManager.kWhiteColor,
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.bold)),
                    //           SizedBox(
                    //             height: Get.height * 0.005,
                    //           ),
                    //           Text('viewconsultations'.tr,
                    //               textAlign: TextAlign.center,
                    //               style: GoogleFonts.poppins(
                    //                   fontSize: 10,
                    //                   color: ColorManager.kWhiteColor))
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      width: Get.width * 0.45,
                      height: Get.height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.kPrimaryColor),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () {
                          Get.to(const AppointmentHistoryscreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.consultedVault,
                              height: Get.height * 0.1,
                              width: Get.width * 0.3,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text('consultedvault'.tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: ColorManager.kWhiteColor)),
                            SizedBox(
                              height: Get.height * 0.005,
                            ),
                            Text('viewconsultations'.tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: ColorManager.kWhiteColor))
                          ],
                        ),
                      ),
                    ),

                    Container(
                      width: Get.width * 0.43,
                      height: Get.height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(colors: [
                            Color(0xffFF4D4D),
                            Color(0xffFF7B7B),
                          ])),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "ComingSoon".tr,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: ColorManager.kPrimaryLightColor,
                              textColor: ColorManager.kPrimaryColor,
                              fontSize: 14.0);
                          //  Get.to(const HealthSummaryScreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.015,
                              bottom: Get.height * 0.015),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Images.healthSummry,
                                height: Get.height * 0.1,
                                width: Get.width * 0.3,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Text('healthsummary'.tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: ColorManager.kWhiteColor)),
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              Text('patientmonitoring'.tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: ColorManager.kWhiteColor))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // SizedBox(
                //   height: Get.height * 0.01,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: Container(
                //         height:Get.height*0.15,
                //         decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         gradient: LinearGradient(colors: [
                //            Color(0xffA6FFC9),Color(0xff1272D3),
                //         ])
                //       ),
                //         child: ElevatedButton(

                //            style: ElevatedButton.styleFrom(
                //             elevation: 0.0,
                //                         backgroundColor: Colors.transparent,
                //                         shadowColor: Colors.transparent),
                //           // style: ElevatedButton.styleFrom(as
                //           //     backgroundColor: Color(0xffA6FFC9)),
                //           onPressed: () {
                //             Get.to(() => NoDataFound(
                //                   Title: 'assessmentform'.tr,
                //                 ));
                //           },
                //           child: Padding(
                //             padding: EdgeInsets.only(
                //                 top: Get.height * 0.02,
                //                 bottom: Get.height * 0.02),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Text('assessmentform'.tr,
                //                     textAlign: TextAlign.center,
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .bodyMedium
                //                         ?.copyWith(
                //                             color: ColorManager.kWhiteColor,
                //                             fontSize: 14,
                //                             fontWeight: FontWeight.bold)),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // Text(
                //   'Services',
                //   style: Theme.of(context)
                //       .textTheme
                //       .titleLarge
                //       ?.copyWith(color: ColorManager.kPrimaryColor, fontSize: 14),
                // ),
                // SizedBox(
                //   height: Get.height * 0.01,
                // ),
                // CarouselSlider.builder(
                //     carouselController: CarouselController(),
                //     itemCount: services.length,
                //     itemBuilder: (context, index, realIndex) {
                //       final service = services[index];
                //       return InkWell(
                //         onTap: service.onPressed,
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 5),
                //           child: Center(
                //             child: Container(
                //               padding: const EdgeInsets.symmetric(horizontal: 5),
                //               alignment: Alignment.center,
                //               decoration: BoxDecoration(
                //                   color: service.color,
                //                   borderRadius: BorderRadius.circular(10)),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Image.asset(service.imagePath!),
                //                   SizedBox(
                //                     height: Get.height * 0.02,
                //                   ),
                //                   Flexible(
                //                     child: Text(service.title!,
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .bodyMedium
                //                             ?.copyWith(
                //                                 color: ColorManager.kWhiteColor,
                //                                 fontSize: 10,
                //                                 fontWeight: FontWeight.w900)),
                //                   )
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //     options: CarouselOptions(
                //       initialPage: 2,
                //       aspectRatio: 16 / 9,
                //       enableInfiniteScroll: false,
                //       height: Get.height * 0.18,
                //       viewportFraction: 0.37,
                //       onPageChanged: (index, reason) {
                //         setState(() {
                //           pageIndex = index;
                //         });
                //       },
                //     )),
                // SizedBox(
                //   height: Get.height * 0.02,
                // ),
                // DotsIndicatorRow(
                //   pageIndex: pageIndex,
                //   activeColor: ColorManager.kPrimaryColor,
                //   inactiveColor: const Color(0xFFDBEAF8),
                // ),
                // SizedBox(
                //   height: Get.height * 0.015,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: PrimaryButton(
                //         height: Get.height * 0.09,
                //         icon: Image.asset(Images.reports),
                //         title: 'Reports',
                //         fontSize: 12,
                //         onPressed: () {
                //           Get.to(() => NoDataFound());
                //         },
                //         color: ColorManager.kPrimaryColor,
                //         textcolor: ColorManager.kWhiteColor,
                //         primaryIcon: true,
                //       ),
                //     ),
                //     SizedBox(
                //       width: Get.width * 0.02,
                //     ),
                //     Expanded(
                //       child: PrimaryButton(
                //         height: Get.height * 0.09,
                //         icon: Image.asset(Images.docs),
                //         title: 'Packages',
                //         fontSize: 12,
                //         onPressed: () {
                //           Get.to(() => NoDataFound());
                //         },
                //         color: ColorManager.kyellowContainer,
                //         textcolor: ColorManager.kblackColor,
                //         primaryIcon: true,
                //       ),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                //  availableDoctor(context),
                //   const SizedBox(
                //     height: 20,
                //   )
              ],
            ),
          ),
        );
      }),
    );
  }

  availableDoctor(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFDBEAF8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(Get.height * 0.02),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(Images.profile)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: ColorManager.kPrimaryColor),
                          child: Text(
                            'Today Available | 09:00 - 13:00',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 12,
                                    color: ColorManager.kWhiteColor),
                          ),
                        ),
                      ),
                      Text(
                        'Dr. Sheikh Hamid',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Get.width * 0.3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorManager.kPrimaryColor),
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p4)
                                  .copyWith(left: AppPadding.p8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'General Consultation',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: ColorManager.kWhiteColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Text(
                                    '10:00 AM',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: ColorManager.kWhiteColor,
                                            fontSize: 10,
                                            fontFamily:
                                                GoogleFonts.mitr().fontFamily),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.05,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: ColorManager.kyellowContainer),
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: FittedBox(
                                child: Text(
                              'Token \n N/A',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeightManager.bold),
                            )),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                children: [
                  Container(
                    width: Get.width * 0.2,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(AppPadding.p4),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(5)),
                        color: ColorManager.kyellowContainer),
                    child: const Text('100'),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Online',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ColorManager.kDarkBlue),
                  )
                ],
              )
            ],
          ),
        ),
        // Positioned(
        //     bottom: -20,
        //     right: 10,
        //     child: Container(
        //       height: Get.height * 0.08,
        //       decoration: BoxDecoration(
        //           color: ColorManager.kPrimaryColor,
        //           borderRadius: BorderRadius.circular(15),
        //           border: Border.all(
        //             width: 5,
        //             color: Colors.white,
        //           )),
        //       child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //               elevation: 10,
        //               side: BorderSide(
        //                   width: 1, color: ColorManager.kPrimaryColor),
        //               backgroundColor: ColorManager.kWhiteColor),
        //           onPressed: () {
        //             Get.to(() => NoDataFound());
        //           },
        //           child: Text(
        //             'Get Appointment',
        //             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //                 color: ColorManager.kPrimaryColor,
        //                 fontWeight: FontWeight.bold),
        //           )),
        //     ))
      ],
    );
  }

  bookAppointmentContainer(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          Images.container,
          width: Get.width,
          fit: BoxFit.cover,
          height: Get.height * 0.2,
        ),
        Positioned(
            bottom: 0,
            child: Image.asset(
              Images.docImage,
              fit: BoxFit.contain,
              height: Get.height * 0.4,
              width: Get.width * 0.4,
              alignment: Alignment.bottomCenter,
            )),
        Positioned(
            top: 0,
            right: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: Get.width * 0.2,
                    child: Text(
                      'Online & Offline',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorManager.kWhiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  'Consulation',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorManager.kyellowContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                )
              ],
            )),
        Positioned(
          bottom: -15,
          right: 20,
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.kWhiteColor, width: 7),
                  color: ColorManager.kWhiteColor,
                  borderRadius: BorderRadius.circular(10)),
              child: PrimaryButton(
                height: Get.height * 0.06,
                title: 'Book Now',
                onPressed: () async {
                  await SpecialitiesController.i.getSpecialities();
                  Get.to(() => const BookyourAppointment());
                },
                color: ColorManager.kPrimaryColor,
                textcolor: ColorManager.kWhiteColor,
                fontSize: 12,
                width: Get.width * 0.3,
              ),
            ),
          ),
        )
      ],
    );
  }
}
