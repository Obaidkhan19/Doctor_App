import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SucessfullRegistrationScreen extends StatefulWidget {
  const SucessfullRegistrationScreen({super.key});

  @override
  State<SucessfullRegistrationScreen> createState() =>
      _SucessfullRegistrationScreenState();
}

class _SucessfullRegistrationScreenState
    extends State<SucessfullRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        title: Image.asset(
          Images.logo,
          height: Get.height * 0.08,
        ),
      ),
      body: Stack(
        children: [
          // Positioned(
          //   top: 100,
          //   right: 0,
          //   child: Container(
          //     height: Get.height * 0.8,
          //     width: Get.width,
          //     alignment: Alignment.centerLeft,
          //     child: Image.asset(
          //       Images.logoBackground,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          const BackgroundLogoimage1(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'registered'.tr,
                  style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: ColorManager.kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  'registrationCompleted'.tr,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const LoginScreen());
                  },
                  child: Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.85,
                    decoration: BoxDecoration(
                      color: ColorManager.kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'ok'.tr,
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: ColorManager.kWhiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
