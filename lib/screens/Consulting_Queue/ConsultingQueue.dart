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

    super.initState();
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
            centerTitle: true,
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
            title: Text(
              'waitingqueue'.tr,
              style: GoogleFonts.poppins(
                textStyle: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.kPrimaryColor),
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
                              cont.updateselectedindex(index);
                              FocusScope.of(context).unfocus();
                            },
                            tabs: [
                              Tab(
                                child: Text(
                                  'Clinical Practice',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: cont.tabindex == 0
                                              ? ColorManager.kPrimaryColor
                                              : ColorManager.kblackColor,
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
                                          color: cont.tabindex == 1
                                              ? ColorManager.kPrimaryColor
                                              : ColorManager.kblackColor,
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
                                          color: cont.tabindex == 2
                                              ? ColorManager.kPrimaryColor
                                              : ColorManager.kblackColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.72,
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
