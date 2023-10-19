import 'dart:io';

import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import 'package:doctormobileapplication/screens/health_summary/user_detail_health_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthSummaryScreen extends StatefulWidget {
  const HealthSummaryScreen({super.key});

  @override
  State<HealthSummaryScreen> createState() => _HealthSummaryScreenState();
}

class _HealthSummaryScreenState extends State<HealthSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: 'healthsummaryappbar'.tr,
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 7,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  bool isConnected = false;
                  return Column(
                    children: [
                      ListTile(
                        leading: const SizedBox(
                          height: 380,
                          width: 71,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(Images.profile),
                          ),
                        ),
                        title: Transform.translate(
                          offset: const Offset(-0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '09:30 am - 09:45 am',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: ColorManager.kGreyColor),
                              ),
                              Text(
                                'Mr. Shaikh Zahid',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: ColorManager.kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${'Mrno'.tr}  ${"123 4567 8901234 5"}',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Row(
                                children: [
                                  if (isConnected)
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: Get.height * 0.04,
                                        width: Get.width * 0.43,
                                        decoration: BoxDecoration(
                                          color: ColorManager.KgreenColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'deviceconnected'.tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color:
                                                    ColorManager.kWhiteColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (!isConnected)
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: Get.height * 0.04,
                                        width: Get.width * 0.43,
                                        decoration: BoxDecoration(
                                          color: ColorManager.kMaroonColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'devicedisconnect'.tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color:
                                                    ColorManager.kWhiteColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: Get.height * 0.04,
                                      width: Get.width * 0.2,
                                      decoration: BoxDecoration(
                                        color: ColorManager.kPrimaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'online'.tr,
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: ColorManager.kWhiteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.height * 0.0001,
                            bottom: Get.height * 0.02),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => const UserHealthSummary());
                          },
                          child: Container(
                            height: Get.height * 0.06,
                            width: Get.width * 0.87,
                            decoration: BoxDecoration(
                              color: ColorManager.kPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'healthsummaryappbar'.tr,
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: ColorManager.kWhiteColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: Get.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
