import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/dashboard/menu_drawer.dart';
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
  TextEditingController SearchFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: ColorManager.kPrimaryColor,
          onPressed: () {
            Get.offAll(() => const DrawerScreen());
          },
        ),
        title: Text(
          'healthsummaryappbar'.tr,
          style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: ColorManager.kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05,
        ),
        child: Column(
          children: [
            CustomTextField(
              onSubmitted: (String value) {
                SearchFieldController.text = value;
              },
              prefixIcon: const Icon(
                Icons.search_outlined,
                color: ColorManager.kPrimaryColor,
                size: 35,
              ),
              controller: SearchFieldController,
              hintText: 'search'.tr,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
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
                                        width: Get.width * 0.34,
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
                                      width: Get.width * 0.16,
                                      decoration: BoxDecoration(
                                        color: ColorManager.kPrimaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Offline'.tr,
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
            // SizedBox(
            //   height: Get.height * 0.05,
            // ),
          ],
        ),
      ),
    );
  }
}
