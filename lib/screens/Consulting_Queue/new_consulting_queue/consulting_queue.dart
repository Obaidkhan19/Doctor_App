import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doctormobileapplication/data/controller/ConsultingQueue_Controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/all_consulting_queue.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/reschedule_consulting_queue.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/upcoming_consulting_queue.dart';
import 'package:doctormobileapplication/screens/dashboard/home.dart';
import 'package:doctormobileapplication/screens/dashboard/menu_drawer.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ConsultingQueueScreen extends StatefulWidget {
  const ConsultingQueueScreen({super.key});

  @override
  State<ConsultingQueueScreen> createState() => _ConsultingQueueScreenState();
}

class _ConsultingQueueScreenState extends State<ConsultingQueueScreen> {
  late List<Widget> pages;
  @override
  void initState() {
    pages = [
      const AllConsultingQueueScreen(),
      const RescheduleConsultingQueueScreen(),
      const UpcomingConsultingQueueScreen()
    ];
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ConsultingQueueController.i.setPageIndexofDayAll(0);
    super.dispose();
  }

  String? SelectedDate;
  var contr = Get.put<ConsultingQueueController>(ConsultingQueueController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(() => const DrawerScreen());
          },
          child: Image.asset(
            AppImages.back,
          ),
        ),
        title: Text(
          'waitingqueue'.tr,
          style: GoogleFonts.raleway(
            textStyle: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: GetBuilder<ConsultingQueueController>(
        builder: (contr) => Padding(
          padding:
              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.03),
          child: Column(
            children: [
              // here add Date
              Container(
                height: Get.height * 0.12,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorManager.kWhiteColor),
                child: DatePicker(
                  DateTime.now(),
                  dateTextStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                  monthTextStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorManager.kPrimaryColor,
                            fontSize: 12,
                          ),
                  dayTextStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorManager.kPrimaryColor,
                            fontSize: 12,
                          ),
                  deactivatedColor: ColorManager.kPrimaryLightColor,
                  height: Get.height * 0.1,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: ColorManager.kPrimaryColor,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    String Date = DateFormat('yyyy-MM-dd').format(date);
                    ConsultingQueueController.i.updatedate(date);
                    SelectedDate = Date;
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),

              Visibility(
                visible: true,
                child: SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            contr.setPageIndexofDayAll(0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: contr.index == 0
                                  ? const Color(0xfff1272d3)
                                  : ColorManager.kWhiteColor,
                              // border: Border.all(
                              //   color: const Color(0xfff1272d3),
                              //   width: 1, // 2px border width
                              // ), // Set the background color of the container
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height * 0.03,
                            child: Center(
                                child: Text(
                              'all'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          contr.index == 1 || contr.index == 2
                                              ? const Color(0xfffb8b8b8)
                                              : ColorManager.kWhiteColor,
                                      //     color: ColorManager.kWhiteColor,
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: 12),
                            )),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.03),
                        InkWell(
                          onTap: () {
                            contr.setPageIndexofDayAll(1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: contr.index == 1
                                  ? const Color(0xfff1272d3)
                                  : ColorManager.kWhiteColor,

                              borderRadius: BorderRadius.circular(5),

                              // border: Border.all(
                              //   color: const Color(0xfff1272d3),
                              //   width: 2, // 2px border width
                              // ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.24,
                            height: MediaQuery.of(context).size.height * 0.03,
                            child: Center(
                                child: Text(
                              'reschedule'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          contr.index == 0 || contr.index == 2
                                              ? const Color(0xfffb8b8b8)
                                              : ColorManager.kWhiteColor,
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: 12),
                            )),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.03),
                        InkWell(
                          onTap: () {
                            contr.setPageIndexofDayAll(2);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: contr.index == 2
                                  ? const Color(0xfff1272d3)
                                  : ColorManager.kWhiteColor,
                              // color: Color(
                              //     0xfff1272D3), // Set the background color of the container
                              borderRadius: BorderRadius.circular(5),

                              // border: Border.all(
                              //   color: const Color(0xfff1272d3),
                              //   width: 2, // 2px border width
                              // ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.03,
                            child: Center(
                                child: Text(
                              'upcoming'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          contr.index == 0 || contr.index == 1
                                              ? const Color(0xfffb8b8b8)
                                              : ColorManager.kWhiteColor,
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: 12),
                            )),
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(height: Get.height * 0.02),
              SizedBox(height: 456, child: pages[contr.index]),
            ],
          ),
        ),
      ),
    );
  }
}
