import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/images.dart';

class RegistrationSuccessfulScreen extends StatelessWidget {
  const RegistrationSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          Images.logo,
          height: Get.height * 0.08,
        ),
      ),
      body: Stack(
        children: [
          const Center(child: BackgroundLogoimage()),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Registered',
                    style: GoogleFonts.poppins(
                        fontSize: 30,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text(
                    'Registration has been successfully completed',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  PrimaryButton(
                      title: 'OK',
                      onPressed: () {},
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
