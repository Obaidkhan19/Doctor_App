// ignore_for_file: use_key_in_widget_constructors

import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/localDB/local_db.dart';
import '../../utils/constants.dart';
import '../auth_screens/login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: AppPadding.p20),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Image.asset(
              Images.welcome,
              height: Get.height * 0.6,
              width: Get.width * 1,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: Get.height * 0.06,
            ),
            Center(
              child: Text('Welcome to ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    fontSize: 30,
                    color: ColorManager.kblackColor,
                  )),
            ),
            Center(
              child: Text('${AppConstants.appName}.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 32,
                      color: ColorManager.kPrimaryColor,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            const GetStartedButton()
          ],
        ),
      ),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        LocalDb().saveIsFirstTime(false);
        Get.offAll(() => const LoginScreen());
        // Get.to(()=>const Introduction());
      },
      child: const CircleAvatar(
        radius: 35,
        backgroundColor: ColorManager.kPrimaryColor,
        child: CircleAvatar(
          radius: 34,
          backgroundColor: ColorManager.kWhiteColor,
          child: CircleAvatar(
            radius: 27,
            child: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}

class ElevatedText extends StatelessWidget {
  final String? text;
  final Color? textColor;
  const ElevatedText({
    super.key,
    this.text,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: const TextStyle(
        fontSize: 20,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(3.0, 3.0),
            blurRadius: 1.0,
            color: Color(0xFFE8E8E8),
          ),
        ],
      ),
    );
  }
}
