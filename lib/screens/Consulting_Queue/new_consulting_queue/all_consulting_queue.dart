import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/ConsultingQueue_Controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/Prescribe_Medicine.dart';
import 'package:doctormobileapplication/screens/health_summary/user_detail_health_summary.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';

class AllConsultingQueueScreen extends StatefulWidget {
  const AllConsultingQueueScreen({super.key});

  @override
  State<AllConsultingQueueScreen> createState() =>
      _AllConsultingQueueScreenState();
}

class _AllConsultingQueueScreenState extends State<AllConsultingQueueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ConsultingQueueController>(
        builder: (cont) => SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 7,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    bool isConnected = false;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Card(
                          elevation: 2,
                          surfaceTintColor: ColorManager.kWhiteColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: Get.height * 0.01,
                                  bottom: Get.height * 0.01,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    Column(
                                      children: [
                                        ClipOval(
                                          child: Container(
                                            width: 71,
                                            height: 71,
                                            decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              image: DecorationImage(
                                                image:
                                                    AssetImage(Images.profile),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '  09:30 am - 09:45 am',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: ColorManager.kGreyColor),
                                        ),
                                        Text(
                                          '  Abu Yousuf',
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: ColorManager.kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${'Mrnospace'.tr}  ${'A2459'}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: ColorManager.kPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            if (!isConnected)
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  height: Get.height * 0.04,
                                                  width: Get.width * 0.2,
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xfffffce62),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'upcoming'.tr,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          color: ColorManager
                                                              .kblackColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            SizedBox(
                                              width: Get.width * 0.02,
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                height: Get.height * 0.04,
                                                width: Get.width * 0.15,
                                                decoration: BoxDecoration(
                                                  color: ColorManager
                                                      .kPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'online'.tr,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        color: ColorManager
                                                            .kWhiteColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.04,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: Get.height * 0.03,
                                          right: Get.width * 0.03),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() =>
                                                  const PrescribeMedicineScreen());
                                            },
                                            child: Container(
                                              width: 47,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: ColorManager
                                                      .kPrimaryColor,
                                                  width: 1, // 2px border width
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Image.asset(AppImages.RxIcon),
                                                  Text(
                                                    'view'.tr,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        color: ColorManager
                                                            .kPrimaryColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: Get.height * 0.002,
                                  bottom: Get.height * 0.02,
                                  left: Get.width * 0.05,
                                  right: Get.width * 0.055,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Get.to(const UserHealthSummary());
                                  },
                                  child: Container(
                                    height: Get.height * 0.06,
                                    width: Get.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: ColorManager.kPrimaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'attendsession'.tr,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: ColorManager.kWhiteColor),
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
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
