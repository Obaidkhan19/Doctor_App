import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/consultingQueue_repo.dart';
import 'package:doctormobileapplication/models/cosultingqueuepatient.dart';
import 'package:doctormobileapplication/screens/appointment_configuration/configure_appointment_listtile.dart';
import 'package:doctormobileapplication/screens/dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../data/controller/ConsultingQueue_Controller.dart';
import '../../helpers/color_manager.dart';
import '../../helpers/values_manager.dart';
import '../../utils/AppImages.dart';
import 'ClinicalPracticeQueueDataList.dart';
import 'ConsultedQueueDataList.dart';
import 'HoldQueueDataList.dart';

class ConsultingQueue extends StatefulWidget {
  const ConsultingQueue({super.key});

  @override
  State<ConsultingQueue> createState() => _ConsultingQueueState();
}

class _ConsultingQueueState extends State<ConsultingQueue>
    with TickerProviderStateMixin {
  @override
  void initState() {
    ConsultingQueueController.i.updatedate(DateTime.now());
    callback();
    super.initState();
  }

  callback() async {
    ConsultingQueueController.i.updateconsultinglist(
        ConsultingQueueRepo.getpatientconsultingqueue(consultingqueuepatients(
            branchId: "",
            doctorId: await LocalDb().getDoctorId(),
            search: "",
            workLocationId: "",
            status: "1",
            fromDate: DateTime.now().toString().split(' ')[0],
            toDate: DateTime.now().toString().split(' ')[0],
            isOnline: "false",
            token: "",
            start: "0",
            length: "10",
            orderColumn: "0",
            orderDir: "desc")));
  }

  String? SelectedDate;

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<ConsultingQueueController>(ConsultingQueueController());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                'Consulting Queue',
                style: GoogleFonts.raleway(
                  textStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            // actions: const [],
            automaticallyImplyLeading: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: GetBuilder<ConsultingQueueController>(builder: (cont) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.helpful_background_logo),
                  alignment: Alignment.center,
                ),
              ),
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    SafeArea(
                      minimum: const EdgeInsets.only(
                        right: AppPadding.p14,
                        left: AppPadding.p14,
                        top: AppPadding.p14,
                        bottom: AppPadding.p10,
                      ).copyWith(top: 0),
                      child: Column(
                        children: [
                          // here add Date
                          // Container(
                          //   height: Get.height * 0.13,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(8),
                          //       color: ColorManager.kPrimaryLightColor),
                          //   child: DatePicker(
                          //     DateTime.now(),
                          //     dateTextStyle: Theme.of(context)
                          //         .textTheme
                          //         .bodyMedium!
                          //         .copyWith(
                          //             color: ColorManager.kPrimaryColor,
                          //             fontWeight: FontWeight.w700),
                          //     dayTextStyle: Theme.of(context)
                          //         .textTheme
                          //         .bodyMedium!
                          //         .copyWith(
                          //             color: ColorManager.kPrimaryColor,
                          //             fontWeight: FontWeight.w100),
                          //     monthTextStyle: Theme.of(context)
                          //         .textTheme
                          //         .bodyMedium!
                          //         .copyWith(
                          //             color: ColorManager.kPrimaryColor,
                          //             fontWeight: FontWeight.w100),
                          //     deactivatedColor: ColorManager.kPrimaryLightColor,
                          //     height: Get.height * 0.15,
                          //     initialSelectedDate: DateTime.now(),
                          //     selectionColor: ColorManager.kPrimaryColor,
                          //     selectedTextColor: Colors.white,
                          //     onDateChange: (date) {
                          //       String Date =
                          //           DateFormat('yyyy-MM-dd').format(date);
                          //       ConsultingQueueController.i.updatedate(date);
                          //       SelectedDate = Date;
                          //       // ManageAppointmentController.i
                          //       //     .getDailyDoctorAppointmentSlots(
                          //       //         Date.toString(),
                          //       //         widget.IsOnline.toString(),
                          //       //         widget.WorkLocationId.toString());
                          //     },
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: Get.height * 0.02,
                          // ),
                          TabBar(
                            padding: const EdgeInsets.all(0),
                            labelPadding:
                                const EdgeInsets.only(left: 0, right: 0),
                            indicator: const UnderlineTabIndicator(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.blue,
                                ),
                                insets: EdgeInsets.only(left: 0, right: 8)),
                            indicatorSize: TabBarIndicatorSize.tab,
                            onTap: (index) {
                              FocusScope.of(context).unfocus();
                              print(index);
                            },
                            tabs: [
                              Tab(
                                child: Text(
                                  'Clinical Practice',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: ColorManager.kblackColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Hold',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: ColorManager.kblackColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Consulted',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: ColorManager.kblackColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: Get.height * 0.01,
                          // ),
                          // const Divider(
                          //   height: 1.5,
                          //   color: ColorManager.kDarkBlue,
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.72,
                      // width: double.infinity,
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ClinicalPracticeQueueDataList(Status: "1"),
                            HoldQueueDataList(Status: "2"),
                            ConsultedQueueDataList(Status: "3"),
                          ]),
                    ),
                  ],
                ),
              )),
            );
          })),
    );
  }
}
