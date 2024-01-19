import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/preference_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/ConsultingQueue.dart';
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
              scale: 2,
              fit: BoxFit.contain,
              color: ColorManager.kPrimaryColor,
            ),
          ),
        ),
        toolbarHeight: Get.height * 0.1,
        centerTitle: true,
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
              SizedBox(
                width: Get.width * 0.05,
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
                      borderRadius: BorderRadius.circular(Get.width * 0.03)),
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
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  // fit: BoxFit.fitHeight,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(AppImages.doctorlogo),
                                )));
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
                              width: boolisMobile!
                                  ? Get.width * 0.5
                                  : Get.width * 1,
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
                if (boolisMobile!)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: Get.height * 0.08,
                        width: Get.width * 0.45,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.03),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff1272D3),
                                  Color(0xff001D86),
                                ])),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          onPressed: () {
                            Get.to(() => const ConsultingQueue());
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
                      Container(
                        height: Get.height * 0.08,
                        width: Get.width * 0.43,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Get.width * 0.03),
                          color: (profileContr.value == 1)
                              ? const Color(0xff00BE4C)
                              : const Color(0xffcd0000),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          onPressed: () async {
                            var doctorId = await LocalDb().getDoctorId();
                            var branchId = await LocalDb().getBranchId();
                            var token = await LocalDb().getToken();
                            OnlineStatusRequest call = OnlineStatusRequest(
                                branchId: "$branchId",
                                doctorId: "$doctorId",
                                token: "$token",
                                isOnline:
                                    (profileContr.value == 0 ? true : false)
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
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: Get.height * 0.015,
                                bottom: Get.height * 0.015),
                            child: Text(
                                profileContr.value == 1
                                    ? "iamonline".tr
                                    : "iamoffline".tr,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: ColorManager.kWhiteColor)),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (!boolisMobile!)
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: Get.height * 0.15,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.03),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff1272D3),
                                    Color(0xff001D86),
                                  ])),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                            onPressed: () {
                              Get.to(() => const ConsultingQueue());
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
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Expanded(
                        child: Container(
                          height: Get.height * 0.15,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.03),
                            color: (profileContr.value == 1)
                                ? const Color(0xff00BE4C)
                                : const Color(0xffcd0000),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                            onPressed: () async {
                              var doctorId = await LocalDb().getDoctorId();
                              var branchId = await LocalDb().getBranchId();
                              var token = await LocalDb().getToken();
                              OnlineStatusRequest call = OnlineStatusRequest(
                                  branchId: "$branchId",
                                  doctorId: "$doctorId",
                                  token: "$token",
                                  isOnline:
                                      (profileContr.value == 0 ? true : false)
                                          .toString());
                              log(call.toJson().toString());
                              profileContr.value =
                                  await SpecialitiesRepo.getStatuses(call);
                              setState(() {
                                if (profileContr.value == 1) {
                                  LocalDb()
                                      .saveOnlineStatus(profileContr.value);
                                  profileContr.status = "iamonline".tr;
                                } else {
                                  LocalDb().saveOnlineStatus(0);
                                  profileContr.status = "iamoffline".tr;
                                }
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: Get.height * 0.015,
                                  bottom: Get.height * 0.015),
                              child: Text(
                                  profileContr.value == 1
                                      ? "iamonline".tr
                                      : "iamoffline".tr,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: ColorManager.kWhiteColor)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                if (boolisMobile!)
                  Wrap(
                    runSpacing: 10,
                    spacing: 7,
                    children: [
                      Container(
                        width: Get.width * 0.45,
                        height: Get.height * 0.25,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.03),
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
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.03),
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
                      Container(
                        width: Get.width * 0.45,
                        height: Get.height * 0.25,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.03),
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
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.03),
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
                                backgroundColor:
                                    ColorManager.kPrimaryLightColor,
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
                if (!boolisMobile!)
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: Get.height * 0.35,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.03),
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
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Expanded(
                        child: Container(
                          height: Get.height * 0.35,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.03),
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
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Expanded(
                        child: Container(
                          height: Get.height * 0.35,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.03),
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
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Expanded(
                        child: Container(
                          height: Get.height * 0.35,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.03),
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
                                  backgroundColor:
                                      ColorManager.kPrimaryLightColor,
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
                      ),
                    ],
                  ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
