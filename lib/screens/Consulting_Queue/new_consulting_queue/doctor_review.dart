import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/consulting_queue.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/feedback_submit.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/images.dart';

class DoctorReviewScreen extends StatefulWidget {
  const DoctorReviewScreen({super.key});

  @override
  State<DoctorReviewScreen> createState() => _DoctorReviewScreenState();
}

class _DoctorReviewScreenState extends State<DoctorReviewScreen> {
  TextEditingController feedbackController = TextEditingController();
  String name = "Shaikh Zahid";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.1,
            ),
            const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    widthFactor: 1,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: ColorManager.kWhiteColor,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(Images.profile),
                      ),
                    )),
                Align(
                    widthFactor: 0.5,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: ColorManager.kWhiteColor,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(Images.profile),
                      ),
                    )),
              ],
            ),
            Center(
              child: Text(
                '${'yoursessionwith'.tr} $name \n ${'iscomplete'.tr}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.kblackColor,
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Card(
              shadowColor: const Color.fromARGB(255, 0, 0, 0),
              elevation: 10,
              surfaceTintColor: ColorManager.kWhiteColor,
              child: SizedBox(
                height: Get.height * 0.61,
                width: Get.width * 0.9,
                child: Padding(
                  padding: EdgeInsets.all(Get.height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '09:30 - 09:45',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: ColorManager.kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.003,
                      ),
                      Text(
                        'Shaikh Zahid',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Get.height * 0.003,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: Get.height * 0.03,
                              width: Get.width * 0.2,
                              decoration: BoxDecoration(
                                color: const Color(0xfffc1ffd3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  'completed'.tr,
                                  style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: ColorManager.kblackColor),
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
                              height: Get.height * 0.03,
                              width: Get.width * 0.16,
                              decoration: BoxDecoration(
                                color: ColorManager.kPrimaryColor,
                                borderRadius: BorderRadius.circular(4),
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
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Text(
                        'wewouldlovetohearfromyou'.tr,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.heartIcon,
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Image.asset(
                            AppImages.heartIcon,
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Image.asset(
                            AppImages.heartIcon,
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Image.asset(
                            AppImages.heartIcon,
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Image.asset(
                            AppImages.heartIcon,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      TextField(
                        controller: feedbackController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'writeyourfeedbackhere'.tr,
                          hintStyle: TextStyle(
                            fontSize: 16,
                            height: Get.height * 0.005,
                          ),
                          label: Text('feedback'.tr),
                          labelStyle: const TextStyle(
                              fontSize: 12, color: ColorManager.kblackColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius as needed
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(
                                10.0), // Match the border radius
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          if (feedbackController.text.isEmpty) {
                            showSnackbar(Get.context!, 'pleaseenterfeedback'.tr,
                                color: Colors.red);
                          } else {
                            Get.to(() => const FeedbackSubmitScreen());
                          }
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
                              'submit'.tr,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: ColorManager.kWhiteColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const ConsultingQueueScreen());
                        },
                        child: Center(
                          child: Text(
                            'skipgotoconsultingqueue'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
