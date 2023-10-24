import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/controller/ManageAppointments_Controller.dart';
import '../../helpers/color_manager.dart';
import '../../helpers/font_manager.dart';
import '../../utils/AppImages.dart';
import '_DailyDetailAppointment.dart';
import '_DetailMonthlyAppointment.dart';

class DailyViewAppointments extends StatefulWidget {
  String? dateTime;
  String? IsOnline;
  String? WorkLocationId;
  DailyViewAppointments(
      {super.key, this.dateTime, this.IsOnline, this.WorkLocationId});

  @override
  State<DailyViewAppointments> createState() => _TodayAppointmentsState();
}

class _TodayAppointmentsState extends State<DailyViewAppointments> {
  late List<Widget> pages;
  @override
  void initState() {
    pages = [
      DailyDetailAppointment(
          dateTime: widget.dateTime,
          IsOnline: widget.IsOnline,
          WorkLocationId: widget.WorkLocationId),
      const DetailMonthlyAppointment()
    ];
    super.initState();
  }

  @override
  void dispose() {
    ManageAppointmentController.i.date = null;
    super.dispose();
  }

  bool isFirstTabSelected = true;

  void _toggleTabSelection() {
    setState(() {
      isFirstTabSelected = !isFirstTabSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    var contr =
        Get.put<ManageAppointmentController>(ManageAppointmentController());
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: ColorManager.kPrimaryColor,
            onPressed: () {
              Get.back();
            },
          ),
          title: GetBuilder<ManageAppointmentController>(
            builder: (con) {
              return Text(
                contr.index == 0
                    ? 'dayviewappointments'.tr
                    : 'monthlyviewappointments'.tr,
                style: GoogleFonts.poppins(
                  textStyle: GoogleFonts.poppins(
                    fontSize: 17,
                    color: ColorManager.kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: GetBuilder<ManageAppointmentController>(builder: (cont) {
          return BlurryModalProgressHUD(
              inAsyncCall: cont.isLoadingDailyDoctorAppointmentSlots,
              blurEffectIntensity: 4,
              progressIndicator: const SpinKitSpinningLines(
                color: Color(0xfff1272d3),
                size: 60,
              ),
              dismissible: false,
              opacity: 0.4,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(children: [
                    SingleChildScrollView(
                      child: Visibility(
                        visible: true,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      Images.logoBackground,
                                    ),
                                  ),
                                ),
                                width: double.maxFinite,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cont.setPageIndexofDayViewAppointment(
                                            0);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: cont.index == 0
                                              ? const Color(0xfff1272d3)
                                              : ColorManager.kWhiteColor,
                                          border: Border.all(
                                            color: const Color(0xfff1272d3),
                                            width: 2,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        child: Center(
                                            child: Text('daily'.tr,
                                                style: GoogleFonts.poppins(
                                                    color: cont.index == 1
                                                        ? const Color(
                                                            0xfff1272d3)
                                                        : ColorManager
                                                            .kWhiteColor,
                                                    fontSize: 16))),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cont.setPageIndexofDayViewAppointment(
                                            1);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: cont.index == 1
                                              ? const Color(0xfff1272d3)
                                              : ColorManager.kWhiteColor,
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                          border: Border.all(
                                            color: const Color(0xfff1272d3),
                                            width: 2,
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        child: Center(
                                            child: Text('monthly'.tr,
                                                style: GoogleFonts.poppins(
                                                    color: cont.index == 0
                                                        ? const Color(
                                                            0xfff1272d3)
                                                        : ColorManager
                                                            .kWhiteColor,
                                                    fontSize: 16))),
                                      ),
                                    ),
                                  ],
                                ))),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.90,
                        child: pages[cont.index]),
                  ]),
                ),
              ));
        }));
  }
}
